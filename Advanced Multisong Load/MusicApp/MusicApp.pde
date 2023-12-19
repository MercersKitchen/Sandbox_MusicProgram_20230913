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
File musicFolder, soundEffectFolder; //Class for java.io.* library
Minim minim; //creates object to access all functions
int numberOfSongs = 1, numberOfSoundEffects = 1; //Placeholder Only, reexecute lines after fileCount Known
AudioPlayer[] playList = new AudioPlayer[numberOfSongs]; //song is now similar to song1
AudioMetaData[] playListMetaData = new AudioMetaData[numberOfSongs]; //same as above
AudioPlayer[] soundEffects = new AudioPlayer[numberOfSoundEffects]; //song is now similar to song1PFont generalFont;
color purple = #2C08FF;
PFont generalFont;
//
void setup() {
  //size() or fullScreen()
  //Display Algorithm
  //Music File Load
  String relativeMusicPathway = "FreeWare Music/MusicDownload/"; //Relative Path
  String absoluteMusicPath = sketchPath( relativeMusicPathway ); //Absolute Path
    musicFolder = new File(absoluteMusicPath);
  int musicFileCount = musicFolder.list().length;
    File[] musicFiles = musicFolder.listFiles(); //String of Full Directies
  String[] songFilePathway = new String[musicFileCount];
  for ( int i = 0; i < musicFiles.length; i++ ) {
    songFilePathway[i] = ( musicFiles[i].toString() );
  }
  //Re-execute Playlist Population, similar to DIV Population
  int numberOfSongs = musicFileCount; //Placeholder Only, reexecute lines after fileCount Known
  playList = new AudioPlayer[numberOfSongs]; //song is now similar to song1
  playListMetaData = new AudioMetaData[numberOfSongs]; //same as above
  for ( int i=0; i<musicFileCount; i++ ) {
    playList[i]= minim.loadFile( songFilePathway[i] );
    playListMetaData[i] = playList[i].getMetaData();
  } //End Music Load
  //
  // Sound Effects Load
  String relativeSoundPathway = "FreeWare Music/SoundEffect/"; //Relative Path
  String absoluteSoundPath = sketchPath( relativeSoundPathway ); //Absolute Path
  soundEffectFolder = new File(absoluteSoundPath);
  int soundEffectFileCount = soundEffectFolder.list().length;
  File[] soundEffectFiles = soundEffectFolder.listFiles(); //String of Full Directies
  String[] soundEffectFilePathway = new String[soundEffectFileCount];
  for ( int i = 0; i < soundEffectFiles.length; i++ ) {
    soundEffectFilePathway[i] = ( soundEffectFiles[i].toString() );
  }
  //Re-execute Playlist Population, similar to DIV Population
  numberOfSoundEffects = soundEffectFileCount; //Placeholder Only, reexecute lines after fileCount Known
  soundEffects = new AudioPlayer[numberOfSoundEffects]; //song is now similar to song1
  for ( int i=0; i<soundEffectFileCount; i++ ) {
    soundEffects[i]= minim.loadFile( soundEffectFilePathway[i] );
  } //End Music Load
  //
  minim = new Minim(this); //load from data directory, loadFile should also load from project folder, like loadImage
  //
  generalFont = createFont ("Harrington", 55); //Must also Tools / Create Font / Find Font / Do Not Press "OK"
  playList[0].play();
} //End setup
//
void draw() {
  //NOte: Looping Function
  //Note: logical operators could be nested IFs
  if ( playList[0].isLooping() && playList[0].loopCount()!=-1 ) println("There are", playList[0].loopCount(), "loops left.");
  if ( playList[0].isLooping() && playList[0].loopCount()==-1 ) println("Looping Infinitely");
  if ( playList[0].isPlaying() && !playList[0].isLooping() ) println("Play Once");
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
  text(playListMetaData[0].title(), width*1/4, height*0, width*1/2, height*3/10);
  fill(255); //Reset to white for rest of the program
} //End draw
//
void keyPressed() {
  /* Broken KeyBinds
  if ( key=='P' || key=='p' ) song[0].play(); //Parameter is milli-seconds from start of audio file to start playing (illustrate with examples)
  //.play() includes .rewind()
  //
  if ( key>='1' || key<='9' ) { //Loop Button, previous (key=='1' || key=='9')
    //Note: "9" is assumed to be massive! "Simulate Infinite"
    String keystr = String.valueOf(key);
    //println(keystr);
    int loopNum = int(keystr); //Java, strongly formatted need casting
    song[0].loop(loopNum); //Parameter is number of repeats
    //
  }
  if ( key=='L' || key=='l' ) song[0].loop(); //Infinite Loop, no parameter OR -1
  //
  if ( key=='M' || key=='m' ) { //MUTE Button
    //MUTE Behaviour: stops electricty to speakers, does not stop file
    //NOTE: MUTE has NO built-in PUASE button, NO built-in rewind button
    //ERROR: if song near end of file, user will not know song is at the end
    //Known ERROR: once song plays, MUTE acts like it doesn't work
    if ( song[0].isMuted() ) {
      //ERROR: song might not be playing
      //CATCH: ask .isPlaying() or !.isPlaying()
      song[0].unmute();
    } else {
      //Possible ERROR: Might rewind the song
      song[0].mute();
    }
  } //End MUTE
  //
  //Possible ERROR: FF rewinds to parameter milliseconds from SONG Start
  //Possible ERROR: FR rewinds to parameter milliseconds from SONG Start
  //How does this get to be a true ff and fr button
  //Actual .skip() allows for varaible ff & fr using .position()+-
  if ( key=='F' || key=='f' ) song[0].skip( 0 ); //SKIP forward 1 second (1000 milliseconds)
  if ( key=='R' || key=='r' ) song[0].skip( 1000 ); //SKIP  backawrds 1 second, notice negative, (-1000 milliseconds)
  //
  //Simple STOP Behaviour: ask if .playing() & .pause() & .rewind(), or .rewind()
  if ( key=='S' | key=='s' ) {
    if ( song[0].isPlaying() ) {
      song[0].pause(); //auto .rewind()
    } else {
      song[0].rewind(); //Not Necessary
    }
  }
  //
  //Simple Pause Behaviour: .pause() & hold .position(), then PLAY
  if ( key=='Y' | key=='y' ) {
    if ( song[0].isPlaying()==true ) {
      song[0].pause(); //auto .rewind()
    } else {
      song[0].play(); //ERROR, doesn't play
    }
  }
  */
} //End keyPressed
//
void mousePressed() {
} //End mousePressed
//
//End MAIN Program
