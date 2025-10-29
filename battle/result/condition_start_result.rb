
require_relative 'result_interface'
require_relative '../../condition/condition_interface'

class ConditionStartResult
  include ResultInterface

  def initialize(pokemon, condition)
    @pokemon = pokemon
    @condition = condition
  end

  def message
    text = case @condition.name
    when :burned
      "#{@pokemon.name}は#{ConditionNameMap[@condition.name]}を追った"
    when :paralysis
      "#{@pokemon.name}はからだがしびれて動けなくなってしまった"
    when :poison
      "#{@pokemon.name}は#{ConditionNameMap[@condition.name]}をあびた"
    else
      raise ArgumentError, "Unknown status condition class: #{@condition.inspect}"
    end
    
    [
      text
    ]
  end
end