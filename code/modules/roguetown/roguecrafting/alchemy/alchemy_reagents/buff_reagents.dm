/* Buff potions
	Previously, it would apply a status effect to the mob lasting for 93 / 300 seconds and remove everything
	However it meant that putting it in an alchemical vial was a trap as it sipped 9 units instead of 5 units that is the required minimum.
	And removed any excessive potion inside the body. This has been changed to apply a 3 seconds buff to the mob, but have much lower
	metabolization rate, so that the duration of the buff depends on how long you last.
	Roughly tested. At Metabolization Rate 1. 10 units sip (1/3 of a vial) last 20 seconds.
	To make this somewhat equal to the old system, base metabolization rate is 0.1 - making it last 200 seconds - 600 seconds if you sip an entire vial.
	This is 2x on weaker potions (Intelligence, Fortune). However, overdose threshold is now 30 units so you can only drink one vial at once.
	And potion stacking is not possible without neutralizing itself.
*/
/datum/reagent/buff
	description = ""
	reagent_state = LIQUID
	metabolization_rate = REAGENTS_METABOLISM * 0.1
	overdose_threshold = 33

/datum/reagent/buff/overdose_process(mob/living/carbon/M)
	. = ..()
	M.Jitter(2)
	if(!HAS_TRAIT(M, TRAIT_CRACKHEAD)) // Baothan get to stack more of one potion in their body, but not multiple
		M.adjustToxLoss(3)

/datum/reagent/buff/on_mob_life(mob/living/carbon/M)
	for(var/datum/reagent/R in M.reagents.reagent_list)
		if(istype(R, /datum/reagent/buff) && R != src)
			holder.remove_reagent(R.type, 10)
			// Rapidly purge stacking buffs
	..()

/datum/reagent/buff/temperature_normalize
	name = "temperature"
	color = "#ff9000"
	taste_description = "like water"

/datum/reagent/buff/temperature_normalize/on_mob_life(mob/living/carbon/M)
	M.apply_status_effect(/datum/status_effect/buff/alch/temperaturepot)
	return ..()

/datum/reagent/buff/strength
	name = STATKEY_STR
	color = "#ff9000"
	taste_description = "old meat"

/datum/reagent/buff/strength/on_mob_life(mob/living/carbon/M)
	M.apply_status_effect(/datum/status_effect/buff/alch/strengthpot)
	return ..()

/datum/reagent/buff/perception
	name = STATKEY_PER
	color = "#e9e98c"
	taste_description = "cat piss"
	metabolization_rate = REAGENTS_METABOLISM * 0.05

/datum/reagent/buff/perception/on_mob_life(mob/living/carbon/M)
	M.apply_status_effect(/datum/status_effect/buff/alch/perceptionpot)
	return ..()

/datum/reagent/buff/intelligence
	name = STATKEY_INT
	color = "#438127"
	taste_description = "bog water"
	metabolization_rate = REAGENTS_METABOLISM * 0.05

/datum/reagent/buff/intelligence/on_mob_life(mob/living/carbon/M)
	M.apply_status_effect(/datum/status_effect/buff/alch/intelligencepot)
	return ..()

/datum/reagent/buff/constitution
	name = STATKEY_CON
	color = "#130604"
	taste_description = "bile"

/datum/reagent/buff/constitution/on_mob_life(mob/living/carbon/M)
	M.apply_status_effect(/datum/status_effect/buff/alch/constitutionpot)
	return ..()

/datum/reagent/buff/endurance
	name = STATKEY_WIL
	color = "#e2c3e1"
	taste_description = "oversweetened milk"

/datum/reagent/buff/endurance/on_mob_life(mob/living/carbon/M)
	M.apply_status_effect(/datum/status_effect/buff/alch/endurancepot)
	return ..()

/datum/reagent/buff/speed
	name = STATKEY_SPD
	color = "#cea63a"
	taste_description = "raw egg yolk"

/datum/reagent/buff/speed/on_mob_life(mob/living/carbon/M)
	M.apply_status_effect(/datum/status_effect/buff/alch/speedpot)
	return ..()

/datum/reagent/buff/fortune
	name = STATKEY_LCK
	color = "#ffff00"
	taste_description = "sour lemons"
	metabolization_rate = REAGENTS_METABOLISM * 0.05

/datum/reagent/buff/fortune/on_mob_life(mob/living/carbon/M)
	M.apply_status_effect(/datum/status_effect/buff/alch/fortunepot)
	return ..()
