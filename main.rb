#!/usr/bin/env ruby
require 'bundler/setup'
require_relative 'pokemon/player_pokemon'
require_relative 'battle/battle'
require_relative 'serif'
require_relative 'move/move'
require_relative 'move/battle_move'
require_relative 'pokemon/pokemon'

# waninoko = Pokemon.new("ワニノコ", :grass, ["たいあたり", "みずでっぽう"])
taiatari = Move.new("たいあたり", :normal, 5, 5)
hinoko = Move.new("ひのこ", :fire, 8, 3)
happa_cutter = Move.new("はっぱカッター", :grass, 8, 3)
hinoarashi = Pokemon.new("ヒノアラシ", :fire, [taiatari, hinoko])
chikorita = Pokemon.new("チコリータ", :grass, [taiatari, happa_cutter])

# プレイヤーのポケモンをセット(ゲットしたイメージ)
player_pokemon = PlayerPokemon.new(hinoarashi, 5, hinoarashi.moves.map { |move| BattleMove.new(move) })

# バトル用にセット
player_battle_pokemon = BattlePokemon.new(player_pokemon.pokemon.name, player_pokemon.pokemon.type, player_pokemon.moves, player_pokemon.level, remainHp: player_pokemon.hp)
enemy_battle_pokemon = BattlePokemon.new(chikorita.name, chikorita.type, chikorita.moves.map { |move| BattleMove.new(move) }, 5)

battle = Battle.new(player_battle_pokemon, enemy_battle_pokemon)
battle.execute
