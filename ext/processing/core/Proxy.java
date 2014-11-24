package processing.core;

public abstract class Proxy {

    private final PApplet app;
    public int width, height;

    public Proxy(PApplet app) {
        this.app = app;
        this.width = app.width;
        this.height = app.height;
        setActive(true);
    }

    public abstract void pre(); 

    public abstract void draw(); 

    public abstract void post();

    private void setActive(boolean active) {
        if (active) {
            this.app.registerMethod("pre", this);
            this.app.registerMethod("draw", this);
            this.app.registerMethod("post", this);
            this.app.registerMethod("dispose", this);
        } else {
            this.app.unregisterMethod("pre", this);
            this.app.unregisterMethod("draw", this);
            this.app.unregisterMethod("post", this);
        }
    }

    public void background(int col) {
        this.app.background(col);
    }

    public void fill(int col) {
        this.app.fill(col);
    }

    public void stroke(int col) {
        this.app.stroke(col);
    }

    public PApplet app() {
        return this.app;
    }

    public void dispose() {
        setActive(false);
    }
}
