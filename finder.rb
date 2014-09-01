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
    if color?(working_image.get_pixel(w,h), 216,216,216)
      bitmap << 1
    else
      bitmap << 0
    end
  end
end

canvas = []

bitmap.each_slice(image.width-1) do |b|
  canvas << b
end

mask = [
  [1,0],
  [1,0]
]

canvas.each_with_index do |row, y|
  c = []
  coords = []

  mask.each_with_index do |m,i|
    row.each_with_index do |col, x|
      c = row.each_cons(m.count).map {|aa| m == aa}.map(&:to_i)
    end
    c.each_with_index do |cc,i|
      next if cc == 0
      head = i
      if head
        result = []
        tail = head + m.count-1 
        (head..tail).each do |x|
          (coords[i] = []) << [x,y]
        end
      end
    end
  end

  puts coords.compact.uniq.flatten(1).inspect unless coords.empty?

end
