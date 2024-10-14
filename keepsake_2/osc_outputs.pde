float previousState = -1;
float state1a = 0.;
float state1b = 1.;
float previousGesture = 1.;
boolean pieceHasStarted = false;


void startThePiece() {

OscMessage myMessage = new OscMessage("/melodies");

myMessage.add(startingGesture);
oscP5.send(myMessage, goingToMax);



}

void goToSB2a() {
  
OscMessage myMessage = new OscMessage("/melodies");

myMessage.add(state1a);
oscP5.send(myMessage, goingToMax);
  
}
void goToSB2b() {
  
OscMessage myMessage = new OscMessage("/melodies");

myMessage.add(state1b);
oscP5.send(myMessage, goingToMax);
  
}
