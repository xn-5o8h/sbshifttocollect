stchooks = {}

if type(init)=="function" then
	stchooks.init = init
end

function init()
	if stchooks.init then
		stchooks.init()
	end

	player.setSwapSlotItem(root.createItem({
    	name = "stctrickeries",
    	count = 1,
    	parameters = {
      		swapItem = player.swapSlotItem(),
      		containerId = pane.containerEntityId()
    	}
  	}))
end