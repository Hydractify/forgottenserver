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
	local splitStr = string.split(msg, "%s*%p?%s%p?%s*")

	for _, split in pairs(splitStr) do
		for _, keyword in pairs(arr) do
			if string.match(split, keyword) then
				return true
			end
		end

		return false
	end
end
