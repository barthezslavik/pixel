require 'matrix'
require 'oily_png'

def color?(pixel, r,g,b)
  px_r = ChunkyPNG::Color.r(pixel)
  px_g = ChunkyPNG::Color.g(pixel) 
  px_b = ChunkyPNG::Color.b(pixel)
  true if px_r == r && px_g == g && px_b == b
end

image = ChunkyPNG::Image.from_file('github.png')
working_image = image.dup
data = []

(0..1365).each do |w|
  (0..767).each do |h|
    pixel = working_image.get_pixel(w,h)
    data << [w,h] if color?(pixel, 216,216,216)
  end
end

pattern = [
  [0,0,0,1,1],
  [0,0,0,0,0],
  [0,0,0,0,0],
  [1,0,0,0,0],
  [1,0,0,0,0],
]
