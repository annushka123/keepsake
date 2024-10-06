


void setupOSC() {
  oscP5 = new OscP5(this, 12000);
  dest = new NetAddress("127.0.0.1", 6450);
}


void oscEvent(OscMessage theOscMessage) {
  if (theOscMessage.checkAddrPattern("/wek/outputs") == true) {
    if (theOscMessage.checkTypetag("ffffffffff")) { // Now looking for 6 parameters
      //bow speed
      f1 = theOscMessage.get(0).floatValue();
      //bow position
      f2 = theOscMessage.get(1).floatValue();
      //starting gesture
      f3 = theOscMessage.get(2).floatValue();
      //bow acceleration
      f4 = theOscMessage.get(3).floatValue();
      //note density
      f5 = theOscMessage.get(4).floatValue();
      //println("p5;", p5);
      //amplitude
      f6 = theOscMessage.get(5).floatValue();
      //pitches
      f7 = theOscMessage.get(6).floatValue();
      //range
      f8 = theOscMessage.get(7).floatValue();
      f9 = theOscMessage.get(8).floatValue();
      f10 = theOscMessage.get(9).floatValue();
    }
  }
}
