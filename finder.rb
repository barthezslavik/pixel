a = [
  [0,1,1,1,0],
  [0,1,0,1,0]
]

b = [
  [1,1],
  [0,1]
]

e0 = a[0].each_cons(b[0].length).map do |aa|
  aa == b[0]
end.index(true)

e1 = a[1].each_cons(b[1].length).map do |aa|
  aa == b[1]
end.index(true)

abort [e0,e1].inspect
