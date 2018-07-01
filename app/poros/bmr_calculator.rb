class BMRCalculator
  def initialize(customer)
    @customer = customer
  end

  def calculate
    mifflin_equation
  end

  private

  attr_reader :customer

  def mifflin_equation
    (10 * customer.weight) + (6.25 * customer.height) - (5 * customer.age) + 5
  end
end
