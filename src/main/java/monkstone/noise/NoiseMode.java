/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package monkstone.noise;

/**
 *
 * @author tux
 */
public enum NoiseMode {
    DEFAULT("Fast OpenSimplex2"),
    FAST_TERRAIN("Fast Terrain"),
    SMOOTH_TERRAIN("Smooth Terrain"),
    OPEN_SMOOTH("Smooth OpenSimplex2");

    private final String description;

    NoiseMode(String description) {
        this.description = description;
    }

    public String description() {
        return description;
    }

}
