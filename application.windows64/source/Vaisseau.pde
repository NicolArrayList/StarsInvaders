void affiche_vaisseau(int Y)
{
  image(vaisseau, 10, Y);
}

void affiche_vaisseauGodMode(int Y)
{
  if(temps%5 == 1)
  {
    image(vaisseau, 10, Y);
  }
}

void deplacement_vaisseau(){

  if (deplacementHaut == true && vaisseauY >=140){
  
    vaisseauY = vaisseauY - 10;
  
  }
  else if (deplacementBas == true && vaisseauY <= 610)
  {
    vaisseauY += 10;
  }
}
