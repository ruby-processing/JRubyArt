# frozen_string_literal: true

# include interfaces
class Processing::App
  include Java::MonkstoneVideoevent::MovieEvent
  include Java::MonkstoneVideoevent::CaptureEvent
end
