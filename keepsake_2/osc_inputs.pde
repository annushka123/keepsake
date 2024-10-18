// wekinator features
float bowSpeed, startingGesture, vert_pos, bow_dir, vol, pitch, f7, f8, f9, f10;


//max values
float sb2, sb3, sb5, sb6, transition1 = 0;

void setupOSC() {
  oscP5 = new OscP5(this, 12001);
  goingToMax = new NetAddress("127.0.0.1", 6450);
}


void oscEvent(OscMessage theOscMessage) {
  if (theOscMessage.checkAddrPattern("/wek/outputs") == true) {
    if (theOscMessage.checkTypetag("ffffffffff")) { // Now looking for 6 parameters
      //bow speed
      bowSpeed = theOscMessage.get(0).floatValue();
      //bow position
      startingGesture = theOscMessage.get(1).floatValue();
      //starting gesture
      vert_pos = theOscMessage.get(2).floatValue();
      //bow acceleration
      bow_dir = theOscMessage.get(3).floatValue();
      //note density
      vol = theOscMessage.get(4).floatValue();
      //println("p5;", p5);
      //amplitude
      pitch = theOscMessage.get(5).floatValue();
      //pitches
      f7 = theOscMessage.get(6).floatValue();
      //range
      f8 = theOscMessage.get(7).floatValue();
      f9 = theOscMessage.get(8).floatValue();
      f10 = theOscMessage.get(9).floatValue();
      
      
    }
  }
  



  if (theOscMessage.checkAddrPattern("/max/outputs/sb2") == true) {
    if (theOscMessage.checkTypetag("f")) { // Now looking for 6 parameters
      
      sb2 = theOscMessage.get(0).floatValue();
      
      
      
    }
  }
  
    if (theOscMessage.checkAddrPattern("/max/outputs/sb3") == true) {
    if (theOscMessage.checkTypetag("f")) { // Now looking for 6 parameters
      
      sb3 = theOscMessage.get(0).floatValue();
      if(sb3 != 0) {
      println("sb3: " + sb3);
      
      }
    }
  }
  
  //    if (theOscMessage.checkAddrPattern("/max/outputs/sb5") == true) {
  //  if (theOscMessage.checkTypetag("f")) { // Now looking for 6 parameters
      
  //    sb5 = theOscMessage.get(0).floatValue();
  //    //if(sb5 != 0) {
  //    //println("sb5: " + sb5);
      
  //    //}
  //    println("sb5: " + sb5);
  //  }
  //}
  
  //void oscEvent(OscMessage theOscMessage) {
    if (theOscMessage.checkAddrPattern("/max/outputs/sb5")) {
        if (theOscMessage.checkTypetag("f")) {
            sb5 = theOscMessage.get(0).floatValue();
            println("OSC sb5 value received: " + sb5);

            // Set the flag to trigger state 4 transition in draw()
            if (sb5 == 2. && currentState == 3 && !state4Triggered) {
                println("OSC: Triggering State 4");
                state4Triggered = true;  // Set the flag
            }
        }
    }


  
        if (theOscMessage.checkAddrPattern("/max/outputs/sb6") == true) {
    if (theOscMessage.checkTypetag("f")) { // Now looking for 6 parameters
      
      sb6 = theOscMessage.get(0).floatValue();
      //if(sb6 != 0) {
      //println("sb6: " + sb6);
      
      //}
      
      //println("sb6: " + sb6);

    }
  }
  
     if (theOscMessage.checkAddrPattern("/max/outputs/transition1") == true) {
    if (theOscMessage.checkTypetag("f")) { // Now looking for 6 parameters
      
      transition1 = theOscMessage.get(0).floatValue();
      //if(sb6 != 0) {
      //println("sb6: " + sb6);
      
      //}
      
      println("transition1: " + transition1);

    }
  }
  
}
  
