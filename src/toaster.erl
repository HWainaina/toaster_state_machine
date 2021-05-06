%%%-------------------------------------------------------------------
%%% @author henrywainaina
%%% @copyright (C) 2021, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 05. May 2021 12:05
%%%-------------------------------------------------------------------
-module(toaster).
-author("henrywainaina").

%% API
-export([start/0, toast/2,insert_bread/1,cancel/1,reheat/2,defrost/2]).

start() ->
  spawn(fun() -> off() end).

toast(Pid,Time ) -> Pid ! {toast, Time}.

reheat(Pid, Time) -> Pid ! {reheat, Time}.

defrost(Pid, Time) -> Pid !{defrost, Time}.

insert_bread(Pid) -> Pid ! bread.

cancel(Pid) -> Pid ! cancel.

off() ->
  io:format("Toaster is ready for bread"),
  receive
    bread ->
      io:format("Ready to toast~n");
    {toast, Time} ->
      toasting(Time);
    {reheating, Time} ->
      reheating(Time);
    {defrost,Time } ->
      defrosting(Time);
    _->
      io:format("Invalid Input.~n")
  end.
defrosting(Time) ->
  io:format("Toasting...~n"),
  receive
    cancel ->
      pop();
    _->
      io:format("Invalid Input.~n")
  after Time * 10000 ->
    pop()
  end.

reheating(Time) ->
  io:format("Reheating...~n"),
  receive
    cancel ->
      pop();
    _->
      io:format("Invalid Input.~n")
  after Time * 10000 ->
    pop()
  end.

toasting(Time) ->
  io:format("Toasting..~n"),
  receive
    cancel ->
      pop();
    _->
      io:format("Invalid Input.~n")

  after Time * 10000 ->
    pop()
  end.

pop() ->
  io:format("Bread toasted~n"),
  off().




