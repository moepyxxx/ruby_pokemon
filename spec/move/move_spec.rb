require_relative '../../move/move'

RSpec.describe Move do
  describe '#initialize' do
    context '必須パラメータのみ渡された場合' do
      it '名前、タイプ、威力、最大PPを持つ技が作成される' do
        move = Move.new(name: 'たいあたり', type: 'ノーマル', max_pp: 35, power: 40)

        expect(move.name).to eq('たいあたり')
        expect(move.type).to eq('ノーマル')
        expect(move.max_pp).to eq(35)
        expect(move.power).to eq(40)
        expect(move.condition_effective).to be_nil
        expect(move.condition_effective_rate).to be_nil
      end
    end

    context '状態異常効果が渡された場合' do
      it '状態異常効果と発動率を持つ技が作成される' do
        move = Move.new(
          name: '10まんボルト',
          type: 'でんき',
          max_pp: 15,
          power: 90,
          condition_effective: :paralysis,
          condition_effective_rate: 0.1
        )

        expect(move.name).to eq('10まんボルト')
        expect(move.type).to eq('でんき')
        expect(move.max_pp).to eq(15)
        expect(move.power).to eq(90)
        expect(move.condition_effective).to eq(:paralysis)
        expect(move.condition_effective_rate).to eq(0.1)
      end
    end

    context '威力0の技の場合' do
      it '威力0の技が作成される' do
        move = Move.new(name: 'でんじは', type: 'でんき', max_pp: 20, power: 0)

        expect(move.power).to eq(0)
      end
    end
  end

  describe 'attr_reader' do
    let(:move) do
      Move.new(
        name: 'かえんほうしゃ',
        type: 'ほのお',
        max_pp: 15,
        power: 90,
        condition_effective: :burned,
        condition_effective_rate: 0.1
      )
    end

    it '名前を読み取ることができる' do
      expect(move.name).to eq('かえんほうしゃ')
    end

    it 'タイプを読み取ることができる' do
      expect(move.type).to eq('ほのお')
    end

    it '威力を読み取ることができる' do
      expect(move.power).to eq(90)
    end

    it '最大PPを読み取ることができる' do
      expect(move.max_pp).to eq(15)
    end

    it '状態異常効果を読み取ることができる' do
      expect(move.condition_effective).to eq(:burned)
    end

    it '状態異常発動率を読み取ることができる' do
      expect(move.condition_effective_rate).to eq(0.1)
    end

    it '名前を書き込むことはできない' do
      expect { move.name = '別の技' }.to raise_error(NoMethodError)
    end

    it 'タイプを書き込むことはできない' do
      expect { move.type = '別のタイプ' }.to raise_error(NoMethodError)
    end

    it '威力を書き込むことはできない' do
      expect { move.power = 100 }.to raise_error(NoMethodError)
    end

    it '最大PPを書き込むことはできない' do
      expect { move.max_pp = 20 }.to raise_error(NoMethodError)
    end

    it '状態異常効果を書き込むことはできない' do
      expect { move.condition_effective = :poison }.to raise_error(NoMethodError)
    end

    it '状態異常発動率を書き込むことはできない' do
      expect { move.condition_effective_rate = 0.2 }.to raise_error(NoMethodError)
    end
  end
end
