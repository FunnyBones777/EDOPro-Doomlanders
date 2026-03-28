--Doomlander Bill
--Scripted by FunnyBones777
local s,id=GetID()
function s.initial_effect(c)
	--Enable pendulum summon
	Pendulum.AddProcedure(c)
    --Take no battle or effect damage
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CHANGE_DAMAGE)
	e1:SetRange(LOCATION_PZONE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetLabel(0)
	e1:SetCondition(s.ndcon)
	e1:SetValue(s.damval)
	c:RegisterEffect(e1)
end
s.listed_names={77777005}
function s.ndcfilter(c)
	return c:IsFaceup() and c:IsCode(77777005)
end
function s.ndcon(e)
	return Duel.IsExistingMatchingCard(s.ndcfilter,e:GetHandlerPlayer(),LOCATION_ONFIELD,0,1,nil)
end
function s.damval(e,re,val,r,rp,rc)
	local tp=e:GetHandlerPlayer()
	if val~=0 then
		e:SetLabel(val)
		return 0
	else return val end
end