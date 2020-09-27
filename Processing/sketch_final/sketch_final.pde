int background_color = 0;
int fontsize_min = 40;
int fontsize_max = 100;

// liste des mots à afficher
StringList words;
PFont font;

int n = 0;

Boolean mode_remplissage = false ; // false: defaut, true: remplissage rapide
//Word mot_remplissage = new Word();
Word mot_remplissage;

class Word {
  float pos_x, pos_y;
  String word;
  int word_height;
  int couleur;
  int fontsize_min;
  int fontsize_max;

  Word () {
    // initialisation
    couleur = 0;
    update(fontsize_min, fontsize_max);
    couleur = 0;
    fontsize_min = 0;
    fontsize_max = 0;
    word_height = 60;
  }

  void draw() {
    fill(couleur);
    textSize(word_height);
    text(word, pos_x, pos_y);
    couleur = max(0, couleur - 16);
  }

  void update(int fmin, int fmax) {
    fontsize_min = fmin;
    fontsize_max = fmax;
    couleur = 255;
    int pick_a_word = int(random(16));
    word = words.get(pick_a_word);
    // choix de la taille du mot 
    word_height = int(random(fontsize_min, fontsize_max));
    // calcul de la largeur du mot
    float word_width = textWidth(word);
    // choix de la position du mot
    pos_x = random(width - word_width) + word_width/2;
    pos_y = random(height - word_height/2) + word_height/2;
  }
}



// tampon de mots affichés
Word[] words_list = new Word[16];

void setup() {
  frameRate(300); // default speed: 60 fps
  size(1920, 1080);
  //size(854, 480);
  //fullScreen(2);
  background(background_color); // black !
  textAlign(CENTER);

  // liste de mots (16)
  words = new StringList();
  words.append("là");
  words.append("las");
  words.append("la");
  words.append("long");
  words.append("large");
  words.append("l'arbre");
  words.append("larme");
  words.append("l'âme");
  words.append("faille");
  words.append("immobile");
  words.append("s'enfuir");
  words.append("femme");
  words.append("fugace");
  words.append("curieuse");
  words.append("instant");
  words.append("aux aguets");

  font = createFont("Ozarks-Normal.otf", 32);
  textFont(font);

  // initialisation des mots à afficher  
  for (int i = 0; i < words_list.length; i++) {
    words_list[i] = new Word();
  }

  mot_remplissage = new Word();
}


void draw() {
  if (mode_remplissage) {
    mot_remplissage.update(fontsize_min, fontsize_max);
    mot_remplissage.draw();
  }
}

void keyPressed() {
  //println(key); // debug

  switch(key) {
  case 'y':
    fontsize_min = 40;
    fontsize_max = 100;
    background(0);  
    for (int y = 0; y < 16; y++ ) {
      words_list[y].draw();
      if (n == y) {
        words_list[y].update(fontsize_min, fontsize_max);
      }
    }

    if (n++ == 16) {
      n = 0;
    }

    //println("top");
    break;

  case 't':
    fontsize_min = 60;
    fontsize_max = 200;
    background(0);  
    for (int y = 0; y < 16; y++ ) {
      words_list[y].draw();
      if (n == y) {
        words_list[y].update(fontsize_min, fontsize_max);
      }
    }

    if (n++ == 16) {
      n = 0;
    }

    //println("top");
    break;

  case 'r':
    int transparence = 16;

    for (int i = 0; i < 16; i++) {
      words_list[i].couleur=0;
    }

    fill(0, transparence);
    rect(0, 0, width, height);
    //println("rectangle translucide");
    break;

  case 'e':
    //println("remplissage");
    if (mode_remplissage) {
      mode_remplissage = false;
    } else {
      mode_remplissage = true;
    }

    break;

  case 'f':
    background_color = 255 - background_color;
    background(background_color); // white !

    //println("flash");
    break;
  }
}
