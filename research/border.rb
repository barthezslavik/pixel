require 'oily_png'
require 'pp'

def color(pixel)
  [:r, :g, :b].map{ |c| ChunkyPNG::Color.send(c, pixel) }
end

def span(image)
  map = []
  data = []
  by_x = []
  (0..image.width-1).each do |x|
    data[x] = 0
    (0..image.height-1).each do |y|
      c = color(image.get_pixel(x,y))
      unless c == [245,245,245]
        data[x] += 1
      end
    end
    by_x << data[x]
  end

  stream = ""
  result = []

  block_on = false
  block_off = true

  by_x.each_with_index do |b,i|
    if b == 0 && block_on
      block_on = false
      result << i
      block_off = true
    end

    result << i if block_on

    if b != 0 && block_off
      block_on = true
      result << i
      block_off = false
    end
  end

  result
  abort result.inspect
end

image = ChunkyPNG::Image.from_file('header.png')
png = ChunkyPNG::Image.new(image.width, image.height, :white)

span(image).each do |x|
  (0..image.height-1).each do |y|
    png[x,y] = ChunkyPNG::Color(:black)
  end
end

png.save('out.png')
