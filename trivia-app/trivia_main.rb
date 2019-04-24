# require both classes used
require_relative 'classes/quiz.rb'
require_relative 'classes/user.rb'

# initialize condition for later and clear screen
@chosing_option = true
puts "\e[2J"

# handle login and signup of users
def login
  login_result = nil
  # while the user is logging in...
  while @chosing_option == true
    puts "What would you like to do?\n(options: (l)ogin or (s)ignup)"
    # handles the option chose by the user
    option_chose = STDIN.noecho(&:gets).chomp
    # handles login
    if option_chose.casecmp('l').zero?
      puts 'What is your username?:'
      username_chose = gets.chomp
      # load all the accounts from a file and assign to variable
      accounts = YAML.load_file('users.store')
      # grab user object chosen by user
      @user_grab = accounts[username_chose.to_s]
      # if the username is not found..
      if @user_grab.nil?
        puts "\e[2J"
        puts 'Invalid username! Try again!'
        @chosing_option = true
      else
        # if the username is found grab the password...
        pass_grab = @user_grab.password
        puts 'Enter your password'
        password_chose = STDIN.noecho(&:gets).chomp
        # compare the object password with users given password...
        if password_chose == pass_grab
          # if they are the same return login success
          login_result = true
          @chosing_option = false
        else
          # if they are not the same...
          puts "\e[2J"
          puts 'Invalid password! Try again!'
          @chosing_option = true
        end
      end
    # handles signup
    elsif option_chose.casecmp('s').zero?
      puts 'Please choose a username:'
      chosen_username = gets.chomp
      puts 'Please choose a password:'
      chosen_password = STDIN.noecho(&:gets).chomp
      # create new account using User class and assign to variable
      save_user = User.new(chosen_username.to_s, chosen_password.to_s)
      # store the new account in the users.store file
      save_user.new_user
      @chosing_option = true
      puts "\e[2J"
      puts 'You successfully signed up!'
    # handles doing_things input from user
    else
      puts "\e[2J"
      puts 'Invalid option! Try Again!'
      @chosing_option = true
    end
  end
  # return the result of the login
  login_result
end

# get user to login and return result as boolean
successful_login = login
puts "\e[2J"
puts "You have successfully logged in as #{@user_grab.username}!" if successful_login == true
doing_things = true
while doing_things == true
  puts "What would you like to do?\n(options: (c)reate a quiz or (t)ake a quiz)"
  user_input = gets.chomp
  if user_input == 'c'
    puts "Who is this quiz for?"
    user_input = gets.chomp
    puts "How many points per question?"
    user_input_points = gets.chomp
    puts "What is the quiz name?"
    user_input_name = gets.chomp
    QuizCreation.new(user_input_name,user_input,user_input_points)
    puts "You have successfully created a quiz for #{user_input}"
    doing_things = true
  elsif user_input == 't'
    #take quiz function
    quiz_list = YAML.load_file('quiz_list.store')
    puts "\e[2J"
    puts "You can choose from the following:"
    # assign to 1 for use in the list of quiz names
    quiz_number = 1
    # make an array to hold the quiz names to be chosen
    # set to nil so that array starts with index 1 instead of 0
    quiz_choose_array = [nil]
    # for each quiz in the list...
    quiz_list.each do |element|
      # check if the quiz is for the signed in user
      if @user_grab.username == element[1].for_user
        # if it is print the quiz in a list with the line number
        puts "#{quiz_number}.#{element[0]}\n"
        # store the quiz in the array for later use
        quiz_choose_array << element
        # add 1 to the list number for each new line
        quiz_number += 1
      end
    end
    puts "Which quiz would you like to take?"
    user_input = gets.chomp.to_i
    # grab the user specified quiz from the array
    quiz_taken = quiz_choose_array[user_input]
  elsif user_input == 'q'
    doing_things == false
  else
    puts "Invalid option! Try again!"
    doing_things == true
  end
end
