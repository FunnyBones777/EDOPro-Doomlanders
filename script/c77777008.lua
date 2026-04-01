local s,id=GetID()
function s.initial_effect(c)
	--pendulum summon
	Pendulum.AddProcedure(c)
	--disable special summon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DISABLE_SUMMON+CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_SPSUMMON)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCountLimit(1)
	e1:SetCost(Cost.PayLP(500))
	e1:SetTarget(s.distg)
	e1:SetOperation(s.disop)
	c:RegisterEffect(e1)
	--"Earthbound Immortal" monsters cannot be destroyed by their own effects
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,SET_EARTHBOUND_IMMORTAL))
	e2:SetValue(s.efilter)
	c:RegisterEffect(e2)
end
s.listed_series={SET_EARTHBOUND_IMMORTAL}
function s.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE_SUMMON,eg,#eg,0,0)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,eg,#eg,0,0)
end
function s.disop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateSummon(eg)
	Duel.Destroy(eg,REASON_EFFECT)
end
function s.efilter(e,re,rp,c)
	return re:GetOwner()==c
end