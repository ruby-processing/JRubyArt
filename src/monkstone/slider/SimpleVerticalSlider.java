/* 
 * Copyright (c) 2016-19 Martin Prout
 * 
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 * 
 * http://creativecommons.org/licenses/LGPL/2.1/
 * 
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 * 
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 */
package monkstone.slider;

import processing.core.PApplet;
import processing.core.PConstants;
import static processing.core.PConstants.HALF_PI;

public class SimpleVerticalSlider extends SimpleSlider {
    
    final int SPACING = 20;
    final int TOP_SPC = SPACING * 2;
    final int BOTTOM_SPC = SPACING * 4;    

    /**
     *
     * @param outer
     * @param beginRange start range
     * @param endRange end range
     * @param initial
     * @param count
     */
    public SimpleVerticalSlider(final PApplet outer, float beginRange, float endRange, float initial, int count) {
        this.applet = outer;     
        setActive(true);
        pX = outer.width  - (TOP_SPC + count * SPACING);
        pY = TOP_SPC;
        pW = outer.height - BOTTOM_SPC;
        pH = 10;
        ID = Integer.toString(count + 1);
        limits(beginRange, endRange);
        
    }

   @Override
    boolean mouseOver() {
        return (applet.mouseX >= pX && applet.mouseX <= pX + pH && applet.mouseY >= pY && applet.mouseY <= pY + pW);
    }

    private void setActive(boolean active) {
        if (active) {
            applet.registerMethod("dispose", this);
            applet.registerMethod("draw", this);
        } else {
            applet.unregisterMethod("draw", this);            
        }
    }

@Override
    void displayText() {
        String lFormat = "%d";
        if (displayLabel) {
            applet.fill(labelColor);
            applet.textSize(labelSize);
            applet.textAlign(PConstants.CENTER);
            applet.pushMatrix();
            applet.translate(pX + pH / 2, pY + pW / 2);
            applet.rotate(HALF_PI);
            applet.text(Integer.toString((int) pValue), 0, 0 + labelSize / 2 - 2);
            applet.popMatrix();
        }
        if (displayValue) {
            applet.textSize(numberSize);
            applet.fill(numbersColor);
            applet.pushMatrix();
            applet.textAlign(PConstants.RIGHT);
            applet.translate(pX - numberSize / 2, pY);
            applet.rotate(HALF_PI);
            applet.text(String.format(lFormat, (int) vMax), 0, 0);
            applet.popMatrix();
            applet.pushMatrix();
            applet.textAlign(PConstants.LEFT);
            applet.translate(pX - numberSize / 2, pY + pW);
            applet.rotate(HALF_PI);
            applet.text(String.format(lFormat, (int) vMin), 0, 0);
            applet.popMatrix();
        }
    }
    
    @Override
    void drawGui() {
        if (backgroundVisible) {
            applet.fill(sliderBack);
            applet.rect(pX, pY, pH, pW);
        }
        applet.fill(sliderFill);
        applet.ellipse(pX + pH / 2, pY + pScaled, 10, 10);
    }
    
    

    /**
     *
     * @param value
     */
    @Override
    public void setValue(float value) {
        if (value > vMax) {
            value = vMax;
        }
        if (value < vMin) {
            value = vMin;
        }
        pValue = value;
        pScaled = map(pValue, vMin, vMax, pW, 0);
    }

    @Override
    void checkKeyboard() {
        if (mouseOver()) {
            if (applet.mousePressed && applet.mouseButton == PConstants.LEFT) {
                pValue = constrainMap(applet.mouseY - pY, pW, 0, vMin, vMax);
            }
            if (applet.keyPressed && pressOnlyOnce) {
                if (applet.keyCode == PConstants.LEFT || applet.keyCode == PConstants.DOWN) {
                    pValue--;
                }
                if (applet.keyCode == PConstants.RIGHT || applet.keyCode == PConstants.UP) {
                    pValue++;
                }
                if (pValue > vMax) {
                    pValue = vMax;
                } else {
                    pValue = (pValue < vMin) ? vMin : pValue;
                }
                pressOnlyOnce = false;
            }
            deBounce(5);
            pScaled = map(pValue, vMin, vMax, pW, 0);
        }
    }
   
    /**
     *
     * @return
     */
    @Override
    public String toString() {
        String geomF = "SimpleHSliderBar.new(%d, %d, %d, %.2f, %.2f, \"%s\")";
        return String.format(geomF, pX, pY, pW, vMin, vMax, ID);
    }
}
