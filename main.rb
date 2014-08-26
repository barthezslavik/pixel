require 'oily_png'

image = ChunkyPNG::Image.from_file('m.png')
working_image = image.dup

working_image.pixels.each_with_index do |pixel,i|
  r = ChunkyPNG::Color.r(pixel)
  g = ChunkyPNG::Color.g(pixel) 
  b = ChunkyPNG::Color.b(pixel)
  abort [r,g,b,i].inspect if r == 216 && g == 216
end
