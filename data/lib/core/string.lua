string.split = function(str, sep)
	local res = {}
	for v in str:gmatch("([^" .. sep .. "]+)") do
		res[#res + 1] = v
	end
	return res
end

string.trim = function(str)
	return str:match'^()%s*$' and '' or str:match'^%s*(.*%S)'
end

string.starts = function(str, substr)
	return string.sub(str, 1, #substr) == substr
end

string.titleCase = function(str)
	return str:gsub("(%a)([%w_']*)", function(first, rest) return first:upper() .. rest:lower() end)
end

string.msgInside = function(msg, arr)
	local splitStr = string.split(msg, "%p?%s%p?")

	for _, split in pairs(splitStr) do
		if table.contains(arr, split:lower()) then
			return true
		end

		return false
	end
end
