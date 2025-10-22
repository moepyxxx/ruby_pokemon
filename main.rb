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
battle.execute
