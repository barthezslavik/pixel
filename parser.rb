class Parser
  attr_accessor :result, :by_x, :h_sizes

  def color(pixel)
    [:r, :g, :b].map{ |c| ChunkyPNG::Color.send(c, pixel) }
  end

  def v(image)
    data = []
    by_x = []
    result = []

    (0..image.width-1).each do |x|
      data[x] = 0
      (0..image.height-1).each do |y|
        if color(image.get_pixel(x,y)) == [255,255,255]
          data[x] += 1
        end
      end
      by_x << data[x]
    end

    abort by_x.inspect

    by_x.map {|col| (col*100/image.height).to_i }.each_with_index do |d, i|
      result << i if d < 95
    end

    abort result.inspect

    ranges = result.sort.uniq.inject([]) do |spans, n|
      if spans.empty? || spans.last.last != n - 1
        spans + [n..n]
      else
        spans[0..-2] + [spans.last.first..n]
      end
    end

    edges = []

    ranges.each do |r|
      edges << r.first
      edges << r.last
    end

    edges.each_with_index do |e,i|
      @h_sizes[i] = edges[i] - edges[i-1] unless i == 0
    end

    @h_sizes[0] = edges[0]

    edges
  end

  def h(image)
    map = []
    data = []
    (0..image.width-1).each do |x|
      data[x] = 0
      (0..image.height-1).each do |y|
        c = color(image.get_pixel(x,y))
        unless c == [245,245,245]
          data[x] += 1
        end
      end
      by_x << data[x]
    end

    stream = ""

    block_on = false
    block_off = true

    by_x.each_with_index do |b,i|
      if b == 0 && block_on
        block_on = false
        self.result << i
        block_off = true
      end

      self.result << i if block_on

      if b != 0 && block_off
        block_on = true
        self.result << i
        block_off = false
      end
    end

    self.result
    self.by_x
  end

  def initialize(image)
    self.result = []
    self.by_x = []
    self.h_sizes = []

    image = ChunkyPNG::Image.from_file(image)
    png = ChunkyPNG::Image.new(image.width, image.height, :white)

    v(image).each do |x|
      (0..image.height-1).each do |y|
        png[x,y] = ChunkyPNG::Color(:black)
      end
    end

    #h(image).each_with_index do |v,x|
    #  (0..image.height-1).each do |y|
    #    png[x,y] = ChunkyPNG::Color(:black) if v > 0
    #  end
    #end

    png.save('static/spaces.png')
  end

end
