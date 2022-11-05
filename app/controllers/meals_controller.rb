require_relative '../views/meals_view'

class MealsController
  def initialize(meal_repository)
    @meal_repository = meal_repository
    @meals_view = MealsView.new
  end

  def list
    # ask the repo for the meals
    meals = @meal_repository.all
    # ask the view to display the meals
    @meals_view.display(meals)
  end

  def add
    # ask the view to ask for a name
    name = @meals_view.ask_for(:name)
    # ask the view to ask for a price
    price = @meals_view.ask_for(:price)
    # make a meal instance
    meal = Meal.new(name: name, price: price)
    # give it to the repo
    @meal_repository.create(meal)
  end
end