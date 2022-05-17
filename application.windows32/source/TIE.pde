class TIE
{
  int speed;
  int x;
  int y;

  TIE()
  {
    speed = 90;
    x = 2000;
    y = 150;
  }
  //--------------------------------------------------------------------------
  void deplacement_Tie_Fighter()
  {  
    if (speed < 10)
    {
      x -= 15;
    }

    if (speed > 10)
    {
      x -= 5;
    } else 
    x -= 17;
  }
  //---------------------------------------------------------------------------
  void affiche_Tie_Fighter() 
  {
    //text(speed, x+20, y);
    image(Tie_Fighter_img, x, y);
  }

  //----------------------------------------------------------------------------
  //----------------------------------------------------------------------------
  void collision_Tie()
  {
    if ( x <= 80 && abs(y - (vaisseauY+50))<=50)
    {
      if(GodMode == false)
      {
       pdv -= 64;
       GodMode = true;
      }
    }
  }
  
  
  
  
}
