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

public class SimpleHorizontalSlider extends SimpleSlider {
    
    final int SPACING = 20;
    final int LEFT_SPC = SPACING * 2;
    final int RIGHT_SPC = SPACING * 4;    

    /**
     *
     * @param outer
     * @param beginRange start range
     * @param endRange end range
     * @param initial
     * @param count
     */
    public SimpleHorizontalSlider(final PApplet outer, float beginRange, float endRange, float initial, int count) {
        this.applet = outer;
        setActive(true);
        pX = LEFT_SPC;
        pY = outer.height - SPACING - (count * SPACING);
        pW = outer.width - RIGHT_SPC;
        pH = 10;
        ID = Integer.toString(count + 1);
        limits(beginRange, endRange);
        setValue(initial);
    }

    @Override
    boolean mouseOver() {
        return (applet.mouseX >= pX && applet.mouseX <= pX + pW && applet.mouseY >= pY && applet.mouseY <= pY + pH);
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
            applet.textAlign(PConstants.BOTTOM);
            applet.text(Integer.toString((int) pValue), pX + pW / 2, pY + pH);
        }
        if (displayValue) {
            applet.textSize(numberSize);
            applet.fill(numbersColor);
            applet.textAlign(PConstants.LEFT);
            applet.text(String.format(lFormat, (int) vMin), pX, pY );
            applet.textAlign(PConstants.RIGHT);
            applet.text(String.format(lFormat, (int) vMax), pX + pW, pY );
        }
    }
    
    @Override
    void drawGui() {
        if (backgroundVisible) {
            applet.stroke(sliderBack);
            applet.line(pX, pY + pH / 2, pX + pW, pY + pH / 2);
        }
        applet.noStroke();
        applet.fill(255);
        applet.ellipse(pX + pScaled, pY + pH / 2, 10, 10);
    }    

    /**
     *
     * @param value
     */
    @Override
    public final void setValue(float value) {
        if (value > vMax) {
            value = vMax;
        }
        if (value < vMin) {
            value = vMin;
        }
        pValue = value;
        pScaled = map(pValue, vMin, vMax, 0, pW);
    }

    @Override
    void checkKeyboard() {
        if (mouseOver()) {
            if (applet.mousePressed && applet.mouseButton == PConstants.LEFT) {
                pValue = constrainMap(applet.mouseX - pX, 0, pW, vMin, vMax);
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
            pScaled = map(pValue, vMin, vMax, 0, pW);
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
