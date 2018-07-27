**v1.5.3** Update to expect processing-3.4

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
