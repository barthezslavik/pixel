require 'matrix'
require 'oily_png'
 
image = ChunkyPNG::Image.from_file('github.png')
working_image = image.dup

pixel = working_image.get_pixel(1365,767)
r = ChunkyPNG::Color.r(pixel)
g = ChunkyPNG::Color.g(pixel) 
b = ChunkyPNG::Color.b(pixel)

abort [r,g,b].inspect
