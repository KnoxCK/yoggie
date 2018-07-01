class FatCalculator
  def initialize(customer)
    @customer = customer
  end

  def percent_fat
    percentage = (fat_calories_per_shake / CalorieCalculator.new(customer).calories_per_shake) * 100
    percentage.round(0)
  end

  GOAL_FAT_PER_KG = {
    'Lose Fat' => 0.5,
    'Health Boost' => 0.625,
    'Gain Muscle' => 0.75
  }

  private

  attr_reader :customer

  def daily_target_grams
    GOAL_FAT_PER_KG[customer.goal] * customer.weight
  end

  def daily_fat_calories
    daily_target_grams * 9
  end

  def fat_calories_per_shake
    daily_fat_calories / customer.meals_per_day
  end
end
