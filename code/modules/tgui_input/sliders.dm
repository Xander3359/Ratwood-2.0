/**
 * ### tgui_input_sliders
 * Opens a window with a list of adjustable sliders, returns the values selected.

 * user - The mob to display the window to
 * message - The message inside the window
 * title - The title of the window
 * list/items - The list of items to display
 * timeout - The timeout for the input (optional)
 */
/proc/tgui_input_sliders(mob/user, message, title = "Select", list/items, timeout = 0, ui_state = GLOB.always_state)
	if (!user)
		user = usr
	if(!length(items))
		return null
	if (!istype(user))
		if (istype(user, /client))
			var/client/client = user
			user = client.mob
		else
			return null

	if(isnull(user.client))
		return null

	var/datum/tgui_sliders_input/slider = new(user, message, title, items, timeout, ui_state)
	slider.ui_interact(user)
	slider.wait()
	if (slider)
		. = slider.choice
		qdel(slider)

/// Window for tgui_input_sliders
/datum/tgui_sliders_input
	/// Title of the window
	var/title
	/// Message to display
	var/message
	/// List of items to display
	var/list/items
	/// The choices that the user has set with the sliders, will return default values if none are adjusted
	var/list/choice
	/// Time when the input was created
	var/start_time
	/// The lifespan of the tgui_sliders_input, after which the window will close and delete itself.
	var/timeout
	/// Boolean field describing if the tgui_sliders_input was closed by the user.
	var/closed
	/// The TGUI UI state that will be returned in ui_state(). Default: always_state
	var/datum/ui_state/state

/datum/tgui_sliders_input/New(mob/user, message, title, list/items, timeout, ui_state)
	src.message = message
	src.title = title
	src.items = items.Copy()
	src.timeout = timeout
	src.state = ui_state

/datum/tgui_sliders_input/Destroy(force)
	SStgui.close_uis(src)
	state = null
	items?.Cut()
	return ..()

/**
 * Waits for a user's response to the tgui_list_input's prompt before returning. Returns early if
 * the window was closed by the user.
 */
/datum/tgui_sliders_input/proc/wait()
	while (!closed && !QDELETED(src))
		stoplag(1)

/datum/tgui_sliders_input/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "SlidersInput")
		ui.open()

/datum/tgui_sliders_input/ui_close(mob/user)
	. = ..()
	closed = TRUE

/datum/tgui_sliders_input/ui_state(mob/user)
	return state

/datum/tgui_sliders_input/ui_static_data(mob/user)
	var/list/data = list()

	data["items"] = items
	data["message"] = message
	data["title"] = title
	return data

/datum/tgui_sliders_input/ui_data(mob/user)
	var/list/data = list()
	if(timeout)
		data["timeout"] = CLAMP01((timeout - (world.time - start_time) - 1 SECONDS) / (timeout - 1 SECONDS))
	return data

/datum/tgui_sliders_input/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if (.)
		return
//	switch(action)






