#!/usr/bin/env ruby
require 'bundler/setup'
require 'tty-prompt'
require_relative 'pokemon/pokemon'

prompt = TTY::Prompt.new

# choice = prompt.select("何をしますか？", %w(起動 停止 再起動 終了))
# puts "#{choice}を実行します"

pikachu = Pokemon.new("ピカチュウ", "でんき", 100)
prompt.say("ポケモンが登場した！")
prompt.say(pikachu.status)