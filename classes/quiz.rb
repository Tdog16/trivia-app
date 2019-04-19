class Question

    attr_accessor :prompt, :answer
    def initialize(prompt, answer)
        @prompt = promt
        @answer = answer
    end

    prompt1 = "How many strings does a standard guitar have?\n(a) 4\n(b) 6\n (c) 8\n (d) 7"
    prompt2 = "Master Chief is the protaganist in what game series?\n(a) Call of Duty\n(b) Halo\n(c) Borderlands\n(d) Left 4 Dead"
    prompt3 = "How many legs do spiders have?\n(a) 10\n(b) 6\n(c) 4\n(d) 8"


    questions = [
        Question.new(prompt1, "b"),
        Question.new(prompt2, "b"),
        Question.new(prompt3, "8")

    ]

