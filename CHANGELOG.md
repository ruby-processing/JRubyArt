**v2.5.0** Update to use jruby-complete-9.2.15.

**v2.4.2** Update to use jruby-complete-9.2.14.0, regularise video/sound downloadswhen no processing ide.

**v2.4.1** Update to use jruby-complete-9.2.13.0  

**v2.4.1** Update to use jruby-complete-9.2.12.0  

**v2.4.0** Update to use jruby-complete-9.2.11.1 recommended java version AdoptOpenJDK-13+ or Openj9-14+

**v2.3.0** Update to use jruby-complete-9.2.11.0 recommended java version AdoptOpenJDK-13+

**v2.2.2** Fix for Native library bug on Windows by Jay Scott. Added minim examples. Bump processing-version in build.

**v2.2.1** Added --force option for use with --install option to remove old configuration. Added support for installing video and sound libraries, without vanilla processing. Added dxf export library, re-branded app with a red wavy triangle icon.

**v2.2.0** A standalone ruby version of processing which runs with jdk12 and essentially uses a development version of processing core (by Sam Pottinger). Use version 1.7.0 if you are using jdk8.

**v2.1.0** JRubyArt is no longer dependent on an installed version of vanilla processing, but needs at least jdk11 to run. Anyone wanting to use jdk8 should install JRubyArt-1.7.0 and probably use bundler to freeze version.
**v2.0.0** Update to jdk11, removing many bashisms on the way. We compile our own processing code, and include with jogl gems in gem. Requires a new `config.yml` file to use libraries. Revert to processing-3.3.7 versions of PShapeOpenGL and PGraphicsOpenGL to fix diwi examples and possibly others.

**v1.7.0** Update to jruby-complete-9.2.8.0. NB: breaking change AppRender(applet) changed to GfxRender(graphics) please update samples.

**v1.6.4** Fix glitch on loading jruby-complete, warn if not using JDK8 improved ColorGroup

**v1.6.3** Update to jruby-complete-9.2.6.0 and processing-3.5.3

**v1.6.2** Update to jruby-complete-9.2.4.0.

**v1.6.1** Update to jruby-complete-9.2.2.0.

**v1.6.0** Update to expect processing-3.4 and to jruby-complete-9.2.1.0. Add color_group library, remove web_array helper method

**v1.5.2** JRuby downloads have moved

**v1.5.1** Revert changes to windows OS detection

**v1.5.0** Update to jruby-complete-9.2.0.0, make native loader work with raspberrypi.

**v1.4.9** Update to jruby-complete-9.1.17.0.

**v1.4.8** Re-factor `control_panel` to avoid calling protected method on slider, also reduces boilerplate code requires in `control_panel` sketches.

**v1.4.7** Bump up to processing-3.3.7, make watch fail early if too many ruby files to watch

**v1.4.6** Bump up to JRubyComplete-9.1.16.0

**v1.4.5** Vec2D and Vec3D now support `copy` constructor where the original can be a duck-type. Further the only requirement is that the duck-type responds to `:x`, and `:y` by returning a `float` or `fixnum` thus Vec2D can be promoted to Vec3D (where `z = 0`), or more usually some other Vector or Point class can be used as the original. A `vector_utils` library has been implemented, see examples for usage.

**v1.4.4** Bump up to JRubyComplete-9.1.15.0

**v1.4.3** Features example sketches using the PixelFlow library by Thomas Diewald

**v1.4.2** Fix for windows `library_loader` thanks to Thomas Diewald

**v1.0.3** Initial version
