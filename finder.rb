require_relative "convert"

canvas = [
  [0,1,0,1,0],
  [0,0,0,0,0],
  [0,0,0,0,0],
  [0,0,0,0,0]
]

mask = [
  [1,0],
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
