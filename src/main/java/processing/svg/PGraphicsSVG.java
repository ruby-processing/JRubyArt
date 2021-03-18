/*
  Part of the Processing project - http://processing.org

  Copyright (c) 2013-2015 The Processing Foundation
  Copyright (c) 2012 Ben Fry and Casey Reas

  This library is free software; you can redistribute it and/or
  modify it under the terms of the GNU Lesser General Public
  License version 2.1 as published by the Free Software Foundation.

  This library is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  Lesser General Public License for more details.

  You should have received a copy of the GNU Lesser General
  Public License along with this library; if not, write to the
  Free Software Foundation, Inc., 59 Temple Place, Suite 330,
  Boston, MA  02111-1307  USA
 */
package processing.svg;

import java.awt.Dimension;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.io.Writer;
import java.nio.charset.StandardCharsets;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.apache.batik.dom.GenericDOMImplementation;
import org.apache.batik.svggen.SVGGraphics2D;
import org.apache.batik.svggen.SVGGraphics2DIOException;
import org.w3c.dom.DOMImplementation;
import org.w3c.dom.Document;
import processing.awt.PGraphicsJava2D;
import processing.core.PImage;
import processing.core.PSurface;
import processing.core.PSurfaceNone;

public class PGraphicsSVG extends PGraphicsJava2D {

    /**
     * File being written, if it's a file.
     */
    protected File file;
    /**
     * OutputStream being written to, if using an OutputStream.
     */
    protected OutputStream output;

//  protected Writer writer;
    public PGraphicsSVG() {
    }

    @Override
    public void setPath(String path) {
        this.path = path;
        if (path != null) {
            file = new File(path);
            if (!file.isAbsolute()) {
                file = null;
            }
        }
        if (file == null) {
            throw new RuntimeException("PGraphicsSVG requires an absolute path "
                    + "for the location of the output file.");
        }
    }

    /**
     * Set the library to write to an output stream instead of a file.
     *
     * @param output
     */
    public void setOutput(OutputStream output) {
        this.output = output;
    }

    @Override
    public PSurface createSurface() {
        return surface = new PSurfaceNone(this);
    }

    @Override
    protected void defaultSettings() {  // ignore
        super.defaultSettings();
        textMode = SHAPE;
    }

    @Override
    public void beginDraw() {
        DOMImplementation domImpl
                = GenericDOMImplementation.getDOMImplementation();

        // Create an instance of org.w3c.dom.Document.
        String ns = "http://www.w3.org/2000/svg";
        Document document = domImpl.createDocument(ns, "svg", null);

        // Create an instance of the SVG Generator.
        g2 = new SVGGraphics2D(document);
        ((SVGGraphics2D) g2).setSVGCanvasSize(new Dimension(width, height));

        // Done with our work, let's check on defaults and the rest
        //super.beginDraw();
        // Can't call super.beginDraw() because it'll nuke our g2
        checkSettings();
        resetMatrix(); // reset model matrix
        vertexCount = 0;

        // Also need to push the matrix since the matrix doesn't reset on each run
        // http://dev.processing.org/bugs/show_bug.cgi?id=1227
        pushMatrix();
    }

    @Override
    public void endDraw() {
        Writer writer;
        // Also need to pop the matrix since the matrix doesn't reset on each run
        // http://dev.processing.org/bugs/show_bug.cgi?id=1227
        popMatrix();
        // Figure out where the output goes. If the sketch is calling setOutput()
        // inside draw(), then that OutputStream will be used, otherwise the
        // path for rendering is expected to have ### inside it so that the frame
        // can be inserted, because SVG doesn't support multiple pages.
        if (output == null) {
            if (path == null) {
                throw new RuntimeException("setOutput() or setPath() must be "
                        + "used with the SVG renderer");
            } else {
                // insert the frame number and create intermediate directories
                File save = parent.saveFile(parent.insertFrame(path));
                try {
                    output = new FileOutputStream(save);
                } catch (FileNotFoundException e) {
                    throw new RuntimeException(e);
                }
            }
        }
        // This needs to be overridden so that the endDraw() from PGraphicsJava2D
        // is not inherited (it calls loadPixels).
        // http://dev.processing.org/bugs/show_bug.cgi?id=1169
        // Finally, stream out SVG to the standard output using UTF-8 encoding.
        boolean useCSS = true; // we want to use CSS style attributes
        writer = new PrintWriter(
                new BufferedWriter(
                        new OutputStreamWriter(output, StandardCharsets.UTF_8)
                )
        );
        try {
            ((SVGGraphics2D) g2).stream(writer, useCSS);
        } catch (SVGGraphics2DIOException e) {
        }
        try {
            writer.flush();
            writer.close();
        } catch (IOException e) {
        } finally {
            output = null;
        }
        try {
            writer.close();
        } catch (IOException ex) {
            Logger.getLogger(PGraphicsSVG.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    // nothing to be done in dispose(), since essentially disposed on each frame
    @Override
    public void dispose() {
    }

    /**
     * Don't open a window for this renderer, it won't be used.
     *
     * @return
     */
    @Override
    public boolean displayable() {
        return false;
    }

    @Override
    public void loadPixels() {
        nope("loadPixels");
    }

    @Override
    public void updatePixels() {
        nope("updatePixels");
    }

    @Override
    public void updatePixels(int x, int y, int c, int d) {
        nope("updatePixels");
    }

    //
    @Override
    public int get(int x, int y) {
        nope("get");
        return 0;  // not reached
    }

    @Override
    public PImage get(int x, int y, int c, int d) {
        nope("get");
        return null;  // not reached
    }

    @Override
    public PImage get() {
        nope("get");
        return null;  // not reached
    }

    @Override
    public void set(int x, int y, int argb) {
        nope("set");
    }

    @Override
    public void set(int x, int y, PImage image) {
        nope("set");
    }

    //
    @Override
    public void mask(int alpha[]) {
        nope("mask");
    }

    @Override
    public void mask(PImage alpha) {
        nope("mask");
    }

    //
    @Override
    public void filter(int kind) {
        nope("filter");
    }

    @Override
    public void filter(int kind, float param) {
        nope("filter");
    }

    //
    @Override
    public void copy(int sx1, int sy1, int sx2, int sy2,
            int dx1, int dy1, int dx2, int dy2) {
        nope("copy");
    }

    @Override
    public void copy(PImage src,
            int sx1, int sy1, int sx2, int sy2,
            int dx1, int dy1, int dx2, int dy2) {
        nope("copy");
    }

    //
    public void blend(int sx, int sy, int dx, int dy, int mode) {
        nope("blend");
    }

    public void blend(PImage src,
            int sx, int sy, int dx, int dy, int mode) {
        nope("blend");
    }

    @Override
    public void blend(int sx1, int sy1, int sx2, int sy2,
            int dx1, int dy1, int dx2, int dy2, int mode) {
        nope("blend");
    }

    @Override
    public void blend(PImage src,
            int sx1, int sy1, int sx2, int sy2,
            int dx1, int dy1, int dx2, int dy2, int mode) {
        nope("blend");
    }

    //
    @Override
    public boolean save(String filename) {
        nope("save");
        return false;
    }

    //////////////////////////////////////////////////////////////
//  /**
//   * Add a directory that should be searched for font data.
//   * <br/>
//   * On Mac OS X, the following directories are added by default:
//   * <UL>
//   * <LI>/System/Library/Fonts
//   * <LI>/Library/Fonts
//   * <LI>~/Library/Fonts
//   * </UL>
//   * On Windows, all drive letters are searched for WINDOWS\Fonts
//   * or WINNT\Fonts, any that exists is added.
//   * <br/><br/>
//   * On Linux or any other platform, you'll need to add the
//   * directories by hand. (If there are actual standards here that we
//   * can use as a starting point, please file a bug to make a note of it)
//   */
//  public void addFonts(String directory) {
//    mapper.insertDirectory(directory);
//  }
//  /**
//   * Check whether the specified font can be used with the PDF library.
//   * @param name name of the font
//   * @return true if it's ok
//   */
//  protected void checkFont() {
//    Font awtFont = textFont.getFont();
//    if (awtFont == null) {  // always need a native font or reference to it
//      throw new RuntimeException("Use createFont() instead of loadFont() " +
//                                 "when drawing text using the PDF library.");
//    } else if (textMode != SHAPE) {
//      if (textFont.isStream()) {
//        throw new RuntimeException("Use textMode(SHAPE) with PDF when loading " +
//                                   ".ttf and .otf files with createFont().");
//      } else if (mapper.getAliases().get(textFont.getName()) == null) {
//        //System.out.println("alias for " + name + " = " + mapper.getAliases().get(name));
////        System.err.println("Use PGraphicsPDF.listFonts() to get a list of " +
////                           "fonts that can be used with PDF.");
////        throw new RuntimeException("The font “" + textFont.getName() + "” " +
////                                   "cannot be used with PDF Export.");
//        if (textFont.getName().equals("Lucida Sans")) {
//          throw new RuntimeException("Use textMode(SHAPE) with the default " +
//                                               "font when exporting to PDF.");
//        } else {
//          throw new RuntimeException("Use textMode(SHAPE) with " +
//                                               "“" + textFont.getName() + "” " +
//                                     "when exporting to PDF.");
//        }
//      }
//    }
//  }
//  /**
//   * List the fonts known to the PDF renderer. This is like PFont.list(),
//   * however not all those fonts are available by default.
//   */
//  static public String[] listFonts() {
//    if (fontList == null) {
//      HashMap<?, ?> map = getMapper().getAliases();
////      Set entries = map.entrySet();
////      fontList = new String[entries.size()];
//      fontList = new String[map.size()];
//      int count = 0;
//      for (Object entry : map.entrySet()) {
//        fontList[count++] = (String) ((Map.Entry) entry).getKey();
//      }
////      Iterator it = entries.iterator();
////      int count = 0;
////      while (it.hasNext()) {
////        Map.Entry entry = (Map.Entry) it.next();
////        //System.out.println(entry.getKey() + "-->" + entry.getValue());
////        fontList[count++] = (String) entry.getKey();
////      }
//      fontList = PApplet.sort(fontList);
//    }
//    return fontList;
//  }
    //////////////////////////////////////////////////////////////
    protected void nope(String function) {
        throw new RuntimeException("No " + function + "() for PGraphicsSVG");
    }
}
