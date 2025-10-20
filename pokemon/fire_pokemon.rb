require_relative 'pokemon'

class FirePokemon < Pokemon
  def initialize(name, max_hp)
    super(name, "ほのお", max_hp)
  end

  def special_move
    return "かえんほうしゃ"
  end
end