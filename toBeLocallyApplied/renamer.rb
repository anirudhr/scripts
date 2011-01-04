#!/usr/bin/ruby

preStr = 'keeley_'

for i in `ls` do
	i.chomp!
	ch = 0
	for k in 0..6 do
		ch += 1 if i[k] == preStr[k]
	end
	if ch < 7 then
		j = preStr + i
		`mv "#{i}" "#{j}"`
	end
	#puts i, j
#puts i
end

`mv "#{preStr}renamer.rb renamer.rb`
