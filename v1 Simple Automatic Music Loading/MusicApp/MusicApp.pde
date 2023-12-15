import java.io.*; //Pure Java Library
//
//Library: use Sketch / Import Library / Minim
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;
//
//Global Variables
File file; //Class for java.io.* library
Minim minim; //creates object to access all functions\
int numberOfSongs = 1; //Placeholder Only, reexecute lines after fileCount Known
AudioPlayer[] song = new AudioPlayer[numberOfSongs]; //song is now similar to song1
AudioMetaData[] songMetaData = new AudioMetaData[numberOfSongs]; //same as above
PFont generalFont;
color purple = #2C08FF;
//
void setup() {
  //size() or fullScreen()
  //Display Algorithm
  String pathway = "FreeWare Music/MusicDownload/"; //Relative Path
  String directory = sketchPath( pathway ); //Absolute Path
  println("Main Directory to Music Folder", directory);
  file = new File(directory);
  int fileCount = file.list().length;
  println("File Count of the Music Folder", fileCount);
  File[] files = file.listFiles(); //String of Full Directies
  println("List of all Directories of Each Song to Load into music playlist");
  printArray(files);
  //Demonstration Only, files know their names
  for ( int i = 0; i < files.length; i++ ) {
    println("File Name", files[i].getName() );
  }
  //NOTE: take each song's pathway and load the music into the PlayList
  String[] songFilePathway = new String[fileCount];
  for ( int i = 0; i < files.length; i++ ) {
    songFilePathway[i] = ( files[i].toString() );
  }
  // Re-execute Playlist Population, similar to DIV Population
  int numberOfSongs = fileCount; //Placeholder Only, reexecute lines after fileCount Known
  song = new AudioPlayer[numberOfSongs]; //song is now similar to song1
  songMetaData = new AudioMetaData[numberOfSongs]; //same as above
  //
  minim = new Minim(this); //load from data directory, loadFile should also load from project folder, like loadImage
  //
  for ( int i=0; i<fileCount; i++ ) {
    song[i]= minim.loadFile( songFilePathway[i] );
    songMetaData[i] = song[i].getMetaData();
  } //End Music Load
  /*
  song[0]= minim.loadFile( songFilePathway[0] );
  songMetaData[0] = song[0].getMetaData();
  song[1]= minim.loadFile( songFilePathway[1] );
  songMetaData[1] = song[1].getMetaData();
  song[2]= minim.loadFile( songFilePathway[2] );
  songMetaData[2] = song[2].getMetaData();
  song[3]= minim.loadFile( songFilePathway[3] );
  songMetaData[3] = song[3].getMetaData();
  song[4]= minim.loadFile( songFilePathway[4] );
  songMetaData[4] = song[4].getMetaData();
  song[5]= minim.loadFile( songFilePathway[5] );
  songMetaData[5] = song[5].getMetaData();
  song[6]= minim.loadFile( songFilePathway[6] );
  songMetaData[6] = song[6].getMetaData();
  song[7]= minim.loadFile( songFilePathway[7] );
  songMetaData[7] = song[7].getMetaData();
  */
  //generalFont = createFont ("Harrington", 55); //Must also Tools / Create Font / Find Font / Do Not Press "OK"
  song[0].play();
} //End setup
//
void draw() {
  //NOte: Looping Function
  //Note: logical operators could be nested IFs
  /*
   if ( song1.isLooping() && song1.loopCount()!=-1 ) println("There are", song1.loopCount(), "loops left.");
   if ( song1.isLooping() && song1.loopCount()==-1 ) println("Looping Infinitely");
   if ( song1.isPlaying() && !song1.isLooping() ) println("Play Once");
   //
   //Debugging Fast Forward and Fast Rewind
   //println( "Song Position", song1.position(), "Song Length", song1.length() );
   //
   // songMetaData1.title()
   rect(width*1/4, height*0, width*1/2, height*3/10); //mistake
   fill(purple); //Ink
   textAlign (CENTER, CENTER); //Align X&Y, see Processing.org / Reference
   //Values: [LEFT | CENTER | RIGHT] & [TOP | CENTER | BOTTOM | BASELINE]
   int size = 10; //Change this font size
   textFont(generalFont, size); //Change the number until it fits, largest font size
   text(songMetaData1.title(), width*1/4, height*0, width*1/2, height*3/10);
   fill(255); //Reset to white for rest of the program
   */
} //End draw
//
void keyPressed() {
  /*
  if ( key=='P' || key=='p' ) song1.play(); //Parameter is milli-seconds from start of audio file to start playing (illustrate with examples)
   //.play() includes .rewind()
   //
   if ( key>='1' || key<='9' ) { //Loop Button, previous (key=='1' || key=='9')
   //Note: "9" is assumed to be massive! "Simulate Infinite"
   String keystr = String.valueOf(key);
   //println(keystr);
   int loopNum = int(keystr); //Java, strongly formatted need casting
   song1.loop(loopNum); //Parameter is number of repeats
   //
   }
   if ( key=='L' || key=='l' ) song1.loop(); //Infinite Loop, no parameter OR -1
   //
   if ( key=='M' || key=='m' ) { //MUTE Button
   //MUTE Behaviour: stops electricty to speakers, does not stop file
   //NOTE: MUTE has NO built-in PUASE button, NO built-in rewind button
   //ERROR: if song near end of file, user will not know song is at the end
   //Known ERROR: once song plays, MUTE acts like it doesn't work
   if ( song1.isMuted() ) {
   //ERROR: song might not be playing
   //CATCH: ask .isPlaying() or !.isPlaying()
   song1.unmute();
   } else {
   //Possible ERROR: Might rewind the song
   song1.mute();
   }
   } //End MUTE
   //
   //Possible ERROR: FF rewinds to parameter milliseconds from SONG Start
   //Possible ERROR: FR rewinds to parameter milliseconds from SONG Start
   //How does this get to be a true ff and fr button
   //Actual .skip() allows for varaible ff & fr using .position()+-
   if ( key=='F' || key=='f' ) song1.skip( 0 ); //SKIP forward 1 second (1000 milliseconds)
   if ( key=='R' || key=='r' ) song1.skip( 1000 ); //SKIP  backawrds 1 second, notice negative, (-1000 milliseconds)
   //
   //Simple STOP Behaviour: ask if .playing() & .pause() & .rewind(), or .rewind()
   if ( key=='S' | key=='s' ) {
   if ( song1.isPlaying() ) {
   song1.pause(); //auto .rewind()
   } else {
   song1.rewind(); //Not Necessary
   }
   }
   //
   //Simple Pause Behaviour: .pause() & hold .position(), then PLAY
   if ( key=='Y' | key=='y' ) {
   if ( song1.isPlaying()==true ) {
   song1.pause(); //auto .rewind()
   } else {
   song1.play(); //ERROR, doesn't play
   }
   }
   */
} //End keyPressed
//
void mousePressed() {
} //End mousePressed
//
//End MAIN Program
