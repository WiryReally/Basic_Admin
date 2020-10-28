function help()
	for i , v in pairs(getfenv()) do
		if type(v) == "function" and i ~= 'help' then
			print(i , )
		end
	end
end

return getfenv()
