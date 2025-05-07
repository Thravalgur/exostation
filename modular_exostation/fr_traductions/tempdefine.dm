// MARK: Variations

// Variations pour la grammaire française
/// Nom par défaut simple et sans article ou autre : pomme, caillou, abeille, artichaut
#define DEFAUT 1
/// DEFINI : la pomme, le caillou, l'abeille, l'artichaut
#define DEFINI 2
/// INDEFINI : une pomme, un caillou, une abeille, un artichaut
#define INDEFINI 3
/// PREPOSITION : de la pomme, du caillou, de l'abeille, de l'artichaut
#define PREPOSITION 4
/// SON : sa pomme, son caillou, son abeille, son artichaut : pour les messages aux autres (singulier)
#define SON 5 
/// LEUR : leur pomme, leur caillou, leur abeille, leur artichaut : pour les messages aux autres (nom pluriel)
#define LEUR 6
/// MON : ma pomme, mon caillou, mon abeille, mon artichaut : pour les messages aux autres (singulier)
#define MON 7
/// VOTRE : votre pomme, votre caillou, votre abeille, votre artichaut : pour les messages au client dans le chat
#define VOTRE 8


/// Мacro de création de liste pour un objet
#define FR_NAMES_LIST_INIT(defaut, defini, indefini, preposition, son, leur, mon, votre) (list(DEFAUT = defaut, DEFINI = defini, INDEFINI = indefini, PREPOSITION = preposition, SON = son, LEUR = leur, MON = mon, VOTRE = votre))
