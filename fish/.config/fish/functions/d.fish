# move up to top parent dir which is a repository
function d --description "move up to parent dir which is a repo"
	while test $PWD != "/"
		if test -d .git
			break
		end
		cd ..
	end
end
