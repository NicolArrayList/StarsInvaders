//défini une nouvelle classe qui portera 2 variables int pour les tirs
class Fire
{
  int xFire;
  int yFire;

  void deplacement_fire()
  {
    xFire += 20;
  }
  void deplacement_fire_reverse()
  {
    xFire -= 20;
  }

  void affiche_fire()
  {
    int compt=0;
    compt = (compt + 1)%8;
    //text(compt,xFire+20,yFire);
    tint(255,255);
    rect(xFire,yFire,20,1,50);
  }
  
  void collision_Fire()
  {
    if ( xFire >= 0 && xFire <= 80 && abs(yFire - (vaisseauY+50))<=50)
    {
      if(GodMode == false)
      {
       pdv -= 64;
       GodMode = true;
      }
    }
  }
    
  
}
