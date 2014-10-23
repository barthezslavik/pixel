require 'sinatra'
require 'oily_png'
require 'pp'

require_relative 'parser'

set :public_folder, File.dirname(__FILE__) + '/static'

get '/' do
  @p = Parser.new('static/header.png')
  haml :index
end
