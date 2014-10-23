require 'sinatra'
require_relative 'parser'

set :public_folder, File.dirname(__FILE__) + '/static'

get '/' do
  p = Parser.new
  p.detect_spaces
  haml :index
end
