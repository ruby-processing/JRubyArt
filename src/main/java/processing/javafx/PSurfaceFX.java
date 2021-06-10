/* -*- mode: java; c-basic-offset: 2; indent-tabs-mode: nil -*- */

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


import java.io.File;
import processing.core.*;


public class PSurfaceFX implements PSurface {
  final String MESSAGE = "Not implemented by ruby-processing projects";

  @Override
  public void initOffscreen(PApplet sketch) {
    throw new UnsupportedOperationException(MESSAGE); //To change body of generated methods, choose Tools | Templates.
  }

  @Override
  public void initFrame(PApplet sketch) {
    throw new UnsupportedOperationException(MESSAGE); //To change body of generated methods, choose Tools | Templates.
  }

  @Override
  public PImage loadImage(String path, Object... args) {
    throw new UnsupportedOperationException(MESSAGE); //To change body of generated methods, choose Tools | Templates.
  }

  @Override
  public void selectInput(String prompt, String callback, File file, Object callbackObject) {
    throw new UnsupportedOperationException(MESSAGE); //To change body of generated methods, choose Tools | Templates.
  }

  @Override
  public void selectOutput(String prompt, String callback, File file, Object callbackObject) {
    throw new UnsupportedOperationException(MESSAGE); //To change body of generated methods, choose Tools | Templates.
  }

  @Override
  public void selectFolder(String prompt, String callback, File file, Object callbackObject) {
    throw new UnsupportedOperationException(MESSAGE); //To change body of generated methods, choose Tools | Templates.
  }

  @Override
  public Object getNative() {
    throw new UnsupportedOperationException(MESSAGE); //To change body of generated methods, choose Tools | Templates.
  }

  @Override
  public void setTitle(String title) {
    throw new UnsupportedOperationException(MESSAGE); //To change body of generated methods, choose Tools | Templates.
  }

  @Override
  public void setVisible(boolean visible) {
    throw new UnsupportedOperationException(MESSAGE); //To change body of generated methods, choose Tools | Templates.
  }

  @Override
  public void setResizable(boolean resizable) {
    throw new UnsupportedOperationException(MESSAGE); //To change body of generated methods, choose Tools | Templates.
  }

  @Override
  public void setAlwaysOnTop(boolean always) {
    throw new UnsupportedOperationException(MESSAGE); //To change body of generated methods, choose Tools | Templates.
  }

  @Override
  public void setIcon(PImage icon) {
    throw new UnsupportedOperationException(MESSAGE); //To change body of generated methods, choose Tools | Templates.
  }

  @Override
  public void placeWindow(int[] location, int[] editorLocation) {
    throw new UnsupportedOperationException(MESSAGE); //To change body of generated methods, choose Tools | Templates.
  }

  @Override
  public void placePresent(int stopColor) {
    throw new UnsupportedOperationException(MESSAGE); //To change body of generated methods, choose Tools | Templates.
  }

  @Override
  public void setupExternalMessages() {
    throw new UnsupportedOperationException(MESSAGE); //To change body of generated methods, choose Tools | Templates.
  }

  @Override
  public void setLocation(int x, int y) {
    throw new UnsupportedOperationException(MESSAGE); //To change body of generated methods, choose Tools | Templates.
  }

  @Override
  public void setSize(int width, int height) {
    throw new UnsupportedOperationException(MESSAGE); //To change body of generated methods, choose Tools | Templates.
  }

  @Override
  public void setFrameRate(float fps) {
    throw new UnsupportedOperationException(MESSAGE); //To change body of generated methods, choose Tools | Templates.
  }

  @Override
  public void setCursor(int kind) {
    throw new UnsupportedOperationException(MESSAGE); //To change body of generated methods, choose Tools | Templates.
  }

  @Override
  public void setCursor(PImage image, int hotspotX, int hotspotY) {
    throw new UnsupportedOperationException(MESSAGE); //To change body of generated methods, choose Tools | Templates.
  }

  @Override
  public void showCursor() {
    throw new UnsupportedOperationException(MESSAGE); //To change body of generated methods, choose Tools | Templates.
  }

  @Override
  public void hideCursor() {
    throw new UnsupportedOperationException(MESSAGE); //To change body of generated methods, choose Tools | Templates.
  }

  @Override
  public boolean openLink(String url) {
    throw new UnsupportedOperationException(MESSAGE); //To change body of generated methods, choose Tools | Templates.
  }

  @Override
  public void startThread() {
    throw new UnsupportedOperationException(MESSAGE); //To change body of generated methods, choose Tools | Templates.
  }

  @Override
  public void pauseThread() {
    throw new UnsupportedOperationException(MESSAGE); //To change body of generated methods, choose Tools | Templates.
  }

  @Override
  public void resumeThread() {
    throw new UnsupportedOperationException(MESSAGE); //To change body of generated methods, choose Tools | Templates.
  }

  @Override
  public boolean stopThread() {
    throw new UnsupportedOperationException(MESSAGE); //To change body of generated methods, choose Tools | Templates.
  }

  @Override
  public boolean isStopped() {
    throw new UnsupportedOperationException(MESSAGE); //To change body of generated methods, choose Tools | Templates.
  }
  
}
