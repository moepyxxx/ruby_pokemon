
require_relative 'result_interface'
require_relative '../../condition/condition_interface'

class TakeDamageForConditionResult
  include ResultInterface

  def initialize(pokemon, condition)
    @pokemon = pokemon
    @condition = condition
  end

  def message
    text = case @condition.name
    when :burned, :poison
      "#{@pokemon.name}は#{ConditionNameMap[@condition.name]}のダメージを受けている"
    when :paralysis
      nil
    else
      raise ArgumentError, "Unknown status condition class: #{@condition.inspect}"
    end

    [text].compact
  end
end