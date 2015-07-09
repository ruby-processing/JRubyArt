
**v0.3.1** Update to jruby-complete-9.0.0.0.rc2, add vector type access to Vec2D and Vec3D parameters eg `vector[:x]` to return 'x' value,  and `vector[:x] = 20` to assign value (also simplify the return type of assignment as input value).

**v0.3.0** Revert to similar architecture as ruby-processing-2.6.12, including changes that make jruby and PApplet use same classloader.  This change is required for JRuby-9.0.0.0 compatibility. Other changes include:- load `rpextras.jar` early (so it only get loaded once) and loading the `vecmath` and `fastmath` libraries by default.
