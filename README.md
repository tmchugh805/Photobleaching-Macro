# Photobleaching-Macro

- Closes all windows, and clears ROI manager.
- Opens a dialog to chose a file and asks user if they would like to select new ROIs or open an existing ROI file
- If creating new ROIs allows the user to manually enter ROIs in to the ROI manager once finished asks if the user would like to save the ROIs.
- If saving ROIs saves them back in the original file folder as a .zip file

### For each ROI;
- Finds the centroid
- Finds the intensity in a 5x5 and 9x9 box around the ROI in each timeframe
- Subtracts the intensity of the pixels in the background region (in the 9x9 but not 5x5 square) from the center region
- Outputs the intensity profile to results table and saves this as a text file. 
