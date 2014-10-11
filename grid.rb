require 'oily_png'
require 'pp'

def color(pixel)
  [:r, :g, :b].map{|c| ChunkyPNG::Color.send(c, pixel)}
end

def vertical(image)
  data = []
  by_x = []
  result = []

  (0..image.width-1).each do |x|
    data[x] = 0
    (0..image.height-1).each do |y|
      if color(image.get_pixel(x,y)) == [255,255,255]
        data[x] += 1
      end
    end
    by_x << data[x]
  end

  by_x.map {|g| (g*100/image.height).to_i }.each_with_index do |d, i|
    result << i if d < 95
  end

  result
end

image = ChunkyPNG::Image.from_file('grid_original.png')
#working_image = image.dup

by_y = []

c = []
(0..image.height-1).each do |y|
  #data[y] = 0
  (0..image.width-1).each do |x|
    if color(image.get_pixel(x,y)) != [255,255,255]
      #data[y] += 1
      c << [x,y]
    end
  end
  #by_y << data[y]
end

#abort c.inspect

#abort [vertical_at, by_y].inspect

#horizontal_at = []
#by_y.map {|g| (g*100/size[:x]).to_i }.each_with_index do |d, i|
#  horizontal_at << i if d < 96
#end


png = ChunkyPNG::Image.new(image.width, image.height, :white)

vertical(image).each do |x|
  (0..image.height-1).each do |y|
    png[x,y] = ChunkyPNG::Color(:black)
  end
end

#horizontal_at.each do |y|
#  (0..size[:x]-1).each do |x|
#    png[x,y] = ChunkyPNG::Color(:black)
#  end
#end

png.save('out.png')
