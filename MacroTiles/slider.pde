class slider
{
  String name;
  float px1;
  float py1;
  float px2;
  float py2;
  float slider_end_str;
  
  float value;
  
  slider(String n_name)
  {
    name = n_name;
    
    px1 = 0;  //Default position arguments
    py1 = 0;  //
    px2 = 0;  //
    py2 = 0;  //
    
    slider_end_str = 20;
    
    value = 0.01;
  }
  
  void drawme()
  {
    pushMatrix();
    pushStyle();
    
    stroke(0);
    strokeWeight(8);
    line(px1,py1, px2,py2);
    
      //Left Circle
    pushMatrix();
    pushStyle();
    stroke(0);
    fill(150);
    translate(px1,py1);
    circle(0,0, slider_end_str);
    popStyle();
    popMatrix();
    
      //Right Circle
    pushMatrix();
    pushStyle();
    stroke(0);
    fill(150);
    translate(px2,py2);
    circle(0,0, slider_end_str);
    popStyle();
    popMatrix();
    
    
      //Slider Circle
    pushMatrix();
    pushStyle();
    translate(px1,py1);
    translate((px2-px1 - slider_end_str*4)*value + slider_end_str*2, 0);
    fill(200,200,255);
    circle(0,0, slider_end_str*2);
    popStyle();
    popMatrix();
    
      //Name of slider
    pushMatrix();
    pushStyle();
    translate(px1,py1);
    fill(0);
    text(get_name(),0,-slider_end_str*2);
    popStyle();
    popMatrix();
    
    popStyle();
    popMatrix();
  }
  
  void set_value_from_vector( PVector p )
  {
    float scl = (p.x - px1 - slider_end_str*2) / (px2 - px1 -  slider_end_str*4) ;  //Just checking how far in x the mouse is on the line
    
      //Constrain Scale to 0-1
    if (scl > 1)
    {scl = 1;}
    if (scl < 0)
    {scl = 0;}
    
    set_value(scl);
  }
  
  boolean check_clicked(PVector mouse)
  {
    if (mouse.dist( new PVector( px1 + (px2-px1 - slider_end_str*4)*value + slider_end_str*2, py1 ) ) < slider_end_str)
    {return true;}
    else{return false;}
  }
  
  
    //### Get/Set Methods ###//
  String get_name()
  {
    return name;
  }
  
  PVector get_pos_1()
  {
    PVector p1 = new PVector(0,0);
    p1.x = px1;
    p1.y = py1;
    return p1;
  }
  PVector get_pos_2()
  {
    PVector p2 = new PVector(0,0);
    p2.x = px2;
    p2.y = py2;
    return p2;
  }
  void set_pos_1(PVector p1)
  {
    px1 = p1.x;
    py1 = p1.y;
  }
  void set_pos_2(PVector p2)
  {
    px2 = p2.x;
    py2 = p2.y;
  }
  
  
  void set_value(float v)
  {
    value = v;
  }
  
}
