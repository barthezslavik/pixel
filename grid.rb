require 'oily_png'
require 'pp'

def color(pixel)
  [:r,:g,:b].map{|c| ChunkyPNG::Color.send(c, pixel)}
end

image = ChunkyPNG::Image.from_file('grid_original.png')
working_image = image.dup

data = []
by_x = []

size = { x:image.width, y:image.height }

(0..image.width-1).each do |x|
  data[x] = 0
  (0..image.height-1).each do |y|
    if color(working_image.get_pixel(x,y)) == [255,255,255]
      data[x] += 1
    end
  end
  by_x << data[x]
end

distr = by_x.map {|g| (g*100/size[:y]).to_i }

lines_at = []

distr.each_with_index do |d, i|
  if d < 95
    lines_at << i
  end
end

png = ChunkyPNG::Image.new(size[:x], size[:y], :white)
lines_at.each do |x|
  (0..size[:y]-1).each do |y|
    png[x,y] = ChunkyPNG::Color(:black)
  end
end

png.save('out.png')
