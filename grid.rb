require 'oily_png'
require 'pp'

def color(pixel)
  [:r,:g,:b].map{|c| ChunkyPNG::Color.send(c, pixel)}
end

image = ChunkyPNG::Image.from_file('grid_original.png')
working_image = image.dup

data = []
by_x = []
by_y = []

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

(0..image.height-1).each do |y|
  data[y] = 0
  (0..image.width-1).each do |x|
    if color(working_image.get_pixel(x,y)) == [255,255,255]
      data[y] += 1
    end
  end
  by_y << data[y]
end

vertical_at = []
by_x.map {|g| (g*100/size[:y]).to_i }.each_with_index do |d, i|
  vertical_at << i if d < 95
end

horizontal_at = []
by_y.map {|g| (g*100/size[:x]).to_i }.each_with_index do |d, i|
  horizontal_at << i if d < 96
end

png = ChunkyPNG::Image.new(size[:x], size[:y], :white)

vertical_at.each do |x|
  (0..size[:y]-1).each do |y|
    png[x,y] = ChunkyPNG::Color(:black)
  end
end

horizontal_at.each do |y|
  (0..size[:x]-1).each do |x|
    png[x,y] = ChunkyPNG::Color(:black)
  end
end

png.save('out.png')
