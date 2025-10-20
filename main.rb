#!/usr/bin/env ruby
require 'bundler/setup'
require_relative 'pokemon/water_pokemon'
require_relative 'pokemon/player_pokemon'
require_relative 'pokemon/grass_pokemon'
require_relative 'pokemon/fire_pokemon'
require_relative 'battle/battle'
require_relative 'serif'

# waninoko = Pokemon.new("ワニノコ", :grass, ["たいあたり", "みずでっぽう"])
hinoarashi = Pokemon.new("ヒノアラシ", :fire, ["たいあたり", "ひのこ"])
chikorita = Pokemon.new("チコリータ", :grass, ["たいあたり", "はっぱカッター"])

# プレイヤーのポケモンをセット(ゲットしたイメージ)
player_pokemon = PlayerPokemon.new(hinoarashi, 5, hinoarashi.moves, 100)

# バトル用にセット
player_battle_pokemon = BattlePokemon.new(player_pokemon.pokemon.name, player_pokemon.pokemon.type, player_pokemon.moves, player_pokemon.level, player_pokemon.hp)
enemy_battle_pokemon = BattlePokemon.new(chikorita.name, chikorita.type, chikorita.moves, 4, 50)

battle = Battle.new(player_battle_pokemon, enemy_battle_pokemon)
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