require 'oily_png'
require 'pp'

def color(pixel)
  [ChunkyPNG::Color.r(pixel), ChunkyPNG::Color.g(pixel), ChunkyPNG::Color.b(pixel)]
end

image = ChunkyPNG::Image.from_file('mini.png')
working_image = image.dup

data = []

(0..image.width-1).each do |x|
  (0..image.height-1).each do |y|
    data << { x: x, y:y, color: color(working_image.get_pixel(x,y)) }
  end
end

pp data
