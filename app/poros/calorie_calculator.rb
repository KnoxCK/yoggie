class CalorieCalculator
  def initialize(customer)
    @customer = customer
  end

  def calories_per_shake
    daily_calories / customer.meals_per_day
  end

  private

  attr_reader :customer

  def TDEE
    BMRCalculator.new(customer).calculate * Customer::ACTIVITY_LEVEL_MULTIPLIERS[customer.activity_level]
  end

  def daily_calories
    TDEE * Customer::GOAL_MULTIPLIERS[customer.goal]
  end
end
