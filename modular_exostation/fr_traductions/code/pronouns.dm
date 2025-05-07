// MARK: Helper procs
/// Singulier ou pluriel des mots (articles et genre des articles, etc.)
/proc/declension_fr(num, single_name, double_name, multiple_name)
	if(!isnum(num) || round(num) != num)
		return double_name // fractional numbers
	if(((num % 10) == 1) && ((num % 100) != 11)) // 1, not 11
		return single_name
	if(((num % 10) in 2 to 4) && !((num % 100) in 12 to 14)) // 2, 3, 4, not 12, 13, 14
		return double_name
	return multiple_name // 5, 6, 7, 8, 9, 0

/**
 * AVERTISSEMENT : ne pas utiliser ce proc, utiliser genderize_decode !
 *
 * Pour passer de masculin à féminin, neutre et pluriel sur des mots (déterminants, par exemple) en fonction de la source (problème : en français mots accordés avec objet déterminé & le féminin pluriel)
 *
*/
/proc/genderize_fr(gender, male_word, female_word, neuter_word, f_multiple_word, multiple_word)
	switch(gender)
		if(MALE)
			return male_word
		if(FEMALE)
			return female_word
		if(NEUTER)
			return neuter_word
    if (F_PLURAL)
      return f_multiple_word
		else
			return multiple_word

/**
 * AVERTISSEMENT : ne pas utiliser ce proc, utiliser genderize_decode !
 *
 * Pour passer de singulier vers pluriel sur les verbes
 *
*/
/proc/pluralize_fr(gender, single_word, plural_word)
	return gender == PLURAL ? plural_word : single_word

/**
 * Replaces the `%(SINGLE,PLURAL)%` or `%(MALE,FEMALE,NEUTER,PLURAL)%` message piece accordingly to user gender.
 * Use `*` to deliberatly skip one genderize word: `%(*,FEMALE,*,PLURAL)%`.
 *
 * Example: var/death_message = genderize_decode(user, "mang%(e,ent)% des patates dans l'assiette qu'%(il,elle,iel,ils) ont fait %(lui,elle,ellui,elles,eux)%-même...")
 *
 * Arguments:
 * * user - Person which pronouns will be used.
 * * msg - The string to modify.
 *
 * Returns the modified msg string.
 *
 */
/proc/genderize_decode(atom/target, msg)
	if(!isatom(target) || !istext(msg))
		stack_trace("Invalid arguments in genderize_decode proc.")
	while(TRUE)
		var/prefix = findtext_char(msg, "%(")
		if(!prefix)
			break
		var/postfix = findtext_char(msg, ")%")
		if(!postfix)
			stack_trace("Genderize string is missing proper ending, expected )%.")
		var/list/pieces = splittext(copytext_char(msg, prefix + 2, postfix), ",")
		switch(length(pieces))
			// Pluralize if only two parts present
			if(2)
				msg = replacetext(splicetext_char(msg, prefix, postfix + 2, pluralize_fr(target.gender, pieces[1], pieces[2])), "*", "")
			// Use full genderize if all four parts exist
			if(5)
				msg = replacetext(splicetext_char(msg, prefix, postfix + 2, genderize_fr(target.gender, pieces[1], pieces[2], pieces[3], pieces[4], pieces[5])), "*", "")
			else
				stack_trace("Invalid data sent to genderize_decode proc.")
	return msg

//////////////////////////////
// MARK: Pronouns
//////////////////////////////
/// Применяет одно из "они", "оно", "он", или "она" в зависимости от пола. Установите TRUE для заглавной буквы.
/datum/proc/fr_p_they(capitalized, temp_gender)
	. = "оно"
	if(capitalized)
		. = capitalize(.)

/// Применяет одно из "их", "его", или "её" в зависимости от пола. Установите TRUE для заглавной буквы.
/datum/proc/fr_p_them(capitalized, temp_gender)
	. = "их"
	if(capitalized)
		. = capitalize(.)

/// Применяет одно из "сами", "само", "сам", или "сама" в зависимости от пола. Установите TRUE для заглавной буквы.
/datum/proc/fr_p_themselves(capitalized, temp_gender)
	. = "само"

/// Применяет одно из "них", "него", "него", или "нее" в зависимости от пола. Установите TRUE для заглавной буквы.
/datum/proc/fr_p_theirs(capitalized, temp_gender)
	. = "него"

/// Применяет "имеет" для единственного числа и "имеют" для множественного ("она имеет" / "они имеют").
/datum/proc/fr_p_have(temp_gender)
	. = "имеет"

/// Применяет "было" для единственного числа и "были" для множественного ("оно было" / "они были").
/datum/proc/fr_p_were(temp_gender)
	. = "было"

/// Применяет "делает" для единственного числа и "делают" для множественного ("она делает" / "они делают").
/datum/proc/fr_p_do(temp_gender)
	. = "делает"

//////////////////////////////
// MARK: Client pronouns
//////////////////////////////
// Like clients, which do have gender.
/client/fr_p_they(capitalized, temp_gender)
	if(!temp_gender)
		temp_gender = gender
	. = "они"
	switch(temp_gender)
		if(MALE)
			. = "он"
		if(FEMALE)
			. = "она"
		if(NEUTER)
			. = "оно"
	if(capitalized)
		. = capitalize(.)

/client/fr_p_them(capitalized, temp_gender)
	if(!temp_gender)
		temp_gender = gender
	. = "их"
	switch(temp_gender)
		if(MALE)
			. = "его"
		if(FEMALE)
			. = "её"
	if(capitalized)
		. = capitalize(.)

/client/fr_p_themselves(capitalized, temp_gender)
	if(!temp_gender)
		temp_gender = gender
	switch(temp_gender)
		if(MALE)
			. = "сам"
		if(FEMALE)
			. = "сама"
		if(NEUTER)
			. = "само"
		if(PLURAL)
			. = "сами"
	if(capitalized)
		. = capitalize(.)

/client/fr_p_theirs(capitalized, temp_gender)
	if(!temp_gender)
		temp_gender = gender
	switch(temp_gender)
		if(MALE)
			. = "него"
		if(FEMALE)
			. = "нее"
		if(NEUTER)
			. = "него"
		if(PLURAL)
			. = "них"
	if(capitalized)
		. = capitalize(.)

/client/fr_p_have(temp_gender)
	if(!temp_gender)
		temp_gender = gender
	. = "имеет"
	if(temp_gender == PLURAL)
		. = "имеют"

/client/fr_p_were(temp_gender)
	if(!temp_gender)
		temp_gender = gender
	. = "был"
	switch(temp_gender)
		if(FEMALE)
			. = "была"
		if(NEUTER)
			. = "было"
		if(PLURAL)
			. = "были"

/client/fr_p_do(temp_gender)
	if(!temp_gender)
		temp_gender = gender
	. = "делает"
	if(temp_gender == PLURAL)
		. = "делают"

//////////////////////////////
// MARK: Mob pronouns
//////////////////////////////
// Mobs (and atoms but atoms don't really matter write your own proc overrides) also have gender!
/mob/fr_p_they(capitalized, temp_gender)
	if(!temp_gender)
		temp_gender = gender
	. = "они"
	switch(temp_gender)
		if(MALE)
			. = "он"
		if(FEMALE)
			. = "она"
		if(NEUTER)
			. = "оно"
	if(capitalized)
		. = capitalize(.)

/mob/fr_p_them(capitalized, temp_gender)
	if(!temp_gender)
		temp_gender = gender
	. = "их"
	switch(temp_gender)
		if(MALE)
			. = "его"
		if(FEMALE)
			. = "её"
	if(capitalized)
		. = capitalize(.)

/mob/fr_p_themselves(capitalized, temp_gender)
	if(!temp_gender)
		temp_gender = gender
	switch(temp_gender)
		if(MALE)
			. = "сам"
		if(FEMALE)
			. = "сама"
		if(NEUTER)
			. = "само"
		if(PLURAL)
			. = "сами"
	if(capitalized)
		. = capitalize(.)

/mob/fr_p_theirs(capitalized, temp_gender)
	if(!temp_gender)
		temp_gender = gender
	switch(temp_gender)
		if(MALE)
			. = "него"
		if(FEMALE)
			. = "нее"
		if(NEUTER)
			. = "него"
		if(PLURAL)
			. = "них"
	if(capitalized)
		. = capitalize(.)

/mob/fr_p_have(temp_gender)
	if(!temp_gender)
		temp_gender = gender
	. = "имеет"
	if(temp_gender == PLURAL)
		. = "имеют"

/mob/fr_p_were(temp_gender)
	if(!temp_gender)
		temp_gender = gender
	. = "был"
	switch(temp_gender)
		if(FEMALE)
			. = "была"
		if(NEUTER)
			. = "было"
		if(PLURAL)
			. = "были"

/mob/fr_p_do(temp_gender)
	if(!temp_gender)
		temp_gender = gender
	. = "делает"
	if(temp_gender == PLURAL)
		. = "делают"

//////////////////////////////
// MARK: Human pronouns
//////////////////////////////
// Humans need special handling, because they can have their gender hidden
/mob/living/carbon/human/fr_p_they(capitalized, temp_gender)
	var/obscured = check_obscured_slots()
	var/skipface = (wear_mask && (wear_mask.flags_inv & HIDEFACE)) || (head && (head.flags_inv & HIDEFACE))
	if((obscured & ITEM_SLOT_ICLOTHING) && skipface)
		temp_gender = PLURAL
	return ..()

/mob/living/carbon/human/fr_p_them(capitalized, temp_gender)
	var/obscured = check_obscured_slots()
	var/skipface = (wear_mask && (wear_mask.flags_inv & HIDEFACE)) || (head && (head.flags_inv & HIDEFACE))
	if((obscured & ITEM_SLOT_ICLOTHING) && skipface)
		temp_gender = PLURAL
	return ..()

/mob/living/carbon/human/fr_p_themselves(capitalized, temp_gender)
	var/obscured = check_obscured_slots()
	var/skipface = (wear_mask && (wear_mask.flags_inv & HIDEFACE)) || (head && (head.flags_inv & HIDEFACE))
	if((obscured & ITEM_SLOT_ICLOTHING) && skipface)
		temp_gender = PLURAL
	return ..()

/mob/living/carbon/human/fr_p_theirs(capitalized, temp_gender)
	var/obscured = check_obscured_slots()
	var/skipface = (wear_mask && (wear_mask.flags_inv & HIDEFACE)) || (head && (head.flags_inv & HIDEFACE))
	if((obscured & ITEM_SLOT_ICLOTHING) && skipface)
		temp_gender = PLURAL
	return ..()

/mob/living/carbon/human/fr_p_have(temp_gender)
	var/obscured = check_obscured_slots()
	var/skipface = (wear_mask && (wear_mask.flags_inv & HIDEFACE)) || (head && (head.flags_inv & HIDEFACE))
	if((obscured & ITEM_SLOT_ICLOTHING) && skipface)
		temp_gender = PLURAL
	return ..()

/mob/living/carbon/human/fr_p_were(temp_gender)
	var/obscured = check_obscured_slots()
	var/skipface = (wear_mask && (wear_mask.flags_inv & HIDEFACE)) || (head && (head.flags_inv & HIDEFACE))
	if((obscured & ITEM_SLOT_ICLOTHING) && skipface)
		temp_gender = PLURAL
	return ..()

/mob/living/carbon/human/fr_p_do(temp_gender)
	var/obscured = check_obscured_slots()
	var/skipface = (wear_mask && (wear_mask.flags_inv & HIDEFACE)) || (head && (head.flags_inv & HIDEFACE))
	if((obscured & ITEM_SLOT_ICLOTHING) && skipface)
		temp_gender = PLURAL
	return ..()

/atom/proc/fr_p_yours(declent = NOMINATIVE)
	var/static/list/fr_names_male
	var/static/list/fr_names_female
	var/static/list/fr_names_neuter
	var/static/list/fr_names_plural
	if(isnull(fr_names_male))
		fr_names_male = fr_names_toml("ваш")
		fr_names_female = fr_names_toml("ваша")
		fr_names_neuter = fr_names_toml("ваше")
		fr_names_plural = fr_names_toml("ваши")

	switch(gender)
		if(FEMALE)
			return fr_names_female[declent] || "ваша"
		if(NEUTER)
			return fr_names_neuter[declent] || "ваше"
		if(PLURAL)
			return fr_names_plural[declent] || "ваши"
		else
			return fr_names_male[declent] || "ваш"

/atom/proc/fr_p_own(declent = NOMINATIVE)
	var/static/list/fr_names_male
	var/static/list/fr_names_female
	var/static/list/fr_names_neuter
	var/static/list/fr_names_plural
	if(isnull(fr_names_male))
		fr_names_male = fr_names_toml("свой")
		fr_names_female = fr_names_toml("своя")
		fr_names_neuter = fr_names_toml("своё")
		fr_names_plural = fr_names_toml("свои")
	switch(gender)
		if(FEMALE)
			return fr_names_female[declent] || "своя"
		if(NEUTER)
			return fr_names_neuter[declent] || "своё"
		if(PLURAL)
			return fr_names_plural[declent] || "свои"
		else
			return fr_names_male[declent] || "свой"
