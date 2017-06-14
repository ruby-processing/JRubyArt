**v1.3.3** Update for processing-3.3.4, jruby-9.1.11.0

**v1.3.2** Update for processing-3.3.3, jruby-9.1.10.0 and bump examples version to include glvideo library examples

**v1.3.1** The native binaries for the video library in MacOS are in the `macosx64` folder not the `macosx` this release should provide a quick fix. Note the library loader is in line for quite a major refactor in the near future, so this is a temporary fix.

**v1.3.0** Not strictly semantic versioning in the sense that the significant internal refactoring of `launcher.rb` (and `sketch_writer.rb`) should not be evident to user. Bump to jruby-9.1.8.0 which should be last before jruby-9.2.x.x series (ruby-2.4 here we come).

**v1.2.9** Grid method now in java (and corrected for step greater than 1). Update to processing-3.3. Update examples to 2.0, which features WOVNS examples that make use of `grid` method and in part caused me to look again a its implementation.

**v1.2.8** Properly implement post-initialize (it might be useful). Refactor Sketchbook and OS. Update to processing-3.2.4, if you have not updated samples for a while you should now.

**v1.2.7** Introduce new config parameters `sketch_title`, `width` and `height` with a view to better static sketch support (for youngsters, absolute novices). Update to use jruby-9.1.7.0 and latest samples 1.8 (includes joons renderer examples)

**v1.2.6** Update to processing-3.2.3 and jruby-9.1.6.0-complete, re-factor to use a Command class to create argument array and exec.

**v1.2.5** Change gemspec description, trying to get people not to ignore changes to documentation?

**v1.2.4** Update to jruby-9.1.5.0-complete.

**v1.2.3** Further refactored sketchwriter.rb. Update to jruby-9.1.4.0-complete.

**v1.2.2** Refactored sketchwriter.rb (adding unit tests) to be more open to change and removing string_extra.rb on the way. Remove sketchbook.rb, because we no-longer guess sketchbook location at runtime (depends on `config.yml`), could pave the way for independent (from processing ide) location of java libraries (and freedom from the tyranny of prisoner john). Update to jruby-9.1.3.0-complete.


**v1.2.1** Use optparse to parse command line options, and related re-factoring. Avoid casting to java Double and Integer and using `to_java` for primitives in jruby extensions. Includes important changes to CLI, `run` becomes `--run` etc and one stop `--install` replacing `setup --install` etc.
Also `--nojruby` is dropped in favor of `config.yml`.

**v1.1.3** Revert using String refinements in `creator.rb`. Refactor java options to `java_opts.rb`.

**v1.1.2** Refactor `runner.rb` to `runner.rb`, `args.rb` and `installer.rb`. The `Installer` classes have the role of installing `jruby-complete`, the examples and providing `setup check` functionality. Refactored and improved default `config.yml` tool, all should make it easier for `collaborators/successors` to follow the code. Refactored `Vec2D` and `Vec3D` `==` and `eql?` methods. New `chooser` library makes it possible to use `select_input` using vanilla processing reflection method.

**v1.1.1** Even more `data_path` fixes in examples, update to jruby-complete-9.1.2.0

**v1.1.0** Using ruby to implement the `data_path` wrapper (to avoid java permission issues). Any macosx users that have problems with accessing the local data folders should use this wrapper within `load_image`, `load_shader` etc or provide the absolute path to the data file eg `File.absolute_path('data/image.png')`. Using the `data_path` wrapper or providing the absolute data path also may fix the permission issue that required the `--no-jruby` flag (tested on linux). Includes update to jruby-complete-9.1.1.0.

**v1.0.8** Exposed Constrain functionality for ArcBall, added literate perspektive method. No longer trying to expose `sketchPath` variable (that was private since recent changes to vanilla processing), but provided an overloaded `sketchPath` method. Re-factor `MathTool` module class (jruby extension) to a simpler more correct form. Recommending the use of latest processing-3.1.1.

**v1.0.7** Added tool to efficiently convert an Array of web colour Strings to and Array of color int (should be used by users of hype library, that uses of web strings in most of its examples). Update to use jruby-complete-9.1.0.0.

**v1.0.6** Experimental support for an in sketch slider, examples now featuring Joshua Davis hype library.

**v1.0.5** This version prefers processing-3.0.2 as the most recent version, and should be matched with oracle `jdk1.8.0_74+` for JavaFX fixes, or OpenJDK-8 and the latest OpenJFX otherwise stick with processing-3.0.1, which masks JavaFX inversion issue

**v1.0.4** Using jruby-complete-9.0.5.0. Adding javadoc, with links to jruby.api and processing.api

**v1.0.3** Build now using processing-3.0.1 core and matching video jars from maven central and pom.rb build file (polyglot maven), furthermore using maven-wrapper so maven version is not even required see mvnw and mvwm.bat and .mvn/maven-wrapper.properties. The pom.xml is not needed but included for completness.

**v1.0.2** Various cleanups, favoring SHA256 over SHA1 to check jruby-complete

**v1.0.1** Using jruby-complete-9.0.4.0, features reworked extension build using maven

**v1.0.0** Using jruby-complete-9.0.3.0 (no 9.0.2.0 owing to snafu at jruby.org) use github.io for home. Re-factor boids to use Vec3D, Vec2D and keyword arguments.

**v0.9.0** Require processing-3.0.

**v0.8.0** Require processing-3.0b7 and using jruby-9.0.1.0 replaced spec tests with minitest.

**v0.7.0** Require processing-3.0b6 and using jruby-9.0.1.0 added a Gemfile for bundler fans, but I'm not sure how well it can work with the required compile step. Statically load JRubyArt jruby extensions. features `on_top` to keep display on top of course (implements `surface.setAlwaysOnTop(true);`).

**v0.6.0** Tested processing-3.0b5 and using jruby-9.0.1.0 getting nearer processing release, `AABB` is now `AaBb` which avoids clashing with toxigem

**v0.5.0** Tested with processing-3.0b4 more samples included, introducing `keyword` args and a 2D `AABB` implementation
map1d, lerp, norm, p5map and `constrained_map` as module methods in a JRuby extension. Using jdk-8 source for lambda...

**v0.4.2** Tested with processing-3.0b2 color helper method refactored to use a jruby extension

**v0.4.1** Implement a `live` mode with `pry`

**v0.4.0** Update to jruby-9.0.0.0 we can revert to using require to load jars first release tested with processing-3.0a11 on linux

**v0.3.1** Update to jruby-complete-9.0.0.0.rc2, add vector type access to Vec2D and Vec3D parameters eg `vector[:x]` to return 'x' value,  and `vector[:x] = 20` to assign value (also simplify the return type of assignment as input value).

**v0.3.0** Revert to similar architecture as ruby-processing-2.6.12, including changes that make jruby and PApplet use same classloader.  This change is required for JRuby-9.0.0.0 compatibility. Other changes include:- load `rpextras.jar` early (so it only get loaded once) and loading the `vecmath` and `fastmath` libraries by default.
