require 'sinatra'
require 'oily_png'
require 'pp'
require 'tesseract'

require_relative 'parser'
require_relative 'ocr'

set :public_folder, File.dirname(__FILE__) + '/static'

get '/' do
  @p = Parser.new('static/header.png')
  @ocr = Ocr.new
  haml :index
end
