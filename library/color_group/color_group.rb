java_import Java::Monkstone::ColorUtil

# class wraps a java color array, supports shuffle!, last and ruby_string
# as well as ability to initialize with an array of "web" color string
class ColorGroup
  attr_reader :colors
  def initialize(p5cols)
    @colors = p5cols
  end

  def self.from_web_array(web)
    ColorGroup.new(ColorUtil.web_array(web.to_java(:string)))
  end

  def shuffle!
    @colors = ColorUtil.shuffle(colors)
  end

  def ruby_string
    ColorUtil.rubyString(colors)
  end

  def last
    colors[0]
  end
end
