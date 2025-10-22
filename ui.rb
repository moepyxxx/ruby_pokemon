class Ui 
  class << self
    def display_messages(messages)
      messages.each do |message|
        Serif.say(message)
        Serif.next("Press any key to continue...")
      end
    end

    def select_move(moves)
      choices = moves.map.with_index { |move, index| {name: move[:name], value: index} }
      Serif.select("どのわざを つかう？", choices)
    end
  end
end