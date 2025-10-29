require_relative '../../condition/condition_poison'

RSpec.describe Condition::Poison do
  let(:poison) { Condition::Poison.new }

  describe '#name' do
    it '状態異常名として:poisonを返す' do
      expect(poison.name).to eq(:poison)
    end
  end

  describe '#calculate_damage' do
    context 'HPが100の場合' do
      it 'HPの1/10のダメージ量として10を返す' do
        expect(poison.calculate_damage(100)).to eq(10)
      end
    end

    context 'HPが50の場合' do
      it 'HPの1/10のダメージ量として5を返す' do
        expect(poison.calculate_damage(50)).to eq(5)
      end
    end

    context 'HPが10の場合' do
      it 'HPの1/10のダメージ量として1を返す' do
        expect(poison.calculate_damage(10)).to eq(1)
      end
    end

    context 'HPが1の場合' do
      it 'HPの1/10のダメージ量として0を返す（整数除算）' do
        expect(poison.calculate_damage(1)).to eq(0)
      end
    end

    context 'HPが150の場合' do
      it 'HPの1/10のダメージ量として15を返す' do
        expect(poison.calculate_damage(150)).to eq(15)
      end
    end
  end

  describe '#move_rate' do
    it '行動可能率として1を返す（どく状態では100%行動可能）' do
      expect(poison.move_rate).to eq(1)
    end

    it '複数回呼び出しても常に1を返す' do
      10.times do
        expect(poison.move_rate).to eq(1)
      end
    end
  end

  describe 'ConditionInterfaceの実装' do
    it 'ConditionInterfaceをincludeしている' do
      expect(Condition::Poison.included_modules).to include(ConditionInterface)
    end
  end
end
