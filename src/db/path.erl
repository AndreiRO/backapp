-module(path).
-export([sanitize/1]).


%%% Sanitize paths so a user won't try to do ../.. etc.

sanitize(Str) -> sanitize(Str, []).
sanitize("", Acc) -> Acc;
sanitize(Str, Acc) ->
	[Current | Others] = Str,
	if 
		Current =:= $. orelse 
		Current =:= $~ orelse
		Current =:= $\\ orelse
		Current =:= $/ 			-> 
									sanitize(Others, Acc ++ [$_]);
		true					->
									sanitize(Others, Acc ++ [Current])
	end
.