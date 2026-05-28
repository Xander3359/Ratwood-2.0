/obj/item/alch
	name = "dust"
	desc = ""
	icon = 'icons/roguetown/misc/alchemy.dmi'
	icon_state = "irondust"
	w_class = WEIGHT_CLASS_TINY
	experimental_inhand = FALSE
	dropshrink = 0.75//way easier to organise on tables like this
	/*
		So, you're here about potions: TLDR - the cauldron takes up to 4 items, from this, makes 1 recipe. Major gives 3 points, med 2 points,minor 1 point.
		If no recipe gets above 5 points, it makes nothing,otherwise It then makes the recipe with the HIGHEST POINTS.
		all 3 of the below variables should be NULL or the type-path of the recipe to make.
	*/
	var/major_pot = null
	var/med_pot = null
	var/minor_pot = null
	//Dont worry, these 3 are just to cache the 'smell' of their pot on initialization to not have to re-look every examine.
	//No need to set them.
	var/major_smell
	var/med_smell
	var/minor_smell
	///Same as the smells, just caching what the potion name is
	var/major_name
	var/med_name
	var/minor_name

/obj/item/alch/Initialize(mapload)
	. = ..()
	if(!isnull(major_pot))
		var/datum/alch_cauldron_recipe/rec = locate(major_pot) in GLOB.alch_cauldron_recipes
		major_smell = rec.smells_like
		major_name = rec.name
	if(!isnull(med_pot))
		var/datum/alch_cauldron_recipe/rec = locate(med_pot) in GLOB.alch_cauldron_recipes
		med_smell = rec.smells_like
		med_name = rec.name
	if(!isnull(minor_pot))
		var/datum/alch_cauldron_recipe/rec = locate(minor_pot) in GLOB.alch_cauldron_recipes
		minor_smell = rec.smells_like
		minor_name = rec.name

/obj/item/alch/examine(mob/user)
	. = ..()
	if(user.mind)
		var/alch_skill = user.get_skill_level(/datum/skill/craft/alchemy)
		var/perint = 0
		if(isliving(user))
			var/mob/living/lmob = user
			perint = FLOOR((lmob.STAPER + lmob.STAINT)/2,1)
		if(HAS_TRAIT(user,TRAIT_LEGENDARY_ALCHEMIST))
			if(!isnull(major_name))
				. += span_notice(" Strongly attuned to making [major_name].")
			if(!isnull(med_name))
				. += span_notice(" Moderately attuned to making [med_name].")
			if(!isnull(minor_name))
				. += span_notice(" Minorly attuned to making [minor_name].")
		else
			if(!isnull(major_smell))
				if(alch_skill >= SKILL_LEVEL_NOVICE || perint >= 6)
					. += span_notice(" Smells strongly of [major_smell].")
			if(!isnull(med_smell))
				if(alch_skill >= SKILL_LEVEL_APPRENTICE || perint >= 10)
					. += span_notice(" Smells slightly of [med_smell].")
			if(!isnull(minor_smell))
				if(alch_skill >= SKILL_LEVEL_EXPERT || perint >= 16)
					. += span_notice(" Smells weakly of [minor_smell].")
