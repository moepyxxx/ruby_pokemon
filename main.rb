#!/usr/bin/env ruby
require 'bundler/setup'
require_relative 'pokemon/water_pokemon'
require_relative 'pokemon/grass_pokemon'
require_relative 'pokemon/fire_pokemon'
require_relative 'battle/battle'
require_relative 'serif'

# choice = prompt.select("何をしますか？", %w(起動 停止 再起動 終了))
# puts "#{choice}を実行します"

waninoko = WaterPokemon.new("ワニノコ", 100)
hinoarashi = FirePokemon.new("ヒノアラシ", 100)
chikorita = GrassPokemon.new("チコリータ", 100)

Serif.say(waninoko.status)
Serif.say(hinoarashi.status)
Serif.say(chikorita.status)
Serif.next("(続ける)")

battle = Battle.new(hinoarashi, waninoko)
introductions = battle.introduction
introductions.each do |line|
  Serif.say(line)
  Serif.next("(続ける)")
end
Serif.say("バトル開始")

while battle.battle_in_progress?
  Serif.say("#{battle.player_pokemon.name}(HP: #{battle.player_pokemon.hp}) - #{battle.enemy_pokemon.name}(HP: #{battle.enemy_pokemon.hp})")

  battle.select_move
  Serif.next("(続ける)")

  texts = battle.player_attack
  texts.each do |line|
    Serif.say(line)
    Serif.next("(続ける)")
  end

  if battle.battle_in_progress?
    texts = battle.enemy_attack
    texts.each do |line|
      Serif.say(line)
      Serif.next("(続ける)")
    end
  end
end

Serif.say("バトル終了！")

if battle.player_pokemon.hp <= 0
  Serif.say("#{battle.enemy_pokemon.name}の勝利！")
else
  Serif.say("#{battle.player_pokemon.name}の勝利！")
end