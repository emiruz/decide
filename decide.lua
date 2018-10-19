local dec = {}

function dec.make(trans, initial, state)
   if trans == nil or #trans == 0 then
      error("Transition table cannot be empty.")
   end
   local r = { tra = {},
	       state = state or {},
	       nxt = nil,
	       hlt = false }
   local tra = r.tra
   for i = 1, #trans do
      local t = trans[i]
      if type(t["FR"]) ~= "function" then
	 error ("FR (from) must be specified and of type 'function'.")
      end
      tra[i] = { FR=t.FR, TO=t.TO, EN=t.EN }
      if r.nxt == nil and (t.FR == initial or t.TO == initial) then
	 r.nxt = initial
      end
   end
   setmetatable(r, {__index = dec})
   return r
end

function dec.stop(self)
   self.hlt = true
end

function dec.inc(self)
   if self.hlt then return nil end
   if self.nxt == nil then error ("No initial state.") end
   self.nxt(self.state)
   for i=1,#self.tra do
      local t = self.tra[i]
      if t.FR == self.nxt and (t.EN == nil or t.EN(self.state)) then
	 self.nxt = t.TO
	 self.hlt = (t.TO == nil)
	 if self.hlt then return nil end
	 return self.state
      end
   end
   self.nxt = nil
   self.hlt = true
   return nil
end

return dec
