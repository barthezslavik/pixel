require 'oily_png'
require 'pp'

def color(pixel)
  [:r,:g,:b].map{|c| ChunkyPNG::Color.send(c, pixel)}
end

image = ChunkyPNG::Image.from_file('grid_original.png')
working_image = image.dup

#size = [80, 43]

data = []
by_x = []

(0..image.width-1).each do |x|
  data[x] = 0
  (0..image.height-1).each do |y|
    if color(working_image.get_pixel(x,y)) == [255,255,255]
      data[x] += 1
    end
    #data << { x: x, y:y, color: color(working_image.get_pixel(x,y)) }
  end
  by_x << data[x]
end

abort by_x.inspect
