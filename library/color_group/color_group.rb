java_import Java::Monkstone::ColorUtil

# class for manipulating color
class ColorGroup
  attr_reader :pcolors
  def initialize(web)
    @pcolors = ColorUtil.web_array(web)
  end

  def self.from_p5cols(p5cols)
    return ColorGroup.new(p5cols)
  end

  def shuffle!
    @pcolors = ColorUtil.shuffle(pcolors)
  end

  def ruby_string
    ColorUtil.rubyString(pcolors)
  end
end
