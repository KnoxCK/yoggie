class Customer < ApplicationRecord
  has_one :basket
  has_one :address

  # validates_presence_of :first_name, :last_name, :age, :gender, :activity_level
  # validates_presence_of :goal, :height, :weight

  accepts_nested_attributes_for :address

  ACTIVITY_LEVEL_MULTIPLIERS = {
    'sedentary' => 1.1,
    'lightly_active' => 1.2,
    'moderately_active' => 1.35,
    'super_active' => 1.45
  }.freeze

  GOAL_MULTIPLIERS = {
    'lose_fat' => 0.5,
    'health_boost' => 0.625,
    'gain_muscle' => 0.75
  }.freeze

  GENDER = ['male', 'female'].freeze
end
