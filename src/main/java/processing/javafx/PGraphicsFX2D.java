package processing.javafx;

import processing.core.PGraphics;
import processing.core.PImage;
import processing.core.PMatrix;
import processing.core.PMatrix2D;
import processing.core.PMatrix3D;
import processing.core.PShape;
import processing.core.PSurface;

public class PGraphicsFX2D extends PGraphics {

  final String message = "FX2D renderer not supported in this version of JRubyArt";

  public PGraphicsFX2D() {
  }

  @Override
  public void applyMatrix(float n00, float n01, float n02, float n10, float n11, float n12) {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public void applyMatrix(float n00, float n01, float n02, float n03, float n10, float n11, float n12, float n13, float n20, float n21, float n22, float n23, float n30, float n31, float n32, float n33) {
    throw new UnsupportedOperationException(message);
  }

  @Override
  protected void backgroundImpl() {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public void beginContour() {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public void beginDraw() {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public void beginShape(int kind) {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public void bezierDetail(int detail) {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public void bezierVertex(float x1, float y1, float x2, float y2, float x3, float y3) {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public void bezierVertex(float x2, float y2, float z2, float x3, float y3, float z3, float x4, float y4, float z4) {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public void box(float w, float h, float d) {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public PSurface createSurface() {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public void curveDetail(int detail) {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public void curveVertex(float x, float y, float z) {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public void endContour() {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public void endDraw() {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public void endShape(int mode) {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public void flush() {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public int get(int x, int y) {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public PMatrix getMatrix() {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public PMatrix2D getMatrix(PMatrix2D target) {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public PMatrix3D getMatrix(PMatrix3D target) {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public Object getNative() {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public void line(float x1, float y1, float x2, float y2) {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public void loadPixels() {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public PShape loadShape(String filename) {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public PShape loadShape(String filename, String options) {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public void mask(PImage alpha) {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public void noClip() {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public void point(float x, float y) {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public void popMatrix() {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public void printMatrix() {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public void pushMatrix() {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public void quad(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public void quadraticVertex(float ctrlX, float ctrlY, float endX, float endY) {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public void quadraticVertex(float x2, float y2, float z2, float x4, float y4, float z4) {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public void resetMatrix() {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public void rotate(float angle) {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public void rotate(float angle, float vx, float vy, float vz) {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public void rotateX(float angle) {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public void rotateY(float angle) {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public void rotateZ(float angle) {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public void scale(float s) {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public void scale(float sx, float sy) {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public void scale(float sx, float sy, float sz) {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public float screenX(float x, float y) {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public float screenX(float x, float y, float z) {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public float screenY(float x, float y) {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public float screenY(float x, float y, float z) {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public float screenZ(float x, float y, float z) {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public void set(int x, int y, int argb) {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public void setMatrix(PMatrix2D source) {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public void setMatrix(PMatrix3D source) {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public void shearX(float angle) {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public void shearY(float angle) {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public void sphere(float r) {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public void strokeCap(int cap) {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public void strokeJoin(int join) {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public void strokeWeight(float weight) {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public float textAscent() {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public float textDescent() {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public void texture(PImage image) {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public void translate(float tx, float ty) {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public void triangle(float x1, float y1, float x2, float y2, float x3, float y3) {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public void vertex(float x, float y) {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public void vertex(float x, float y, float z) {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public void vertex(float[] v) {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public void vertex(float x, float y, float u, float v) {
    throw new UnsupportedOperationException(message);
  }

  @Override
  public void vertex(float x, float y, float z, float u, float v) {
    throw new UnsupportedOperationException(message);
  }
}
