/obj/item/alch/viscera
	name = "viscera"
	icon_state = "viscera"
	major_pot = /datum/alch_cauldron_recipe/big_health_potion
	med_pot = /datum/alch_cauldron_recipe/health_potion
	minor_pot = /datum/alch_cauldron_recipe/antidote

/obj/item/alch/waterdust
	name = "water essentia"
	icon_state = "water_runedust"
	major_pot = /datum/alch_cauldron_recipe/int_potion
	med_pot = /datum/alch_cauldron_recipe/big_mana_potion
	minor_pot = /datum/alch_cauldron_recipe/per_potion

/obj/item/alch/bonemeal
	name = "bone meal"
	icon_state = "bonemeal"
	major_pot = /datum/alch_cauldron_recipe/mana_potion
	med_pot = /datum/alch_cauldron_recipe/per_potion
	minor_pot = /datum/alch_cauldron_recipe/antidote

/obj/item/alch/seeddust
	name = "seed dust"
	icon_state = "seeddust"
	major_pot = /datum/alch_cauldron_recipe/big_stamina_potion
	med_pot = /datum/alch_cauldron_recipe/stamina_potion
	minor_pot = /datum/alch_cauldron_recipe/strong_antidote

/obj/item/alch/blessedseedpowder
	name = "blessed seed powder"
	desc = "Luminous seed dust prepared with sanctified water. Dendor's touch lingers within it."
	icon = 'icons/roguetown/items/produce.dmi'
	icon_state = "flour"
	color = "#BFFFC4"
	major_pot = null
	med_pot = null
	minor_pot = null

/obj/item/alch/blessedseedpowder/Initialize(mapload)
	. = ..()
	set_light(1, 1, 2, l_color = "#58C86A")
	add_filter("blessedseed_glow", 2, list("type" = "outline", "color" = "#58C86A", "alpha" = 95, "size" = 1))

/obj/item/alch/blessedseedpowder/Destroy()
	remove_filter("blessedseed_glow")
	return ..()

//==============================================================================
// Harvest Bloomstone — ritual reward from Cat 9 Harvest Bloomstone rite.
// Functions as a 20-use blessed seed powder when held during Bless Crops.
// Each use (qdel call from blesscrop) decrements charges instead of destroying it.
// When all 20 charges are spent, the stone shatters and leaves stone dust.
//==============================================================================
/obj/item/alch/bloomstone
	name = "harvest bloomstone"
	desc = "A smooth stone suffused with the Treefather's living power. When held during while using the Bless Crops miracle it functions like blessed seed powder and spends a charge instead of being consumed — good for twenty uses before it shatters."
	icon = 'icons/roguetown/gems/gem_shell.dmi'
	icon_state = "cutgem_shell"
	color = "#228B22"
	major_pot = null
	med_pot = null
	minor_pot = null
	var/charges = 20

/obj/item/alch/bloomstone/Initialize(mapload)
	. = ..()
	set_light(1, 1, 2, l_color = "#73c47a")
	add_filter("bloomstone_glow", 2, list("type" = "outline", "color" = "#73c47a", "alpha" = 95, "size" = 1))

/obj/item/alch/bloomstone/examine(mob/user)
	. = ..()
	. += span_info("It has [charges] charge\s remaining.")

/obj/item/alch/bloomstone/Destroy()
	remove_filter("bloomstone_glow")
	charges--
	if(charges > 0)
		// Stone survives this use; re-apply glow and stay alive.
		add_filter("bloomstone_glow", 2, list("type" = "outline", "color" = "#73c47a", "alpha" = 95, "size" = 1))
		return QDEL_HINT_LETMELIVE
	// All charges spent — shatter into stone dust.
	new /obj/item/alch/stonedust(get_turf(src))
	if(loc && isliving(loc))
		var/mob/living/holder = loc
		to_chat(holder, span_warning("The Harvest Bloomstone's light gutters and the stone crumbles to dust in my hand!"))
	return ..()

/obj/item/alch/runedust
	name = "raw essentia"
	icon_state = "runedust"
	major_pot = /datum/alch_cauldron_recipe/int_potion
	med_pot = /datum/alch_cauldron_recipe/big_mana_potion
	minor_pot = /datum/alch_cauldron_recipe/per_potion

/obj/item/alch/coaldust
	name = "coal dust"
	icon_state = "coaldust"
	major_pot = /datum/alch_cauldron_recipe/antidote
	med_pot = /datum/alch_cauldron_recipe/end_potion
	minor_pot = /datum/alch_cauldron_recipe/str_potion

/obj/item/alch/stonedust
	name = "stone dust"
	desc = "Finely ground mineral dust used for glass clay refinement."
	icon_state = "coaldust"
	major_pot = null
	med_pot = null
	minor_pot = null

/obj/item/alch/silverdust
	name = "silver dust"
	icon_state = "silverdust"
	major_pot = /datum/alch_cauldron_recipe/strong_antidote
	med_pot = /datum/alch_cauldron_recipe/antidote
	minor_pot = /datum/alch_cauldron_recipe/big_health_potion
	is_silver = TRUE

/obj/item/alch/magicdust
	name = "pure essentia"
	icon_state = "magic_runedust"
	major_pot = /datum/alch_cauldron_recipe/big_mana_potion
	med_pot = /datum/alch_cauldron_recipe/end_potion
	minor_pot = /datum/alch_cauldron_recipe/con_potion

/obj/item/alch/firedust
	name = "fire essentia"
	icon_state = "fire_runedust"
	major_pot = /datum/alch_cauldron_recipe/str_potion
	med_pot = /datum/alch_cauldron_recipe/con_potion
	minor_pot = /datum/alch_cauldron_recipe/fire_potion

/obj/item/alch/sinew
	name = "sinew"
	icon_state = "sinew"
	dropshrink = 0.9
	major_pot = /datum/alch_cauldron_recipe/aphrodisiac
	med_pot = /datum/alch_cauldron_recipe/end_potion
	minor_pot = /datum/alch_cauldron_recipe/health_potion

/obj/item/alch/irondust
	name = "iron dust"
	icon_state = "irondust"
	major_pot = /datum/alch_cauldron_recipe/end_potion
	med_pot = /datum/alch_cauldron_recipe/con_potion
	minor_pot = /datum/alch_cauldron_recipe/str_potion

/obj/item/alch/airdust
	name = "air essentia"
	icon_state = "air_runedust"
	major_pot = /datum/alch_cauldron_recipe/spd_potion
	med_pot = /datum/alch_cauldron_recipe/stamina_potion
	minor_pot = /datum/alch_cauldron_recipe/int_potion

/obj/item/alch/swampdust
	name = "swampweed dust"
	icon_state = "swampdust"
	major_pot = /datum/alch_cauldron_recipe/temp_potion
	med_pot = /datum/alch_cauldron_recipe/aphrodisiac
	minor_pot = /datum/alch_cauldron_recipe/end_potion

/obj/item/alch/tobaccodust
	name = "westleach dust"
	icon_state = "tobaccodust"
	major_pot = /datum/alch_cauldron_recipe/per_potion
	med_pot = /datum/alch_cauldron_recipe/stamina_potion
	minor_pot = /datum/alch_cauldron_recipe/spd_potion

/obj/item/alch/earthdust
	name = "earth essentia"
	icon_state = "earth_runedust"
	major_pot = /datum/alch_cauldron_recipe/con_potion
	med_pot = /datum/alch_cauldron_recipe/end_potion
	minor_pot = /datum/alch_cauldron_recipe/str_potion

/obj/item/alch/bone
	name = "tail bone"
	icon_state = "bone"
	desc = "The only bone in creachers with alchemical properties."
	force = 7
	throwforce = 5
	w_class = WEIGHT_CLASS_SMALL
	grid_width = 32
	grid_height = 64

	major_pot = /datum/alch_cauldron_recipe/strong_antidote
	med_pot = /datum/alch_cauldron_recipe/health_potion
	minor_pot = /datum/alch_cauldron_recipe/con_potion

/obj/item/alch/horn
	name = "troll horn"
	icon_state = "horn"
	desc = "The horn of a bog troll."
	force = 7
	throwforce = 5
	w_class = WEIGHT_CLASS_NORMAL
	grid_width = 64
	grid_height = 64

	major_pot = /datum/alch_cauldron_recipe/str_potion
	med_pot = /datum/alch_cauldron_recipe/con_potion
	minor_pot = /datum/alch_cauldron_recipe/end_potion

/obj/item/alch/golddust
	name = "gold dust"
	icon_state = "golddust"

	major_pot = /datum/alch_cauldron_recipe/big_mana_potion
	med_pot = /datum/alch_cauldron_recipe/con_potion
	minor_pot = /datum/alch_cauldron_recipe/per_potion

/obj/item/alch/feaudust
	name = "feau dust"
	icon_state = "feaudust"

	major_pot = /datum/alch_cauldron_recipe/spd_potion
	med_pot = /datum/alch_cauldron_recipe/big_mana_potion
	minor_pot = /datum/alch_cauldron_recipe/strong_antidote

/obj/item/alch/ozium
	name = "alchemical ozium"
	desc = "Alchemical processing has left it unfit for consumption."
	icon_state = "darkredpowder"

	major_pot = /datum/alch_cauldron_recipe/big_stamina_potion
	med_pot = /datum/alch_cauldron_recipe/lck_potion
	minor_pot = /datum/alch_cauldron_recipe/int_potion

/obj/item/alch/transisdust
	name = "sui dust"
	desc = "A long mix of herbs resulting in a special dust. For you. Use it while held."
	icon_state = "transisdust"

/obj/item/alch/transisdust/attack_self(mob/living/user)
	..()

	if(alert("Do you wish to change your self?", "Dust of Self", "Yes", "No") != "Yes")
		return
	user.visible_message(
		span_warn("[user] begins to use [src]."),
		span_warn("I begin to apply [src] on myself.")
	)
	if(!do_after(user, 5 SECONDS))
		return

	var/p_input = input(user, "Choose your character's pronouns", "Pronouns") as null|anything in GLOB.pronouns_list
	if(p_input)
		user.pronouns = p_input
	if(alert("Do you wish to change your frame?", "Body Type", "Yes", "No") == "Yes")
		user.gender = "male" ? "female" : "male"

	if(!do_after(user, 5 SECONDS))
		return

	user.regenerate_icons()
	to_chat(user, span_notice("Tis' complete."))
	qdel(src)

/obj/item/alch/puresalt
	name = "purified salts"
	desc = "Salts that have been finely sifted to enhance their healing properties and to bolster their connection to the arcyne."
	icon_state = "puresalt"

	major_pot = /datum/alch_cauldron_recipe/antidote
	med_pot = /datum/alch_cauldron_recipe/strong_antidote
	minor_pot = /datum/alch_cauldron_recipe/big_mana_potion

/obj/item/alch/mineraldust
	name = "mineral dusts"
	desc = "Elements of gems ground and sifted of impurities to help draw out its useful alchemical minerals."
	icon_state = "mineraldust"

	major_pot = /datum/alch_cauldron_recipe/doompoison
	med_pot = /datum/alch_cauldron_recipe/big_mana_potion
	minor_pot = /datum/alch_cauldron_recipe/big_stam_poison

/obj/item/alch/infernaldust
	name = "infernal dust"
	desc = "The remains of an abyssal tether to this plane, banished or slain. Best handled with gloves."
	icon_state = "infernaldust"

	major_pot = /datum/alch_cauldron_recipe/fire_potion
	med_pot = /datum/alch_cauldron_recipe/big_stam_poison
	minor_pot = /datum/alch_cauldron_recipe/int_potion

/obj/item/alch/solardust
	name = "solar dust"
	desc = "A pinch of Astrata worked into radiant matter. Looking at it hurts your eyes."
	icon_state = "solardust"

	major_pot = /datum/alch_cauldron_recipe/fire_potion
	med_pot = /datum/alch_cauldron_recipe/int_potion
	minor_pot = /datum/alch_cauldron_recipe/per_potion

/obj/item/alch/berrypowder
	name = "berry powder"
	desc = "Berries ground and dried into a soft fragrant powder."
	icon_state = "berrypowder"

	major_pot = /datum/alch_cauldron_recipe/berrypoison
	med_pot = /datum/alch_cauldron_recipe/mana_potion
	minor_pot = /datum/alch_cauldron_recipe/big_mana_potion

//dust mix crafting
/datum/crafting_recipe/roguetown/alch/feaudust
	name = "feau dust"
	result = list(/obj/item/alch/feaudust,
				/obj/item/alch/feaudust)
	reqs = list(/obj/item/alch/irondust = 2,
				/obj/item/alch/golddust = 1)
	structurecraft = /obj/structure/table/wood
	verbage = "mixes"
	craftsound = 'sound/foley/scribble.ogg'
	skillcraft = /datum/skill/craft/alchemy
	craftdiff = 0

/datum/crafting_recipe/roguetown/alch/magicdust
	name = "pure essentia"
	result = list(/obj/item/alch/magicdust)
	reqs = list(/obj/item/alch/waterdust = 1, /obj/item/alch/firedust = 1,
				/obj/item/alch/airdust = 1, /obj/item/alch/earthdust = 1)
	structurecraft = /obj/structure/table/wood
	verbage = "mixes"
	craftsound = 'sound/foley/scribble.ogg'
	skillcraft = /datum/skill/craft/alchemy
	craftdiff = 0
