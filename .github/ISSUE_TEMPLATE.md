### Before you file an issue

Please check your configuration `~/jruby_art/config.yml`, if you get the following error (_or similar_)
```bash
LoadError: load error: C:/jruby-9.1.15.0/lib/ruby/gems/shared/gems/jruby_art-1.4.6/lib/jruby_art/app --java.lang.NoClassDefFoundError: processing/core/PApplet
```
It means the program can't find the processing root and you should make sure that
```bash
PROCESSING_ROOT: /home/tux/processing-3.3.6
```
matches your system (_typical linux shown above for user tux_) for windows it may be safer to use quoted string, especially if you have spaces in your path.


<!--
This is a simple template for filing JRubyArt issues.

Please help us help you by providing the information below.

Text inside XML comment tags will not be shown in your report.
-->

### Environment

Ensure that you are using the recommended versions of processing(`k9 setup check`), jruby (`jruby -v`) and java (`java -version`) 
Provide JRubyArt version that you are using (`k9 --version`)
Provide your operating system and platform (e.g. `uname -a`, and/or `java -version` output if relevant)

### Expected Behavior

Describe your expectation of how JRubyArt sketch should behave.
Provide a `problematic` JRubyArt sketch or a link to an example repository.

### Actual Behavior

Describe or show the actual behavior.
Provide text or screen capture showing the behavior.

### Other

eg installation issue (just use this header and explain the problem as best you can)
