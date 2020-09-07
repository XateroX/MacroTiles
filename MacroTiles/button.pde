class button
{
  String name;
  
  int r;
  int g;
  int b;
  
  float px;
  float py;
  
  float x_dim;
  float y_dim;
  
  button(String n_name)
  {
    name = n_name;
    
    px = 0;
    py = 0;
    
    x_dim = 100;
    y_dim = 100;
    
    r = 200;
    g = 200;
    b = 200;
  }
  
  void drawme()
  {
    if ( gui.get_mode().equals("macroman") )
    {
      pushMatrix();
      pushStyle();
      
      translate(px,py);
      fill(get_col());
      stroke(100);
      strokeWeight(map.get_tileSize()/10);
      rect(0,0, x_dim,y_dim);
      
      popStyle();
      popMatrix();
    }
  }
  
  
  void check_if_pressed()
  {
    PVector mouse = new PVector(mouseX,mouseY);
    PVector rel_mouse = map.transform(mouse);
    
    if (is_overlapped(rel_mouse))
    {set_col( color(0,255,0) );}
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
}
