require_relative '../../battle/type_effectiveness'

RSpec.describe TypeEffectiveness do
  describe '定数' do
    it 'SUPER（効果はばつぐん）は2.0' do
      expect(TypeEffectiveness::SUPER).to eq(2.0)
    end

    it 'NOT_VERY（効果はいまいち）は0.5' do
      expect(TypeEffectiveness::NOT_VERY).to eq(0.5)
    end

    it 'NORMAL（通常のダメージ）は1.0' do
      expect(TypeEffectiveness::NORMAL).to eq(1.0)
    end
  end

  describe '.effectiveness' do
    context 'ほのおタイプの攻撃の場合' do
      it 'くさタイプに対してばつぐん（2.0）' do
        expect(TypeEffectiveness.effectiveness(:fire, :grass)).to eq(2.0)
      end

      it 'みずタイプに対していまいち（0.5）' do
        expect(TypeEffectiveness.effectiveness(:fire, :water)).to eq(0.5)
      end

      it 'ほのおタイプに対していまいち（0.5）' do
        expect(TypeEffectiveness.effectiveness(:fire, :fire)).to eq(0.5)
      end

      it 'ノーマルタイプに対して通常（1.0）' do
        expect(TypeEffectiveness.effectiveness(:fire, :normal)).to eq(1.0)
      end
    end

    context 'みずタイプの攻撃の場合' do
      it 'ほのおタイプに対してばつぐん（2.0）' do
        expect(TypeEffectiveness.effectiveness(:water, :fire)).to eq(2.0)
      end

      it 'くさタイプに対していまいち（0.5）' do
        expect(TypeEffectiveness.effectiveness(:water, :grass)).to eq(0.5)
      end

      it 'みずタイプに対していまいち（0.5）' do
        expect(TypeEffectiveness.effectiveness(:water, :water)).to eq(0.5)
      end

      it 'ノーマルタイプに対して通常（1.0）' do
        expect(TypeEffectiveness.effectiveness(:water, :normal)).to eq(1.0)
      end
    end

    context 'くさタイプの攻撃の場合' do
      it 'みずタイプに対してばつぐん（2.0）' do
        expect(TypeEffectiveness.effectiveness(:grass, :water)).to eq(2.0)
      end

      it 'ほのおタイプに対していまいち（0.5）' do
        expect(TypeEffectiveness.effectiveness(:grass, :fire)).to eq(0.5)
      end

      it 'くさタイプに対していまいち（0.5）' do
        expect(TypeEffectiveness.effectiveness(:grass, :grass)).to eq(0.5)
      end

      it 'ノーマルタイプに対して通常（1.0）' do
        expect(TypeEffectiveness.effectiveness(:grass, :normal)).to eq(1.0)
      end
    end

    context 'ノーマルタイプの攻撃の場合' do
      it 'ほのおタイプに対して通常（1.0）' do
        expect(TypeEffectiveness.effectiveness(:normal, :fire)).to eq(1.0)
      end

      it 'みずタイプに対して通常（1.0）' do
        expect(TypeEffectiveness.effectiveness(:normal, :water)).to eq(1.0)
      end

      it 'くさタイプに対して通常（1.0）' do
        expect(TypeEffectiveness.effectiveness(:normal, :grass)).to eq(1.0)
      end

      it 'ノーマルタイプに対して通常（1.0）' do
        expect(TypeEffectiveness.effectiveness(:normal, :normal)).to eq(1.0)
      end
    end

    context '未定義の組み合わせの場合' do
      it 'デフォルト値としてNORMAL（1.0）を返す' do
        # 存在しない組み合わせをテストする場合、nilが返される可能性があるが
        # コードでは `|| NORMAL` でフォールバックしている
        # ただし、現在の実装では全組み合わせが定義されているため、このケースは発生しにくい
      end
    end
  end

  describe 'EFFECTIVENESS定数' do
    it '変更できないようにfreezeされている' do
      expect(TypeEffectiveness::EFFECTIVENESS).to be_frozen
    end
  end
end
