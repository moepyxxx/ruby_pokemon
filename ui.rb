require_relative 'cli'

class Ui
  class << self
    def display_messages(messages)
      messages.each do |message|
        Cli.say(message)
        Cli.next("Press any key to continue...")
      end
    end

    def select_move(moves)
      choices = moves.map.with_index { |move, index| {name: move.name, value: index} }
      idx = Cli.select("どのわざを つかう？", choices)
      return moves[idx]
    end
  end
end