if IsAddOnLoaded("Bagnon_ItemInfo") then 
	return DisableAddOn((...), true) 
end 

-- Using the Bagnon way to retrieve names, namespaces and stuff
local MODULE =  ...
local ADDON, Addon = MODULE:match("[^_]+"), _G[MODULE:match("[^_]+")]
local Module = Bagnon:NewModule("ItemUncollectedAppearance", Addon)

-- Lua API
local _G = _G
local string_match = string.match
local tonumber = tonumber

-- WoW API
local C_TransmogCollection = _G.C_TransmogCollection
local CreateFrame = _G.CreateFrame

-- FontString & Texture Caches
local Cache_Uncollected = {}

-----------------------------------------------------------
-- Utility Functions
-----------------------------------------------------------
-- Move Pawn out of the way
local RefreshPawn = function(button)
	local UpgradeIcon = button.UpgradeIcon
	if UpgradeIcon then
		UpgradeIcon:ClearAllPoints()
		UpgradeIcon:SetPoint("BOTTOMRIGHT", 2, 0)
	end
end

-----------------------------------------------------------
-- Cache & Creation
-----------------------------------------------------------
-- Retrieve a button's plugin container
local GetPluginContainter = function(button)
	local name = button:GetName() .. "ExtraInfoFrame"
	local frame = _G[name]
	if (not frame) then 
		frame = CreateFrame("Frame", name, button)
		frame:SetAllPoints()
	end 
	return frame
end


local Cache_GetUncollected = function(button)
	local Uncollected = GetPluginContainter(button):CreateTexture()
	Uncollected:SetDrawLayer("OVERLAY")
	Uncollected:SetPoint("CENTER", 0, 0)
	Uncollected:SetSize(24,24)
	Uncollected:SetTexture([[Interface\Transmogrify\Transmogrify]])
	Uncollected:SetTexCoord(0.804688, 0.875, 0.171875, 0.230469)
	Uncollected:Hide()

	-- Move Pawn out of the way
	RefreshPawn(button)

	-- Store the reference for the next time
	Cache_Uncollected[button] = Uncollected

	return Uncollected
end

-----------------------------------------------------------
-- Main Update
-----------------------------------------------------------
local Update = function(self)
	local itemLink = self:GetItem() 
	if itemLink then

		-- Get some blizzard info about the current item
		local itemName, _itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, iconFileDataID, itemSellPrice, itemClassID, itemSubClassID, bindType, expacID, itemSetID, isCraftingReagent = GetItemInfo(itemLink)

		-- Retrieve the itemID from the itemLink
		local itemID = tonumber(string_match(itemLink, "item:(%d+)"))

		---------------------------------------------------
		-- Uncollected Appearance
		---------------------------------------------------
		if (itemRarity and (itemRarity > 1)) and (not C_TransmogCollection.PlayerHasTransmog(itemID)) then 
			local appearanceID, sourceID = C_TransmogCollection.GetItemInfo(itemID)
			local data = sourceID and C_TransmogCollection.GetSourceInfo(sourceID)
			if (itemRarity and (itemRarity > 1)) and (data and (data.isCollected == false)) then
				-- figure out if we own a matching item
				local known
				local sources = C_TransmogCollection.GetAppearanceSources(appearanceID)
				if sources then 
					for i = 1, #sources do 
						local data = C_TransmogCollection.GetSourceInfo(sources[i].sourceID) 
						if (data and data.isCollected) then 
							-- found a collected matching source
							known = true 
							break
						end 
					end
				end
				if (not known) then 
					-- some items can't have their appearances learned
					local isInfoReady, canCollect = C_TransmogCollection.PlayerCanCollectSource(sourceID)
					if (isInfoReady and canCollect) then 
						local Uncollected = Cache_Uncollected[self] or Cache_GetUncollected(self)
						Uncollected:Show()
					end
				end
			else 
				if Cache_Uncollected[self] then 
					Cache_Uncollected[self]:Hide()
				end	
			end
		else
			if Cache_Uncollected[self] then 
				Cache_Uncollected[self]:Hide()
			end	
		end
	else
		if Cache_Uncollected[self] then 
			Cache_Uncollected[self]:Hide()
		end	
	end	
end 

Module.OnEnable = function(self)
	hooksecurefunc(Bagnon.ItemSlot, "Update", Update)
end 
