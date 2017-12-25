require "/scripts/util.lua"

function update(_,_, shiftHeld)
  self.containerId = config.getParameter("containerId")
  self.swapItem = config.getParameter("swapItem")

  if shiftHeld and self.containerId and world.entityExists(self.containerId) then
    local status, result = pcall(eatItems)
  end

  if self.swapItem then player.setSwapSlotItem(self.swapItem)
  else item.setCount(0) end
end

function eatItems()
  local items = world.containerItems(self.containerId)

  if items then
    for offset, item in pairs(items) do
      lootItem(item, offset)
    end

    player.cleanupItems()
  end
end

function lootItem(item, offset)
  player.giveItem(item)
  world.containerConsumeAt(self.containerId, offset - 1, item.count)
end