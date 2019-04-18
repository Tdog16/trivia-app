require 'io/console'
require 'yaml'
require 'yaml/store'

# class to handle all user information and actions
class User
  attr_accessor :username, :password
# initialize the credentials as instance variables
  def initialize(username, password)
    @username = username
    @password = password
  end

  # handles the storing of user credentials
  def new_user
    account_make = self
    # assign storing of information to a variable
    account_store = YAML::Store.new 'users.store'
    # store the object into a file
    account_store.transaction do
      account_store[username.to_s] = account_make
    end
  end
end