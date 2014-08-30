require 'matrix'
require 'oily_png'
 
image = ChunkyPNG::Image.from_file('github.png')
working_image = image.dup

(0..1365).each do |w|
  (0..767).each do |h|
    pixel = working_image.get_pixel(w,h)
    r = ChunkyPNG::Color.r(pixel)
    g = ChunkyPNG::Color.g(pixel) 
    b = ChunkyPNG::Color.b(pixel)

    puts [w,h].inspect if r == 217 && g == 217 && b == 217
  end
end


