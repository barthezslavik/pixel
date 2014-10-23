require_relative "pixel_range"

sample = [
  [0,1,1,0,0,0],
  [1,0,0,1,0,0],
  [1,0,0,1,0,0],
  [0,1,1,0,0,0],
]

sample2 = [
  [0,0,0,0,0,0,0],
  [0,0,0,1,1,1,0],
  [0,0,1,0,0,0,1],
  [0,0,1,0,0,0,1],
  [0,0,1,0,0,0,1],
  [0,0,1,0,0,0,1],
  [0,0,1,0,0,0,1],
  [0,0,0,1,1,1,0],
]

sample3 = [
  [0,0,1,1,1,1,1,1,1,0,0],
  [0,1,0,0,0,0,0,0,0,1,0],
  [0,1,0,0,0,0,0,0,0,1,0],
  [0,0,1,1,1,1,1,1,1,0,0],
]

pixel_range = PixelRange.new
data = pixel_range.fetch(sample)

sample.each do |s|
  puts s.inspect
end

puts " "

data.each do |d|
  puts d.inspect
end
