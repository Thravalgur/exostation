/datum/keybinding/living/resist
	hotkey_keys = list("R") //Original B
	full_name = "Résister"
	description = "Se débarasser de votre situation actuelle. Attaché ? En feu ? Résistez !"

/datum/keybinding/living/look_up
	hotkey_keys = list("ShiftZ") //Original L
	full_name = "Regarder en haut"
	description = "Regarder en haut, au z-niveau supérieur. Ne marche qu'au dessous du vide."

/datum/keybinding/living/look_down
	hotkey_keys = list("ShiftS") //Original ;
	full_name = "Regarder en bas"
	description = "Regarder en bas, au z-niveau inférieur. Ne marche qu'au dessus du vide."

/datum/keybinding/living/rest
	hotkey_keys = list("B") //Original U
	full_name = "Se coucher"
	description = "S'allonger, ou se mettre debout."

/datum/keybinding/living/toggle_combat_mode
	hotkey_keys = list("F")
	full_name = "Activer/Désactiver le mode Combat"
	description = "Active ou désactive le mode Combat."

/datum/keybinding/living/enable_combat_mode
	hotkey_keys = list(UNBOUND_KEY) //Original 4
	full_name = "Activer le mode Combat"
	description = "Active le mode Combat."

/datum/keybinding/living/disable_combat_mode
	hotkey_keys = list(UNBOUND_KEY) //Original 1
	full_name = "Activer/Désactiver le mode Combat"
	description = "Active ou désactive le mode Combat."

/datum/keybinding/living/toggle_move_intent
	hotkey_keys = list("C")
	full_name = "Échanger le mode de déplacement"
	description = "Garder cette touche appuyée échange votre mode de déplacement, et la relâcher désactive ce mode"

/datum/keybinding/living/toggle_move_intent_alternative
	hotkey_keys = list("ShiftC") //Original Unbound
	full_name = "Inverser le mode de déplacement"
	description = "Inverse votre mode de déplacement, sans retour arrière."

/datum/keybinding/living/toggle_throw_mode
	hotkey_keys = list("Southwest") // Original: R, Southwest
	full_name = "Active/Désactive le mode Lancer"
	description = "Active/Désactive le mode lancer pour l'objet actuel."

/datum/keybinding/living/hold_throw_mode
	hotkey_keys = list("Space")
	full_name = "Rester en mode Lancer"
	description = "Garder cette touche appuyée active le mode lancer, et la relâcher désactive ce mode"

/datum/keybinding/living/give
	hotkey_keys = list("G")
	full_name = "Offrir un objet"
	description = "Offre l'objet que vous tenez actuellement à toutes les personnes autour"

/datum/keybinding/living/view_pet_data
	hotkey_keys = list("Shift")
	full_name = "Voir les ordres pour animaux"
	description = "Appuyer sur cette touche pour voir tous les ordres que vous pouvez donner à vos  animaux de compagnie."

/datum/keybinding/living/cancel_interactions
	full_name = "Cancel Interactions"
	description = "Cancels any ongoing interactions (such as using a tool, performing surgery, or climbing). \
		Note that some interactions cannot be interrupted, and you can't cancel other player's interaction with this hotkey."
