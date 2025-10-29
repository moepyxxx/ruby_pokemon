require_relative '../../pokemon/pokemon'

RSpec.describe Pokemon do
  describe '#initialize' do
    context '技が渡された場合' do
      it '名前、タイプ、技を持つポケモンが作成される' do
        moves = ['たいあたり', 'ひっかく']
        pokemon = Pokemon.new('ピカチュウ', 'でんき', moves)

        expect(pokemon.name).to eq('ピカチュウ')
        expect(pokemon.type).to eq('でんき')
        expect(pokemon.moves).to eq(moves)
      end
    end

    context '技が渡されなかった場合' do
      it '空の技配列を持つポケモンが作成される' do
        pokemon = Pokemon.new('ピカチュウ', 'でんき')

        expect(pokemon.name).to eq('ピカチュウ')
        expect(pokemon.type).to eq('でんき')
        expect(pokemon.moves).to eq([])
      end
    end
  end

  describe 'attr_reader' do
    let(:pokemon) { Pokemon.new('フシギダネ', 'くさ', ['たいあたり']) }

    it '名前を読み取ることができる' do
      expect(pokemon.name).to eq('フシギダネ')
    end

    it 'タイプを読み取ることができる' do
      expect(pokemon.type).to eq('くさ')
    end

    it '技を読み取ることができる' do
      expect(pokemon.moves).to eq(['たいあたり'])
    end

    it '名前を書き込むことはできない' do
      expect { pokemon.name = '別の名前' }.to raise_error(NoMethodError)
    end

    it 'タイプを書き込むことはできない' do
      expect { pokemon.type = '別のタイプ' }.to raise_error(NoMethodError)
    end

    it '技を書き込むことはできない' do
      expect { pokemon.moves = ['別の技'] }.to raise_error(NoMethodError)
    end
  end
end
