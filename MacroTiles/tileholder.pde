class tileholder
{
    //Tokens
  float token1;
    //Tokens
  
  boolean macroman_mode_ani_ready;
  
  float bufferWidth;
  float bufferHeight;
  float cameraX;
  float tar_cameraX;
  float cameraY;
  float tar_cameraY;
  float x_shift;
  float y_shift;
  
  ArrayList< ArrayList<tile> > tileArray;
  float tileSize;
  
  void init()
  {
    token1 = -1;
    
    tileSize = 75;
    bufferWidth = width/5;
    bufferHeight = height/5;
    cameraX     = 0;
    tar_cameraX = 0;
    cameraY     = 0;
    tar_cameraY = 0;
    x_shift = 0;
    y_shift = 0;
    macroman_mode_ani_ready = true;
  }
  
  tileholder(int x, int y)
  {
    tileArray = new ArrayList< ArrayList<tile> >();
    for (int i = 0; i < y; i++)
    {
      tileArray.add( new ArrayList<tile>() );
      for (int j = 0; j < x; j++)  //Construct the nested tile list
      {
        tileArray.get(tileArray.size()-1).add( new tile(j,i) );
      }
    }
    init();
  }
  
  
  void update()
  {
    for (int i = 0; i < dim()[1]; i++)
    {
      for (int j = 0; j < dim()[0]; j++)  //Construct the nested tile list
      {
        tileArray.get(i).get(j).drawme();
      }
    }
    
    update_all_tiles();
    
    if (get_cameraX() == tar_cameraX && !macroman_mode_ani_ready)
    {
      macroman_mode_ani_ready = true;
      token1 = -1;
    }
  }
  
  void macroman_ani()
  {
    tar_cameraX = -width/4;
    Ani.to(this, 2, "cameraX", tar_cameraX);
    macroman_mode_ani_ready = false;
  }
  void default_ani()
  {
    tar_cameraX = 0;
    Ani.to(this, 2, "cameraX", tar_cameraX);
    macroman_mode_ani_ready = false;
  }
  
  PVector transform( PVector n_p )  //Transform global vectors into reference frame of the tiles
  {
    PVector f_p = new PVector(0,0);
    
    if (height < width)
    {
      f_p.x = n_p.x - map.get_tileSize()/2 - width/2 + map.get_tileSize()*map.dim()[0]/2  - get_cameraX();  //Camera methods to correct for movement of camera
      f_p.y = n_p.y - map.bufferHeight/2 - map.get_tileSize()/2                           - get_cameraY();
    }else
    {
      f_p.x = n_p.x - map.bufferWidth/2 - map.get_tileSize()/2                            - get_cameraX();
      f_p.y = n_p.y - map.get_tileSize()/2 - height/2 + map.get_tileSize()*map.dim()[1]/2 - get_cameraY();
    }
    
    return f_p;
  }
  
  int[] dim()
  {
    int[] returnDims = new int[2];
    returnDims[0] = tileArray.get(0).size();
    returnDims[1] = tileArray       .size();
    return returnDims;
  }
  
  
  public void flip_tile(int x, int y)
  {
    tileArray.get(y).get(x).flip();
  }
  public void recolor_tile(int x, int y, color c)
  {
    tileArray.get(y).get(x).recolor(c);
  }
  public void reset_tiles(int i, int j)
  {
    tileArray.get(j).get(i).reset(); //<>//
  }
  
  void update_all_tiles()
  {
    for (int i = 0; i < dim()[1]; i++)
    {
      for (int j = 0; j < dim()[0]; j++)  //Construct the nested tile list
      {
        tileArray.get(j).get(i).check_ani_ready();
      }
    }
  }
  
  boolean tile_ani_ready()
  {
    boolean all = true;
    for (int i = 0; i < dim()[1]; i++)
    {
      for (int j = 0; j < dim()[0]; j++)  //Construct the nested tile list
      {
        all = all && tileArray.get(j).get(i).get_ani_ready();
      }
    }
    return all;
  }
  boolean tile_ani_ready(int i_x, int i_y)
  {
    boolean all = tileArray.get(i_y).get(i_x).get_ani_ready();
    return all;
  }
  
  
    // Get/Set Variables
  float get_tileSize()
  {
    float t_tileSize = tileSize;
    if (width < height)
    {
      t_tileSize = (width-bufferWidth) / dim()[0];
    }else
    {
      t_tileSize = (height-bufferHeight) / dim()[1];
    }
    return t_tileSize;
  }
  
  float get_cameraX()
  {
    return cameraX;
  }
  float get_cameraY()
  {
    return cameraY;
  }
  
  void set_cameraX(float x)
  {
    cameraX = x;
  }
  void set_cameraY(float y)
  {
    cameraY = y;
  }
  
  float get_x_shift()
  {
    return x_shift;
  }
  float get_y_shift()
  {
    return y_shift;
  }
  void set_x_shift()
  {
  }
  void set_y_shift()
  {
  }
}
