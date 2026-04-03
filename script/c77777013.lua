--Earthbound Immortals' Power
--Scripted by FunnyBones777
local s,id=GetID()
function s.initial_effect(c)
	aux.AddSkillProcedure(c,1,false,s.flipcon,s.flipop)
end
function s.flipcon(e,tp,eg,ep,ev,re,r,rp)
	--opd check
	if Duel.GetFlagEffect(ep,id)>0 then return end
	--condition
	return aux.CanActivateSkill(tp) and Duel.IsExistingMatchingCard(s.DOOMfilter,tp,LOCATION_MZONE,0,2,nil)
end
function s.flipop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SKILL_FLIP,tp,id|(1<<32))
	Duel.Hint(HINT_CARD,tp,id)
	--opd register
	Duel.RegisterFlagEffect(ep,id,0,0,0)
	local c=e:GetHandler()
	local sg=Duel.SelectMatchingCard(tp,s.DOOMfilter,tp,LOCATION_MZONE,0,1,1,nil)
	local tc=sg:GetFirst()
	if tc then
		--Cannot be targeted for attacks
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
		e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
		e2:SetRange(LOCATION_MZONE)
		c:RegisterEffect(e2)
		--Can attack directly
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetCode(EFFECT_DIRECT_ATTACK)
		c:RegisterEffect(e3)
	end
end
s.listed_series={0x666}
function s.DOOMfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x666)
end