class button
{
  String name;
  String type;

  color def_col;
  int r;
  int g;
  int b;
  float alpha;
  float tar_alpha;
  boolean alpha_ani_ready;

  float px;
  float py;

  float x_dim;
  float y_dim;

  boolean held;

  //IF variables
  int dir_sel;
  color col_cond;
  String IFAction;
  //

  button(String n_name, String n_type)
  {
    name = n_name;

    px = 0;
    py = 0;

    x_dim = 100;
    y_dim = 100;

    r = 150;
    g = 80;
    b = 80;
    def_col = color(r, g, b);
    alpha           = 0;
    tar_alpha       = 0;
    alpha_ani_ready = true;

    type = n_type;

    held = false;

    //IF Variables
    dir_sel  = 4;
    col_cond = def_col; 
    IFAction = "FT";
    //
  }

  void drawme()
  {
    if (get_alpha() == get_tar_alpha() && !get_alpha_ani_ready())
    {
      set_alpha_ani_ready(true);
    }

    if ( gui.get_mode().equals("macroman") || gui.get_mode().equals("macroman_if_selection") )
    {
      pushMatrix();
      pushStyle();
      translate(px, py);
      if        (type == "IFPos")
      {
        draw_IFPos();
      } else if (type == "IFCon")
      {
        draw_IFCon();
      } else if (type == "IFAct")
      {
        draw_IFAct();
      } else if (type == "IFSub")
      {
        draw_IFSub();
      } else
      { 
        fill(red(get_col()), green(get_col()), blue(get_col()), alpha);
        if (type.equals("DLT")) fill(200, 200, 200);
        stroke(100, alpha);
        strokeWeight(map.get_tileSize()/10);
        rect(0, 0, x_dim, y_dim);
        fill(0);
        textSize(map.get_tileSize() * 0.70);
        text(type, 0, -map.get_tileSize()/10);
      }
      popStyle();
      popMatrix();
    }
  }


  void ani_alpha(int t_alpha)
  {
    set_tar_alpha(t_alpha);
    Ani.to(this, 4, "alpha", tar_alpha);
    alpha_ani_ready = false;
  }


  void check_if_pressed()
  {
    PVector mouse = new PVector(mouseX, mouseY);
    PVector rel_mouse = map.transform(mouse);

    if (is_overlapped(rel_mouse) && mousePressed && !held)
    {
      held = true;
      gui.evaluate(get_type());
      set_col( color(0, 255, 0) );
      Ani.to(this, 3, "r", red  (def_col));
      Ani.to(this, 3, "g", green(def_col));
      Ani.to(this, 3, "b", blue (def_col));
    }
  }

  boolean is_overlapped(PVector t)
  {
    PVector p = get_pos();
    boolean c1 = t.x < p.x + x_dim/2;
    boolean c2 = t.x > p.x - x_dim/2;
    boolean c3 = t.y < p.y + y_dim/2;
    boolean c4 = t.y > p.y - y_dim/2;

    return c1 && c2 && c3 && c4;
  }


  void draw_IFSub()
  {
    fill(200, 200, 200);
    stroke(0);
    strokeWeight(map.get_tileSize()/10);
    rect(0, 0, x_dim, y_dim);
    textSize(map.get_tileSize());
    fill(0);
    text("+", 0, -map.get_tileSize()/5);
  }

  void draw_IFAct()
  {
    fill(255, 200);
    stroke(0);
    strokeWeight(map.get_tileSize()/10);
    rect(0, 0, x_dim, y_dim);
    textSize(map(IFAction.length(), 1, 5, 3, 1) * map.get_tileSize()/3);
    fill(0);
    text(IFAction, 0, -map.get_tileSize()/10);
  }

  void draw_IFCon()
  {
    fill(col_cond, 200);
    stroke(200, 200);
    strokeWeight(map.get_tileSize()/10);
    rect(0, 0, x_dim, y_dim);
  }

  void draw_IFPos()
  {
    fill(255, 200);
    stroke(200, 200);
    strokeWeight(map.get_tileSize()/10);
    rect(0, 0, x_dim, y_dim);
    draw_mini_pad(dir_sel, x_dim, y_dim);
  }


  void draw_mini_pad(int dir_s, float x_d, float y_d)
  {
    rectMode(CENTER);
    pushMatrix();
    pushStyle();

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
    rectMode(CENTER);
  }


  //### Get/Set functions ###//
  String get_type()
  {
    return type;
  }
  void set_type(String n_type)
  {
    type = n_type;
  }
  
  PVector get_pos()
  {
    return new PVector(px, py);
  }
  void set_pos(float n_px, float n_py)
  {
    px = n_px;
    py = n_py;
  }
  void set_pos(PVector p)
  {
    px = p.x;
    py = p.y;
  }

  String get_name()
  {
    return name;
  }
  void set_name(String n_name)
  {
    name = n_name;
  }

  color get_col()
  {
    return color(r, g, b);
  }
  void set_col( color c )
  {
    r = (int)red(c);
    g = (int)green(c);
    b = (int)blue(c);
  }
  void set_col( int n_r, int n_g, int n_b )
  {
    r = n_r;
    g = n_r;
    b = n_r;
  }

  float get_tar_alpha()
  {
    return tar_alpha;
  }
  void set_tar_alpha(float t_alpha)
  {
    tar_alpha = t_alpha;
  }

  float get_alpha()
  {
    return alpha;
  }
  void set_alpha(float n_alpha)
  {
    alpha = n_alpha;
  }

  boolean get_alpha_ani_ready()
  {
    return alpha_ani_ready;
  }
  void set_alpha_ani_ready(boolean v)
  {
    alpha_ani_ready = v;
  }

  boolean get_held()
  {
    return held;
  }
  void set_held(boolean v)
  {
    held = v;
  }
  
  int get_dir_sel()
  {
    return dir_sel;
  }
  void set_dir_sel(int n_dir_sel)
  {
    dir_sel = n_dir_sel;
  }
  
  color get_col_cond()
  {
    return col_cond;
  }
  void set_col_cond(color n_col_cond)
  {
    col_cond = n_col_cond;
  }
  
  String get_action()
  {
    return IFAction;
  }
  void set_action(String n_IFAction)
  {
    IFAction = n_IFAction;
  }
}
