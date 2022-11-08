class Order
  attr_accessor :id
  attr_reader :meal, :customer, :employee
  def initialize(attributes = {})
    @id = attributes[:id] # integer
    @meal = attributes[:meal] # instance
    @customer = attributes[:customer] # instance
    @employee = attributes[:employee] # instance
    @delivered = attributes[:delivered] || false # boolean
  end

  def delivered?
    @delivered
  end

  def deliver!
    @delivered = true
  end
end
