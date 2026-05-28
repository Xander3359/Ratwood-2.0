//Poisons
/* Tested this quite a bit. Heres the deal. Metabolism REAGENTS_SLOW_METABOLISM is 0.1 and needs to be that so poison isnt too fast working but
still is dangerous. Toxloss of 3 at metabolism 0.1 puts you in dying early stage then stops for reference of these values.
A dose of ingested potion is defined as 5u, projectile deliver at most 2u, you already do damage with projectile, a bolt can only feasible hold a tiny amount of poison, so much easier to deliver than ingested and so on.
If you want to expand on poisons theres tons of fun effects TG chemistry has that could be added, randomzied damage values for more unpredictable poison, add trait based resists instead of the clunky race check etc.*/

/datum/reagent/berrypoison	// Weaker poison, balanced to make you wish for death and incapacitate but not kill
	name = "Berry Poison"
	description = ""
	reagent_state = LIQUID
	color = "#47b2e0"
	taste_description = "bitterness"
	metabolization_rate = 0.1 * REAGENTS_METABOLISM
	harmful = TRUE

/datum/reagent/berrypoison/on_mob_life(mob/living/carbon/M)
	if(volume > 0.09)
		if(isdwarf(M))
			M.add_nausea(1)
			M.adjustToxLoss(0.5)
		else
			M.add_nausea(3) // so one berry or one dose (one clunk of extracted poison, 5u) will make you really sick and a hair away from crit.
			M.adjustToxLoss(2)
	return ..()


/datum/reagent/strongpoison		// Strong poison, meant to be somewhat difficult to produce using alchemy or spawned with select antags. Designed to kill in one full dose (5u) better drink antidote fast
	name = "Strong Poison"
	description = ""
	reagent_state = LIQUID
	color = "#1a1616"
	taste_description = "burning"
	metabolization_rate = 0.1 * REAGENTS_METABOLISM
	harmful = TRUE

/datum/reagent/strongpoison/on_mob_life(mob/living/carbon/M)
	testing("Someone was poisoned")
	if(volume > 0.09)
		if(isdwarf(M))
			M.add_nausea(1)
			M.adjustToxLoss(2.3)  // will put you just above dying crit treshold
		else
			M.add_nausea(6) //So a poison bolt (2u) will eventually cause puking at least once
			M.adjustToxLoss(4.5) // just enough so 5u will kill you dead with no help
	return ..()

/datum/reagent/bloodacid // Quietus Poison for Vampires
	name = "Vitae Acid"
	description = ""
	reagent_state = LIQUID
	color = "#ff3300"
	taste_description = "burning"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	harmful = TRUE

/datum/reagent/bloodacid/on_mob_life(mob/living/carbon/M)
	if(volume > 0.09)
		if(isdwarf(M))
			M.add_nausea(5.5)
			M.adjustToxLoss(7.5)
			to_chat(M, span_userdanger("MY HEART! I'VE BEEN POISONED."))
			M.playsound_local('sound/magic/heartbeat.ogg', 50)
		else
			M.add_nausea(6.5)
			M.adjustToxLoss(8.5)
			to_chat(M, span_userdanger("MY HEART! I'VE BEEN POISONED."))
			M.playsound_local('sound/magic/heartbeat.ogg', 50)
	return ..()

/datum/reagent/organpoison
	name = "Organ Poison"
	description = ""
	reagent_state = LIQUID
	color = "#2c1818"
	taste_description = "sour meat"
	metabolization_rate = 0.1 * REAGENTS_METABOLISM
	harmful = TRUE


/datum/reagent/organpoison/on_mob_life(mob/living/carbon/M)
	if(!HAS_TRAIT(M, TRAIT_NASTY_EATER) && !HAS_TRAIT(M, TRAIT_ORGAN_EATER))
		M.add_nausea(9)
		M.adjustToxLoss(2)
	return ..()

/datum/reagent/stampoison
	name = "Stamina Poison"
	description = ""
	reagent_state = LIQUID
	color = "#083b1c"
	taste_description = "breathlessness"
	metabolization_rate = 0.1 * REAGENTS_METABOLISM * 3
	harmful = TRUE


/datum/reagent/stampoison/on_mob_life(mob/living/carbon/M)
	if(!HAS_TRAIT(M,TRAIT_INFINITE_STAMINA))
		M.energy_add(-45) //Slowly leech energy
	return ..()

/datum/reagent/strongstampoison
	name = "Strong Stamina Poison"
	description = ""
	reagent_state = LIQUID
	color = "#041d0e"
	taste_description = "frozen air"
	metabolization_rate = 0.1 * REAGENTS_METABOLISM * 9
	harmful = TRUE


/datum/reagent/strongstampoison/on_mob_life(mob/living/carbon/M)
	if(!HAS_TRAIT(M,TRAIT_INFINITE_STAMINA))
		M.energy_add(-180) //Rapidly leech energy
	return ..()

/datum/reagent/toxin/killersice
	name = "Killer's Ice"
	description = ""
	reagent_state = LIQUID
	color = "#c8c9e9"
	metabolization_rate = 0.1
	toxpwr = 0
	harmful = TRUE

/datum/reagent/toxin/killersice/on_mob_life(mob/living/carbon/M)
	M.adjustToxLoss(20, 0)
	return ..()

//Potion reactions
/datum/chemical_reaction/alch/vitae_essence
	name = "Vitae Decoction"
	id = /datum/reagent/medicine/vitae_essence
	results = list(/datum/reagent/medicine/vitae_essence = 1)
	required_reagents = list(/datum/reagent/vitae = 1, /datum/reagent/toxin/fyritiusnectar = 5)
	mix_message = "The cauldron glows for a moment."

/*----------\
|Ingredients|
\----------*/
/datum/reagent/undeadash
	name = "Spectral Powder"
	description = ""
	reagent_state = SOLID
	color = "#330066"
	taste_description = "tombstones"
	metabolization_rate = 0.1

/datum/reagent/toxin/fyritiusnectar
	name = "fyritius nectar"
	description = "oh no"
	reagent_state = LIQUID
	color = "#ffc400"
	metabolization_rate = 0.5
	harmful = TRUE

/datum/reagent/toxin/fyritiusnectar/on_mob_life(mob/living/carbon/M)
	if(volume > 0.49)
		M.add_nausea(9)
		M.adjustFireLoss(2, 0)
		M.adjust_fire_stacks(1)
		M.ignite_mob()
	return ..()
//I'm stapling our infection reagents on the bottom, because IDEK where else to put them.

/datum/reagent/infection
	name = "excess choleric humour"
	description = "Red-yellow pustulence - the carrier of disease, the enemy of all Pestrans."
	reagent_state = LIQUID
	color = "#dfe36f"
	metabolization_rate = 0.1
	var/damage_tick = 0.3
	var/lethal_fever = FALSE
	var/fever_multiplier = 1

/datum/reagent/infection/on_mob_life(mob/living/carbon/M)
	var/heat = (BODYTEMP_AUTORECOVERY_MINIMUM + clamp(volume, 3, 15)) * fever_multiplier
	M.adjustToxLoss(damage_tick, 0)
	if (lethal_fever)
		M.adjust_bodytemperature(heat, 0)
		if (prob(5))
			to_chat(M, span_warning("A wicked heat settles within me... I feel ill. Very ill."))
	else
		M.adjust_bodytemperature(heat, 0, BODYTEMP_HEAT_DAMAGE_LIMIT - 1)
		if (prob(5))
			to_chat(M, span_warning("I feel a horrible chill despite the sweat rolling from my brow..."))
	return ..()

/datum/reagent/infection/minor
	name = "disrupted choleric humor"
	description = "Symptomatic of disrupted humours."
	damage_tick = 0.1
	lethal_fever = FALSE

/datum/reagent/infection/major
	name = "excess melancholic humour"
	description = "Kingsfield's Bane. Excess melancholic has killed thousands, and even Pestra's greatest struggle against its insidious advance."
	damage_tick = 1
	lethal_fever = TRUE
	fever_multiplier = 3

/datum/reagent/infection/major/on_mob_life(mob/living/carbon/M)
	if (M.badluck(1))
		M.reagents.add_reagent(src, rand(1,3))
		to_chat(M, span_small("I feel even worse..."))
	return ..()


/datum/reagent/medicine/vitae_essence
	name = "Vitae Decoction"
	description = "Decoction of essence of lyfe, used to restore one's lux humours."
	color = "#67c7ff" // rgb: 96, 165, 132
	overdose_threshold = 10
	metabolization_rate = 0.1

/datum/reagent/medicine/vitae_essence/on_mob_life(mob/living/carbon/M)
	if(M.has_flaw(/datum/charflaw/addiction/junkie))
		M.sate_addiction(/datum/charflaw/addiction/junkie)
	if(M.has_status_effect(/datum/status_effect/debuff/ritualdefiled))
		M.remove_status_effect(/datum/status_effect/debuff/ritualdefiled)
	return ..()

/datum/reagent/fire_resist
	name = "Fire Resistance"
	color = "#ff7300"
	taste_description = "burning coal"

/datum/reagent/fire_resist/on_mob_life(mob/living/carbon/M)
	M.apply_status_effect(/datum/status_effect/buff/alch/fire_resist)
	return ..()

/datum/reagent/fermented_crab
	name = "Fermented Crab"
	description = ""
	color = "#abaa7c"
	overdose_threshold = 15
	metabolization_rate = 0.2
	taste_description = "randcid, putrid crab"

/datum/reagent/fermented_crab/overdose_process(mob/living/M)
	M.adjustToxLoss(1, FALSE)
	if(iscarbon(M) && prob(1))
		var/mob/living/carbon/carbon_consumer = M
		carbon_consumer.vomit(1)
	return ..()

/datum/reagent/fermented_crab/on_mob_metabolize(mob/living/M)
	var/mob/living/carbon/carbon_consumer = M
	if(!istype(carbon_consumer))
		return ..()
	to_chat(M, span_userdanger("That fermented crab was truly rancid... You feel..."))
	// Default chance to vomit with WIL 12 - 40%
	// With WIL 10 - 48%; With WIL 14 - 32% and so on.
	if(prob(40 - ((M.STAWIL - 12) * 4)))
		to_chat(M, span_userdanger("You suddenly feel very sick... Mayhaps, eating the fermented crab wasn't the best idea..."))
		carbon_consumer.vomit(5, blood = FALSE, stun = TRUE)
		M.add_stress(/datum/stressevent/fermented_crab_bad)
	else
		to_chat(M, span_userdanger("You feel a bit queasy, but otherwise okay. And even greatly invigorated!"))
		M.add_stress(/datum/stressevent/fermented_crab_good)
	M.apply_status_effect(/datum/status_effect/buff/fermented_crab)
	return ..()

/datum/reagent/fermented_crab/overdose_start(mob/living/M)
	M.playsound_local(M, 'sound/magic/heartbeat.ogg', 100, FALSE)
	M.visible_message(span_warning("Blood runs from [M]'s nose."))
