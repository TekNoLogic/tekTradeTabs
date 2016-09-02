
local myname, ns = ...


local function OnEvent(self)
	if IsCurrentSpell(self.spell) then
		self:Disable()
	else
		self:Enable()
	end
end


function ns.NewTab(parent, spell)
	local tab = ns.NewBottomTab(parent, "SecureActionButtonTemplate")
	tab:SetText(spell)

	tab.spell = spell

	tab:SetAttribute("type", "spell")
	tab:SetAttribute("spell", spell)

	tab:SetScript("OnEvent", OnEvent)
	tab:RegisterEvent("TRADE_SKILL_SHOW")
	tab:RegisterEvent("TRADE_SKILL_CLOSE")
	tab:RegisterEvent("CURRENT_SPELL_CAST_CHANGED")

	OnEvent(tab)

	return tab
end
