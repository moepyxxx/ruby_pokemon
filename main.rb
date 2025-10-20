#!/usr/bin/env ruby
require 'bundler/setup'
require 'tty-prompt'
require_relative 'pokemon/water_pokemon'
require_relative 'pokemon/grass_pokemon'
require_relative 'pokemon/fire_pokemon'
require_relative 'battle/battle'

prompt = TTY::Prompt.new

# choice = prompt.select("何をしますか？", %w(起動 停止 再起動 終了))
# puts "#{choice}を実行します"

waninoko = WaterPokemon.new("ワニノコ", 100)
hinoarashi = FirePokemon.new("ヒノアラシ", 100)
chikorita = GrassPokemon.new("チコリータ", 100)

prompt.say(waninoko.status)
prompt.say(hinoarashi.status)
prompt.say(chikorita.status)
prompt.keypress("(続ける)")

battle = Battle.new(hinoarashi, waninoko)
introductions = battle.introduction
introductions.each do |line|
  prompt.say(line)
  prompt.keypress("(続ける)")
end
prompt.say("バトル開始")

while battle.battle_in_progress?
  prompt.say("#{battle.player_pokemon.name}(HP: #{battle.player_pokemon.hp}) - #{battle.enemy_pokemon.name}(HP: #{battle.enemy_pokemon.hp})")
  prompt.keypress("(続ける)")

  battle.select_move
  prompt.keypress("(続ける)")

  texts = battle.player_attack
  texts.each do |line|
    prompt.say(line)
    prompt.keypress("(続ける)")
  end

  if battle.battle_in_progress?
    texts = battle.enemy_attack
    texts.each do |line|
      prompt.say(line)
      prompt.keypress("(続ける)")
    end
  end
end

prompt.say("バトル終了！")

if battle.player_pokemon.hp <= 0
  prompt.say("#{battle.enemy_pokemon.name}の勝利！")
else
  prompt.say("#{battle.player_pokemon.name}の勝利！")
end