# c-tpb-motivation-decision-graph

Motivation decision-graph (MDG). A heuristic for human-aware planning. The MDG is modelled in the structure of a transiton system using Action Reasoning-based Answer Set Programming. States correspond to mental states of a human agent. Transitions correspond to suitable motivational focus for changing mental state given an estimated mental state. The system is modelled following a psychological theory, the theory of planned behavior (TPB), and shaped following a knowledge elicitation study with experts, e.g., psychologists.

The motivation decision-graph is formalized by the semantics of an action language (defined elsewhere) for reasoning about facilitation of human health behavior-change.

### Knowledge elicitation

The MDG is the result of a knowledge elicitation process. A qualitative study with 15 domain experts (psychologists, physiotherapists, occupational therapists, and special education teachers) was conducted. The study found that the most influential sources of motivation in a moment depends on an individual's current motivational beliefs in terms of TPB. 

By assuming that the current mental state of an individual can be sufficiently recognized, i.e., the attitude (A), subjective norm (SN), and perceived behavioral control (PBC), and valuated in the scale Negative (inhibiting behavior), Medium (indifferent to behavior) and Positive (promoting behavior), the participating experts were asked how a person's motivation to a behavior should be boosted depending on the person's current mental state. E.g., if the person currently has a mental state where A is negative, SN is negative and PBC is negative, then which aspect should be prioritised to boost? If so, what about a similar case where A is medium? By following this approach, 27 states are specified, each state consisting of the variables A, SN, or PBC, in which each variable has a value of negative, medium, or positive. Following the experts’ suggestions, we can specify a state space with transition relations between states that represents a prioritised change of A, SN or PBC depending on the recognized mental state of the human. We can model these relations in terms of a weighted graph, called a motivation decision-graph.

### Prerequisites

CLINGO: https://potassco.org/clingo/

CLINGO is an Answer Set Programming system to ground and solve logic programs.

### Running the program

Command line: C:\clingo>clingo CTPB-MDG.lp

The program generates a plan (sequence of transitions) that follows the experts' suggestions for motivational focus, based on a current observed mental state leading to a goal mental state.

Example configuration: 

``` 
% Current Mental State
% ===========================
init_on(attitude,1).
init_on(norm,1).
init_on(control,1).

% Goal State
% ===========================
goal_on(attitude,3).
goal_on(norm,3).
goal_on(control,3).

% 1=Negative, 2=Medium, 3=Positive.

% Number of generated actions
% ===========================
plan_length(6).
```

Example output:

```
clingo version 4.5.4
Reading from CTPB-MDG.lp
Solving...
Answer: 1
motivate(attitude,2,1) motivate(attitude,3,2) motivate(control,2,3) motivate(norm,2,4) motivate(norm,3,5) motivate(control,3,6)
SATISFIABLE
 
Models       : 1+
Calls        : 1
Time         : 0.007s (Solving: 0.00s 1st Model: 0.00s Unsat: 0.00s)
CPU Time     : 0.016s
```


### Authors

* Andreas Brännström {andreasb@cs.umu.se} [Homepage](https://people.cs.umu.se/andreasb/)
* Juan Carlos Nieves {jcnieves@cs.umu.se} [Homepage](https://www.umu.se/en/staff/juan-carlos-nieves/)

Department of Computing Science  
Umeå university  
SE-901 87, Umeå, Sweden  
