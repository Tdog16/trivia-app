require 'io/console'
require 'yaml'
require 'yaml/store'

# class to handle the complete creation and saving of a quiz
class QuizCreation
  # Class to handle the prompted questions and their answers
  attr_accessor :for_user, :score_per_question
  def initialize(for_user, score_per_question)
    @for_user = for_user
    @score_per_question = score_per_question
    # create 3 arrays to hold answers, questions and options
    @prompt_list = []
    @answer_list = []
    @answer = []
    # when the class is created facilitate the functions
    # to create and save the quiz
    new_quiz
    new_quiz_save
  end

  # handles the creation of the quiz
  def new_quiz
    choosing_questions = true
    # loop for the user to add as many questions as they want
    while choosing_questions == true
      puts 'What question would you like to add?'
      question_to_add = gets.chomp
      # add the question to an array
      @prompt_list << question_to_add
      option_amount = 0
      options = []
      # this loop creates 4 options for the question
      while option_amount <= 3
        option_amount += 1
        puts "What is option #{option_amount}'s answer?"
        option = gets.chomp
        options << option
      end
      # put the options into an array and show back
      puts options.to_s
      @answer_list << options
      puts 'What is the answer?'
      answer = gets.chomp
      # put the answer into the array
      @answer << answer
      # ask user if they want to add another question
      puts 'Would you like to add another question? (options: (y)es or (n)o)'
      user_input = gets.chomp
      if user_input == 'y'
        choosing_questions = true
      elsif user_input == 'n'
        choosing_questions = false
      else
        puts 'Invalid Option! Try again!'
        choosing_questions = true
      end
    end
  end

  # this function handles the storing of the quiz
  def new_quiz_save
    quiz_make = self
    # assign storing of information to a variable
    quiz_store = YAML::Store.new 'quiz_list.store'
    # store the object into a file
    quiz_store.transaction do
      quiz_store[@for_user.to_s] = quiz_make
    end
  end
end

QuizCreation.new('testing123', 25)
