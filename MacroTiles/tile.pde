class tile
{
  int[] p;
  boolean ani_ready;
  int r;
  int g;
  int b;
  int t_r;
  int t_g;
  int t_b;
  
  color def_col;
  
  tile(int x, int y)
  {
    def_col = color(175, 175, 255);
    
    p = new int[2];
    p[0] = x;
    p[1] = y;
    
    ani_ready = true;
    
    r = 175;
    g = 175;
    b = 255;
    
    t_r = 175;
    t_g = 175;
    t_b = 255;
    
  }
  
  void drawme()
  {
    pushMatrix();
    pushStyle();
    
    float size = map.get_tileSize();
    
    translate(p[0]*size,p[1]*size);
    
    color c_col = get_col();
    fill(red(c_col), green(c_col), blue(c_col));
    stroke(110);
    strokeWeight(size/10);
    //noStroke();
    rect(0,0, size+1,size+1);
    
    popStyle();
    popMatrix();
  }


  public void recolor(color c)
  {
    if (r==t_r && g==t_g && b==t_b)
    {
      ani_ready = true;
    }
    if (ani_ready && speed != 0)
    {
      t_r = int(red  (c));
      t_g = int(green(c));
      t_b = int(blue (c));
            
      Ani.to(this, 1/speed, "r", t_r);
      Ani.to(this, 1/speed, "g", t_g);
      Ani.to(this, 1/speed, "b", t_b);
      
      ani_ready = false;
    }
  }
  
  
  void flip()
  {recolor( color(255-int(red(get_col())),255-int(green(get_col())),255-int(blue(get_col()))) );}
  void reset()
  {recolor( def_col );}

  
  void check_ani_ready()
  {
    if (r==t_r && g==t_g && b==t_b)
    {
      ani_ready = true;
    }
  }
  
    //### Get/Set methods ###//
  color get_col()
  {
    return color(r,g,b);
  }
  void set_col(int n_r, int n_g, int n_b)
  {
    r = n_r;
    g = n_g;
    b = n_b;
  }
  
  boolean get_ani_ready()
  {
    return ani_ready;
  }
}
