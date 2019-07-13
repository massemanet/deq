%% -*- mode: erlang; erlang-indent-level: 4 -*-
-module(deq).

-export([popl/1, popr/1, pushl/2, pushr/2, length/1]).

-record(deq,
       {left = [] :: list(),
        right = [] :: list(),
        length = 0 :: integer()}).

length(#deq{length = Len}) ->
    Len;
length(_) ->
    error(bad_arg).

popl(#deq{left = [], right = []}) ->
    error({no_data});
popl(#deq{left = [], right = Rs} = DEQ) ->
    popl(DEQ#deq{left = lists:reverse(Rs), right = []});
popl(#deq{left = [L|Ls], length = Len} = DEQ) ->
    {L, DEQ#deq{left = Ls, length = Len-1}};
popl(_) ->
    error(bad_arg).

popr(#deq{left = [], right = []}) ->
    error({no_data});
popr(#deq{left = Ls, right = []} = DEQ) ->
    popr(DEQ#deq{left = [], right = lists:reverse(Ls)});
popr(#deq{right = [R|Rs], length = Len} = DEQ) ->
    {R, DEQ#deq{right = Rs, length = Len-1}};
popr(_) ->
    error(bad_arg).

pushl(Val, #deq{left = Ls, length = Len} = DEQ) ->
    DEQ#deq{left = [Val|Ls], length = Len+1};
pushl(_, _) ->
    error(bad_arg).

pushr(Val, #deq{right = Rs, length = Len} = DEQ) ->
    DEQ#deq{right = [Val|Rs], length = Len+1};
pushr(_, _) ->
    error(bad_arg).
