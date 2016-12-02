import ketai.camera.*;
import ketai.cv.facedetector.*;
import ketai.data.*;
import ketai.net.*;
import ketai.net.bluetooth.*;
import ketai.net.nfc.*;
import ketai.net.nfc.record.*;
import ketai.net.wifidirect.*;
import ketai.sensors.*;
import ketai.ui.*;

KetaiSensor sensor;

float ax, ay, az, calibrator;

float multiplier=0.75;
int screenState, timer, attackPattern, score, levelNumber=1, waveNumber;
boolean died, nightMode, mouseReleased;
//PImage background;

//Declaring the player
Player player = new Player();
//Declaring all of the arraylists for all of the projectiles
ArrayList<ProjectileNormal> normalProjectiles = new ArrayList<ProjectileNormal>();
ArrayList<ProjectileHoming> homingProjectiles = new ArrayList<ProjectileHoming>();
ArrayList<ProjectileHomingAccurate> accurateHomingProjectiles = new ArrayList<ProjectileHomingAccurate>();
ArrayList<ProjectileShooter> projectileShooters = new ArrayList<ProjectileShooter>();


void setup()
{
  fullScreen(P3D);
  noStroke();
  sensor = new KetaiSensor(this);
  sensor.start();
  //Setting up the minim
  orientation(LANDSCAPE);
  screenState = 0;
  imageMode(CENTER);
  //fullScreen();
  textAlign(CENTER);
  //background=loadImage("background.png");
  //background.resize(width, height);
  //noCursor();
}
void draw()
{
  //Basic screenState switch
  switch(screenState)
  {
  case 0:
    startScreen();
    break;
  case 1:
    gameCode();
    if (died)
    {
      //Stopping the music if you die
      screenState=2;
      //Re opening it but not playing
    }
    break;
  case 2:
    died();
    break;
  case 3:
    player.tutorial();
    break;
  }
  fill(0, 0, 255);
  //ellipse(mouseX, mouseY, 10, 10);
  fill(255);
}
void startScreen()
{
  //Initial Screen
  background(0);
  //image(background, width/2, height/2);
  textSize(150);
  //Night Mode button
  text("Calibrator", width/2, height/4);
  if (mouseX>(width*0.390625)&&mouseX<(width*0.609375)&&mouseY>(height*0.15625)&&mouseY<(height*0.28125))
  {
    //nightMode=true;
    //screenState=1;
    calibrator=ax;
  }
  textSize(400);
  //Normal mode button
  text("Start", width/2, height/2);
  //image(start, width/2, height/2);
  //rect(width*0.3125, height*0.375, width*0.6875, height*0.5625);
  fill(255);
  if (mouseX>(width*0.3125)&&mouseX<(width*0.6875)&&mouseY>(height*0.375)&&mouseY<(height*0.5625))
  {
    nightMode=false;
    screenState=1;
  }
  textSize(150);
  //Tutorial button
  text("Tutorial", width/2, (height/2)+200);
  if (mouseX>(width*0.390625)&&mouseX<(width*0.609375)&&mouseY>(height*0.5625)&&mouseY<(height*0.75))
  {
    screenState=3;
  }
}
void gameCode()
{
  //Different backgrounds based on nightMode being true/false
  if (nightMode==false)
  {
    fill(255);
    rect(0, 0, width, height);
  }
  if (nightMode==true)
  {
    background(0);
    ellipse(player.x, player.y, 600, 600);
  }
  //Runs randomiser every 5 seconds
  if (millis()>timer)
  {
    if (waveNumber==2)
    {
      waveNumber=0;
      levelNumber++;
      killAll();
      multiplier+=0.125;
    }
    //Random attack pattern
    if (levelNumber>5)
    {
      killAll();
      attackPattern=int(random(1, 7));
      switch((int)random(4))
      {
      case 0:
        projectileShooters.add(new ProjectileShooter(0, 0, 10, (int)random(10)));
        break;
      case 1:
        projectileShooters.add(new ProjectileShooter(0, height, 10, (int)random(10)));
        break;
      case 2:
        projectileShooters.add(new ProjectileShooter(width, 0, 10, (int)random(10)));
        break;
      case 3:
        projectileShooters.add(new ProjectileShooter(width, height, 10, (int)random(10)));
        break;
      }
    } else
    {
      attackPattern=int(random(levelNumber, levelNumber+2));
      killAll();
    }
    timer=millis()+5000;
    waveNumber++;
    //Running the code to initialise the attacks
    switch(attackPattern)
    {
    case 1: 
      Attack1();
      break;
    case 2:
      Attack2();
      break;
    case 3:
      Attack3();
      break;
    case 4:
      Attack4();
      break;
    case 5:
      Attack5();
      break;
    case 6:
      Attack6();
      break;
    }
  }
  //Updating everything else
  attackUpdate();
  player.movementCode();
  //Updates the score and multiplier
  score++;
  //multiplier+=0.00025; //Rate of 0.25 per 1000 points, just a smaller scale for more accurate updating
  textSize(60);
  //Different colored text (white for night mode and black for normal mode) for the score
  if (nightMode)
  {
    fill(255);
    text(score, 30, 30);
    if (levelNumber>5)
    {
      text("5+", width/2, 30);
    } else
    {
      text(levelNumber, width/2, 30);
    }
    text(millis()-timer, width-20, 20);
  } else
  {
    fill(0);
    text(timer-millis(), width-60, 50);
    if (levelNumber>5)
    {
      text("5+", width/2, 50);
    } else
    {
      text(levelNumber, width/2, 50);
    }    
    text(score, 50, 50);
  }
}
void attackUpdate()
{
  //Runs through all of the code for updating the projectiles; collision, movement, and if it collides kill the player
  for (int i=0; i<normalProjectiles.size(); i++)
  {
    ProjectileNormal part = normalProjectiles.get(i);
    part.move();
    part.collision();
    if (part.collide)
    {
      died=true;
    }
  }
  for (int i=0; i<accurateHomingProjectiles.size(); i++)
  {
    ProjectileHomingAccurate part = accurateHomingProjectiles.get(i);
    part.move();
    part.collision();
    if (part.collide)
    {
      died=true;
    }
  }
  for (int i=0; i<homingProjectiles.size(); i++)
  {
    ProjectileHoming part = homingProjectiles.get(i);
    part.move();
    part.collision();
    if (part.collide)
    {
      died=true;
      mouseReleased=false;
    }
  }
  for (int i=0; i<projectileShooters.size(); i++)
  {
    ProjectileShooter part = projectileShooters.get(i);
    part.update();
  }
}
void killAll()
{
  //Clear all projectiles before every wave
  normalProjectiles.clear();
  homingProjectiles.clear();
  accurateHomingProjectiles.clear();
  projectileShooters.clear();
}
void died()
{
  //The respawn screenState
  background(0);
  killAll();
  textSize(100);
  text("You died!", width/2, height/3);
  textSize(60);
  text("Click to play again!", width/2, 2*(height/3));
  text(score, width/2, height/2);
  text("Back", 70, 60);
  if (mousePressed==false)
  {
    mouseReleased=true;
  }
  if (mousePressed&&mouseX<200&&mouseY<100)
  {
    screenState=0;
    reset();
  } else if (mousePressed&&mouseReleased)
  {
    reset();
    screenState=1;
  }
}
void reset()
{
  //Sets values back to normal
  multiplier=0.75;
  player.x=width/2;
  player.y=2*(height/3);
  score=0;
  died=false;
  timer=0;
  mouseReleased=false;
  levelNumber=1;
  waveNumber=0;
}
void onAccelerometerEvent(float x, float y, float z)
{
  ax = x;
  ay = y;
  az = z;
}