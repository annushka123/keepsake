void pixelSubtraction(PImage currentFrame, PImage previousFrame, PImage diffFrame, int r, int g, int b, float a  ) {
  diffFrame.loadPixels();
  previousFrame.loadPixels();
  currentFrame.loadPixels();

  for (int i = 0; i < currentFrame.pixels.length; i++) {
    color currentColor = currentFrame.pixels[i];
    color previousColor = previousFrame.pixels[i];

    // Extract brightness from the current and previous frames (grayscale)
    float currentBrightness = brightness(currentColor);
    float previousBrightness = brightness(previousColor);

    // Compute absolute difference between current and previous frame
    float diff = abs(currentBrightness - previousBrightness);

    // Apply a threshold to highlight differences
    if (diff > thresholdValue) {
      diffFrame.pixels[i] = color(r, g, b, a);  // Mark as white for the outline
    } else {
      diffFrame.pixels[i] = color(0, 0);    // Black background
    }
  }

  diffFrame.updatePixels();
}
