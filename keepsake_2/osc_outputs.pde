

float previousGesture = 1.;
boolean pieceHasStarted = false;


void startThePiece() {

OscMessage myMessage = new OscMessage("/melodies");

myMessage.add(startingGesture);
oscP5.send(myMessage, goingToMax);



}
