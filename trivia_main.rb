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
          user_grab = accounts[username_chose.to_s]
          # if the username is not found..
          if user_grab.nil?
            puts "\e[2J"
            puts 'Invalid username! Try again!'
            @chosing_option = true
          else
            # if the username is found grab the password...
            pass_grab = user_grab.password
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
        # handles invalid input from user
        else
          puts "\e[2J"
          puts 'Invalid option! Try Again!'
          @chosing_option = true
        end
    end
    # return the result of the login
    return login_result
end

# get user to login and return result as boolean
successful_login = login()
if successful_login == true
    puts "You have successfully logged in!"
end