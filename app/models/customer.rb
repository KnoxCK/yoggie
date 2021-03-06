class Customer < ApplicationRecord
  belongs_to :user
  has_one :basket
  has_one :address
  extend FriendlyId
  friendly_id :slug, use: :slugged
  # validates_presence_of :first_name, :last_name, :age, :gender, :activity_level
  # validates_presence_of :goal, :height, :weight

  accepts_nested_attributes_for :address

  ACTIVITY_LEVEL_MULTIPLIERS = {
    'Sedentary' => 1.1,
    'Lightly Active' => 1.2,
    'Moderately Active' => 1.35,
    'Super Active' => 1.45
  }.freeze

  GOAL_MULTIPLIERS = {
    'Lose Fat' => 0.8,
    'Health Boost' => 1,
    'Gain Muscle' => 1.1
  }.freeze

  MEALS_PER_DAY = {
    '3 or less' => 3,
    '4' => 4,
    '5 or more' => 5
  }

  GENDER = ['Guy', 'Girl'].freeze

  def full_name
    arr = [first_name, last_name].reject { |n| n.blank? }
    arr.join(' ')
  end

  def calculate_stats
    update(
      bmr: calculate_bmr,
      tdee: calculate_TDEE,
      daily_calorie_goal: calculate_daily_calories,
      calories_per_shake: calculate_shake_calories,
      protein: calculate_protein,
      fat: calculate_fat,
      carbs: calculate_carbs
      )
    user.update(standard: false)
  end

  def calculate_bmr
    BMRCalculator.new(self).calculate
  end

  def calculate_TDEE
    calculate_bmr * ACTIVITY_LEVEL_MULTIPLIERS[activity_level]
  end

  def calculate_daily_calories
    calculate_TDEE * GOAL_MULTIPLIERS[goal]
  end

  def calculate_shake_calories
    calculate_daily_calories / meals_per_day
  end

  def calculate_protein
    ProteinCalculator.new(self).percent_protein
  end

  def calculate_fat
    FatCalculator.new(self).percent_fat
  end

  def calculate_carbs
    100 - calculate_protein - calculate_fat
  end

  def standard?
    user.standard
  end

  def tailored?
    !user.standard
  end

  def check_status
    if !basket.nil?
      return if !basket.tailored? && standard?
      return if basket.tailored? && tailored?
      update_user_status
    end
  end

  def update_user_status
    user.update(standard: current_standard_status)
  end

  def current_standard_status
   user.standard ? true : false
  end

  def calculate_tailored_stat(smoothie, stat_symbol)
    # stat symbol can be any value in NutriInfo for the Smoothie
    original_stat = smoothie.nutri_info[stat_symbol]

    multiplication_factor = (calories_per_shake / smoothie.nutri_info[:energy_kcal])

    tailored_stat = (original_stat * multiplication_factor).round(1)

    # convert to integer if zero value at decimal places
    tailored_stat % 1 == 0 ? tailored_stat.to_i : tailored_stat
  end

  def generate_order_csv
    smoothie_group = basket&.smoothies&.first&.group&.name
    smoothie_size = basket&.smoothies&.first&.size&.name

    CSV.generate do |csv|
       csv << ["CUSTOMER DETAILS", ""]
       csv << ["CustomerRef", slug]
       csv << ["FirstName", first_name]
       csv << ["LastName", last_name]
       csv << ["AddressLine1", address&.address_line_one]
       csv << ["AddressLine2", address&.address_line_two]
       csv << ["AddressLine3", address&.address_line_three]
       csv << ["Postcode", address&.postcode]
       csv << ["SafePlace", address&.delivery_instructions]
       csv << ["MACROS", ""]
       csv << ["kCal", calories_per_shake]
       csv << ["protein", protein]
       csv << ["carbs", carbs]
       csv << ["fats", fat]
       csv << ["CUSTOMISATION QUESTIONS", ""]
       csv << ["Sex", gender]
       csv << ["Weight_kg", weight]
       csv << ["Height_cm", height]
       csv << ["Age", age]
       csv << ["ActivityLevel", activity_level]
       csv << ["Goal", goal]
       csv << ["MealsPerDay", meals_per_day]
       csv << ["ORDER DETAILS", ""]
       csv << ["OrderRef", basket&.stripe_sub_id]
       csv << ["OrderDate", "#{Date.today.day.ordinalize} #{Date.today.strftime("%B, %Y")}"]
       csv << ["DeliveryDate", basket&.next_delivery_date_string]
       csv << ["OrderType", "#{standard? ? 'STANDARD' : 'TAILORED'}"]
       csv << ["Group", smoothie_group]
       csv << ["Size", smoothie_size]
       csv << ["Smoothie1", basket&.smoothies[0]&.name&.titleize]
       csv << ["Smoothie2", basket&.smoothies[1]&.name&.titleize]
       csv << ["Smoothie3", basket&.smoothies[2]&.name&.titleize]
       csv << ["Smoothie4", basket&.smoothies[3]&.name&.titleize]
       csv << ["Smoothie5", basket&.smoothies[4]&.name&.titleize]
    end
  end

  private

  def should_generate_new_friendly_id?
    self.slug.nil?
  end
end
