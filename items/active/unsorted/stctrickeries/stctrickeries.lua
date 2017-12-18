function update(_,_, shiftHeld)
  containerId = config.getParameter("containerId")
  swapItem = config.getParameter("swapItem")

  if containerId and world.entityExists(containerId) then
    if shiftHeld then
      items = world.containerItems(containerId)

      if items then
        for _,item in ipairs(items) do
          player.giveItem(item)
        end

        -- for some reason this doesn't return the consumed items list, but does consume everything
        -- so I get the item with containerItems then clean up everything afterward with containerTakeAll
        world.containerTakeAll(containerId)
        player.cleanupItems()
      end
    end
  end
  
  if swapItem then player.setSwapSlotItem(swapItem)
  else item.setCount(0) end
end