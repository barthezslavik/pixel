require 'oily_png'

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

(0..image.width-1).each do |w|
  (0..image.height-1).each do |h|
    #color?(working_image.get_pixel(w,h), 216,216,216)
  end
end
