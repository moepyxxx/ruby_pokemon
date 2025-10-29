require_relative 'condition_burned'
require_relative 'condition_paralysis'
require_relative 'condition_poison'

class StatusCondition
  def self.create(type)
    case type
    when :burned
      Condition::Burned.new
    when :paralysis
      Condition::Paralysis.new
    when :poison
      Condition::Poison.new
    else
      raise ArgumentError, "Unknown status condition type: #{type}"
    end
  end
end