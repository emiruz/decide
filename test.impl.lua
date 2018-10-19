-- Smoke test for a simple counting flow.

D = require 'decide'

-- State machine definition starts here.

function inc_val(state) state.val = state.val + 1 end
function mul_val(state) state.val = 1 + state.val * 2 end

trans = {
   { FR=inc_val, EN=function(s) return s.val > 100 end },
   { FR=inc_val, TO=mul_val, EN=function(s) return s.val%5==0 end },
   { FR=inc_val, TO=inc_val },
   { FR=mul_val, TO=inc_val }
}

d = D.make(trans, inc_val, {val = 0})

-- Ends here.

-- Assertion tests to make sure output sequence is correct.

local cnt = 0
for i=1, 100 do
   if cnt % 5 == 0 then cnt = 1 + cnt * 2
   else cnt = cnt + 1
   end
   d:inc()
   assert (d.state.val == cnt)
   if cnt > 100 then break end
end
d:inc()
assert(d.hlt == true and d:inc() == nil)
