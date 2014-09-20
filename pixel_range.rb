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

class PixelRange
  def find_border(struct, pointer, direction)
    if direction == :head
      search = struct[0..pointer]
      index = search.each_with_index.select { |num, index| num == 1 }.map { |pair| pair[1] }.max
      if index
        return index+1
      else
        return pointer
      end
    end
    if direction == :tail
      search = struct[pointer..struct.count]
      index = search.each_with_index.select { |num, index| num == 1 }.map { |pair| pair[1] }.min
      if index
        return index+pointer-1
      else
        return pointer+search.count-1
      end
    end
  end

  def fetch(sample)
    data = []
    sample.each_with_index do |row, y|
      row.each_with_index do |r, x|
        next if r == 1
        min_x = find_border(row, x, :head)
        max_x = find_border(row, x, :tail)
        min_y = find_border(sample.transpose[y], y, :head)
        max_y = find_border(sample.transpose[y], y, :tail)
        data << [x, y, min_x, max_x, min_y, max_y]
        #data << { x:x, y:y, min_x: min_x, max_x: max_x, min_y: min_y, max_y: max_y }
      end
    end
    return data
  end
end
