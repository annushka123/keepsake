var bufferLength = 0;  // Store the buffer length in milliseconds
var bangSent = false;  // Track whether the bang has been sent
var lastPosition = 0;  // Store the last playback position

function anything() {
    var args = arrayfromargs(messagename, arguments);  // Convert incoming message to array

    if (args[0] === "length") {
        // Set the buffer length from info~ object
        bufferLength = args[1];
        post("Buffer length set to: " + bufferLength + " ms\n");
        bangSent = false;  // Reset bang state when a new buffer is loaded
    } 
    else if (args[0] === "position") {
        // Ensure position argument is valid
        var normalizedPosition = parseFloat(args[1]);

        if (isNaN(normalizedPosition)) {
            post("Error: Invalid playback position received.\n");
            return;
        }

        // Detect end of playback (transition from > 0 to 0)
        if (normalizedPosition === 0 && lastPosition > 0 && !bangSent) {
            outlet(0, "bang");  // Send bang when playback finishes
            bangSent = true;  // Prevent further bangs until reset
        }

        // Store the current position for comparison on the next call
        lastPosition = normalizedPosition;
    } 
    else if (args[0] === "reset") {
        // Manual reset function to allow a new bang
        bangSent = false;
        post("Playback state reset.\n");
    } 
    else {
        post("Error: Unrecognized message.\n");
    }
}
