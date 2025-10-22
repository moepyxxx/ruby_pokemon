require 'tty-prompt'

class Serif 
  @prompt = TTY::Prompt.new
  
  class << self
    def say(message)
      @prompt.say(message)
    end

    def next(message)
      @prompt.keypress(message)
    end

    def select(message, choices)
      @prompt.select(message) do |menu|
        choices.each do |choice|
          menu.choice choice[:name], choice[:value]
        end
      end
    end
  end
end