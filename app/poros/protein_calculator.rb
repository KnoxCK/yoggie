class ProteinCalculator
  def initialize(customer)
    @customer = customer
  end

  def percent_protein
    percentage = (protein_calories_per_shake / CalorieCalculator.new(customer).calories_per_shake) * 100
    percentage.round(0)
  end

  private

  attr_reader :customer

  def daily_target_grams
    2.2 * customer.weight
  end

  def daily_protein_calories
    daily_target_grams * 4
  end

  def protein_calories_per_shake
    daily_protein_calories / customer.meals_per_day
  end
end
