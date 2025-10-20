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
  end
end