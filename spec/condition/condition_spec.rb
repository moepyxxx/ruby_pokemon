require_relative '../../condition/condition'
require_relative '../../condition/condition_burned'
require_relative '../../condition/condition_paralysis'
require_relative '../../condition/condition_poison'

RSpec.describe StatusCondition do
  describe '.create' do
    context 'タイプが:burnedの場合' do
      it 'Condition::Burnedのインスタンスを返す' do
        condition = StatusCondition.create(:burned)
        expect(condition).to be_a(Condition::Burned)
      end

      it '返されたインスタンスは:burnedという名前を持つ' do
        condition = StatusCondition.create(:burned)
        expect(condition.name).to eq(:burned)
      end
    end

    context 'タイプが:paralysisの場合' do
      it 'Condition::Paralysisのインスタンスを返す' do
        condition = StatusCondition.create(:paralysis)
        expect(condition).to be_a(Condition::Paralysis)
      end

      it '返されたインスタンスは:paralysisという名前を持つ' do
        condition = StatusCondition.create(:paralysis)
        expect(condition.name).to eq(:paralysis)
      end
    end

    context 'タイプが:poisonの場合' do
      it 'Condition::Poisonのインスタンスを返す' do
        condition = StatusCondition.create(:poison)
        expect(condition).to be_a(Condition::Poison)
      end

      it '返されたインスタンスは:poisonという名前を持つ' do
        condition = StatusCondition.create(:poison)
        expect(condition.name).to eq(:poison)
      end
    end

    context '未知のタイプが渡された場合' do
      it 'ArgumentErrorを発生させる' do
        expect { StatusCondition.create(:unknown) }.to raise_error(ArgumentError, 'Unknown status condition type: unknown')
      end

      it ':frozenなど他の未実装タイプでもArgumentErrorを発生させる' do
        expect { StatusCondition.create(:frozen) }.to raise_error(ArgumentError, 'Unknown status condition type: frozen')
      end

      it '文字列型で渡してもArgumentErrorを発生させる' do
        expect { StatusCondition.create('burned') }.to raise_error(ArgumentError, 'Unknown status condition type: burned')
      end
    end

    context '生成されたインスタンスの動作' do
      it ':burnedで生成したインスタンスはmove_rateが1を返す' do
        condition = StatusCondition.create(:burned)
        expect(condition.move_rate).to eq(1)
      end

      it ':paralysisで生成したインスタンスはmove_rateが0.5を返す' do
        condition = StatusCondition.create(:paralysis)
        expect(condition.move_rate).to eq(0.5)
      end

      it ':poisonで生成したインスタンスはmove_rateが1を返す' do
        condition = StatusCondition.create(:poison)
        expect(condition.move_rate).to eq(1)
      end
    end
  end
end
