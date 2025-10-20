#!/usr/bin/env ruby
require 'bundler/setup'
require 'tty-prompt'
require_relative 'pokemon/water_pokemon'
require_relative 'pokemon/grass_pokemon'
require_relative 'pokemon/fire_pokemon'

prompt = TTY::Prompt.new

# choice = prompt.select("何をしますか？", %w(起動 停止 再起動 終了))
# puts "#{choice}を実行します"

waninoko = WaterPokemon.new("ワニノコ", 100)
hinoarashi = FirePokemon.new("ヒノアラシ", 100)
chikorita = GrassPokemon.new("チコリータ", 100)
prompt.say(waninoko.status)
prompt.say(hinoarashi.status)
prompt.say(chikorita.status)