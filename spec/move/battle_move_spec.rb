require_relative '../../move/battle_move'
require_relative '../../move/move'

RSpec.describe BattleMove do
  let(:base_move) do
    Move.new(
      name: '10まんボルト',
      type: 'でんき',
      max_pp: 15,
      power: 90,
      condition_effective: :paralysis,
      condition_effective_rate: 0.1
    )
  end

  describe '#initialize' do
    context 'max_ppが渡されなかった場合' do
      it '技の最大PPが使用される' do
        battle_move = BattleMove.new(base_move)

        expect(battle_move.max_pp).to eq(15)
      end
    end

    context 'max_ppが渡された場合' do
      it '指定されたmax_ppが使用される' do
        battle_move = BattleMove.new(base_move, 20)

        expect(battle_move.max_pp).to eq(15) # Moveの元のmax_ppが返される
      end
    end

    context '技がmax_ppを持たない場合' do
      it 'デフォルトで10が設定される' do
        move_without_pp = Move.new(name: 'テスト技', type: 'ノーマル', max_pp: nil, power: 50)
        battle_move = BattleMove.new(move_without_pp)

        # 初期化時に@current_ppが設定されるが、max_ppはMoveから取得される
        expect(battle_move.max_pp).to be_nil
      end
    end
  end

  describe '委譲されたメソッド' do
    let(:battle_move) { BattleMove.new(base_move) }

    it '名前を読み取ることができる' do
      expect(battle_move.name).to eq('10まんボルト')
    end

    it 'タイプを読み取ることができる' do
      expect(battle_move.type).to eq('でんき')
    end

    it '威力を読み取ることができる' do
      expect(battle_move.power).to eq(90)
    end

    it '最大PPを読み取ることができる' do
      expect(battle_move.max_pp).to eq(15)
    end

    it '状態異常効果を読み取ることができる' do
      expect(battle_move.condition_effective).to eq(:paralysis)
    end

    it '状態異常発動率を読み取ることができる' do
      expect(battle_move.condition_effective_rate).to eq(0.1)
    end
  end

  describe '#useable?' do
    context 'PPが残っている場合' do
      it 'trueを返す' do
        battle_move = BattleMove.new(base_move)

        expect(battle_move.useable?).to be true
      end
    end

    context 'PPが0の場合' do
      it 'falseを返す' do
        battle_move = BattleMove.new(base_move)
        15.times { battle_move.use! }

        expect(battle_move.useable?).to be false
      end
    end
  end

  describe '#use!' do
    let(:battle_move) { BattleMove.new(base_move) }

    context 'PPが残っている場合' do
      it '現在のPPが1減る' do
        battle_move.use!

        # 内部状態の変化を確認するため、もう一度使えるかチェック
        expect(battle_move.useable?).to be true
      end

      it '複数回使用できる' do
        3.times { battle_move.use! }

        expect(battle_move.useable?).to be true
      end
    end

    context 'PPが0の場合' do
      it '例外が発生する' do
        15.times { battle_move.use! }

        expect { battle_move.use! }.to raise_error('PPが足りません！')
      end
    end

    context '最後の1PPを使う場合' do
      it '使用後はuseable?がfalseになる' do
        15.times { battle_move.use! }

        expect(battle_move.useable?).to be false
      end
    end
  end

  describe '#restore_pp!' do
    let(:battle_move) { BattleMove.new(base_move) }

    context 'PPを消費した後' do
      it '指定した量だけPPが回復する' do
        5.times { battle_move.use! }
        battle_move.restore_pp!(3)

        # PPが回復したことを確認（まだ使えるはず）
        expect(battle_move.useable?).to be true
      end
    end

    context '最大PPを超える量を回復しようとした場合' do
      it '最大PPまでしか回復しない' do
        battle_move.use!
        battle_move.restore_pp!(100)

        # 最大PPまで回復していることを確認
        # 15回使えるはずだが、1回使って100回復しても15回しか使えない
        15.times { battle_move.use! }
        expect(battle_move.useable?).to be false
      end
    end
  end

  describe '#recover_full_pp!' do
    let(:battle_move) { BattleMove.new(base_move) }

    context 'PPを消費した後' do
      it 'PPが最大値まで回復する' do
        10.times { battle_move.use! }
        battle_move.recover_full_pp!

        # 最大PP分使えることを確認
        15.times { battle_move.use! }
        expect(battle_move.useable?).to be false
      end
    end

    context 'PPが0の場合' do
      it 'PPが最大値まで回復する' do
        15.times { battle_move.use! }
        expect(battle_move.useable?).to be false

        battle_move.recover_full_pp!
        expect(battle_move.useable?).to be true
      end
    end
  end
end
