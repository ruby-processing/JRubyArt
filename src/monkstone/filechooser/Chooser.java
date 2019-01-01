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
package monkstone.filechooser;

import java.io.File;

/**
 * This interface makes it easier/possible to use the reflection methods
 * selectInput
 * def setup
 *   java_signature 'void selectInput(String, String)'
 *   selectInput('Select a file to process:', 'fileSelected')
 * end
 *
 * def file_selected(selection)
 *   if selection.nil?
 *     puts 'Window was closed or the user hit cancel.'
 *   else
 *     puts format('User selected %s', selection.get_absolute_path)
 *   end
 * end
 * @author Martin Prout
 */
public interface Chooser {
    
    public void file_selected(File selection);
}
