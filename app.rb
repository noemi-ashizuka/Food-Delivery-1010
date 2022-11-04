require_relative 'app/repositories/meal_repository.rb'
require_relative 'app/controllers/meals_controller.rb'
require_relative 'app/repositories/customer_repository.rb'
require_relative 'app/controllers/customers_controller.rb'
require_relative 'router.rb'

csv_file_meals = File.join(__dir__, 'data/meals.csv')
meal_repository = MealRepository.new(csv_file_meals)
meals_controller = MealsController.new(meal_repository)

csv_file_customers = File.join(__dir__, 'data/customers.csv')
customer_repository = CustomerRepository.new(csv_file_customers)
customers_controller = CustomersController.new(customer_repository)

router = Router.new(meals_controller, customers_controller)

router.run
