
require_relative 'result_interface'

class CanNotMoveForConditionResult
  include ResultInterface

  def initialize(pokemon, condition)
    @pokemon = pokemon
    @condition = condition
  end

  def message
    text = case @condition.name
    when :burned
      nil
    when :paralysis
      "#{@pokemon.name}はからだがしびれて動けない"
    when :poison
      nil
    else
      raise ArgumentError, "Unknown status condition class: #{@condition.inspect}"
    end

    [text].compact
  end
end