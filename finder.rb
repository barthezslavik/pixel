require_relative "convert"

a = [
  [0,0,0,0,0],
  [0,1,0,0,0],
  [0,1,0,0,0],
  [0,1,0,0,0]
]

b = [
  [1,0],
  [1,0],
  [1,0]
]

e = []

(0..b.count).each do |i|
  e[i] = a[i].each_cons(b[0].length).map do |aa|
    aa == b[i]
  end.map(&:to_i)
end

abort e.inspect

ee = e.transpose.map{|x| x.reduce :+}.index(b.count)

abort ee.inspect
