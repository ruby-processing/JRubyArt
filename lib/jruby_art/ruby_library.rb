# The abstract RubyLibrary class
class RubyLibrary
  attr_reader :path

  def initialize(name)
    @path = nil
  end

  def exist?
    File.exist? path
  end
end

# The LocalRubyLibrary class
class LocalRubyLibrary < RubyLibrary
  def initialize(name)
    super
    @path = File.absolute_path(
      File.join(Processing::SKETCH_ROOT, 'library', name, "#{name}.rb")
    )
  end
end

# The InstalledLibraryLoader class
class InstalledRubyLibrary < RubyLibrary
  def initialize(name)
    super
    @path = File.join(K9_ROOT, 'library', name, "#{name}.rb")
  end
end
