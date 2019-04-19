class Question
#Class to handle the prompted questions and their answers
    attr_accessor :prompt, :answer
    def initialize(prompt, answer)
        @prompt = prompt
        @answer = answer
    end
end
#The questions and their multiple choice answers
prompt1 = "How many strings does a standard guitar have?\n(a) 4\n(b) 6\n(c) 8\n(d) 7"
prompt2 = "Master Chief is the protaganist in what game series?\n(a) Call of Duty\n(b) Halo\n(c) Borderlands\n(d) Left 4 Dead"
prompt3 = "How many legs do spiders have?\n(a) 10\n(b) 6\n(c) 4\n(d) 8"

#An array calling new questions with their answers
questions = [
    Question.new(prompt1, "b"),
    Question.new(prompt2, "b"),
    Question.new(prompt3, "d")
]
#defining a method to run the quiz with saved scoring
def run_quiz(questions)
    answer = ""
    score = 0
    for question in questions #a for loop for every question in the above array
    puts question.prompt
    answer = gets.chomp()
    if answer == question.answer
        score += 1
    end
end
    puts "you got" + score.to_s + "/" + questions.length.to_s 
end



