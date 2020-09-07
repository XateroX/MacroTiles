import de.looksgood.ani.*;
import de.looksgood.ani.easing.*;

boolean mouse_has_been_released;

ArrayList<macroman> mMen;
boolean global_mMan_ready;
tileholder map;
gui gui;

float speed;

void setup()
{
  fullScreen();
  frameRate(60);
  rectMode(CENTER);
  textAlign(CENTER,CENTER);
  textSize(30);
  global_mMan_ready = true;
  mouse_has_been_released = true;
  
  speed = 2;

  map = new tileholder(10,10);
  gui = new gui();
  
  Ani.init(this);
  mMen = new ArrayList<macroman>();
  for (int i = 0; i < 3; i ++)
  {
    mMen.add( new macroman( new PVector(map.get_tileSize()*floor(random(map.dim()[0])),map.get_tileSize()*floor(random(map.dim()[1]))) ) );
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
  
  options.add("RESET");
  
  options.add("J");
  //options.add("rJ");
  
  for (int j = 0; j < mMen.size(); j++){
    for (int i = 0; i < 20; i++)  // Generate random path of x moves
    { 
      mMen.get(j).set_c_commands( options.get( floor(random(options.size())) ) );  //Default Macro
    }
  }
}
void draw()
{
  background(200,200,255);
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
    {c_macroman.exe();}
    c_macroman.drawme();
  }   
  //map.set_cameraX((width/4) * sin((float)frameCount/60));
  //map.set_cameraY(0);
  gui.get_input();
  speed = gui.get_slider("Speed Slider").value* 100;
  gui.drawme();

  popMatrix();
    //FPS Counter
  text("FPS: " + round(frameRate), 100,20);
}


void mousePressed()
{
  for (macroman c_mMan : mMen)
  {
    c_mMan.set_exe_ready(false);
  }
  if (mouse_has_been_released)
  {
    boolean overlap = false;
    for (macroman c_mMan : mMen)
    {
      if (c_mMan.check_clicked())
      {
        gui.set_mode(c_mMan);
        overlap = true;
        break;
      }
    }
    if (!overlap)
    {
      gui.set_mode();  //Default mode
      for (macroman c_mMan : mMen)
      {c_mMan.set_is_selected(false);}
    }
  }
  mouse_has_been_released = false;
}

void mouseReleased()
{
  mouse_has_been_released = true;
}
