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
  def find_left(row, x)
    (1..row.count).each do |i|
      return x if row[x-i] == 1
    end
  end

  def find_right(row, x)
    (1..row.count).each do |i|
      return x if row[x+i] == 1
    end
  end

  def find_up(col, y)
    (1..col.count).each do |i|
      return y if col[y-i] == 1
    end
  end

  def find_down(col, y)
    (1..col.count).each do |i|
      return y if col[y+i] == 1
    end
  end

  def fetch(sample)
    data = []
    sample.each_with_index do |row, y|
      row.each_with_index do |r, x|
        next if r == 1
        min_x = find_left(row, x)
        max_x = find_right(row, x)
        min_y = find_up(sample.transpose[y], y)
        max_y = find_down(sample.transpose[y], y)
        max_x = max_x.max-1 if max_x.is_a? Range
        max_y = max_y.max-1 if max_y.is_a? Range 
        data << [min_x, max_x, min_y, max_y]
        #data << { x:x, y:y, min_x: min_x, max_x: max_x, min_y: min_y, max_y: max_y }
      end
    end
    return data
  end
end
