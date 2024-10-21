float previousState = -1;
float previousState2 = -1;
float previousState4 = -1;
int previousSB7 = -1;
float state1a = 0.;
float state1b = 1.;
float state4a = 3.;
float state4b = 4.;
int generate = 6;
float endPiece = 5.;
int bell_1 = 1;
int groan_1 = 2;
int groan_2 = 3;
int groan_3 = 4;
int groan_4 = 5;
int doni_2 = 6;
int previousBell = -1;
float previousGesture = 1.;
boolean pieceHasStarted = false;


void startThePiece() {

OscMessage myMessage = new OscMessage("/melodies");

myMessage.add(startingGesture);
oscP5.send(myMessage, goingToMax);

}

void playBell_1() {

OscMessage myMessage = new OscMessage("/snippets");

myMessage.add(bell_1);
oscP5.send(myMessage, goingToMax);

}

void playGroan_1() {

OscMessage myMessage = new OscMessage("/snippets");

myMessage.add(groan_1);
oscP5.send(myMessage, goingToMax);

}

void playGroan_2() {

OscMessage myMessage = new OscMessage("/snippets");

myMessage.add(groan_2);
oscP5.send(myMessage, goingToMax);

}

void playGroan_3() {

OscMessage myMessage = new OscMessage("/snippets");

myMessage.add(groan_3);
oscP5.send(myMessage, goingToMax);

}

void playGroan_4() {

OscMessage myMessage = new OscMessage("/snippets");

myMessage.add(groan_4);
oscP5.send(myMessage, goingToMax);

}

void playDoni_2() {

OscMessage myMessage = new OscMessage("/snippets");

myMessage.add(doni_2);
oscP5.send(myMessage, goingToMax);

}

void goToSB2a() {
  
OscMessage myMessage = new OscMessage("/melodies");

myMessage.add(state1a);
oscP5.send(myMessage, goingToMax);

println("sent message to Max");
  
}
void goToSB2b() {
  
OscMessage myMessage = new OscMessage("/melodies");

myMessage.add(state1b);
oscP5.send(myMessage, goingToMax);

println("sent message to Max");
  
}

void goToSB4a() {
  
OscMessage myMessage = new OscMessage("/melodies");

myMessage.add(state4a);
oscP5.send(myMessage, goingToMax);

println("sent message to Max");
  
}
void goToSB4b() {
  
OscMessage myMessage = new OscMessage("/melodies");

myMessage.add(state4b);
oscP5.send(myMessage, goingToMax);

println("sent message to Max");
  
}


//starts generated melodies
void startML() {
  
OscMessage myMessage = new OscMessage("/markov");

myMessage.add(generate);
oscP5.send(myMessage, goingToMax); 

println("sent generate message to Max");
  
}

void endThePiece() {

OscMessage myMessage = new OscMessage("/melodies");

myMessage.add(endPiece);
oscP5.send(myMessage, goingToMax);

}
