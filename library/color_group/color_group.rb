java_import Java::Monkstone::ColorUtil

# class wraps a java color array, supports shuffle!, last and ruby_string
# as well as ability to initialize with an array of "web" color string
class ColorGroup
  attr_reader :pcolors
  def initialize(p5cols)
    @pcolors = p5cols
  end

  def self.from_web_array(web)
    ColorGroup.new(ColorUtil.web_array(web))
  end

  def shuffle!
    @pcolors = ColorUtil.shuffle(pcolors)
  end

  def ruby_string
    ColorUtil.rubyString(pcolors)
  end

  def last
    pcolors[0]
  end
end
