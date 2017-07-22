require 'rubygems'
require 'bundler'

Bundler.require

Dir.glob('./app/models/*.rb').each { |file| require file }

require './app.rb'
run Sinatra::Application
