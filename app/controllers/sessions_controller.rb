require_relative '../views/sessions_view'

class SessionsController
  def initialize(employee_repository)
    @employee_repository = employee_repository
    @sessions_view = SessionsView.new
  end

  def sign_in
    # Ask the username
    username = @sessions_view.ask_for(:username)
    # Ask the password
    password = @sessions_view.ask_for(:password)
    # Check with the repo if there's a user with that username
    employee = @employee_repository.find_by_username(username) # instance/nil
    # if user exists and password is correct
    if employee && employee.password == password
      # welcome
      @sessions_view.welcome(employee)
      return employee
    # otherwise
    else
      # wrong credentials
      @sessions_view.wrong_credentials
      # ask again
      sign_in
    end
  end
end