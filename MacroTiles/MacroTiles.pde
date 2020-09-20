import processing.sound.*;

import ch.bildspur.postfx.builder.*;
import ch.bildspur.postfx.pass.*;
import ch.bildspur.postfx.*;

import de.looksgood.ani.*;
import de.looksgood.ani.easing.*;

PostFX fx;

boolean mouse_has_been_released;

ArrayList<macroman> mMen;
boolean global_mMan_ready;
tileholder map;
GUI gui;

float speed;

ArrayList<String> def_commands;

void setup()
{
  size(1920, 1080, P2D);
  frameRate(60);
  rectMode(CENTER);
  textAlign(CENTER, CENTER);
  textSize(30);
  global_mMan_ready = true;
  mouse_has_been_released = true;

  //Defining the default (basic) commands
  def_commands = new ArrayList<String>();
  def_commands.add( "U" );
  def_commands.add( "D" );
  def_commands.add( "L" );
  def_commands.add( "R" );

  def_commands.add( "FT" );
  def_commands.add( "RT" );
  def_commands.add( "GT" );
  def_commands.add( "BT" );

  def_commands.add( "RESET" );

  def_commands.add( "J" );
  def_commands.add( "rJ" );
  //

  speed = 2;
  map = new tileholder(10, 10);
  gui = new GUI();

  Ani.init(this);
  mMen = new ArrayList<macroman>();
  for (int i = 0; i < 5; i ++)
  {
    mMen.add( new macroman( new PVector(map.get_tileSize()*floor(random(map.dim()[0])), map.get_tileSize()*floor(random(map.dim()[1]))) ) );
  }


  ArrayList<String> options = new ArrayList<String>();
  options.add("U");
  options.add("D");
  options.add("L");
  options.add("R");//

  options.add("FT");
  options.add("RT");
  options.add("GT");
  options.add("BT");

  //options.add("RESET");

  //options.add("J");
  //options.add("rJ");

  for (int j = 0; j < mMen.size(); j++) {
    for (int i = 0; i < 5; i++)  // Generate random path of x moves
    { 
      mMen.get(j).append_commands( options.get( floor(random(options.size())) ) );  //Default Macro
    }
  }

  fx = new PostFX(this);
}
void draw()
{
  background(20, 20, 50);
  pushMatrix();
  translate(width/2 - map.get_x_shift(), height/2 - map.get_y_shift());
  translate(map.get_tileSize()/2-map.get_tileSize()*map.dim()[0]/2 + map.get_cameraX(), map.get_tileSize()/2-map.get_tileSize()*map.dim()[1]/2 + map.get_cameraY());

  map.update();

  global_mMan_ready = true;
  for (macroman c_macroman : mMen)
  {
    global_mMan_ready = global_mMan_ready && c_macroman.get_exe_ready() && c_macroman.get_ani_ready() && map.tile_ani_ready(c_macroman.get_ind_x(), c_macroman.get_ind_y());
  }
  for (macroman c_macroman : mMen)
  {
    if (speed > 0)  //So that the animations don't take infinite time
    {
      c_macroman.exe();
    }
    c_macroman.drawme();
  }   
  gui.get_input();
  speed = gui.get_slider("Speed Slider").value* 100;
  gui.drawme();

  popMatrix();
  //FPS Counter
  text("FPS: " + round(frameRate), 100, 20);

    //Enable Bloom
  //fx.render()
    //.bloom(0.9, 20, 5)
    //.bloom(0.3, 5, 5)
    //.sobel()
    //.compose();
}


void mousePressed()
{
  for (macroman c_mMan : mMen)
  {
    c_mMan.set_exe_ready(false);
  }
  if (mouse_has_been_released)
  {
    //Boolean for macromen
    boolean overlap1 = false;
    for (macroman c_mMan : mMen)
    {
      if (c_mMan.check_clicked())
      {
        gui.set_mode(c_mMan);
        overlap1 = true;
        break;
      }
    }

    //Boolean for gui
    boolean overlap2;
    overlap2 = gui.check_overlap();

    if (!(overlap1 || overlap2) && !gui.get_mode().equals("macroman_if_selection"))  //When clicking off of things, go to default
    {
      gui.set_mode();  //Default mode
      for (macroman c_mMan : mMen)
      {
        c_mMan.set_is_selected(false);
      }
    }
  }
  mouse_has_been_released = false;
}

boolean is_def_command(String tar_command)
{
  for (String c_command : def_commands)
  {
    if (c_command.equals(tar_command))
    {
      return true;
    }
  }
  return false;
}

void mouseReleased()
{
  mouse_has_been_released = true;
  gui.reset_buttons();
}
