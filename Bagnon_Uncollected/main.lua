if (function(addon)
	for i = 1,GetNumAddOns() do
		if (string.lower((GetAddOnInfo(i))) == string.lower(addon)) then
			if (GetAddOnEnableState(UnitName("player"), i) ~= 0) then
				return 
			end
		end
	end
end)("Bagnon_ItemInfo") then 
	return 
end 

local MODULE =  ...
local ADDON, Addon = MODULE:match("[^_]+"), _G[MODULE:match("[^_]+")]
local Module = Bagnon:NewModule("ItemUncollectedAppearance", Addon)

-- Tooltip used for scanning
local ScannerTip = _G.BagnonItemInfoScannerTooltip or CreateFrame("GameTooltip", "BagnonItemInfoScannerTooltip", WorldFrame, "GameTooltipTemplate")
local ScannerTipName = ScannerTip:GetName()

-- Lua API
local _G = _G
local string_find = string.find
local string_match = string.match
local tonumber = tonumber

-- WoW API
local C_TransmogCollection = _G.C_TransmogCollection
local CreateFrame = _G.CreateFrame

-- WoW Strings
local S_TRANSMOGRIFY_STYLE_UNCOLLECTED = _G.TRANSMOGRIFY_STYLE_UNCOLLECTED
local S_TRANSMOGRIFY_TOOLTIP_APPEARANCE_UNKNOWN = _G.TRANSMOGRIFY_TOOLTIP_APPEARANCE_UNKNOWN

-- FontString & Texture Caches
local Cache_Uncollected = {}

-----------------------------------------------------------
-- Utility Functions
-----------------------------------------------------------
-- Update our secret scanner tooltip with the current button
local RefreshScanner = function(button)
	local bag, slot = button:GetBag(), button:GetID()
	ScannerTip.owner = button
	ScannerTip.bag = bag
	ScannerTip.slot = slot
	ScannerTip:SetOwner(button, "ANCHOR_NONE")
	ScannerTip:SetBagItem(button:GetBag(), button:GetID())
end

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
		if (itemRarity and itemRarity > 1) and (not C_TransmogCollection.PlayerHasTransmog(itemID)) then 

			-- Refresh the scanner only if we actually need to scan
			RefreshScanner(self)

			local unknown
			for i = ScannerTip:NumLines(),2,-1 do 
				local line = _G[ScannerTipName.."TextLeft"..i]
				if line then 
					local msg = line:GetText()
					if msg and (string_find(msg, S_TRANSMOGRIFY_STYLE_UNCOLLECTED) or string_find(msg, S_TRANSMOGRIFY_TOOLTIP_APPEARANCE_UNKNOWN)) then
					unknown = true
						break
					end
				end
			end 
			if (unknown) then 
				local Uncollected = Cache_Uncollected[self] or Cache_GetUncollected(self)
				Uncollected:Show()
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

hooksecurefunc(Bagnon.ItemSlot, "Update", Update)
