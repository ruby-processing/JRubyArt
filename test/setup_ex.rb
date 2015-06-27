def setup
  begin
    unknown_method()
  rescue NoMethodError => e
    puts e
    exit
  end
end

def draw
end

def settings
  size(300, 300)
end
