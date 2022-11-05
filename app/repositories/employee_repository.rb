require 'csv'
require_relative '../models/employee'

class EmployeeRepository
  def initialize(filepath)
    @filepath = filepath
    @employees = [] # array on instances
    @next_id = 1
    load_csv if File.exist?(@filepath)
  end

  def find_by_username(username)
    @employees.find { |employee| employee.username == username }
  end

  def find(id)
    @employees.find { |employee| employee.id == id }
  end

  def all_riders
    @employees.select { |employee| employee.rider? }
  end

  private

  def load_csv
    CSV.foreach(@filepath, headers: :first_row, header_converters: :symbol) do |row|
      row[:id] = row[:id].to_i
      @employees << Employee.new(row)
    end
    @next_id = @employees.last.id + 1 unless @employees.empty?
  end
end
