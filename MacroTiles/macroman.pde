class macroman
{
  boolean is_selected;
  
  ArrayList<String> commands;
  ArrayList<String> temp_commands;
  boolean ani_ready;
  boolean exe_ready;
  int exe_timer;
  int exe_timer_max;
  
  float i_px;
  float i_py;
  float px;
  float py;
  float tarx;
  float tary;
  
  int ind_x;
  int ind_y;

  macroman(PVector m_p)
  {
    is_selected = false;
    
    commands      = new ArrayList<String>();
    temp_commands = new ArrayList<String>();
    ani_ready     = true;
    exe_ready     = true;
    exe_timer_max = 60;
    exe_timer     = exe_timer_max;  //Frames to stand still
    
    i_px = m_p.x;
    i_py = m_p.y;
    px   = m_p.x;
    py   = m_p.y;
    
    ind_x = get_ind_x();
    ind_y = get_ind_y();
  }
  
  
  void reset_temp_commands()
  {
    temp_commands = new ArrayList<String>();
    for (String c_command : commands)
    {
      temp_commands.add(c_command);
    }
  }
  
  void reset_man()
  {
    tarx = i_px;
    tary = i_py;
    Ani.to(this, 0.1, "px", tarx);
    Ani.to(this, 0.1, "py", tary);
     //<>//
    ani_ready = false;
    exe_ready = false;
  }
  
  
  void exe()
  {
    if (!exe_ready && exe_timer > 0) exe_timer--;  //Decrement timer
    else exe_ready = true;
    
    if (temp_commands.size() <= 0 && ani_ready && exe_ready)
    {
      reset_temp_commands();
      reset_man();
      reset_exe_timer();
      //println("        ---RESET---");
    }
    else
    {
      if (exe_ready && ani_ready && map.tile_ani_ready(ind_x, ind_y) && global_mMan_ready && mouse_has_been_released)
      {
        reset_exe_timer();
        String c_command = (String)temp_commands.get(0);
        if      (c_command.equals("U"))  U();
        else if (c_command.equals("D"))  D();
        else if (c_command.equals("L"))  L();
        else if (c_command.equals("R"))  R();
        else if (c_command.equals("FT")) FT();
        else if (c_command.equals("RT")) RT();
        else if (c_command.equals("GT")) GT();
        else if (c_command.equals("BT")) BT();
        else if (c_command.equals("RESET")) RESET();
        else if (c_command.equals("J"))  J();
        else if (c_command.equals("rJ")) rJ();
        else if (c_command.substring(0,2).equals("IF")) {evaluate_IF(c_command);};
        temp_commands.remove(0);
      }else{
        if (px == tarx && py == tary)
        {
          ani_ready = true;
        }
      }
    }
  }
  
  
  void evaluate_IF(String c_command)
  {
  }
  
  void step(float size, int dx, int dy)
  {
    tarx = px + dx*size;
    tary = py + dy*size;
    
    if ((tarx <= (size-1)*map.dim()[0] && tarx >= 0)
        && 
        (tary <= (size-1)*map.dim()[1] && tary >= 0))
    { 
      Ani.to(this, 1/speed, "px", tarx);
      Ani.to(this, 1/speed, "py", tary);
      
      ani_ready = false;
    }else
    {
      tarx = px;
      tary = py;
    }
  }
  
  
  void jump(int n)
  {
    int c_ind = commands.size() - temp_commands.size();  //the command being read now (HAS TO BE J or rJ) *!* //<>//
    ArrayList<String> buffer_commands = new ArrayList<String>();
    for (String let : commands)
    {buffer_commands.add(let);}
    for (int i = commands.size()-1; i >= 0; i--)
    {
      if (n>0 && i < c_ind+n+1)
      {
        buffer_commands.remove(i);
      } 
      if (n<0 && i < c_ind+n)
      {
        buffer_commands.remove(i);
      } 
    }
    
    if (n<0 && abs(n) < c_ind+1)
    {buffer_commands.remove(abs(n));}
    else if (n<0 && abs(n) >= c_ind+1)
    {buffer_commands.remove(c_ind);}
    
    buffer_commands.add(0,"-1");  //To be removed by macroman.exe()
    
    temp_commands = new ArrayList<String>();
    for (String let : buffer_commands)
    {temp_commands.add(let);}
  }
  
  
  boolean check_clicked()
  {
    PVector trans_p     = new PVector(px    ,py);
    PVector trans_mouse = map.transform(new PVector(mouseX,mouseY));
    if (trans_p.dist(trans_mouse) < get_size())
    {return true;}
    return false;
  }
  
  
  void drawme()
  {
    pushMatrix();
    pushStyle();
    
    translate(px,py);
    fill(240);
    stroke(50);
    strokeWeight(map.get_tileSize()*0.6 / 5);
    rect(0,0 ,map.get_tileSize()*0.6,map.get_tileSize()*0.6);
    
    if (is_selected) draw_selected_arrows();
    
    
    String commandList = "";
    
    if (speed < 5)
    {
      translate(0,-map.get_tileSize()*0.75);
      for (int i = 0; i < 6; i++)
      {
        if (temp_commands.size() >= i+1){
          commandList = commandList + temp_commands.get(i) + " ";
        }
      }
      if (temp_commands.size() > 6) commandList = commandList + "...";
      
      //if (temp_commands.size()>=1){commandList = temp_commands.get(0);} 
      textSize(map.get_tileSize()*0.5);
      fill(0);

      text(commandList, 0,0);
    }
    popStyle();
    popMatrix();
  }
  
  void draw_selected_arrows()
  {
    pushMatrix();
    pushStyle();
    
    stroke(255,0,0,230);
    strokeWeight(map.get_tileSize()/10);
    
    PVector dir = new PVector(0,-1);
    dir.rotate(2*PI * (float)frameCount/180);
    float SCL = 1.2 * (sin(2*PI * (float)frameCount/60)+2)/2;
    int n = 3;  //Number of arrows
   
    for (int i = 0; i < n; i++)
    {
      PVector ep = new PVector(dir.x*map.get_tileSize()*0.5 * SCL,dir.y*map.get_tileSize()*0.5 * SCL);
      line(dir.x*map.get_tileSize()*0.5 * SCL,dir.y*map.get_tileSize()*0.5 * SCL, dir.x*map.get_tileSize() * SCL,dir.y*map.get_tileSize() * SCL);
      dir.rotate(PI/10);
      line(dir.x*map.get_tileSize()*0.7 * SCL,dir.y*map.get_tileSize()*0.7 * SCL, ep.x,ep.y);
      dir.rotate(-PI/5);
      line(dir.x*map.get_tileSize()*0.7 * SCL,dir.y*map.get_tileSize()*0.7 * SCL, ep.x,ep.y);
      dir.rotate(PI/10);
      dir.rotate(2*PI / n);
    }
    
    popMatrix();
    popStyle();
  }
  
  
    //### Commands ###//
    
    //Movement Functions
  void U()
  {step(map.get_tileSize(), 0,-1);}
  void D()
  {step(map.get_tileSize(), 0, 1);}
  void L()
  {step(map.get_tileSize(),-1, 0);}
  void R()
  {step(map.get_tileSize(), 1, 0);}
  
    //Tile Functions
  void FT()  //FT - Flip Tile
  {map.flip_tile(get_ind_x(), get_ind_y());}
  void RT()  //RT - Recolor Red Tile
  {map.recolor_tile(get_ind_x(), get_ind_y(), color(255,0,0));}
  void GT()  //GT - Recolor Green Tile
  {map.recolor_tile(get_ind_x(), get_ind_y(), color(0,255,0));}
  void BT()  //BT - Recolor Blue Tile
  {map.recolor_tile(get_ind_x(), get_ind_y(), color(0,0,255));}
  
    //META Functions
  void J()
  {jump( 2);}
  void rJ()
  {jump(-2);}
  
    //Reset Functions
  void RESET()
  {map.reset_tiles(get_ind_x(), get_ind_y());} //<>//
  
  void reset_exe_timer()
  {
    exe_ready = false;
    exe_timer = ceil(frameRate * 1/speed);
  }
  
  
  
    //### Get/Set variables ###//
  void append_commands(String n_string)
  {
    commands.add(n_string);
  }
  void pop_commands()
  {
    commands.remove( commands.size()-1 );
    reset_man();
  }
  void set_commands(String commandString)
  {
    commands      = new ArrayList<String>();
    temp_commands = new ArrayList<String>();
    String[] listCommandString = split(commandString, ";");
    for (int i = 0; i < listCommandString.length; i++)
    {  
      String let = listCommandString[i];
      commands     .add(let);
      temp_commands.add(let);
    }
  }
  void set_commands(ArrayList<String> commandString)
  {
    commands      = new ArrayList<String>();
    temp_commands = new ArrayList<String>();
    for (int i = 0; i < commandString.size(); i++)
    {  
      String let = commandString.get(i);
      commands     .add(let);
      temp_commands.add(let);
    }
  }
  ArrayList<String> get_commands()
  {
    return commands;
  }
  
  int get_ind_x()
  {
    int t_ind_x = ceil( (px - map.get_tileSize()/2) / map.get_tileSize() );
    return t_ind_x;
  }
  int get_ind_y()
  {
    int t_ind_y = ceil( (py - map.get_tileSize()/2) / map.get_tileSize() );
    return t_ind_y;
  }
  
  float get_size()
  {
    return map.get_tileSize()*0.6;
  }
  
  boolean get_is_selected()
  {
    return is_selected;
  }
  void set_is_selected(boolean v)
  {
    is_selected = v;
    if (v)
    {
      for (macroman c_mMan : mMen)
        {if (c_mMan != this) c_mMan.set_is_selected(false);};
    }
  }
  
  boolean get_exe_ready()
  {
    return exe_ready;
  }
  void set_exe_ready(boolean v)
  {
    exe_ready = v;
  }
  
  boolean get_ani_ready()
  {
    return ani_ready;
  }
  void set_ani_ready(boolean v)
  {
    ani_ready = v;
  }
}
