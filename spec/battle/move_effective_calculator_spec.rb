require_relative '../../battle/move_effective_calculator'

RSpec.describe MoveEffectiveCalculator do
  describe '.calculate' do
    let(:move) do
      double('Move',
        type: :fire,
        power: 50,
        condition_effective: nil,
        condition_effective_rate: nil
      )
    end

    let(:attacker) do
      double('BattlePokemon',
        level: 10,
        type: :fire,
        condition: nil,
        can_move?: true
      )
    end

    let(:receiver) do
      double('BattlePokemon',
        type: :grass,
        condition: nil
      )
    end

    context '通常の攻撃の場合' do
      it 'ダメージ、クリティカルフラグ、相性倍率、ヒットフラグを含むハッシュを返す' do
        allow(DamageCalculator).to receive(:calculate).and_return([1000, false])

        result = MoveEffectiveCalculator.calculate(move, attacker, receiver)

        expect(result[:damage]).to eq(1000)
        expect(result[:is_critical]).to be false
        expect(result[:effectiveness]).to eq(2.0) # fire vs grass
        expect(result[:is_hit]).to be true
        expect(result[:condition]).to be_nil
        expect(result[:is_start_condition_effective]).to be false
      end

      it 'TypeEffectivenessとDamageCalculatorを正しく呼び出す' do
        expect(TypeEffectiveness).to receive(:effectiveness).with(:fire, :grass).and_return(2.0)
        expect(DamageCalculator).to receive(:calculate).with(
          attacker_level: 10,
          move_power: 50,
          effectiveness: 2.0
        ).and_return([1000, false])

        MoveEffectiveCalculator.calculate(move, attacker, receiver)
      end
    end

    context '攻撃者が状態異常で動けない場合' do
      let(:paralyzed_attacker) do
        condition = double('Condition', name: :paralysis)
        double('BattlePokemon',
          level: 10,
          type: :fire,
          condition: condition,
          can_move?: false
        )
      end

      it 'ダメージ0、ヒットせず、can_not_move_for_conditionがtrueのハッシュを返す' do
        result = MoveEffectiveCalculator.calculate(move, paralyzed_attacker, receiver)

        expect(result[:damage]).to eq(0)
        expect(result[:is_critical]).to be false
        expect(result[:effectiveness]).to be_nil
        expect(result[:is_hit]).to be false
        expect(result[:can_not_move_for_condition]).to be true
        expect(result[:condition]).not_to be_nil
        expect(result[:is_start_condition_effective]).to be false
      end

      it 'DamageCalculatorを呼び出さない' do
        expect(DamageCalculator).not_to receive(:calculate)

        MoveEffectiveCalculator.calculate(move, paralyzed_attacker, receiver)
      end
    end

    context '状態異常を付与する技の場合' do
      let(:move_with_condition) do
        double('Move',
          type: :fire,
          power: 50,
          condition_effective: :burned,
          condition_effective_rate: 0.1
        )
      end

      context '状態異常が発動した場合' do
        it 'is_start_condition_effectiveがtrueで、新しい状態異常を返す' do
          allow(DamageCalculator).to receive(:calculate).and_return([1000, false])
          allow(MoveEffectiveCalculator).to receive(:rand).and_return(0.05) # 0.05 < 0.1

          result = MoveEffectiveCalculator.calculate(move_with_condition, attacker, receiver)

          expect(result[:is_start_condition_effective]).to be true
          expect(result[:condition]).not_to be_nil
          expect(result[:condition]).to be_a(Condition::Burned)
        end
      end

      context '状態異常が発動しなかった場合' do
        it 'is_start_condition_effectiveがfalseで、元のconditionを返す' do
          allow(DamageCalculator).to receive(:calculate).and_return([1000, false])
          allow(MoveEffectiveCalculator).to receive(:rand).and_return(0.5) # 0.5 >= 0.1

          result = MoveEffectiveCalculator.calculate(move_with_condition, attacker, receiver)

          expect(result[:is_start_condition_effective]).to be false
          expect(result[:condition]).to be_nil
        end
      end

      context '受け手が既に状態異常の場合' do
        let(:receiver_with_condition) do
          existing_condition = double('Condition', name: :poison)
          double('BattlePokemon',
            type: :grass,
            condition: existing_condition
          )
        end

        it '新しい状態異常は発動せず、既存の状態異常を維持する' do
          allow(DamageCalculator).to receive(:calculate).and_return([1000, false])
          allow(MoveEffectiveCalculator).to receive(:rand).and_return(0.05)

          result = MoveEffectiveCalculator.calculate(move_with_condition, attacker, receiver_with_condition)

          expect(result[:is_start_condition_effective]).to be false
          expect(result[:condition].name).to eq(:poison)
        end
      end
    end

    context '状態異常効果がない技の場合' do
      it 'is_start_condition_effectiveがfalseで、conditionはnilのまま' do
        allow(DamageCalculator).to receive(:calculate).and_return([1000, false])

        result = MoveEffectiveCalculator.calculate(move, attacker, receiver)

        expect(result[:is_start_condition_effective]).to be false
        expect(result[:condition]).to be_nil
      end
    end

    context '異なるタイプ相性の場合' do
      it 'みず vs ほのお（ばつぐん）' do
        water_move = double('Move', type: :water, power: 50, condition_effective: nil, condition_effective_rate: nil)
        fire_receiver = double('BattlePokemon', type: :fire, condition: nil)

        allow(DamageCalculator).to receive(:calculate).and_return([2000, false])

        result = MoveEffectiveCalculator.calculate(water_move, attacker, fire_receiver)

        expect(result[:effectiveness]).to eq(2.0)
      end

      it 'みず vs くさ（いまいち）' do
        water_move = double('Move', type: :water, power: 50, condition_effective: nil, condition_effective_rate: nil)
        grass_receiver = double('BattlePokemon', type: :grass, condition: nil)

        allow(DamageCalculator).to receive(:calculate).and_return([500, false])

        result = MoveEffectiveCalculator.calculate(water_move, attacker, grass_receiver)

        expect(result[:effectiveness]).to eq(0.5)
      end
    end
  end
end
