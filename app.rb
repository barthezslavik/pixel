require 'sinatra'
require 'oily_png'
require 'pp'

require_relative 'parser'

set :public_folder, File.dirname(__FILE__) + '/static'

get '/' do
  p = Parser.new

  image = ChunkyPNG::Image.from_file('header.png')
  png = ChunkyPNG::Image.new(image.width, image.height, :white)

  p.span(image).each do |x|
    (0..image.height-1).each do |y|
      png[x,y] = ChunkyPNG::Color(:black)
    end
  end

  png.save('static/spaces.png')

  haml :index
end
