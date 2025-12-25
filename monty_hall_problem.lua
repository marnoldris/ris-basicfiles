--[[ Challenge students to do this but with an assert for the win percentages --]]

local function mhp(change)
	local change = change or nil

	local choices = {1, 2, 3}
	local win = math.random(#choices)
	local choice = table.remove(choices, math.random(#choices))
	local reveal
	for i, v in ipairs(choices) do
		if v ~= win then
			reveal = table.remove(choices, i)
		end
	end

	if not change then
		return choice == win
	else
		choice = choices[1]
		return choice == win
	end
end

local TRIALS = 10000000

local wins = 0
for i=1, TRIALS do
	if mhp() then
		wins = wins + 1
	end
end
print('No change win percentage: ' .. wins/TRIALS*100 .. '%')

wins = 0
for i=1, TRIALS do
	if mhp(true) then
		wins = wins + 1
	end
end
print('Change win percentage:    ' .. wins/TRIALS*100 .. '%')
