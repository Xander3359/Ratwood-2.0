/*!
 * Contains all the heal-type reagents
 */

//Potions
/datum/reagent/medicine/healthpot
	name = "Health Potion"
	description = "Gradually regenerates all types of damage."
	reagent_state = LIQUID
	color = "#ff0000"
	taste_description = "lifeblood"
	overdose_threshold = 0
	metabolization_rate = REAGENTS_METABOLISM
	alpha = 173

/datum/reagent/medicine/healthpot/on_mob_life(mob/living/carbon/M)
	if(volume >= 60)
		M.reagents.remove_reagent(/datum/reagent/medicine/healthpot, 2) //No overhealing.
	if(M.blood_volume < BLOOD_VOLUME_NORMAL)
		M.blood_volume = min(M.blood_volume+15, BLOOD_VOLUME_NORMAL)
	var/list/wCount = M.get_wounds()
	if(wCount.len > 0)
		M.heal_wounds(3) //at a motabalism of .5 U a tick this translates to 120WHP healing with 20 U Most wounds are unsewn 15-100. This is powerful on single wounds but rapidly weakens at multi wounds.
	if(volume > 0.99)
		M.adjustBruteLoss(-1.75*REM, 0)
		M.adjustFireLoss(-1.75*REM, 0)
		M.adjustOxyLoss(-1.25, 0)
		M.adjustOrganLoss(ORGAN_SLOT_BRAIN, -5*REM)
		M.adjustCloneLoss(-1.75*REM, 0)
		M.adjustOrganLoss(ORGAN_SLOT_EYES, -1*REM)
	..()

/* XANTODO: Clear up references
/datum/reagent/medicine/stronghealth
	name = "Strong Health Potion"
	description = "Quickly regenerates all types of damage."
	color = "#820000"
	taste_description = "rich lifeblood"
	metabolization_rate = REAGENTS_METABOLISM * 3

/datum/reagent/medicine/stronghealth/on_mob_life(mob/living/carbon/M)
	if(volume >= 60)
		M.reagents.remove_reagent(/datum/reagent/medicine/healthpot, 2) //No overhealing.
	if(M.blood_volume < BLOOD_VOLUME_NORMAL)
		M.blood_volume = min(M.blood_volume+20, BLOOD_VOLUME_NORMAL)
	var/list/wCount = M.get_wounds()
	if(wCount.len > 0)
		M.heal_wounds(6) //at a motabalism of .5 U a tick this translates to 240WHP healing with 20 U Most wounds are unsewn 15-100.
	if(volume > 0.99)
		M.adjustBruteLoss(-7*REM, 0)
		M.adjustFireLoss(-7*REM, 0)
		M.adjustOxyLoss(-5, 0)
		M.adjustOrganLoss(ORGAN_SLOT_BRAIN, -5*REM)
		M.adjustCloneLoss(-7*REM, 0)
		M.adjustOrganLoss(ORGAN_SLOT_EYES, -2.5*REM)
	..()
	. = 1
*/

/datum/reagent/medicine/manapot
	name = "Mana Potion"
	description = "Gradually regenerates energy."
	reagent_state = LIQUID
	color = "#000042"
	taste_description = "sweet mana"
	overdose_threshold = 0
	metabolization_rate = REAGENTS_METABOLISM
	alpha = 173

/datum/reagent/medicine/manapot/on_mob_life(mob/living/carbon/M)
	if(!HAS_TRAIT(M,TRAIT_INFINITE_STAMINA))
		M.energy_add(30)
	..()

/* XANTODO Clear up references
/datum/reagent/medicine/strongmana
	name = "Strong Mana Potion"
	description = "Rapidly regenerates energy."
	color = "#0000ff"
	taste_description = "raw power"
	metabolization_rate = REAGENTS_METABOLISM * 3

/datum/reagent/medicine/strongmana/on_mob_life(mob/living/carbon/M)
	if(!HAS_TRAIT(M,TRAIT_INFINITE_STAMINA))
		M.energy_add(120)
	..()
*/

/datum/reagent/medicine/stampot
	name = "Stamina Potion"
	description = "Gradually regenerates stamina."
	reagent_state = LIQUID
	color = "#129c00"
	taste_description = "sweet tea"
	overdose_threshold = 0
	metabolization_rate = REAGENTS_METABOLISM
	alpha = 173

/datum/reagent/medicine/stampot/on_mob_life(mob/living/carbon/M)
	if(volume > 0.99)
		M.stamina_add(-20)
	..()
	. = 1

/* XANTODO: Clear up references
/datum/reagent/medicine/strongstam
	name = "Strong Stamina Potion"
	description = "Rapidly regenerates stamina."
	color = "#13df00"
	taste_description = "sparkly static"
	metabolization_rate = REAGENTS_METABOLISM

/datum/reagent/medicine/strongstam/on_mob_life(mob/living/carbon/M)
	if(volume > 0.99)
		M.stamina_add(-50)
	..()
	. = 1
*/

/** Design Note: Antidotes are meant to last as long as the poison, and purge them much quicker
 * Having a 1 to 1 antidote to poison where you have to tailor defense to an increasing amount of attack
 * is a bad idea, since that just means no one will use antidotes and the weapon win the race vs defense.
 * This means pre ingesting antidote when expecting poison is a viable strategy.
 * Previously, antidote did not have a dylovene-like effect and just purged toxin damage while poison will outlast them.
**/
/datum/reagent/medicine/antidote
	name = "Antidote"
	description = ""
	reagent_state = LIQUID
	color = "#00ff00"
	taste_description = "sickly sweet"
	metabolization_rate = 0.1 * REAGENTS_METABOLISM

/datum/reagent/medicine/antidote/on_mob_life(mob/living/carbon/M)
	if(volume > 0.99)
		M.adjustToxLoss(-4, 0)
	for(var/datum/reagent/R in M.reagents.reagent_list)
		if(R.harmful)
			holder.remove_reagent(R.type, 1)

	..()
	. = 1

/* XANTODO: Clear up references
// About 3 time as potent as antidote
/datum/reagent/medicine/strong_antidote
	name = "Strong Antidote"
	description = ""
	reagent_state = LIQUID
	color = "#004200"
	taste_description = "dirt"
	metabolization_rate = 0.1 * REAGENTS_METABOLISM

/datum/reagent/medicine/strong_antidote/on_mob_life(mob/living/carbon/M)
	if(volume > 0.99)
		M.adjustToxLoss(-12, 0)
	for(var/datum/reagent/R in M.reagents.reagent_list)
		if(R.harmful)
			holder.remove_reagent(R, 3)
	..()
	. = 1
*/
