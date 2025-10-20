#!/usr/bin/env ruby
require 'bundler/setup'
require 'tty-prompt'

prompt = TTY::Prompt.new

choice = prompt.select("何をしますか？", %w(起動 停止 再起動 終了))
puts "#{choice}を実行します"