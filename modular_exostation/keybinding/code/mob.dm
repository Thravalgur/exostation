/datum/keybinding/mob/stop_pulling
	hotkey_keys = list("H", "Delete")
	full_name = "Arrêter de tirer"
	description = "Arrêter de tirer ce que vous êtes en train de tirer."

/datum/keybinding/mob/swap_hands
	hotkey_keys = list("X")
	full_name = "Changer de main"
	description = "Change la main active."

/datum/keybinding/mob/select_hand/right
	hotkey_keys = list(UNBOUND_KEY)
	full_name = "Passer sur la main droite"

/datum/keybinding/mob/select_hand/left
	hotkey_keys = list(UNBOUND_KEY)
	full_name = "Passer sur la main gauche"

/datum/keybinding/mob/activate_inhand
	hotkey_keys = list(UNBOUND_KEY) //Original Z
	full_name = "Activer l'objet tenu"
	description = "Utilise l'objet que vous tenez dans votre main active"

/datum/keybinding/mob/drop_item
	hotkey_keys = list("A") //Original Q
	full_name = "Lâcher l'objet tenu"
	description = "Lâche l'objet que vous tenez dans votre main active"

/datum/keybinding/mob/drop_item_specific
	hotkey_keys = list("CtrlA") //Original CtrlX
	full_name = "Lâcher l'objet tenu (Précis)"
	description = "Dépose l'objet que vous tenez dans votre main active là où est votre curseur, si c'est à portée."

/datum/keybinding/mob/target/head_cycle
	hotkey_keys = list("Numpad8")
	full_name = "Cibler : Zone Tête et Visage"
	description = "Appuyer sur cette touche cible la tête, puis les yeux, puis la bouche en maintenant appuyé : cela impacte sur l'endroit où vous touchez les gens (et peut être utilisé pour la chirurgie)"

/datum/keybinding/mob/target/head
	hotkey_keys = list(UNBOUND_KEY)
	full_name = "Cible : Tête"
	description = "Appuyer sur cette touche cible la tête : cela impacte sur l'endroit où vous touchez les gens (et peut être utilisé pour la chirurgie)"

/datum/keybinding/mob/target/eyes
	hotkey_keys = list("Numpad7")
	full_name = "Cible : Yeux"
	description = "Appuyer sur cette touche cible les yeux : cela impacte sur l'endroit où vous touchez les gens (et peut être utilisé pour la chirurgie)"

/datum/keybinding/mob/target/mouth
	hotkey_keys = list("Numpad9")
	full_name = "Cible : Bouche"
	description = "Appuyer sur cette touche cible la bouche : cela impacte sur l'endroit où vous touchez les gens (et peut être utilisé pour la chirurgie)"

/datum/keybinding/mob/target/r_arm
	hotkey_keys = list("Numpad4")
	full_name = "Cibler : bras droit"
	description = "Appuyer sur cette touche cible le bras droit : cela impacte sur l'endroit où vous touchez les gens (et peut être utilisé pour la chirurgie"

/datum/keybinding/mob/target/body_chest
	hotkey_keys = list("Numpad5")
	full_name = "Cibler : Torse"
	description = "Appuyer sur cette touche cible le torse : cela impacte sur l'endroit où vous touchez les gens (et peut être utilisé la chirurgie)"

/datum/keybinding/mob/target/left_arm
	hotkey_keys = list("Numpad6")
	full_name = "Cibler : Bras gauche"
	description = "Appuyer sur cette touche cible le bras gauche : cela impacte sur l'endroit où vous touchez les gens (et peut être utilisé pour la chirurgie)"

/datum/keybinding/mob/target/right_leg
	hotkey_keys = list("Numpad1")
	full_name = "Cibler : Jambe droite"
	description = "Appuyer sur cette touche cible la jambe droite : cela impacte sur l'endroit où vous touchez les gens (et peut être utilisé pour la chirurgie)"

/datum/keybinding/mob/target/body_groin
	hotkey_keys = list("Numpad2")
	full_name = "Cibler : Entrejambe"
	description = "Appuyer sur cette touche cible l'entrejambe : cela impacte sur l'endroit où vous touchez les gens (et peut être utilisé pour la chirurgie)"

/datum/keybinding/mob/target/left_leg
	hotkey_keys = list("Numpad3")
	full_name = "Cible : Jambe gauche"
	description = "Appuyer sur cette touche cible la jambe gauche : cela impacte sur l'endroit où vous touchez les gens (et peut être utilisé pour la chirurgie)"

/datum/keybinding/mob/prevent_movement
	hotkey_keys = list("Alt")
	full_name = "Bloquer le mouvement"
	description = "Vous empêche de bouger"
