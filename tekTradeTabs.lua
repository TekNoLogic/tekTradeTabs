
local myname, ns = ...


local whitelist = {
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


local RUNEFORGING = 53428 -- Runeforging spellid


local function TradeSpells()
	local p1, p2, arch, fishing, cooking, firstaid = GetProfessions()
	local profs = {p1, p2, cooking, firstaid}

	local spells = {}

	local _, class = UnitClass("player")
	if class == "DEATHKNIGHT" then
		spells[1] = GetSpellInfo(RUNEFORGING)
	end

	for i,prof in pairs(profs) do
		local name, icon, _, _, abilities, offset, skillLine = GetProfessionInfo(prof)
		if whitelist[skillLine] then
		-- if whitelist[skillLine] and not IsPassiveSpell(offset + 1, BOOKTYPE_PROFESSION) then
			local _, spellid = GetSpellBookItemInfo(offset + 1, BOOKTYPE_PROFESSION)
			table.insert(spells, (GetSpellInfo(spellid)))
		end
	end

	return spells
end


function ns.OnLoad()
	local parent = TradeSkillFrame
	local anchor

	for _,spellid in ipairs(TradeSpells()) do
		local tab = ns.NewTab(parent, GetSpellInfo(spellid))

		if anchor then
			tab:SetPoint("LEFT", anchor, "RIGHT", -15, 0)
		else
			tab:SetPoint("TOPLEFT", parent, "BOTTOMLEFT", 11, 2)
		end

		anchor = tab
	end
end
