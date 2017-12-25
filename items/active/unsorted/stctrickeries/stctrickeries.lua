require "/scripts/util.lua"

function update(_,_, shiftHeld)
  containerId = config.getParameter("containerId")
  swapItem = config.getParameter("swapItem")

  if storage.items then
    if not storage.cantFix then
      for offset, item in pairs(storage.items) do
        lootItem(item, offset)
      end
    end

    if #storage.items > 0 or storage.cantFix then
      storage.cantFix = true
      sb.logInfo("uh oh look like we got a problem; please post this to the Shift To Loot mod page!")
      error(storage.items)
      return
    end
  end

  if containerId and world.entityExists(containerId) then
    if shiftHeld then
      items = world.containerItems(containerId)
      storage.items = items

      if items then
        for offset, item in pairs(items) do
          lootItem(item, offset)
        end

        player.cleanupItems()
      end
    end
  end

  if swapItem then player.setSwapSlotItem(swapItem)
  else item.setCount(0) end
end

function lootItem(item, offset)
  player.giveItem(item)
  if player.hasItem(item, true) then
    world.containerConsumeAt(containerId, offset - 1, item.count)
  end

  storage.items = util.filter(storage.items, function(i) if i ~= item then return true end end)
end