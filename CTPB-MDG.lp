%==============================================================================
% Author information
%==============================================================================
% MOTIVATION DECISION-GRAPH
% Heuristics in the action language: C-TPB.
%
% Theoretical base:
% * Based on theory of planned behavior.
% * Qualitative studies with experts in psychology and occupational theraphy.
%
% * Author: Andreas Brännström
% * E-mail: andreasb@cs.umu.se
% * Department of computing science
% * Umeå university, SE-901 87, Umeå, Sweden
% * 2021-05-18
%
%==============================================================================
% Running the program
%==============================================================================
%
% C:\clingo>clingo CTPB.lp
% clingo version 4.5.4
% Reading from CTPB.lp
% Solving...
% Answer: 1
% motivate(attitude,2,1) motivate(attitude,3,2) motivate(control,2,3) motivate(norm,2,4) motivate(norm,3,5) motivate(control,3,6)
% SATISFIABLE
% 
% Models       : 1+
% Calls        : 1
% Time         : 0.007s (Solving: 0.00s 1st Model: 0.00s Unsat: 0.00s)
% CPU Time     : 0.016s
%
%==============================================================================
% Logic Program: Motivation Decision Grapgh
%==============================================================================

% Knowledge base
%==============================================================================
value(1..3).
mind(attitude).
mind(norm).
mind(control).

% Observation
%==============================================================================
init_on(attitude,1).
init_on(norm,1).
init_on(control,1).

% Goal
%==============================================================================
goal_on(attitude,3).
goal_on(norm,3).
goal_on(control,3).

plan_length(6).

% Display
#show motivate/3.

% Generate
%==============================================================================
{ motivate(MS,V,T) : mind(MS), value(V) } = 1 :- plan_length(M),  T = 1..M.

% Define
%==============================================================================
motivate(MS,T)	:- motivate(MS,_,T).
on(MS,V,0)   	:- init_on(MS,V).
on(MS,V,T)   	:- motivate(MS,V,T).
on(MS,V,T+1) 	:- on(MS,V,T), not motivate(MS,T+1), not plan_length(T).

blocked(MS,V-1,T+1) :- on(MS,V,T), not plan_length(T).
blocked(MS,V-1,T)   :- blocked(MS,V,T), value(V).

% C-TPB: Integrity constraints
%==============================================================================
:- motivate(MS,V,T), blocked(MS,V,T).
:- motivate(MS,T), on(MS,V,T-1), blocked(MS,V,T).

:- goal_on(MS,V), not on(MS,V,M), plan_length(M).
:- { on(MS,V,T) } != 1, mind(MS), plan_length(M), T = 1..M.


% Restrict from decreasing mental states
% Attitude
:- motivate(attitude, 1, T+1), on(attitude, 1, T).
:- motivate(attitude, 2, T+1), on(attitude, 2, T).
:- motivate(attitude, 3, T+1), on(attitude, 3, T).
:- motivate(attitude, 3, T+1), on(attitude, 1, T).
:- motivate(attitude, 1, T+1), on(attitude, 3, T).
:- motivate(attitude, 2, T+1), on(attitude, 3, T).

% Norm
:- motivate(norm, 1, T+1), on(norm, 1, T).
:- motivate(norm, 2, T+1), on(norm, 2, T).
:- motivate(norm, 3, T+1), on(norm, 3, T).
:- motivate(norm, 3, T+1), on(norm, 1, T).
:- motivate(norm, 1, T+1), on(norm, 3, T).
:- motivate(norm, 2, T+1), on(norm, 3, T).

% Control
:- motivate(control, 1, T+1), on(control, 1, T).
:- motivate(control, 2, T+1), on(control, 2, T).
:- motivate(control, 3, T+1), on(control, 3, T).
:- motivate(control, 3, T+1), on(control, 1, T).
:- motivate(control, 1, T+1), on(control, 3, T).
:- motivate(control, 2, T+1), on(control, 3, T).

% Prioritize to push attitude away from a negative state whenever possible, i.e., to a medium or positive state. 
:- motivate(norm, 2, T+1), on(attitude, 1, T).
:- motivate(norm, 3, T+1), on(attitude, 1, T).
:- motivate(norm, 2, T+1), on(attitude, 2, T).
:- motivate(control, 2, T+1), on(attitude, 1, T).
:- motivate(control, 3, T+1), on(attitude, 1, T).
:- motivate(control, 2, T+1), on(attitude, 2, T).

% Prioritize to push subjective norm away from a negative state, if attitude is at least medium and control is positive.
:- motivate(control, 3, T+1), on(norm, 2, T).

% Prioritize to push control away from a negative state if an internal or external motivator is already present, i.e., if attitude or subjective norm is at least medium.
:- motivate(norm, 3, T+1), on(control, 1, T).




