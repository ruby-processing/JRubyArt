**v1.0.9** Implementing `data_path` using ruby, this does away with file permission issue when loading data, hence no requirement for `--no-jruby` flag only downside need to wrap data filename with `data_path('filename')` but should fix macosx data path issue? Update to jruby-complete-9.1.1.0.

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
