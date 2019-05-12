package monkstone.core;

import processing.core.PApplet;
import static processing.core.PConstants.*;
import processing.event.MouseEvent;
import processing.event.KeyEvent;

/**
* The purpose of this class is to enable
* access to processing pre, draw and post loops in
* ruby-processing as a regular java library class.
* Also included background, fill and stroke methods.
* PConstants should also be available from static import
* @author Martin Prout
*/
public abstract class LibraryProxy {

  private final PApplet app;

  /**
  * Useful accessors
  */
  public int width, height;

  /**
  *
  * @param app PApplet
  */
  public LibraryProxy(PApplet app) {
    this.app = app;
    this.width = app.width;
    this.height = app.height;
    setActive(true);
  }

  /**
  * Extending classes can override this, gives access to, by reflection,
  * processing PApplet pre loop (called before draw)
  */
  public void pre(){}

  /**
  * Extending classes must implement this gives access to processing PApplet
  * draw loop
  */
  public abstract void draw();

  /**
  * Extending classes can override this, gives access to, by reflection,
  * processing PApplet post loop (called after draw)
  */
  public void post(){}

  /**
  * Extending classes can override this, gives access to, by reflection,
  * processing PApplet post loop (called after draw)
  */
  public void keyEvent(KeyEvent e){}

  /**
  * Extending classes can override this, gives access to, by reflection,
  * processing PApplet post loop (called after draw)
  */
  public void mouseEvent(MouseEvent e){}

  /**
  * Register or unregister reflection methods
  * @param active
  */
  final void setActive(boolean active) {
    if (active) {
      this.app.registerMethod("pre", this);
      this.app.registerMethod("draw", this);
      this.app.registerMethod("post", this);
      this.app.registerMethod("mouseEvent", this);
      this.app.registerMethod("keyEvent", this);
      this.app.registerMethod("dispose", this);
    } else {
      this.app.unregisterMethod("pre", this);
      this.app.unregisterMethod("draw", this);
      this.app.unregisterMethod("post", this);
      this.app.unregisterMethod("mouseEvent", this);
      this.app.unregisterMethod("keyEvent", this);
    }
  }

  /**
  * Simple signature for background hides need to call app
  * @param col int
  */
  public void background(int col) {
    this.app.background(col);
  }

  /**
  * Simple signature for fill hides need to call app
  * @param col int
  */
  public void fill(int col) {
    this.app.fill(col);
  }

  /**
  * Simple signature for stroke hides need to call app
  * @param col int
  */
  public void stroke(int col) {
    this.app.stroke(col);
  }

  /**
  * Access applet if we must
  * @return applet PApplet
  */
  public PApplet app() {
    return this.app;
  }

  /**
  * required for processing
  */
  public void dispose() {
    setActive(false);
  }
}
