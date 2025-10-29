require_relative '../../battle/damage_calculator'

RSpec.describe DamageCalculator do
  describe '.calculate' do
    context '通常のダメージ計算' do
      it 'レベル、技の威力、相性倍率を掛けた値と、クリティカルフラグを配列で返す' do
        allow(DamageCalculator).to receive(:rand).and_return(0.5) # クリティカルにならない

        damage, is_critical = DamageCalculator.calculate(
          attacker_level: 10,
          move_power: 50,
          effectiveness: 1.0
        )

        expect(damage).to eq(10 * 50 * 1.0 * 1)
        expect(is_critical).to be false
      end

      it '相性倍率が2.0の場合、ダメージが2倍になる' do
        allow(DamageCalculator).to receive(:rand).and_return(0.5)

        damage, is_critical = DamageCalculator.calculate(
          attacker_level: 10,
          move_power: 50,
          effectiveness: 2.0
        )

        expect(damage).to eq(10 * 50 * 2.0 * 1)
        expect(is_critical).to be false
      end

      it '相性倍率が0.5の場合、ダメージが半分になる' do
        allow(DamageCalculator).to receive(:rand).and_return(0.5)

        damage, is_critical = DamageCalculator.calculate(
          attacker_level: 10,
          move_power: 50,
          effectiveness: 0.5
        )

        expect(damage).to eq(10 * 50 * 0.5 * 1)
        expect(is_critical).to be false
      end
    end

    context 'クリティカルヒットの場合' do
      it 'randが0.09以下の場合、クリティカルが発生してダメージが1.5倍になる' do
        allow(DamageCalculator).to receive(:rand).and_return(0.09)

        damage, is_critical = DamageCalculator.calculate(
          attacker_level: 10,
          move_power: 50,
          effectiveness: 1.0
        )

        expect(damage).to eq(10 * 50 * 1.0 * 1.5)
        expect(is_critical).to be true
      end

      it 'randが0.1以上の場合、クリティカルが発生しない' do
        allow(DamageCalculator).to receive(:rand).and_return(0.1)

        damage, is_critical = DamageCalculator.calculate(
          attacker_level: 10,
          move_power: 50,
          effectiveness: 1.0
        )

        expect(damage).to eq(10 * 50 * 1.0 * 1)
        expect(is_critical).to be false
      end

      it 'クリティカル時は相性倍率も考慮される' do
        allow(DamageCalculator).to receive(:rand).and_return(0.05)

        damage, is_critical = DamageCalculator.calculate(
          attacker_level: 10,
          move_power: 50,
          effectiveness: 2.0
        )

        expect(damage).to eq(10 * 50 * 2.0 * 1.5)
        expect(is_critical).to be true
      end
    end

    context '異なるパラメータの組み合わせ' do
      it 'レベル20、威力100、相性等倍の場合' do
        allow(DamageCalculator).to receive(:rand).and_return(0.5)

        damage, is_critical = DamageCalculator.calculate(
          attacker_level: 20,
          move_power: 100,
          effectiveness: 1.0
        )

        expect(damage).to eq(20 * 100 * 1.0 * 1)
        expect(is_critical).to be false
      end

      it 'レベル5、威力40、相性ばつぐんの場合' do
        allow(DamageCalculator).to receive(:rand).and_return(0.5)

        damage, is_critical = DamageCalculator.calculate(
          attacker_level: 5,
          move_power: 40,
          effectiveness: 2.0
        )

        expect(damage).to eq(5 * 40 * 2.0 * 1)
        expect(is_critical).to be false
      end
    end

    context '戻り値の形式' do
      it '配列で[ダメージ, クリティカルフラグ]の形式で返される' do
        allow(DamageCalculator).to receive(:rand).and_return(0.5)

        result = DamageCalculator.calculate(
          attacker_level: 10,
          move_power: 50,
          effectiveness: 1.0
        )

        expect(result).to be_an(Array)
        expect(result.length).to eq(2)
        expect(result[0]).to be_a(Numeric)
        expect([true, false]).to include(result[1])
      end
    end
  end
end
