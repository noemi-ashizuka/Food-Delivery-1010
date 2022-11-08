require 'csv'
require_relative '../models/order'

class OrderRepository
  def initialize(filepath, meal_repository, customer_repository, employee_repository)
    @filepath = filepath
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @orders = [] # array on instances
    @next_id = 1
    load_csv if File.exist?(@filepath)
  end

  def create(order)
    order.id = @next_id
    @orders << order
    @next_id += 1
    save_csv
  end

  def undelivered_orders
    @orders.reject do |order|
      order.delivered?
    end
  end

  def my_undelivered_orders(employee)
    undelivered_orders.select do |order|
      order.employee == employee
    end
  end

  def mark_as_delivered(order)
    order.deliver!
    save_csv
  end
  
  private

  def load_csv
    CSV.foreach(@filepath, headers: :first_row, header_converters: :symbol) do |row|
      row[:id] = row[:id].to_i
                          # 'true' == 'true' => true
                          # 'false' == 'true' => false
      row[:meal] = @meal_repository.find(row[:meal_id].to_i)
      row[:customer] = @customer_repository.find(row[:customer_id].to_i)
      row[:employee] = @employee_repository.find(row[:employee_id].to_i)
      row[:delivered] = row[:delivered] == 'true' # real boolean
      @orders << Order.new(row)
    end
    @next_id = @orders.last.id + 1 unless @orders.empty?
  end

  def save_csv
    CSV.open(@filepath, 'wb') do |csv|
      csv << ['id', 'meal_id', 'customer_id', 'employee_id', 'delivered']
      @orders.each do |order|
        csv << [order.id, order.meal.id, order.customer.id, order.employee.id, order.delivered?]
      end
    end
  end
end
