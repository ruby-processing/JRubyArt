---
layout: post
title:  "File Chooser<sup>2</sup>"
keywords: library, chooser, gui, processing

---
<sup>2</sup><i>A built in hybrid ruby/java library</i>

Start by loading in the chooser library, the purpose of this library is to allow you to use the vanilla processing interface to the `native file chooser` (it is almost impossible to use vanilla processing reflection methods without this sort of wrapper)

```ruby
load_library :chooser

def setup
  java_signature 'void selectInput(String, String)'
  selectInput('Select a file to process:', 'fileSelected')
end

def fileSelected(selection)
  if selection.nil?
    puts 'Window was closed or the user hit cancel.'
  else
    puts format('User selected %s', selection.get_absolute_path)
  end
end
```

See also [these examples](https://github.com/ruby-processing/JRubyArt-examples/tree/master/processing_app/library/file_chooser)
