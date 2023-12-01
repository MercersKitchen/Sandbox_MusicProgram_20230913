//Global Variables
Minim minim; //creates object to access all functions
AudioPlayer song1; //creates "Play List" variable holding extensions WAV, AIFF, AU, SND, and MP3
//
void setup() {
  //size() or fullScreen()
  //Display Algorithm
  minim = new Minim(this); //load from data directory, loadFile should also load from project folder, like loadImage
  String pathway = "../FreeWare Music/Music Download/";
  String groove = "groove.mp3";
  String extension = ".mp3";
  song1 = minim.loadFile( pathway + groove );
} //End setup
//
void draw() {} //End draw
//
void keyPressed() {
  song1.loop(0);
} //End keyPressed
//
void mousePressed() {} //End mousePressed
//
//End MAIN Program
