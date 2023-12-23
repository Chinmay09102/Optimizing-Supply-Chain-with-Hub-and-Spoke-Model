Sets
   i   Supply Nodes /S1*S5/
   k   Demand Nodes /D1*D8/;

Parameters
   supply_capacity(i) Supply Capacities
   / S1 100, S2 150, S3 200, S4 120, S5 180 /
   demand_requirement(k) Demand Requirements
   / D1 80, D2 90, D3 70, D4 110,D5 70, D6 60, D7 80, D8 190 /
   cost_s_d(i,k)   Shipping Costs from Supply Nodes to Demand Nodes
   / S1.D1 22, S1.D2 18, S1.D3 25, S1.D4 20,S1.D5 18, S1.D6 14, S1.D7 22, S1.D8 30,
     S2.D1 30, S2.D2 24, S2.D3 28, S2.D4 21,S2.D5 28, S2.D6 27, S2.D7 22, S2.D8 20,
     S3.D1 37, S3.D2 33, S3.D3 40, S3.D4 36,S3.D5 27, S3.D6 23, S3.D7 34, S3.D8 29,
     S4.D1 26, S4.D2 31, S4.D3 29, S4.D4 27,S4.D5 26, S4.D6 31, S4.D7 29, S4.D8 27,
     S5.D1 40, S5.D2 36, S5.D3 45, S5.D4 34,S5.D5 33, S5.D6 31, S5.D7 30, S5.D8 31 /;

Variables
   x(i,k) Goods Shipped from Supply Nodes to Demand Nodes
   Z;  

Positive Variable x;

Equations
   supply_constraint(i) Supply Constraint
   demand_constraint(k) Demand Constraint
   objective_function Objective Function;

supply_constraint(i).. sum(k, x(i,k)) =l= supply_capacity(i);

demand_constraint(k).. sum(i, x(i,k)) =g= demand_requirement(k);

objective_function.. Z =e= sum((i,k), x(i,k) * cost_s_d(i,k));

Model transport /all/;

Solve transport using LP minimizing Z;

Display x.l, Z.l;
