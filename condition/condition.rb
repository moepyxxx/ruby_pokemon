require_relative 'condition_burned'
require_relative 'condition_paralysis'
require_relative 'condition_poison'

class StatusCondition
  def self.create(type)
    puts "type: #{type}"
    case type
    when :burned
      Condition::Burned.new
    when :paralyzed
      Condition::Paralyzed.new
    when :poisoned
      Condition::Poisoned.new
    else
      raise ArgumentError, "Unknown status condition type: #{type}"
    end
  end
end