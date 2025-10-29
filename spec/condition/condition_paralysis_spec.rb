require_relative '../../condition/condition_paralysis'

RSpec.describe Condition::Paralysis do
  let(:paralysis) { Condition::Paralysis.new }

  describe '#name' do
    it '状態異常名として:paralysisを返す' do
      expect(paralysis.name).to eq(:paralysis)
    end
  end

  describe '#calculate_damage' do
    it 'ダメージを受けず、0を返す' do
      expect(paralysis.calculate_damage(100)).to eq(0)
    end

    it 'どのようなHPでも0を返す' do
      expect(paralysis.calculate_damage(50)).to eq(0)
      expect(paralysis.calculate_damage(150)).to eq(0)
      expect(paralysis.calculate_damage(1)).to eq(0)
    end
  end

  describe '#move_rate' do
    it '行動可能率として0.5を返す（まひ状態では50%の確率で行動可能）' do
      expect(paralysis.move_rate).to eq(0.5)
    end

    it '複数回呼び出しても常に0.5を返す' do
      10.times do
        expect(paralysis.move_rate).to eq(0.5)
      end
    end
  end

  describe 'ConditionInterfaceの実装' do
    it 'ConditionInterfaceをincludeしている' do
      expect(Condition::Paralysis.included_modules).to include(ConditionInterface)
    end
  end
end
