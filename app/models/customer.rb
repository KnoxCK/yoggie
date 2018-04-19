class Customer < ApplicationRecord
  has_one :basket
  has_one :address

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
    'Lose Fat' => 0.5,
    'Health Boost' => 0.625,
    'Gain Muscle' => 0.75
  }.freeze

  GENDER = ['male', 'female'].freeze

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
end