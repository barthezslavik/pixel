require 'oily_png'
require_relative "convert"

def color?(pixel, r,g,b)
  px_r = ChunkyPNG::Color.r(pixel)
  px_g = ChunkyPNG::Color.g(pixel) 
  px_b = ChunkyPNG::Color.b(pixel)
  if px_r == r && px_g == g && px_b == b
    true 
  else
    false
  end
end

image = ChunkyPNG::Image.from_file('mini.png')
working_image = image.dup

bitmap = []

(0..image.width-1).each do |w|
  (0..image.height-1).each do |h|
    if color?(working_image.get_pixel(w,h), 0,0,0)
      bitmap << 1
    else
      bitmap << 0
    end
  end
end

canvas = []

bitmap.each_slice(image.width) do |b|
  canvas << b
end

png = ChunkyPNG::Image.new(image.width, image.height)
canvas.each_with_index do |c,width|
  c.each_with_index do |cc,height|
    png[height,width] = ChunkyPNG::Color.rgb(0, 0, 0) if cc == 1
    png[height,width] = ChunkyPNG::Color.rgb(255, 255, 255) if cc == 0
  end
end
png.save('filename.png')

abort canvas.inspect
