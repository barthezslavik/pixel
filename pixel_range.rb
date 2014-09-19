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
    sample.each_with_index do |row, x|
      row.each_with_index do |r, y|
        next if r == 1

        min_x = find_left(row, x)
        max_x = find_right(row, x)
        min_y = find_up(sample.transpose[y], y)
        max_y = find_down(sample.transpose[y], y)

        min_x = x if min_x.is_a? Range
        max_x = x if max_x.is_a? Range
        min_y = x if min_y.is_a? Range
        max_y = y if max_y.is_a? Range 

        data << { x:x, y:y, min_x: min_x, max_x: max_x, min_y: min_y, max_y: max_y }
      end
    end
    return data
  end
end
