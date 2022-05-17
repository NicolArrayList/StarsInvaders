//------------------------------------------------------------

import processing.sound.*;

//------------------------------------------------------------

PImage background, vaisseau, Tie_Fighter_img, explosion_Tie, HUD, startscreen, star_invaders, start, start_press, defeatR, restart, restart_press;

SoundFile Fire, SoundTrack, op, geraldine, geraldine2;

int vaisseauY = 150, nbTie_Fighter = 0, temps0 = 0, temps = 0, nbFire = -1, nbFire_Tie = -1, Tie_Max = 6, tir = 0, pdv = 640, compt0 = 0, compt = 0, InGame = 0, diff = 60, score = 0;

TIE[] Tie_Fighter;

Fire[] PiouPiou, PiouPiou_Tie;

boolean deplacementHaut, deplacementBas, spawnTie = true, GodMode = false, animation_expl;

//-----------------------------------------------------------

//------------------------------------------------------------
void setup() 
{
  PiouPiou = new Fire[16];
  PiouPiou_Tie = new Fire[16];

  for (int i = 0; i<16; i++)
  {
    PiouPiou[i] = new Fire();
    PiouPiou_Tie[i] = new Fire();
  }

  //------------------------------------------------------------

  Tie_Fighter = new TIE[Tie_Max+1];
  for (int i = 0; i<Tie_Fighter.length; i++)
  {
    Tie_Fighter[i] = new TIE() ;
  }

  //------------------------------------------------------------

  surface.setTitle("Star Invaders");

  size(1280, 720);

  //------------------------------------------------------------

  background = loadImage("background2.jpg");
  vaisseau = loadImage("X-Wing-petit.png");
  Tie_Fighter_img = loadImage("Tie_Fighter_img.png");
  explosion_Tie = loadImage("explosion_Tie.png");
  HUD = loadImage("HUD.png");
  startscreen = loadImage("background1.jpg");
  star_invaders = loadImage("star invaders.png");
  start = loadImage("start.png");
  start_press =loadImage("start1.png");
  defeatR = loadImage("defaite cote lumineux.png");
  restart = loadImage("restart.png");
  restart_press = loadImage("restart1.png");

  Fire = new SoundFile(this, "Tie_Fighter_Fire.mp3");
  SoundTrack = new SoundFile(this, "Star Wars - Resistance Suite (Theme).mp3");
  op = new SoundFile(this, "Star Wars Intro HD 1080p (1).mp3");
  geraldine = new SoundFile(this, "Geraldine.mp3");
  geraldine2 = new SoundFile(this, "Geraldine2.mp3");
}

//------------------------------------------------------------

void fire() {
  if (tir !=0)
  {
    nbFire = (nbFire+1)%8;
    PiouPiou[nbFire].xFire = 80;
    PiouPiou[nbFire].yFire = vaisseauY + 8;

    nbFire = (nbFire+1)%8;
    PiouPiou[nbFire].xFire = 80;
    PiouPiou[nbFire].yFire = vaisseauY + 91;
    Fire.play();

    tir --;
  }
}
//------------------------------------------------------------
void affiche_fire()
{
  if (tir == 1)
  {
    fill(255, 0, 0);
    stroke(255, 0, 0);
    rect(1124, 65, 40, 40);
  } else if (tir == 2)
  {
    fill(255, 0, 0);
    stroke(255, 0, 0);
    rect(1124, 65, 40, 40);
    rect(1175, 65, 40, 40);
  } else if (tir == 3)
  {
    fill(255, 0, 0);
    stroke(255, 0, 0);
    rect(1124, 65, 40, 40);
    rect(1175, 65, 40, 40);
    rect(1227, 65, 40, 40);
  }
}
//------------------------------------------------------------
void barre_vie()
{

  stroke(0, 255, 0);
  fill(0, 255, 0);
  rect(182, 32, pdv, 27);
}
//------------------------------------------------------------
void fire_Tie()
{
  int hasard = int(random(0, 7));
  if (Tie_Fighter[hasard].speed > 10)
  {
    nbFire_Tie = (nbFire_Tie+1)%16;
    PiouPiou_Tie[nbFire_Tie].xFire = Tie_Fighter[hasard].x;
    PiouPiou_Tie[nbFire_Tie].yFire = Tie_Fighter[hasard].y+25;
  }
}

//------------------------------------------------------------
//------------------------------------------------------------
///Fonction de collision entre laser et enemi 
void collision()
{
  //boolean explosion; 
  for (int i = 0; i<nbTie_Fighter+1; i++)      //boucle for balayanttout les ennemis
  {
    for (int j = 0; j<nbFire+1; j++)           //boucle for balayanttout les lasers
    {
      //Test qui vérifie si la laser à dépasser l'enemi et si il est situé sur sa HitBox (ici la HitBox de l'ennemi est 50 pixel sur l'axe y)
      if (PiouPiou[j].xFire-Tie_Fighter[i].x >= 0 && abs((Tie_Fighter[i].y+25)-(PiouPiou[j].yFire))<=25)                
      {
        image(explosion_Tie, Tie_Fighter[i].x-100, Tie_Fighter[i].y-100);    
        Tie_Fighter[i].x = -100;                                               //fait sortir l'enimi de l'ecran de jeu et laisse une explosion
        Tie_Fighter[i].y = 0;
        Tie_Fighter[i].speed = int(random(0, 100));
        PiouPiou[j].yFire = 1280;        //fait sortir le laser de l'écran de jeu
        score += 25;      
      }
    }
  }
  //return explosion;
}

//------------------------------------------------------------
void Tie_Fighter_spawn() 
{ 
  if (nbTie_Fighter<Tie_Max)
  {
    if (nbTie_Fighter == 1 && temps >= 180)
    {
      nbTie_Fighter++;
      Tie_Fighter[nbTie_Fighter].x = 1280;
      Tie_Fighter[nbTie_Fighter].y = vaisseauY;
      Tie_Fighter[nbTie_Fighter].speed = 5;
    } else
    {
      nbTie_Fighter++;
      Tie_Fighter[nbTie_Fighter].x = 1280;
      Tie_Fighter[nbTie_Fighter].y = int(random(125, 680));
    }
  }
}
//------------------------------------------------------------
//------------------------------------------------------------

void draw()
{
  if (InGame == 0)
  {

    temps0++;

    if (temps0%5200 == 1)
    {
      op.play();
    }

    image(startscreen, 0, 0);
    fill(0, 0, 0, 1000);

    if (temps0 >= 149)
    {
      image(star_invaders, 100, 30);
      image(start, 167, 220);
      if (mouseX >= 167 && mouseX <= 413 && mouseY >= 220 && mouseY <= 271)
      {
        image(start_press, 160, 215);
      }
    }
  }

  if (InGame == 2)
  {
    image(defeatR, 0, 0);
    fill(0, 0, 0, 1000);
    image(restart, 800, 250);
    if (mouseX >= 800 && mouseX <= 1151 && mouseY >= 250 && mouseY <= 301)
    {
      image(restart_press, 794, 245);
    }
  }

  if ( InGame == 1)
  {
    //------------------------------------------------------------

    ///temps est le compteur de la boucle draw 
    temps++;

    //------------------------------------------------------------

    op.stop();

    //------------------------------------------------------------

    image(background, 0, 0);

    //------------------------------------------------------------

    ///répète la musique 11160 car la musique dure 186s et comme draw se répète 60 fois /sec donc 11160 !
    if ((temps%4320) == 1)
    {
      SoundTrack.play();
    }

    ///Fait apparaitre un ennemi toute les secondes
    if ((temps%60) == 1) 
    {
      score++;
      Tie_Fighter_spawn();
    }

    if (temps%diff == 1  && temps >= 300)
    {
      Fire.play();
      fire_Tie();
      fire_Tie();
      fire_Tie();
      diff = int(random(40, 120));
    }

    ///chargeur des munition qui se bloque à 3 lasers
    if (tir<3)
    {
      if ((temps%120) == 1)
      {
        tir++;
      }
    }
    //------------------------------------------------------------
    if (GodMode == true)
    {
      compt = compt +1;
      affiche_vaisseauGodMode(vaisseauY);
      if (compt >= 60)
      {
        GodMode = false;
        compt = 0;
      }
    } else
      affiche_vaisseau(vaisseauY);
    //------------------------------------------------------------

    collision();

    //------------------------------------------------------------

    deplacement_vaisseau();

    //deplacement_fire();

    //------------------------------------------------------------

    ///Applique le déplacement et l'affichage à chaque composant du tableau Tie_Fighter
    for (int i = 0; i<Tie_Fighter.length; i++)
    {
      Tie_Fighter[i].deplacement_Tie_Fighter();
      Tie_Fighter[i].affiche_Tie_Fighter();
      Tie_Fighter[i].collision_Tie();
    }

    for (int i = 0; i<PiouPiou.length; i++)
    {
      PiouPiou[i].deplacement_fire();
      stroke(255, 0, 0);
      PiouPiou[i].affiche_fire();
    }

    for (int i = 0; i<PiouPiou_Tie.length; i++)
    {
      PiouPiou_Tie[i].deplacement_fire_reverse();
      stroke(0, 255, 0);
      PiouPiou_Tie[i].affiche_fire();
      PiouPiou_Tie[i].collision_Fire();
    }

    //Remet les ennemis 
    for (int i = 0; i<Tie_Fighter.length; i++)
    {
      int hasard = int(random(0, 100));
      if (Tie_Fighter[i].x <= -10)
      {
        if (hasard <= 10)
        {
          Tie_Fighter[i].x = 1980;
          Tie_Fighter[i].y = vaisseauY;
          Tie_Fighter[i].speed = 5;
        } 
        else
        Tie_Fighter[i].y = int(random(125, 670));
        Tie_Fighter[i].speed = int(random(0, 100));
        
        if( Tie_Fighter[i].speed <= 10 )
        {
          Tie_Fighter[i].x = 1980;
        }
        else
        Tie_Fighter[i].x = 1280;

        if (Tie_Fighter[i].speed <= 5)
        {
          geraldine.play();
        }
        if (Tie_Fighter[i].speed > 5 && Tie_Fighter[i].speed <= 10)
        {
          geraldine2.play();
        }
      }
    }

    if (pdv == 64)
    {
      stroke(255, 0, 0);
      fill(255, 0, 0);
      rect(182, 32, pdv, 27);
    }
    if (pdv > 64)
    {
      stroke(255, 120, 0);
      fill(255, 120, 0);
      rect(182, 32, pdv, 27);
    }
    if (pdv >= 340)
    {
      stroke(0, 255, 0);
      fill(0, 255, 0);
      rect(182, 32, pdv, 27);
    }

    if (pdv<=0)
    {
      InGame = 2;
      SoundTrack.stop();
    }

    image(HUD, 0, 0);
    fill(255);
    text("Score : " + score, 900,50);
    textSize(25);
    text("X-WING", 65, 55);
    textSize(30);
    text( (pdv*100)/640 +"/100", 580, 95);

    affiche_fire();
  }

  //------------------------------------------------------------

  //spawnTie = false;

  //------------------------------------------------------------
}

void keyPressed() {

  if (key == CODED)
  {
    if (keyCode == UP)
    {
      deplacementHaut = true;
    }
    if (keyCode == DOWN)
    {
      deplacementBas = true;
    }
  }
  if (key == ' ') 
  {
    fire();
  }
  if (key == 's')
  {
    InGame = 1;
  }
  if (key == 'r' && InGame == 2)
  {
    InGame = 1;
    pdv = 640;
    temps = 0;
    for (int i = 0; i<Tie_Fighter.length; i++)
    {
      Tie_Fighter[i].x += 1280;
    }
  }
  if (key == 'h')
  {
    pdv += 64;
  }
}

void keyReleased() {

  if (key == CODED)
  {
    if (keyCode == UP)
    {
      deplacementHaut = false;
    }
    if (keyCode == DOWN)
    {
      deplacementBas = false;
    }
  }
}
//--------------------------------------------------------
//--------------------------------------------------------

void mouseClicked()
{
  if (mouseX >= 167 && mouseX <= 413 && mouseY >= 220 && mouseY <= 271 && InGame == 0 && temps0>= 149)
  {
    InGame = 1;
  }
  if (mouseX >= 800 && mouseX <= 1151 && mouseY >= 250 && mouseY <= 301 && InGame == 2)
  {

    InGame = 1;
    pdv = 640;
    temps = 0;
    for (int i = 0; i<Tie_Fighter.length; i++)
    {
      Tie_Fighter[i].x += 1280;
    }
  }
}
