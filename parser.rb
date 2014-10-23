class Parser
  attr_accessor :result, :by_x

  def color(pixel)
    [:r, :g, :b].map{ |c| ChunkyPNG::Color.send(c, pixel) }
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

    image = ChunkyPNG::Image.from_file(image)
    png = ChunkyPNG::Image.new(image.width, image.height, :white)

    h(image).each_with_index do |v,x|
      (0..image.height-1).each do |y|
        png[x,y] = ChunkyPNG::Color(:black) if v > 0
      end
    end

    png.save('static/spaces.png')
  end

end
