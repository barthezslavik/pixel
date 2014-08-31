require_relative "convert"

canvas = [
  [1,1,0,0,0],
  [1,1,0,1,1],
  [1,1,0,1,1],
  [0,0,0,1,1]
]

mask = [1,1]

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
  puts "c:#{c}"
  
  head = c.index(1)
  if head
    result = []
    tail = head + mask.count-1 
    (head..tail).each do |x|
      coords << [x,y]
    end
    puts "head:#{head}, tail:#{tail}, y:#{y}"
    puts coords.inspect
  end
end

#=============================

# bb = [
#   [1,1],
#   [1,1],
#   [1,1]
# ]

# cc = [
#   [[0,0],[0,1],
#    [1,0],[2,1],
#    [2,0],[2,2]],

#   [[1,4],[1,5],
#    [2,4],[2,5],
#    [3,4],[3,5]]
# ]
