# frozen_string_literal: true

# @TODO usage
class Processing::App
  require_relative 'itextpdf-5.5.13.2.jar'
  java_import Java::ProcessingPdf::PGraphicsPDF
end
