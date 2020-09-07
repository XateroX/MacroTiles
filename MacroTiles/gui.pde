class gui
{
  String mode;
  macroman tar_macroman;
  
    //Macroman GUI variables
  boolean c_box_ani_ready;
  color c_box_col;
  int c_box_r;
  int c_box_g;
  int c_box_b;
  int c_box_alpha;
  int tar_c_box_alpha;
    //
  
  ArrayList<slider> held_sliders;
  ArrayList<slider> sliders;
  
  ArrayList<button> buttons;
  
  void init()
  {
      //Macroman GUI variables
    c_box_ani_ready = true;
    c_box_r         = 100;
    c_box_g         = 100;
    c_box_b         = 200;
    c_box_alpha     = 0;
    tar_c_box_alpha = 0;
    c_box_col = color(c_box_r, c_box_g, c_box_b);
      //
    
      //Setup the speed slider
    slider speed_slider = get_slider("Speed Slider");
    speed_slider.set_pos_1( new PVector(0,-map.get_tileSize()) );
    speed_slider.set_pos_2( new PVector(map.get_tileSize()*(map.dim()[0]-1),-map.get_tileSize()) );
    mode = "-1";
    tar_macroman = new macroman( new PVector(-1,-1) );  //Blank placeholder macroman
      //
      
      //Setup test button
    button test_button = get_button("Test Button"); 
    test_button.set_pos( map.dim()[0]*map.get_tileSize() + map.get_tileSize()*2, map.get_tileSize()*2 );
      //
  }
  
  gui()
  {
    held_sliders = new ArrayList<slider>();
    sliders      = new ArrayList<slider>();
    sliders.add( new slider("Speed Slider") );  //Slider for the top of the map (speed of the game)
    
    buttons      = new ArrayList<button>();
    buttons.add( new button("Test Button") );
    
    init();
  }
  
  void drawme()
  {
      //Draw all sliders
    for (slider c_slider : sliders)
    {c_slider.drawme();}
    for (slider c_slider : held_sliders)
    {c_slider.set_value_from_vector( map.transform( new PVector(mouseX, mouseY) ) );}  //Find the most appropriate value to give in this situation
      //
      
      //Draw and check all buttons
    for (button c_button : buttons)
    {
      if (mousePressed)
      {c_button.check_if_pressed();}
      c_button.drawme();
    }
      //
    
    
    if ( get_mode().equals("macroman") )
    {draw_macroman_gui(tar_macroman);}
    
    
  }
  
  void get_input()
  {
    manage_slider_collison();
  }
  
  slider get_slider(String c_name)
  {
    int c_ind = -1;
    for (int i = 0; i < sliders.size(); i++)
    {
      if (sliders.get(i).get_name().equals(c_name))
      {
        c_ind = i;
        break;
      }
    }
    return sliders.get(c_ind);  //May try to get -1, as seen above this means there was no slider with this name
  }
  
  button get_button(String name)
  {
    int c_ind = 0;
    for (int i = 0; i < buttons.size(); i++)
    {
      if (buttons.get(i).get_name().equals(name))
      {
        c_ind = i;
        break;
      }
    }
    return buttons.get(c_ind);
  }
  
  void manage_slider_collison()
  {
    PVector mouse = new PVector(mouseX,mouseY);
    PVector rel_mouse = new PVector(0,0);
    
    rel_mouse = map.transform(mouse);
    for (int i = 0; i < sliders.size(); i++)
    {
      slider c_slider = sliders.get(i);
      boolean overlap = c_slider.check_clicked(rel_mouse);
      boolean in_held = false;
      if (overlap)
      {
        for (slider c_slider2 : held_sliders)
        {
          if (c_slider2.get_name().equals(c_slider.get_name()))
          {
            in_held = true;
            break;
          }
        }
      }
      if (overlap && mousePressed && !in_held)
      {
        held_sliders.add( sliders.get(i) );
      }else if (!mousePressed)
      {
        for (int j = 0; j < held_sliders.size(); j++)
        {
          if (held_sliders.get(j).get_name().equals(sliders.get(i).get_name()))
          {
            held_sliders.remove(j);
            break;
          }
        }
      }
    }
  }
  
  
  void set_mode(macroman c_mMan)  //macroman mode
  {
    map.macroman_ani();
    set_mode("macroman");
    set_tar_macroman(c_mMan);
    set_tar_c_box_alpha(255);
    Ani.to(this, 10, "c_box_alpha", get_tar_c_box_alpha());
    c_box_ani_ready = false;
  }
  void set_mode()
  {
    map.default_ani();
    set_mode("-1");
    set_tar_c_box_alpha(0);
    Ani.to(this, 4, "c_box_alpha", get_tar_c_box_alpha());
    c_box_ani_ready = false;
  }
  
  
  void draw_macroman_gui(macroman c_mMan)
  {
    c_mMan.set_is_selected(true);
    
    if (get_c_box_alpha() == get_tar_c_box_alpha() && !c_box_ani_ready)
    {c_box_ani_ready = true;}
    
    pushMatrix();
    pushStyle();
    
      //Initially, move the origin to a better place
    translate( -map.get_tileSize()/2 + map.get_tileSize()*map.dim()[0] , -map.get_tileSize()/2 );
    translate( (5*width/4 - 3*map.dim()[0]*map.get_tileSize()/2) / 2, 0 );


    fill(red(c_box_col), green(c_box_col), blue(c_box_col), c_box_alpha);
    stroke(50, 100);
    strokeWeight(map.get_tileSize()*0.1);
    
    translate(0 , map.get_tileSize()/2);
    rect(0,0 ,(5*width/4 - 3*map.dim()[0]*map.get_tileSize()/2) * 0.75, map.get_tileSize());
    fill(220);
    
      //Display the commands of the macroman in the box
    display_commands_in_c_box(c_mMan);
    
    popStyle();
    popMatrix();
  }
  
  void display_commands_in_c_box(macroman c_mMan)
  {
    String command_string = "";
    ArrayList<String> c_command_list = c_mMan.get_commands();
    for (int i = 0; i < 10; i++)
    {
      if (c_command_list.size() > i)
      {
        String c_command = c_command_list.get(i);
        command_string = command_string + c_command + " ";
      }
    }
    if (c_command_list.size() > 10)
    {
      command_string = command_string + "...";
    }
    textSize((5*width/4 - 3*map.dim()[0]*map.get_tileSize()/2) * 0.75 / 20);
    text(command_string,0,-map.get_tileSize()/10);
    
    textSize(map.get_tileSize()/3);
    fill(75);
    text("Commands", -(5*width/4 - 3*map.dim()[0]*map.get_tileSize()/2) * 0.75 / 2.4,-map.get_tileSize()*1);
  }
  
  
  
  
  
    //### Get/Set methods ###//
  macroman get_tar_macroman()
  {
    return tar_macroman;
  }
  void set_tar_macroman(macroman c_mMan)
  {
    tar_macroman = c_mMan;
  }
  
  String get_mode()
  {
    return mode;
  }
    //Multiple set methods to overload for all the types it can be set to
  void set_mode(String mode_name)
  {
    mode = mode_name;
  }
  
  color get_c_box_col()
  {
    return color(c_box_r, c_box_g, c_box_b);
  }
  void set_c_box_col(int r, int g, int b)
  {
    c_box_r = r;
    c_box_r = g;
    c_box_r = b;
  }
  
  int get_c_box_alpha()
  {
   return c_box_alpha;
  }
  void set_c_box_alpha(int t)
  {
    c_box_alpha = t;
  }
  
  int get_tar_c_box_alpha()
  {
    return tar_c_box_alpha;
  }
  void set_tar_c_box_alpha(int t)
  {
    tar_c_box_alpha = t;
  }
}
