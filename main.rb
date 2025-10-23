#!/usr/bin/env ruby
require 'bundler/setup'
require_relative 'pokemon/player_pokemon'
require_relative 'battle/battle'
require_relative 'serif'
require_relative 'move/move'
require_relative 'pokemon/pokemon'

# waninoko = Pokemon.new("ワニノコ", :grass, ["たいあたり", "みずでっぽう"])
hinoarashi = Pokemon.new("ヒノアラシ", :fire, [Move.new("たいあたり", :normal, 5), Move.new("ひのこ", :fire, 8)])
chikorita = Pokemon.new("チコリータ", :grass, [Move.new("たいあたり", :normal, 5), Move.new("はっぱカッター", :grass, 8)])

# プレイヤーのポケモンをセット(ゲットしたイメージ)
player_pokemon = PlayerPokemon.new(hinoarashi, 5, hinoarashi.moves[0..3])

# バトル用にセット
player_battle_pokemon = BattlePokemon.new(player_pokemon.pokemon.name, player_pokemon.pokemon.type, player_pokemon.moves, player_pokemon.level, remainHp: player_pokemon.hp)
enemy_battle_pokemon = BattlePokemon.new(chikorita.name, chikorita.type, chikorita.moves, 5)

battle = Battle.new(player_battle_pokemon, enemy_battle_pokemon)
battle.execute
