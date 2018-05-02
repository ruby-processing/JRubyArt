# Here's a little library for quickly hooking up controls to sketches.
# For messing with the parameters and such.
# These controls will set instance variables on the sketches.
# You can make sliders, checkboxes, buttons, and drop-down menus.
# Optionally pass range and a default value to sliders.
module ControlPanel
  def self.app_value(name, val)
    Processing.app.instance_variable_set("@#{name}", val)
  end

  # class used to create slider elements for control_panel
  class Slider < javax.swing.JSlider
    def initialize(control_panel, name, range, initial, proc = nil)
      min = range.begin * 100
      mx = range.end
      mx = range.max if range.exclude_end? && range.begin.respond_to?(:succ)
      max = mx * 100
      val = range.cover?(initial) ? initial * 100 : (range.first + range.last) * 50
      super(min, max, val)
      set_minor_tick_spacing((max - min).abs / 10)
      set_paint_ticks true
      # paint_labels = true
      set_preferred_size(java.awt.Dimension.new(190, 30))
      label = control_panel.add_element(self, name)
      add_change_listener do
        update_label(label, name, value)
        ControlPanel.app_value(name, value)
        proc.call(value) if proc
      end
      ControlPanel.app_value(name, val)
    end

    def value
      get_value / 100.0
    end

    def update_label(label, name, value)
      value = value.to_s
      value << '0' if value.length < 4
      label.set_text "<html><br><b>#{name}: #{value}</b></html>"
    end
  end

  # class used to combo_box menu elements for control_panel
  class Menu < javax.swing.JComboBox
    def initialize(control_panel, name, elements, initial_value, proc = nil)
      super(elements.to_java(:String))
      set_preferred_size(java.awt.Dimension.new(190, 30))
      control_panel.add_element(self, name)
      add_action_listener do
        ControlPanel.app_value(name, value) unless value.nil?
        proc.call(value) if proc
      end
      set_selected_index(initial_value ? elements.index(initial_value) : 0)
    end

    def value
      get_selected_item
    end
  end

  # Creates check-box elements for control_panel
  class Checkbox < javax.swing.JCheckBox
    def initialize(control_panel, name, proc = nil)
      @control_panel = control_panel
      super(name.to_s)
      set_preferred_size(java.awt.Dimension.new(190, 64))
      set_horizontal_alignment javax.swing.SwingConstants::CENTER
      control_panel.add_element(self, name, false)
      add_action_listener do
        ControlPanel.app_value(name, value)
        proc.call(value) if proc
      end
    end

    # define value as checkbox state
    def value
      is_selected
    end
  end

  # Creates button elements for control_panel
  class Button < javax.swing.JButton
    def initialize(control_panel, name, proc = nil)
      super(name.to_s)
      set_preferred_size(java.awt.Dimension.new(170, 64))
      control_panel.add_element(self, name, false, true)
      add_action_listener do
        Processing.app.send(name)
        proc.call(value) if proc
      end
    end
  end

  # class used to contain control_panel elements
  class Panel < javax.swing.JFrame
    java_import javax.swing.UIManager

    attr_accessor :elements, :panel

    def initialize
      super()
      @elements = []
      @panel = javax.swing.JPanel.new(java.awt.FlowLayout.new(1, 0, 0))
      feel
    end

    def display
      add panel
      set_size 200, 30 + (64 * elements.size)
      set_default_close_operation javax.swing.JFrame::HIDE_ON_CLOSE
      set_resizable false
      xoffset = Processing.app.width + 10
      set_location(xoffset, 0) unless xoffset > Processing.app.displayWidth
      panel.visible = true
    end

    def add_element(element, name, has_label = true, _button_ = false)
      if has_label
        label = javax.swing.JLabel.new("<html><br><b>#{name}</b></html>")
        panel.add label
      end
      elements << element
      panel.add element
      has_label ? label : nil
    end

    def remove
      remove_all
      dispose
    end

    def title(name)
      set_title(name)
    end

    def slider(name, range = 0..100, initial = nil, &block)
      Slider.new(self, name, range, initial, block || nil)
    end

    def menu(name, elements, initial_value = nil, &block)
      Menu.new(self, name, elements, initial_value, block || nil)
    end

    def checkbox(name, initial_value = false, &block)
      checkbox = Checkbox.new(self, name, block || nil)
      checkbox.do_click if initial_value == true
    end

    def button(name, &block)
      Button.new(self, name, block || nil)
    end

    def look_feel(lf)
      feel(lf)
    end

    private

    def feel(lf = 'metal')
      lafinfo = javax.swing.UIManager.getInstalledLookAndFeels
      laf = lafinfo.to_ary.find do |info|
        info.name =~ Regexp.new(Regexp.escape(lf), Regexp::IGNORECASE)
      end
      javax.swing.UIManager.setLookAndFeel(laf.class_name)
    end
  end

  # instance methods module
  module InstanceMethods
    def control_panel
      @control_panel ||= ControlPanel::Panel.new
      return @control_panel unless block_given?
      yield(@control_panel)
      @control_panel.display
      @control_panel.set_visible true
      @control_panel # for legacy compat
    end
  end
end

Processing::App.include(ControlPanel::InstanceMethods)
