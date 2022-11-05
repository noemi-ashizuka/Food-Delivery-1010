class SessionsView < BaseView
  def welcome(user)
    puts "Welcome #{user.username}!"
  end

  def wrong_credentials
    puts 'Sorry wrong username or password'
  end
end
