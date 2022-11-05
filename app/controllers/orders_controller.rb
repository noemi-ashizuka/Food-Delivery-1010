require_relative '../views/orders_view'
require_relative '../views/employees_view'

class OrdersController
  def initialize(meal_repository, customer_repository, employee_repository, order_repository)
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @order_repository = order_repository
    @orders_view = OrdersView.new
    @meals_view = MealsView.new
    @customers_view = CustomersView.new
    @employees_view = EmployeesView.new
  end

  def add
    # ask the meal repository for all the meals
    meals = @meal_repository.all
    # display a list of meals
    @meals_view.display(meals)
    # ask which number (index)
    index = @meals_view.ask_for('meal number').to_i - 1
    # we use the index to retrieve the meal
    meal = meals[index] # instance of meal

    # ask the customer repository for all the customers
    customers = @customer_repository.all
    # display a list of customers
    @customers_view.display(customers)
    # ask which number (index)
    index = @customers_view.ask_for('customer number').to_i - 1
    # we use the index to retrieve the customer
    customer = customers[index] # instance of customer

    # ask the employee repository for all the employees
    employees = @employee_repository.all_riders
    # display a list of employees
    @employees_view.display(employees)
    # ask which number (index)
    index = @employees_view.ask_for('employee number').to_i - 1
    # we use the index to retrieve the employee
    employee = employees[index] # instance of employee

    order = Order.new(meal: meal, customer: customer, employee: employee)
    @order_repository.create(order)
  end

  def list_undelivered_orders
    # ask the repository for all the undelivered orders
    orders = @order_repository.undelivered_orders
    # ask the orders view to display them
    @orders_view.display(orders)
  end

  def list_my_orders(rider)
    # ask the repo for MY undelivered orders
    orders = @order_repository.my_undelivered_orders(rider)
    # display them
    @orders_view.display(orders)
  end

  def mark_as_delivered(rider)
    # ask the repo for MY undelivered orders
    orders = @order_repository.my_undelivered_orders(rider)
    # display them
    @orders_view.display(orders)
    # view should ask for index
    index = @orders_view.ask_for("number of order").to_i - 1
    # we should retrieve the correct order with the index
    order = orders[index]
    # we should ask repo to mark it
    @order_repository.mark_as_delivered(order)
  end
end