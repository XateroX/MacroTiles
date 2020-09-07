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
  
  button(String n_name, String n_type)
  {
    name = n_name;
    
    px = 0;
    py = 0;
    
    x_dim = 100;
    y_dim = 100;
    
    r = 100;
    g = 100;
    b = 150;
    def_col = color(r,g,b);
    alpha           = 0;
    tar_alpha       = 0;
    alpha_ani_ready = true;
    
    type = n_type;
    
    held = false;
  }
  
  void drawme()
  {
    if (get_alpha() == get_tar_alpha() && !get_alpha_ani_ready())
    {set_alpha_ani_ready(true);}
      
    if ( gui.get_mode().equals("macroman") )
    {
      pushMatrix();
      pushStyle();
      
      translate(px,py);
      fill(red(get_col()),green(get_col()),blue(get_col()), alpha);
      if (type.equals("DLT")) fill(200,200,200);
      stroke(100, alpha);
      strokeWeight(map.get_tileSize()/10);
      rect(0,0, x_dim,y_dim);
      fill(0);
      textSize(map.get_tileSize() * 0.70);
      text(type,0,-map.get_tileSize()/10);
      
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
    PVector mouse = new PVector(mouseX,mouseY);
    PVector rel_mouse = map.transform(mouse);
    
    if (is_overlapped(rel_mouse) && mousePressed && !held)
    {
      held = true;
      gui.evaluate(type);
      set_col( color(0,255,0) );
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
  
  
  
    //### Get/Set functions ###//
  PVector get_pos()
  {
    return new PVector(px,py);
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
    return color(r,g,b);
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
}
