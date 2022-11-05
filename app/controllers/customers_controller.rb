require_relative '../views/customers_view'

class CustomersController
  def initialize(customer_repository)
    @customer_repository = customer_repository
    @customers_view = CustomersView.new
  end

  def list
    # ask the repo for the customers
    customers = @customer_repository.all
    # ask the view to display the customers
    @customers_view.display(customers)
  end

  def add
    # ask the view to ask for a name
    name = @customers_view.ask_for(:name)
    # ask the view to ask for a price
    address = @customers_view.ask_for(:address)
    # make a customer instance
    customer = Customer.new(name: name, address: address)
    # give it to the repo
    @customer_repository.create(customer)
  end
end
