class CalorieCalculator
  attr_reader :customer

  def initialize(customer)
    @customer = customer
  end

  def calories_per_shake
    daily_calories / customer.meals_per_day
  end

  def daily_calories
    calculate_TDEE * Customer::GOAL_MULTIPLIERS[customer.goal]
  end

  def calculate_TDEE
    BMRCalculator.new(customer).calculate * Customer::ACTIVITY_LEVEL_MULTIPLIERS[customer.activity_level]
  end
end
