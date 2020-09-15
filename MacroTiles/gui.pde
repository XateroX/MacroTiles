class GUI
{
  String mode;
  macroman tar_macroman;
  
    //If command variables
  boolean if_selection_ani_ready;
  boolean next_input_is_if;
  float if_sel_val;  //The 0-1 progression value of the animation of the selection area
  float tar_if_sel_val;
  button if_sel_button;
    //
  
    //Macroman GUI variables
  boolean c_box_ani_ready;
  color c_box_col;
  int c_box_r;
  int c_box_g;
  int c_box_b;
  int c_box_alpha;
  int tar_c_box_alpha;
  float c_box_scroll;
  float tar_c_box_scroll;
    //
  
    //Drawable objects
  ArrayList<slider> held_sliders;
  ArrayList<slider> sliders;
  ArrayList<button> buttons;
  ArrayList<text> text_list;
    //
  
  void init()
  {
      //If command variables
    if_selection_ani_ready = true;
    next_input_is_if       = false;
    if_sel_val             = 0;  //The 0-1 progression value of the animation of the selection area
    tar_if_sel_val         = 0;
    if_sel_button          = null;
      //
    
      //Macroman GUI variables
    c_box_ani_ready  = true;
    c_box_r          = 100;
    c_box_g          = 100;
    c_box_b          = 200;
    c_box_alpha      = 0;
    tar_c_box_alpha  = 0;
    c_box_scroll     = 1000;
    tar_c_box_scroll = 0;
    c_box_col = color(c_box_r, c_box_g, c_box_b);
      //
    
      //Setup the speed slider
    slider speed_slider = get_slider("Speed Slider");
    speed_slider.set_pos_1( new PVector(0,-map.get_tileSize()) );
    speed_slider.set_pos_2( new PVector(map.get_tileSize()*(map.dim()[0]-1),-map.get_tileSize()) );
    mode = "-1";
    tar_macroman = new macroman( new PVector(-1,-1) );  //Blank placeholder macroman
      //
      
      //Setup buttons
    button U = get_button("U Button"); 
    button D = get_button("D Button"); 
    button L = get_button("L Button"); 
    button R = get_button("R Button"); 
    U.set_pos( map.dim()[0]*map.get_tileSize() + map.get_tileSize()*2.0, map.get_tileSize()*1.5 );
    D.set_pos( map.dim()[0]*map.get_tileSize() + map.get_tileSize()*2.0, map.get_tileSize()*4.5 );
    L.set_pos( map.dim()[0]*map.get_tileSize() + map.get_tileSize()*0.5, map.get_tileSize()*3 );
    R.set_pos( map.dim()[0]*map.get_tileSize() + map.get_tileSize()*3.5, map.get_tileSize()*3 );
    
    button FT = get_button("FT Button"); 
    button RT = get_button("RT Button"); 
    button GT = get_button("GT Button"); 
    button BT = get_button("BT Button"); 
    FT.set_pos( map.dim()[0]*map.get_tileSize() + map.get_tileSize()*7.50, map.get_tileSize()*2 );
    RT.set_pos( map.dim()[0]*map.get_tileSize() + map.get_tileSize()*5.75, map.get_tileSize()*4 );
    GT.set_pos( map.dim()[0]*map.get_tileSize() + map.get_tileSize()*7.50, map.get_tileSize()*4 );
    BT.set_pos( map.dim()[0]*map.get_tileSize() + map.get_tileSize()*9.25, map.get_tileSize()*4 );
    
    button DLT = get_button("DLT Button");
    DLT.set_pos( map.dim()[0]*map.get_tileSize() + map.get_tileSize()*0.3, map.get_tileSize()*0.0 );
    
    button IFPos = get_button("IF Position Button"); 
    button IFCond= get_button("IF Condition Button"); 
    button IFAct = get_button("IF Action Button"); 
    button IFSub = get_button("IF Submit Button"); 
    IFPos .set_pos( map.dim()[0]*map.get_tileSize() + map.get_tileSize()*2.0, map.get_tileSize()*8 );
    IFCond.set_pos( map.dim()[0]*map.get_tileSize() + map.get_tileSize()*3.5, map.get_tileSize()*8 );
    IFAct .set_pos( map.dim()[0]*map.get_tileSize() + map.get_tileSize()*6.5, map.get_tileSize()*8 );
    IFSub .set_pos( map.dim()[0]*map.get_tileSize() + map.get_tileSize()*9.5, map.get_tileSize()*8 );
      //
      
      //Setup text objects
    text IF   = get_text("IF");
    text THEN = get_text("THEN");
    //text MODE = get_text("MODE");
    IF  .set_pos( map.dim()[0]*map.get_tileSize() + map.get_tileSize()*1.0, map.get_tileSize()*8.0 );
    THEN.set_pos( map.dim()[0]*map.get_tileSize() + map.get_tileSize()*5.0, map.get_tileSize()*8.0 );
    //MODE.set_pos( map.dim()[0]*map.get_tileSize() + map.get_tileSize()*1.0, map.get_tileSize()*1.0 );
      //
  }
  
  GUI()
  {
    held_sliders = new ArrayList<slider>();
    sliders      = new ArrayList<slider>();
    sliders.add( new slider("Speed Slider") );  //Slider for the top of the map (speed of the game)
    
    buttons      = new ArrayList<button>();
    buttons.add( new button("U Button", "U") );
    buttons.add( new button("D Button", "D") );
    buttons.add( new button("L Button", "L") );
    buttons.add( new button("R Button", "R") );
    
    buttons.add( new button("FT Button", "FT") );
    buttons.add( new button("RT Button", "RT") );
    buttons.add( new button("GT Button", "GT") );
    buttons.add( new button("BT Button", "BT") );
    
    buttons.add( new button("DLT Button", "DLT") );
    
    buttons.add( new button("IF Position Button", "IFPos") );
    buttons.add( new button("IF Condition Button", "IFCon") );
    buttons.add( new button("IF Action Button", "IFAct") );
    buttons.add( new button("IF Submit Button", "IFSub") );
    
    text_list = new ArrayList<text>();
    text_list.add( new text("IF") );
    text_list.add( new text("THEN") );
    //text_list.add( new text("MODE") );
    
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
    for (button c_button : buttons)  // THIS SHOULD BE IN THE GET_INPUT() METHOD #(!!!)# //
    {
      if (mousePressed)
      {c_button.check_if_pressed();}
      c_button.drawme();
    }
    
      //Draw all text objects
    for (text c_text : text_list)
    {
      if (c_text.get_content().equals("MODE"))
      {
        c_text.drawme(get_mode());
      }else
      {
        c_text.drawme();
      }
    }
      //
    
    if ( get_mode().equals("macroman") || get_mode().equals("macroman_if_selection") )
    {draw_macroman_gui(tar_macroman);}
    if (if_sel_button != null && if_sel_val != 0)
    {draw_if_selection_box();}
    
    check_ani_states();
  }
  
  void get_input()
  {
    manage_slider_collison();
    selection_mode_input_check();
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
  
  
  
  void evaluate(String i_type)  //Buttons use this to do things
  {
    if (next_input_is_if && is_def_command(i_type))
    {
      get_button("IF Action Button").set_action(i_type);
      selection_mode_ani_false();
    }
    else
    {
      if      (i_type.equals("U"))
      {/*Add U to the macroman's commands*/}
      else if (i_type.equals("D"))
      {/*Add D to the macroman's commands*/}
      else if (i_type.equals("L"))
      {/*Add L to the macroman's commands*/}
      else if (i_type.equals("R"))
      {/*Add R to the macroman's commands*/}
      
      else if (i_type.equals("FT"))
      {/*Add FT to the macroman's commands*/}
      else if (i_type.equals("RT"))
      {/*Add RT to the macroman's commands*/}
      else if (i_type.equals("GT"))
      {/*Add GT to the macroman's commands*/}
      else if (i_type.equals("BT"))
      {/*Add BT to the macroman's commands*/}
      
      else if (i_type.equals("J"))
      {/*Add J to the macroman's commands*/}
      else if (i_type.equals("rJ"))
      {/*Add rJ to the macroman's commands*/}
      
      else if (i_type.equals("RESET"))
      {/*Add RESET to the macroman's commands*/}
      
      if ( is_def_command(i_type) )
      {
        tar_macroman.append_commands(i_type);
        tar_macroman.reset_man();
      }
      else if (i_type.equals("DLT"))
      {tar_macroman.pop_commands();}
      else if (i_type.equals("IFPos"))
      {start_IFPos_selection();}     //Go into IFPos selection mode
      else if (i_type.equals("IFCon"))
      {start_IFCon_selection();}     //Go into IFCon selection mode
      else if (i_type.equals("IFAct"))
      {start_IFAct_selection();}     //Go into IFAct selection mode
      else if (i_type.equals("IFSub"))
      {submit_IF_command();}         //Submit the current IF command
    }
  }
  
  
  void start_IFPos_selection()
  {
    if (get_mode() == "macroman")
    {
      selection_mode_ani(get_button("IF Position Button"));
    }
    else if (get_mode() == "macroman_if_selection")
    {
      selection_mode_ani_false();
    }
  }
  void start_IFCon_selection()
  {
    if (get_mode() == "macroman")
    {
      selection_mode_ani(get_button("IF Condition Button"));
    }
    else if (get_mode() == "macroman_if_selection")
    {
      selection_mode_ani_false();
    }
  }
  void start_IFAct_selection()
  {
    if (get_mode() == "macroman")
    {
      selection_mode_ani(get_button("IF Action Button"));
    }
    else if (get_mode() == "macroman_if_selection")
    {
      selection_mode_ani_false();
    }
  }
  void submit_IF_command()
  {
    String IF_command = "IF[";
    IF_command = IF_command + str(get_button("IF Position Button").get_dir_sel()) + "+";
    if      (red(  get_button("IF Condition Button").get_col_cond()) == 255) {IF_command = IF_command + "R" + "]->";}
    else if (green(get_button("IF Condition Button").get_col_cond()) == 255) {IF_command = IF_command + "G" + "]->";}
    else if (blue( get_button("IF Condition Button").get_col_cond()) == 255) {IF_command = IF_command + "B" + "]->";}
    else {IF_command = IF_command + "D" + "]->";}
    IF_command = IF_command + get_button("IF Action Button").get_action();
    tar_macroman.append_commands(IF_command);
  }
  void selection_mode_ani(button tar_button)
  {
    if (get_mode() == "macroman" && if_selection_ani_ready)
    {
      set_mode("macroman_if_selection");
    }
    start_if_selection_ani();
    set_if_sel_button(tar_button);
  }
  void selection_mode_ani_false()
  {
    if (get_mode() == "macroman_if_selection" && if_selection_ani_ready)
    {
      reverse_if_selection_ani();
    }
  }
  
  void start_if_selection_ani()
  {
    if (if_selection_ani_ready)
    {
      if_selection_ani_ready = false;
      tar_if_sel_val = 1;
      Ani.to(this, 1, "if_sel_val", tar_if_sel_val);
    }
  }
  void reverse_if_selection_ani()
  {
    if (if_selection_ani_ready)
    {
      if_selection_ani_ready = false;
      tar_if_sel_val = 0;
      Ani.to(this, 1, "if_sel_val", tar_if_sel_val);
    }
  }
  
  
  boolean check_overlap()
  {
    boolean overlap = false;
    if (check_button_overlap()) overlap = true;
    if (check_slider_overlap()) overlap = true;
    return overlap;
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
  
  text get_text(String tar_content)
  {
    int tar_ind = -1;
    
    for (int i = 0; i < text_list.size(); i++)
    {
      if ( text_list.get(i).get_content().equals(tar_content) )
      {
        tar_ind = i;
        break;
      }
    }
    
    return text_list.get(tar_ind);
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
  
  void selection_mode_input_check()
  {
    if (get_mode().equals("macroman_if_selection"))
    {
      if (if_sel_button.get_type().equals("IFPos"))
      {collision_logic_pos();}
      if (if_sel_button.get_type().equals("IFCon"))
      {collision_logic_con();}
      if (if_sel_button.get_type().equals("IFAct"))
      {collision_logic_act();}
    }
  }
  void collision_logic_pos()
  {
    pushMatrix();
    pushStyle();
    
    PVector mouse     = new PVector(mouseX,mouseY);
    PVector rel_mouse = map.transform(mouse);
    PVector b_pos = get_button("IF Position Button").get_pos();
    
    float scl = map(pow(if_sel_val,2), 0, 1, 0, 1);  //This is the value that animates the area
    int collided_square = -1;  //Which of the squares is the cursor over at the moment
    
    float constant_x = b_pos.x + scl*map.get_tileSize()*0    - 2*map.get_tileSize();  //The last 2*tile*(4/3) is the size of the main square (can be abstracted)
    float constant_y = b_pos.y + scl*map.get_tileSize()*(-3) - 2*map.get_tileSize();
    
    float rel_x = rel_mouse.x - constant_x;  //Relative to the smaller selection grid
    float rel_y = rel_mouse.y - constant_y;  //
    
    collided_square = 3*floor(rel_y / (map.get_tileSize()*((float)4/3))) + floor(rel_x / (map.get_tileSize()*((float)4/3)));
    if (mousePressed && if_selection_ani_ready)
    {
      get_button("IF Position Button").set_dir_sel(collided_square);
      selection_mode_ani_false();
    }
    
    popStyle();
    popMatrix();
  }
  void collision_logic_con()
  {
        pushMatrix();
    pushStyle();
    
    PVector mouse     = new PVector(mouseX,mouseY);
    PVector rel_mouse = map.transform(mouse);
    PVector b_pos = get_button("IF Condition Button").get_pos();
    color b_color = get_button("IF Condition Button").get_col_cond();
    
    float scl = map(pow(if_sel_val,2), 0, 1, 0, 1);  //This is the value that animates the area
    int new_col_cond = color(0,0,0);  //Which of the squares is the cursor over at the moment
    
    float constant_x = b_pos.x - scl*((float)3/2)*map.get_tileSize();  
    float constant_y = b_pos.y - scl*2*           map.get_tileSize();
    
    float rel_x = rel_mouse.x - constant_x;  //Relative to the smaller selection grid
    float rel_y = rel_mouse.y - constant_y;  //
    
    if (rel_x > -0.5*(0.8*map.get_tileSize()) && rel_x < -0.5*(0.8*map.get_tileSize()) + 1*map.get_tileSize())
    {
      new_col_cond = color(255,0,0);
    }
    else if (rel_x > -0.5*(0.8*map.get_tileSize()) + 1*map.get_tileSize() && rel_x < -0.5*(0.8*map.get_tileSize()) + 2*map.get_tileSize())
    {
      new_col_cond = color(0,255,0);
    }
    else if (rel_x > -0.5*(0.8*map.get_tileSize()) + 2*map.get_tileSize() && rel_x < -0.5*(0.8*map.get_tileSize()) + 3*map.get_tileSize())
    {
      new_col_cond = color(0,0,255);
    }
    
    if (mousePressed && if_selection_ani_ready)
    {
      get_button("IF Condition Button").set_col_cond(new_col_cond);
      selection_mode_ani_false();
    }
    
    popStyle();
    popMatrix();
  }
  void collision_logic_act()
  {
    next_input_is_if = true;
  }
  
  void check_ani_states()
  {
    if (if_sel_val == tar_if_sel_val)
    {
      if (get_mode().equals("macroman_if_selection") && if_sel_val == 0)
      {
        set_mode("macroman");
      }
      if_selection_ani_ready = true;
    }
  }
  
  void draw_if_selection_box()
  {
    pushMatrix();
    pushStyle();
    
    if (get_mode().equals("macroman_if_selection"))
    {
      if ( get_if_sel_button().get_type().equals("IFPos") ){ draw_IFPos_sel_box(); }
      if ( get_if_sel_button().get_type().equals("IFCon") ){ draw_IFCon_sel_box(); }
      if ( get_if_sel_button().get_type().equals("IFAct") ){ draw_IFAct_sel_box(); }
    }
    
    popStyle();
    popMatrix();
  }
  void draw_IFPos_sel_box()
  {
    pushMatrix();
    pushStyle();
    
    float scl = map(pow(if_sel_val,2), 0, 1, 0, 1);  //This is the value that animates the area
    
    translate( get_if_sel_button().get_pos().x, get_if_sel_button().get_pos().y );
    translate( scl*map.get_tileSize()*0, scl*map.get_tileSize()*(-3) );
    
    fill(255,255,255,200);
    stroke(100,200);
    strokeWeight(scl*map.get_tileSize()/10);
    rect(0,0, scl*map.get_tileSize()*4,scl*map.get_tileSize()*4);
    
    float x_d   = scl*map.get_tileSize()*4;
    float y_d   = scl*map.get_tileSize()*4;
    int dir_sel = get_button("IF Position Button").dir_sel;  //Currently selected direction
    
    translate(-x_d/2, -y_d/2);  //Top left corner is origin now
    translate(x_d/6, y_d/6);
    for (int i = 0; i < 3; i++)
    {
      for (int j = 0; j < 3; j++)
      {
        fill(150, 100);
        stroke(0, 100);
        strokeWeight(map.get_tileSize()/20);

        if ((3*i + j) == dir_sel) fill(50);
        rect(0, 0, x_d/3, y_d/3);
        translate(x_d/3, 0);
      }
      translate(0, y_d/3);
      translate(-x_d, 0);
    }
    
    popStyle();
    popMatrix();
  }
  void draw_IFCon_sel_box()
  {
    pushMatrix();
    pushStyle();
    
    float scl = map(pow(if_sel_val,2), 0, 1, 0, 1);  //This is the value that animates the area
    float x_d   = scl*map.get_tileSize()*4;
    float y_d   = scl*map.get_tileSize()*1;
    
    translate( get_if_sel_button().get_pos().x, get_if_sel_button().get_pos().y );
    translate( scl*map.get_tileSize()*0, scl*map.get_tileSize()*(-2) );
    
    strokeWeight(scl*map.get_tileSize()/10);
    
    fill(255,255,255,200);
    stroke(100,200);
    rect(0,0, scl*map.get_tileSize()*4,scl*map.get_tileSize()*1);
    
    translate(-scl*3*map.get_tileSize()/2,0);
    fill(255,0,0,200);
    stroke(255,200);
    rect(0,0, scl*map.get_tileSize()*0.8,scl*map.get_tileSize()*0.8);
    
    translate(scl*map.get_tileSize(),0);
    fill(0,255,0,200);
    stroke(255,200);
    rect(0,0, scl*map.get_tileSize()*0.8,scl*map.get_tileSize()*0.8);
    
    translate(scl*map.get_tileSize(),0);
    fill(0,0,255,200);
    stroke(255,200);
    rect(0,0, scl*map.get_tileSize()*0.8,scl*map.get_tileSize()*0.8);
    
    translate(scl*map.get_tileSize(),0);
    fill(100,100,100,200);
    stroke(255,200);
    rect(0,0, scl*map.get_tileSize()*0.8,scl*map.get_tileSize()*0.8);
    
    popStyle();
    popMatrix();
  }
  void draw_IFAct_sel_box()
  {
    pushMatrix();
    pushStyle();
    
    float scl = map(pow(if_sel_val,2), 0, 1, 0, 1);  //This is the value that animates the area
    float x_d   = scl*map.get_tileSize()*4;
    float y_d   = scl*map.get_tileSize()*4;
    
    translate( get_if_sel_button().get_pos().x, get_if_sel_button().get_pos().y );
    translate( scl*map.get_tileSize()*(-1.4), scl*map.get_tileSize()*(-5) );
    
    noFill();
    stroke(0.5*(sin((float)frameCount/20 + 2*PI/3)+1)*255,0.5*(sin((float)frameCount/20 + 4*PI/3)+1)*255,0.5*(sin((float)frameCount/20 + 6*PI/3)+1)*255,230);
    strokeWeight(map.get_tileSize()/3);
    rect(0,0, scl*map.get_tileSize()*11, scl*map.get_tileSize()*5);
    
    popStyle();
    popMatrix();
  }
  
  void draw_macroman_gui(macroman c_mMan)
  {
    c_mMan.set_is_selected(true);
    
    if (get_c_box_alpha() == get_tar_c_box_alpha() && !c_box_ani_ready)
    {c_box_ani_ready = true;}
    
    pushMatrix();
    pushStyle();
    
    c_box_scroll = c_mMan.get_commands().size() * ((5*width/4 - 3*map.dim()[0]*map.get_tileSize()/2) * 0.75 / 20);
      //Initially, move the origin to a better place
    translate( -map.get_tileSize()/2 + map.get_tileSize()*map.dim()[0] , -map.get_tileSize()/2 );
    translate( (5*width/4 - 3*map.dim()[0]*map.get_tileSize()/2) / 2, 0 );


    fill(red(c_box_col), green(c_box_col), blue(c_box_col), c_box_alpha);
    stroke(50, 100);
    strokeWeight(map.get_tileSize()*0.1);
    
    translate(0 , map.get_tileSize()/2);
    rect(0,0 , 0.75 * (5*width/4 - 3*map.dim()[0]*map.get_tileSize()/2), map.get_tileSize());
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
    for (int i = 0; i < c_command_list.size(); i++)
    {
      if (c_command_list.size() > i)
      {
        String c_command = c_command_list.get(i);
        command_string = command_string + c_command + " ";
      }
    }
    textSize((5*width/4 - 3*map.dim()[0]*map.get_tileSize()/2) * 0.75 / 20);
    text(command_string,0,-map.get_tileSize()/10);
    
    textSize(map.get_tileSize()/3);
    fill(75);
    text("Commands", -(5*width/4 - 3*map.dim()[0]*map.get_tileSize()/2) * 0.75 / 2.4,-map.get_tileSize()*1);
  }
  
  
  boolean check_button_overlap()
  {
    boolean overlap = false;
    for (button c_button : buttons)
    {
      if ( c_button.is_overlapped( map.transform(new PVector(mouseX, mouseY)) ) )
      {
        overlap = true;
        break;
      }
    }
    return overlap;
  }
  
  void reset_buttons()
  {
    for (button c_button : buttons)
    {
      c_button.set_held(false);
    }
  }
  
  boolean check_slider_overlap()
  {
    boolean overlap = false;
    PVector mouse = new PVector(mouseX,mouseY);
    PVector rel_mouse = map.transform(mouse);
    for (slider c_slider : sliders)
    {
      if ( c_slider.check_clicked(rel_mouse) )
      {
        overlap = true;
        break;
      }
    }
    return overlap;
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
  void set_mode(macroman c_mMan)  //macroman mode
  {
    map.macroman_ani();
    set_mode("macroman");
    set_tar_macroman(c_mMan);
    set_tar_c_box_alpha(255);
    Ani.to(this, 2, "c_box_alpha", get_tar_c_box_alpha());
    for (button c_button : buttons)
    {
      c_button.ani_alpha(255);
    }
    c_box_ani_ready = false;
    
      //If Selection variables
    if_selection_ani_ready = true;
    if_sel_val = 0;
  }
  void set_mode()
  {
    map.default_ani();
    set_mode("-1");
    set_tar_c_box_alpha(0);
    Ani.to(this, 2, "c_box_alpha", get_tar_c_box_alpha());
    c_box_ani_ready = false;
    
      //If Selection variables
    if_selection_ani_ready = true;
    if_sel_val = 0;
  }
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
  
  button get_if_sel_button()
  {
    return if_sel_button;
  }
  void set_if_sel_button(button tar_button)
  {
    if_sel_button = tar_button;
  }
}
