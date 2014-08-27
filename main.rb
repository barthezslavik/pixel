require 'oily_png'

def seq_sort(array)
  finished = [array.first], i = 0
  array.each_cons(2) do |(a,b)|
    if b - a == 1
      finished[i] << b
    else
      finished[i += 1] = [b]
    end
  end
  finished
end

image = ChunkyPNG::Image.from_file('github.png')
working_image = image.dup

pixels = []

working_image.pixels.each_with_index do |pixel,i|
  r = ChunkyPNG::Color.r(pixel)
  g = ChunkyPNG::Color.g(pixel) 
  b = ChunkyPNG::Color.b(pixel)
  if r == 216 && g == 216 && b == 216
    pixels << i
  end
end

seq = seq_sort(pixels)
c = []

seq.each_with_index do |s,i|
  c << s.count if s.count > 2
end

abort c.inspect
