require_relative "convert"

a = [
  [0,1,1,1,0],
  [0,1,0,1,0]
]

b = [
  [1,1,0],
  [0,1,0]
]

e0 = a[0].each_cons(b[0].length).map do |aa|
  aa == b[0]
end.map(&:to_i)

e1 = a[1].each_cons(b[1].length).map do |aa|
  aa == b[1]
end.map(&:to_i)

e2 = e1

x = e0.zip(e1, e2).map {|a| a.inject(:+)}.index(3)

abort x.inspect
