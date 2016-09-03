
local myname, ns = ...


local RUNEFORGING = 53428 -- Runeforging spellid
local TRADES = {
	[171] = true, -- Alchemy
	[164] = true, -- Blacksmithing
	[185] = true, -- Cooking
	[333] = true, -- Enchanting
	[129] = true, -- First Aid
	[773] = true, -- Inscription
	[755] = true, -- Jewelcrafting
	[165] = true, -- Leatherworking
	[186] = true, -- Mining
	[197] = true, -- Tailoring
	[202] = true, -- Engineering
}


local function TradeSpells()
	local spells = {}
	local p1, p2, arch, fishing, cooking, firstaid = GetProfessions()
	local profs = {p1, p2, cooking, firstaid}

	local _, class = UnitClass("player")
	if class == "DEATHKNIGHT" then spells[1] = GetSpellInfo(RUNEFORGING) end

	for _,prof in pairs(profs) do
		local _, _, _, _, _, offset, skillline = GetProfessionInfo(prof)
		if TRADES[skillline] then
			local _, spellid = GetSpellBookItemInfo(offset + 1, BOOKTYPE_PROFESSION)
			table.insert(spells, (GetSpellInfo(spellid)))
		end
	end

	return spells
end


function ns.OnLoad()
	local anchor = CreateFrame("Frame", nil, TradeSkillFrame)
	anchor:SetSize(15, 32)
	anchor:SetPoint("BOTTOMLEFT", 11, -30)

	for _,spellid in ipairs(TradeSpells()) do
		local tab = ns.NewTab(TradeSkillFrame, GetSpellInfo(spellid))
		tab:SetPoint("LEFT", anchor, "RIGHT", -15, 0)
		anchor = tab
	end
end
