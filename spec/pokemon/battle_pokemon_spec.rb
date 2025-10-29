require_relative '../../pokemon/battle_pokemon'

RSpec.describe BattlePokemon do
  describe '#initialize' do
    context 'remainHpが渡されなかった場合' do
      it 'HPはレベル * 15で計算される' do
        moves = ['10まんボルト', 'でんこうせっか']
        battle_pokemon = BattlePokemon.new('ピカチュウ', 'でんき', moves, 10)

        expect(battle_pokemon.name).to eq('ピカチュウ')
        expect(battle_pokemon.type).to eq('でんき')
        expect(battle_pokemon.moves).to eq(moves)
        expect(battle_pokemon.level).to eq(10)
        expect(battle_pokemon.hp).to eq(150)
      end
    end

    context 'remainHpが渡された場合' do
      it '指定されたremainHpの値が使用される' do
        moves = ['10まんボルト']
        battle_pokemon = BattlePokemon.new('ピカチュウ', 'でんき', moves, 10, remainHp: 80)

        expect(battle_pokemon.hp).to eq(80)
      end
    end

    context '異なるレベルの場合' do
      it 'レベル5のときHPはレベル * 15で計算される' do
        battle_pokemon = BattlePokemon.new('ピカチュウ', 'でんき', [], 5)
        expect(battle_pokemon.hp).to eq(75)
      end

      it 'レベル20のときHPはレベル * 15で計算される' do
        battle_pokemon = BattlePokemon.new('ピカチュウ', 'でんき', [], 20)
        expect(battle_pokemon.hp).to eq(300)
      end
    end
  end

  describe '#status' do
    context '状態異常がnil（Normal）の場合' do
      it 'Normalの状態を含むステータス文字列が返される' do
        battle_pokemon = BattlePokemon.new('ピカチュウ', 'でんき', [], 10)

        expect(battle_pokemon.status).to eq('ピカチュウ (Type: でんき, Level: 10) - HP: 150 Condition: Normal')
      end
    end

    context '状態異常が設定されている場合' do
      it '設定された状態異常を含むステータス文字列が返される' do
        battle_pokemon = BattlePokemon.new('ピカチュウ', 'でんき', [], 10)
        battle_pokemon.apply_condition!(:paralysis)

        expect(battle_pokemon.status).to eq('ピカチュウ (Type: でんき, Level: 10) - HP: 150 Condition: paralysis')
      end
    end

    context 'ダメージを受けた後の場合' do
      it '更新されたHPを含むステータス文字列が返される' do
        battle_pokemon = BattlePokemon.new('ピカチュウ', 'でんき', [], 10)
        battle_pokemon.take_damage!(50)

        expect(battle_pokemon.status).to eq('ピカチュウ (Type: でんき, Level: 10) - HP: 100 Condition: Normal')
      end
    end
  end

  describe '#take_damage!' do
    let(:battle_pokemon) { BattlePokemon.new('ピカチュウ', 'でんき', [], 10) }

    it 'ダメージ量分HPが減少する' do
      initial_hp = battle_pokemon.hp
      battle_pokemon.take_damage!(30)

      expect(battle_pokemon.hp).to eq(initial_hp - 30)
    end

    it '複数回HPを減少させることができる' do
      battle_pokemon.take_damage!(20)
      battle_pokemon.take_damage!(30)

      expect(battle_pokemon.hp).to eq(100)
    end

    it 'HPをゼロまたはマイナスまで減少させることができる' do
      battle_pokemon.take_damage!(200)

      expect(battle_pokemon.hp).to eq(-50)
    end

    it 'HPをその場で変更する' do
      expect { battle_pokemon.take_damage!(10) }.to change { battle_pokemon.hp }.by(-10)
    end
  end

  describe '#apply_condition!' do
    let(:battle_pokemon) { BattlePokemon.new('ピカチュウ', 'でんき', [], 10) }

    it '状態異常を設定する' do
      battle_pokemon.apply_condition!(:poison)

      expect(battle_pokemon.status).to include('Condition: poison')
    end

    it '状態異常を変更できる' do
      battle_pokemon.apply_condition!(:paralysis)
      battle_pokemon.apply_condition!(:burned)

      expect(battle_pokemon.status).to include('Condition: burned')
    end
  end

  describe 'attr_reader' do
    let(:battle_pokemon) { BattlePokemon.new('ピカチュウ', 'でんき', ['10まんボルト'], 10) }

    it '名前を読み取ることができる' do
      expect(battle_pokemon.name).to eq('ピカチュウ')
    end

    it 'タイプを読み取ることができる' do
      expect(battle_pokemon.type).to eq('でんき')
    end

    it 'HPを読み取ることができる' do
      expect(battle_pokemon.hp).to eq(150)
    end

    it '技を読み取ることができる' do
      expect(battle_pokemon.moves).to eq(['10まんボルト'])
    end

    it 'レベルを読み取ることができる' do
      expect(battle_pokemon.level).to eq(10)
    end

    it '名前を書き込むことはできない' do
      expect { battle_pokemon.name = '別の名前' }.to raise_error(NoMethodError)
    end

    it 'タイプを書き込むことはできない' do
      expect { battle_pokemon.type = '別のタイプ' }.to raise_error(NoMethodError)
    end

    it 'HPを直接書き込むことはできない' do
      expect { battle_pokemon.hp = 200 }.to raise_error(NoMethodError)
    end

    it '技を書き込むことはできない' do
      expect { battle_pokemon.moves = ['別の技'] }.to raise_error(NoMethodError)
    end

    it 'レベルを書き込むことはできない' do
      expect { battle_pokemon.level = 20 }.to raise_error(NoMethodError)
    end
  end
end
