/*
  Part of the Processing project - http://processing.org

  Copyright (c) 2015 The Processing Foundation

  This library is free software; you can redistribute it and/or
  modify it under the terms of the GNU Lesser General Public
  License as published by the Free Software Foundation, version 2.1.

  This library is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
  Lesser General Public License for more details.

  You should have received a copy of the GNU Lesser General
  Public License along with this library; if not, write to the
  Free Software Foundation, Inc., 59 Temple Place, Suite 330,
  Boston, MA  02111-1307  USA
 */
package processing.javafx;

import processing.core.PApplet;
import processing.core.PImage;
import processing.core.PSurface;

public class PSurfaceFX implements PSurface {

  final String message = "FX2D renderer not supported in this version of propane";

  @Override
  public void initOffscreen(PApplet sketch) {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public void initFrame(PApplet sketch) {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public Object getNative() {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public void setTitle(String title) {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public void setVisible(boolean visible) {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public void setResizable(boolean resizable) {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public void setAlwaysOnTop(boolean always) {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public void setIcon(PImage icon) {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public void placeWindow(int[] location, int[] editorLocation) {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public void placePresent(int stopColor) {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public void setupExternalMessages() {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public void setLocation(int x, int y) {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public void setSize(int width, int height) {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public void setFrameRate(float fps) {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public void setCursor(int kind) {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public void setCursor(PImage image, int hotspotX, int hotspotY) {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public void showCursor() {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public void hideCursor() {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public void startThread() {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public void pauseThread() {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public void resumeThread() {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public boolean stopThread() {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public boolean isStopped() {
    throw new UnsupportedOperationException(message);
  }

}
