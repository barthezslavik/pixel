sample1 = [
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

data = []
sample1.each_with_index do |row, x|
  row.each_with_index do |r, y|
    next if r == 1

    min_x = find_left(row, x)
    max_x = find_right(row, x)
    min_y = find_up(sample1.transpose[y], y)
    max_y = find_down(sample1.transpose[y], y)

    data << { x:x, y:y, min_x: min_x, max_x: max_x, min_y: min_y, max_y: max_y }
  end
end

sample1.each do |s|
  puts s.inspect
end

data.each do |d|
  puts d.inspect
end
