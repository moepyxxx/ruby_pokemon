require_relative '../../pokemon/player_pokemon'
require_relative '../../pokemon/pokemon'

RSpec.describe PlayerPokemon do
  let(:base_pokemon) { Pokemon.new('ピカチュウ', 'でんき') }

  describe '#initialize' do
    context '技が渡された場合' do
      it 'ポケモン、レベル、技、計算されたHPを持つPlayerPokemonが作成される' do
        moves = ['10まんボルト', 'でんこうせっか']
        player_pokemon = PlayerPokemon.new(base_pokemon, 10, moves)

        expect(player_pokemon.pokemon).to eq(base_pokemon)
        expect(player_pokemon.level).to eq(10)
        expect(player_pokemon.moves).to eq(moves)
        expect(player_pokemon.hp).to eq(150)
      end
    end

    context '技が渡されなかった場合' do
      it '空の技配列を持つPlayerPokemonが作成される' do
        player_pokemon = PlayerPokemon.new(base_pokemon, 5)

        expect(player_pokemon.pokemon).to eq(base_pokemon)
        expect(player_pokemon.level).to eq(5)
        expect(player_pokemon.moves).to eq([])
        expect(player_pokemon.hp).to eq(75)
      end
    end

    context '異なるレベルの場合' do
      it 'レベル1のときHPはレベル * 15で計算される' do
        player_pokemon = PlayerPokemon.new(base_pokemon, 1)
        expect(player_pokemon.hp).to eq(15)
      end

      it 'レベル20のときHPはレベル * 15で計算される' do
        player_pokemon = PlayerPokemon.new(base_pokemon, 20)
        expect(player_pokemon.hp).to eq(300)
      end

      it 'レベル50のときHPはレベル * 15で計算される' do
        player_pokemon = PlayerPokemon.new(base_pokemon, 50)
        expect(player_pokemon.hp).to eq(750)
      end
    end
  end

  describe 'attr_reader' do
    let(:player_pokemon) { PlayerPokemon.new(base_pokemon, 10, ['10まんボルト']) }

    it 'ポケモンを読み取ることができる' do
      expect(player_pokemon.pokemon).to eq(base_pokemon)
    end

    it 'レベルを読み取ることができる' do
      expect(player_pokemon.level).to eq(10)
    end

    it '技を読み取ることができる' do
      expect(player_pokemon.moves).to eq(['10まんボルト'])
    end

    it 'HPを読み取ることができる' do
      expect(player_pokemon.hp).to eq(150)
    end

    it 'ポケモンを書き込むことはできない' do
      expect { player_pokemon.pokemon = Pokemon.new('別', 'タイプ') }.to raise_error(NoMethodError)
    end

    it 'レベルを書き込むことはできない' do
      expect { player_pokemon.level = 20 }.to raise_error(NoMethodError)
    end

    it '技を書き込むことはできない' do
      expect { player_pokemon.moves = ['別の技'] }.to raise_error(NoMethodError)
    end

    it 'HPを書き込むことはできない' do
      expect { player_pokemon.hp = 200 }.to raise_error(NoMethodError)
    end
  end
end
