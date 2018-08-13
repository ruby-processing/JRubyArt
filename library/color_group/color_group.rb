java_import Java::Monkstone::ColorUtil

class ColorGroup
  attr_reader :web_colors, :pcolors
  def initialize(web)
    @web_colors = web
    @pcolors = ColorUtil.web_array(web)
  end

  def shuffle
    @pcolors = ColorUtil.web_array(web_colors.shuffle)
  end

  def shuffle!
    web_colors.shuffle!
    @pcolors = ColorUtil.web_array(web_colors)
  end
end
