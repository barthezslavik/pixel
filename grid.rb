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

  by_x.map {|col| (col*100/image.height).to_i }.each_with_index do |d, i|
    result << i if d < 95
  end

  result
end

def horizontal(image)
  blocks = vertical(image)
  tracks = []

  blocks.each_with_index do |b,i|
    tracks << [b, blocks[i+1]]
  end

  tracks = tracks[0...-1]

  data = []
  result = []
  tracks.each do |t|
    (0..image.height-1).each do |y|
      data[y] = 0
      (t[0]+1..t[1]-1).each do |x|
        if color(image.get_pixel(x,y)) == [255,255,255]
          data[y] += 1
        end
      end
      d = ((data[y]*100)/(t[1]-t[0]-1)).to_i
      result << [t[0]..t[1], y] if d < 100
    end
  end
  result
end

image = ChunkyPNG::Image.from_file('grid_original.png')
png = ChunkyPNG::Image.new(image.width, image.height, :white)

abort horizontal(image).inspect

vertical(image).each do |x|
  (0..image.height-1).each do |y|
    png[x,y] = ChunkyPNG::Color(:black)
  end
end

png.save('out.png')
