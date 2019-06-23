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
    "#{first_name} #{last_name}"
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
   basket.smoothies.first.standard? ? true : false
  end

  private

  def should_generate_new_friendly_id?
    self.slug.nil?
  end
end
