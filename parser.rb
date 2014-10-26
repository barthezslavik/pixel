class Parser
  attr_accessor :result, :by_x, :by_y, :h_sizes,
    :data, :objects, :image, :edges, :groups, :distances, :background

  def color(pixel)
    [:r, :g, :b].map{ |c| ChunkyPNG::Color.send(c, pixel) }
  end

  def get_objects
    (0..@image.width-1).each do |x|
      data[x] = 0
      (0..@image.height-1).each do |y|
        c = color(@image.get_pixel(x,y))
        unless c == background
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

    ranges.each_with_index do |r,i|
      fill = []
      (0..image.height-1).each do |y|
        clear = true
        r.each do |x|
          c = color(@image.get_pixel(x,y))
          clear = false if c != background
        end
        fill << [clear,y]
      end

      top = fill.each { |f| break f.last if f.first == false }
      bottom = fill.reverse.each { |f| break f.last if f.first == false }
      objects << { element_id: i+1, min_x: r.first, min_y: top, max_x: r.last, max_y: bottom }
    end

    objects[0] = { html: { tag: "img", src: "image1.png" } }.merge!(objects[0])
    objects[1] = { html: { tag: "input", type: "text", placeholder: "Search GitHub" } }.merge!(objects[1])
    objects[2] = { html: { tag: "li" }, text: "Explore" }.merge!(objects[2])
    objects[3] = { html: { tag: "li" }, text: "Gist" }.merge!(objects[3])
    objects[4] = { html: { tag: "li" }, text: "Blog" }.merge!(objects[4])
    objects[5] = { html: { tag: "li" }, text: "Help" }.merge!(objects[5])

    objects[6] = { html: { tag: "img" }, src: "image2.png" }.merge!(objects[6])
    objects[7] = { html: { tag: "li" }, text: "barthezslavik" }.merge!(objects[7])
    objects[8] = { html: { tag: "img" }, src: "image3.png" }.merge!(objects[8])
    objects[9] = { html: { tag: "img" }, src: "image4.png" }.merge!(objects[9])

  end

  def get_distances
    objects.each_with_index do |o,i|
      next if o[:deep] == 1
      if i <= objects.count-2
        d = objects[i+1][:min_x] - objects[i][:max_x]
        distances << d if d > 0
      end
    end
  end

  def left_right
    peak_index =  distances.each_with_index.max[1]
    #objects[0..peak_index-1].each { |o| o[:deep] = 1 }
    #objects[peak_index..-1].each { |o| o[:deep] = 1 }

    min_x_left = objects[0..peak_index].map {|o| o[:min_x]}.min
    min_y_left = objects[0..peak_index].map {|o| o[:min_y]}.min
    max_x_left = objects[0..peak_index].map {|o| o[:max_x]}.max
    max_y_left = objects[0..peak_index].map {|o| o[:max_y]}.max

    min_x_right = objects[peak_index+1..-1].map {|o| o[:min_x]}.min
    min_y_right = objects[peak_index+1..-1].map {|o| o[:min_y]}.min
    max_x_right = objects[peak_index+1..-1].map {|o| o[:max_x]}.max
    max_y_right = objects[peak_index+1..-1].map {|o| o[:max_y]}.max

    #objects << { min_x: min_x_left, min_y: min_y_left, max_x: max_x_left, max_y: max_y_left }
    #objects << { min_x: min_x_right, min_y: min_y_right, max_x: max_x_right, max_y: max_y_right }
  end

  def group_near
    glue = []
    distances.each_with_index do |d,i|
      glue << [i,i+1] if d < 7
    end

    glue.each do |g|
      objects[g.first][:deep] = 1
      objects[g.last][:deep] = 1
      max_y = [objects[g.first][:max_y], objects[g.last][:max_y]].max 
      objects << { min_x: objects[g.first][:min_x], min_y: objects[g.first][:min_y], max_x: objects[g.last][:max_x], max_y: max_y}
    end
  end

  def get_container
    min_x = objects.map { |o| o[:min_x] }.min
    max_x = objects.map { |o| o[:max_x] }.max
    min_y = objects.map { |o| o[:min_y] }.min
    max_y = objects.map { |o| o[:max_y] }.max
    objects << { html: { tag: "div", id: "container"}, css: ["width:#{max_x-min_x}px"], min_x: min_x, min_y: min_y, max_x: max_x, max_y: max_y }
    objects << { html: { tag: "div", id: "header"}, css: ["width:#{@image.width-1}px", "background:#{rgb_to_hex(background)}"], min_x: 0, min_y: 0, max_x: @image.width-1, max_y: @image.height-1 } 
  end

  def rgb_to_hex(value)
    color = ""
    value.each {|component| color << component.to_s(16) }
    "##{color}"
  end

  def initialize(image)
    @groups = []
    @distances = []
    @result = []
    @by_x = []
    @data = []
    @objects = []
    @background = [245,245,245]

    @image = ChunkyPNG::Image.from_file(image)

    get_objects
    get_distances
    group_near
    left_right rescue nil
    get_container

    output = ChunkyPNG::Image.new(@image.width, @image.height, :white)

    objects[0..-1].each { |o| o[:deep] = 0 }
    objects.each do |o|
      next if o[:deep] == 1
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
  end
end
