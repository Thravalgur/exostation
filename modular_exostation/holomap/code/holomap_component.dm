/**
 * An attempt at figuring out how to make holomaps into a component.
 */
/datum/action/toggle_holomap
	name = "Toggle Holomap"
	desc = "Faire apparaître une carte holographique de la station, avec divers marqueurs utiles."
	button_icon = 'modular_exostation/holomap/icons/32x32.dmi'
	button_icon_state = "map"
	check_flags = AB_CHECK_CONSCIOUS
	var/atom/holder = null
	var/datum/component/holomap/newholomap = null

/datum/action/toggle_holomap/Trigger(trigger_flags)
	toggle_summon(holder)

/datum/action/toggle_holomap/proc/toggle_summon(mob/living/user)
	if(!newholomap)
		return FALSE
	else
		user = holder.loc //Alright, seems like they clicked the item's action instead.
	newholomap.summon_holomap(user)

/datum/component/holomap
	var/datum/action/toggle_holomap/holobutton = new
	/// The various images and icons for the map are stored in here, as well as the actual big map itself.
	var/datum/station_holomap/holomap_datum
	/// The mob that is currently watching the holomap.
	var/mob/watching_mob
	// zLevel which the pda is showing a map for.
	var/current_z_level
	var/holomap_visible = FALSE // Whether the holomap is visible or not.
	/// This set to FALSE when the station map is initialized on a zLevel that has its own icon formatted for use by station holomaps.
	var/bogus = TRUE

/datum/component/holomap/engineering

/datum/component/holomap/Initialize()
	. = ..()
	if(!isatom(parent) || !isitem(parent))
		return COMPONENT_INCOMPATIBLE

	if(isatom(parent))
		holobutton.holder = parent
		holobutton.newholomap = src

	if(istype(parent, /obj/item))
		var/obj/item/holder = parent
		RegisterSignal(holder, COMSIG_ITEM_EQUIPPED, PROC_REF(on_equip))
		RegisterSignal(holder, COMSIG_ITEM_DROPPED, PROC_REF(on_drop))
		if(isliving(holder.loc)) //Account for items pre-spawned on people...
			on_equip(holder, holder.loc, null)
		return

/datum/component/holomap/proc/get_user()
	RETURN_TYPE(/mob/living)
	var/atom/movable/holder = parent
	return (isliving(holder) || !isatom(holder)) ? holder : holder.loc //FIXME - This proc is terrible (and can runtime). Just save the user and track if they get del'd like a sane person. Why is this like this??????

/datum/component/holomap/proc/on_equip(datum/source, mob/equipper, slot)
	if(!(source || equipper))
		return
	if(slot && slot == ITEM_SLOT_BACKPACK)
		on_drop(source, equipper)
		return
	holobutton.Grant(equipper)

/datum/component/holomap/proc/on_drop(datum/source, mob/user)
	holobutton.Remove(user)

/datum/component/holomap/Destroy(force, silent)
	. = ..()
	if(holomap_visible)
		deactivate_holomap(get_user())
	if(holobutton)
		holobutton.holder = null
		holobutton.newholomap = null
		QDEL_NULL(holobutton)
	if(holomap_datum)
		QDEL_NULL(holomap_datum)

// Activate and deactivate holomap

/datum/component/holomap/proc/summon_holomap(datum/user)
	if(holomap_visible)
		deactivate_holomap(user)
	else
		activate_holomap(user)

/datum/component/holomap/engineering/summon_holomap(datum/user)
	. = ..()
	if(.)
		holomap_datum.update_map(handle_overlays())

// Handle overlays

/datum/component/holomap/proc/handle_overlays()
	// Each entry in this list contains the text for the legend, and the icon and icon_state use. Null or non-existent icon_state ignore hiding logic.
	// If an entry contains an icon,
	var/list/legend = list() + GLOB.holomap_default_legend

	var/list/z_transitions = SSholomaps.holomap_z_transitions["[current_z_level]"]
	if(length(z_transitions))
		legend += z_transitions
	if(SSshuttle.emergency && (SSshuttle.emergency.mode in list(SHUTTLE_CALL, SHUTTLE_DOCKED, SHUTTLE_IGNITING)))
		var/list/escape_pods = SSholomaps.holomap_pod_locations["[current_z_level]"]
		if(length(escape_pods))
			legend += escape_pods
	return legend

/datum/component/holomap/engineering/handle_overlays()
	var/list/extra_overlays = ..()
	if(bogus)
		return extra_overlays

	var/list/fire_alarms = list()
	for(var/obj/machinery/firealarm/alarm as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/airalarm))
		if(alarm?.z == current_z_level && alarm?.my_area?.active_alarms[ALARM_FIRE])
			var/image/alarm_icon = image('modular_exostation/holomap/icons/8x8.dmi', "fire_marker")
			alarm_icon.pixel_x = alarm.x + HOLOMAP_CENTER_X - 1
			alarm_icon.pixel_y = alarm.y + HOLOMAP_CENTER_Y
			fire_alarms += alarm_icon

	if(length(fire_alarms))
		extra_overlays["Fire Alarms"] = list("icon" = image('modular_exostation/holomap/icons/8x8.dmi', "fire_marker"), "markers" = fire_alarms)

	var/list/air_alarms = list()
	for(var/obj/machinery/airalarm/air_alarm as anything in SSmachines.get_machines_by_type_and_subtypes(/obj/machinery/airalarm))
		if(air_alarm?.z == current_z_level && air_alarm?.my_area?.active_alarms[ALARM_ATMOS])
			var/image/alarm_icon = image('modular_exostation/holomap/icons/8x8.dmi', "atmos_marker")
			alarm_icon.pixel_x = air_alarm.x + HOLOMAP_CENTER_X - 1
			alarm_icon.pixel_y = air_alarm.y + HOLOMAP_CENTER_Y
			air_alarms += alarm_icon

	if(length(air_alarms))
		extra_overlays["Air Alarms"] = list("icon" = image('modular_exostation/holomap/icons/8x8.dmi', "atmos_marker"), "markers" = air_alarms)

	return extra_overlays

/datum/component/holomap/proc/activate_holomap(mob/user)
	var/turf/current_turf = get_turf(user.client.eye)
	current_z_level = current_turf.z
	holomap_datum = new()
	bogus = FALSE
	if(!("[HOLOMAP_EXTRA_STATIONMAP]_[current_z_level]" in SSholomaps.extra_holomaps))
		bogus = TRUE
		holomap_datum.initialize_holomap_bogus()
		return

	holomap_datum.initialize_holomap(current_turf.x, current_turf.y, current_z_level, reinit_base_map = TRUE, extra_overlays = handle_overlays())

	holomap_datum.update_map(handle_overlays())

	var/datum/hud/human/user_hud = user.hud_used
	holomap_datum.base_map.loc = user_hud.holomap  // Put the image on the holomap hud
	playsound(user, 'modular_exostation/holomap/sounds/holomap_open.ogg', 125)

	user.hud_used.holomap.used_station_map = src
	user.hud_used.holomap.mouse_opacity = MOUSE_OPACITY_ICON
	user.client.screen |= user.hud_used.holomap
	user.client.images |= holomap_datum.base_map

	watching_mob = user
	holomap_visible = TRUE
	if(bogus)
		to_chat(user, span_warning("L'holomap n'a pas pu être initialisée : emplacement impossible à cartographier."))
	else
		to_chat(user, span_notice("Un hologramme de la station apparaît devant vos yeux."))
	return TRUE

/datum/component/holomap/proc/deactivate_holomap(mob/user)
	if(!watching_mob)
		return
	holomap_visible = FALSE
	playsound(user, 'modular_exostation/holomap/sounds/holomap_close.ogg', 125)
	if(watching_mob?.client)
		watching_mob.client?.screen -= watching_mob.hud_used.holomap
		watching_mob.client?.images -= holomap_datum.base_map
		watching_mob.hud_used.holomap.used_station_map = null
		watching_mob = null
	holomap_datum.clear_holomap()
	return TRUE
