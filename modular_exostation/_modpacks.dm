SUBSYSTEM_DEF(modpacks)
	name = "Modpacks"
	init_stage = INITSTAGE_FIRST
	flags = SS_NO_FIRE
	var/list/loaded_modpacks = list()

/datum/controller/subsystem/modpacks/Initialize()
	var/list/all_modpacks = list()
	for(var/modpack in subtypesof(/datum/modpack/))
		all_modpacks.Add(new modpack)
	// Pre-init and register all compiled modpacks.
	for(var/datum/modpack/package as anything in all_modpacks)
		var/fail_msg = package.pre_initialize()
		if(QDELETED(package))
			CRASH("Modpack of type [package.type] is null or queued for deletion.")
		if(fail_msg)
			CRASH("Modpack [package.name] failed to pre-initialize: [fail_msg].")
		if(loaded_modpacks[package.name])
			CRASH("Attempted to register duplicate modpack name [package.name].")
		loaded_modpacks.Add(package)

	// Handle init and post-init (two stages in case a modpack needs to implement behavior based on the presence of other packs).
	for(var/datum/modpack/package as anything in all_modpacks)
		var/fail_msg = package.initialize()
		if(fail_msg)
			CRASH("Modpack [(istype(package) && package.name) || "Unknown"] failed to initialize: [fail_msg]")
	for(var/datum/modpack/package as anything in all_modpacks)
		var/fail_msg = package.post_initialize()
		if(fail_msg)
			CRASH("Modpack [(istype(package) && package.name) || "Unknown"] failed to post-initialize: [fail_msg]")

	return SS_INIT_SUCCESS

/client/verb/modpacks_list()
	set name = "Modpacks List"
	set category = "OOC"

	if(!mob || !SSmodpacks.initialized)
		return

	if(length(SSmodpacks.loaded_modpacks))
		. = "<hr><br><center><b><font size = 3>Liste des modifications</font></b></center><br><hr><br>"
		for(var/datum/modpack/M as anything in SSmodpacks.loaded_modpacks)
			if(M.name)
				. += "<div class = 'statusDisplay'>"
				. += "<center><b>[M.name]</b></center>"

				if(M.desc || M.author)
					. += "<br>"
					if(M.desc)
						. += "<br>Description : [M.desc]"
					if(M.author)
						. += "<br><i>Auteur : [M.author]</i>"
				. += "</div><br>"

		var/datum/browser/popup = new(mob, "modpacks_list", "Liste des modifications", 480, 580)
		popup.set_content(.)
		popup.open()
	else
		to_chat(src, "Ce serveur n'utilise aucune modification.")
