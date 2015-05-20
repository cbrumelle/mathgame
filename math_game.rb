class MathGame

  def initialize(name)
    speak("Welcome back #{name}. Lets do some math.")
  end

  def play
    number_of_questions_per_round.times do
      question = Question.new
      speak_and_print question.ask_in_words
      question.correct_answer?(gets.chomp) ? speak("correct!") : speak("sorry!")
      speak_and_print question.answer_in_words
    end
    play if play_again?
  end

  def number_of_questions_per_round
    10
  end

  def play_again?
    speak_and_print("Would you like to play again? Press 'y' to continue.")
    gets.chomp.downcase == 'y'
  end

  def speak(words)
    `say #{words.sub('-',"minus").sub('/',"divide")}` # :( for the sub
  end

  def speak_and_print(words)
    speak(words) and puts(words)
  end

  def self.for(name)
    self.new(name)
  end
end

class Question
  attr_accessor :a, :b, :opperator
  
  def initialize
    @a, @b = pick_numbers
    @opperator = pick_operator
    @a,@b = @b,@a if @a < @b && @opperator == "-" # avoid negative answers
  end

  def pick_numbers
    [Random.rand(9), Random.rand(5)]
  end

  def pick_operator
    ["+","-"].sample
  end

  def answer
    @a.send(@opperator,@b)
  end

  def correct_answer?(user_answer)
    user_answer == answer.to_s
  end

  def to_s
    "#{@a} #{@opperator} #{@b}"
  end

  def ask_in_words
    "#{self} = ?"
  end

  def answer_in_words
    "#{self} = #{answer}"
  end
end

MathGame.for("Shelby").play

