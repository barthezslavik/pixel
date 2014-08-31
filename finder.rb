require_relative "convert"

canvas = [
  [1,1,1,0,0],
  [1,1,0,1,1],
  [1,1,1,1,1],
  [0,0,0,1,1]
]

mask = [1,0,1]

result = [
  [2,0],[3,0],
  [3,0],[4,0],
  [0,3],[1,3],
  [1,3],[2,3]
]

canvas.each_with_index do |row, y|
  c = []
  coords = []
  row.each_with_index do |col, x|
    c = row.each_cons(mask.count).map {|aa| mask == aa}.map(&:to_i)
  end
  c.each_with_index do |cc,i|
    next if cc == 0
    head = i
    if head
      result = []
      tail = head + mask.count-1 
      (head..tail).each do |x|
        coords << [x,y]
      end
    end
  end
  puts coords.inspect unless coords.empty?
end
