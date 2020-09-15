class text
{
  String content;
  float px;
  float py;
  float size;
  
  color col;
  
  text(String n_content)
  {
    size = map.get_tileSize()/2;
    set_content(n_content);
    col = color(0,0,0);
  }
  
  void drawme(String mode)
  {
    if ( gui.get_mode().equals("macroman") || gui.get_mode().equals("macroman_if_selection") )
    {
      if (get_content().equals("IF") || get_content().equals("THEN"))
      {
        draw_text();
      }
    }
    if ( get_content().equals("MODE") )
    {
      draw_text(mode);
    }
  }
  void drawme()
  {
    if ( gui.get_mode().equals("macroman") || gui.get_mode().equals("macroman_if_selection") )
    {
      if (get_content().equals("IF") || get_content().equals("THEN"))
      {
        draw_text();
      }
    }
  }
  
  void draw_text(String mode)
  {
    pushMatrix();
    pushStyle();
    
    translate(get_px(),get_py());
    textSize(size);
    fill(col);
    text(mode,0,0);
    
    popStyle();
    popMatrix();
  }
  void draw_text()
  {
    pushMatrix();
    pushStyle();
    
    translate(get_px(),get_py());
    textSize(size);
    fill(col);
    text(get_content(),0,0);
    
    popStyle();
    popMatrix();
  }
  
    //### Get/Set methods ###//
  float get_px()
  {
    return px;
  }
  void set_px(float n_px)
  {
    px = n_px;
  }
  
  float get_py()
  {
    return py;
  }
  void set_py(float n_py)
  {
    py = n_py;
  }
  
  PVector get_pos()
  {
    return new PVector(px,py);
  }
  void set_pos(float n_px, float n_py)
  {
   set_px(n_px);
   set_py(n_py);
  }
  
  String get_content()
  {
    return content;
  }
  void set_content(String n_content)
  {
    content = n_content;
  }
  
  float get_size()
  {
    return size;
  }
  void set_size(float n_size)
  {
    size = n_size;
  }
    //
}
