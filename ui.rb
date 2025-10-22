class Ui 
  class << self
    def display_messages(messages)
      messages.each do |message|
        Serif.say(message)
        Serif.next("Press any key to continue...")
      end
    end
  end
end