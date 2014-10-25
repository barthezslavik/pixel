class Parser
  attr_accessor :result, :by_x, :by_y, :h_sizes, :data, :objects, :image, :edges

  def color(pixel)
    [:r, :g, :b].map{ |c| ChunkyPNG::Color.send(c, pixel) }
  end

  def get_objects
    (0..@image.width-1).each do |x|
      data[x] = 0
      (0..@image.height-1).each do |y|
        c = color(@image.get_pixel(x,y))
        unless c == [245,245,245]
          data[x] += 1
        end
      end
      by_x << data[x]
    end
    by_x

    by_x.map {|col| (col*100/@image.height).to_i }.each_with_index do |d, i|
      result << i if d > 0
    end

    ranges = result.sort.uniq.inject([]) do |s, n|
      if s.empty? || s.last.last != n - 1
        s + [n..n]
      else
        s[0..-2] + [s.last.first..n]
      end
    end

    ranges.each do |r|
      fill = []
      (0..image.height-1).each do |y|
        clear = true
        r.each do |x|
          c = color(@image.get_pixel(x,y))
          clear = false if c != [245,245,245]
        end
        fill << [clear,y]
      end
      top = fill.each { |f| break f.last if f.first == false }
      bottom = fill.reverse.each { |f| break f.last if f.first == false }
      objects << { min_x: r.first, min_y: top, max_x: r.last, max_y: bottom }
    end
  end

  def initialize(image)
    @result = []
    @by_x = []
    @data = []
    @objects = []
    @image = ChunkyPNG::Image.from_file(image)

    get_objects
    output = ChunkyPNG::Image.new(@image.width, @image.height, :white)

    objects.each do |o|
      (o[:min_x]..o[:max_x]).each do |x|
        output[x,o[:min_y]] = ChunkyPNG::Color(:black)
      end

      (o[:min_x]..o[:max_x]).each do |x|
        output[x,o[:max_y]] = ChunkyPNG::Color(:black)
      end

      (o[:min_y]..o[:max_y]).each do |y|
        output[o[:min_x],y] = ChunkyPNG::Color(:black)
      end

      (o[:min_y]..o[:max_y]).each do |y|
        output[o[:max_x],y] = ChunkyPNG::Color(:black)
      end
    end

    output.save('static/output.png')

    #objects.each_with_index do |o,i|
    #  output = ChunkyPNG::Image.new(@image.width, @image.height, :white)
    #  output.save("static/output#{i}.png")
    #end

  end
end
