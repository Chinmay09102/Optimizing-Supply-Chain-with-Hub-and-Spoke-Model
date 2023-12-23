Sets
   i   Supply Nodes /S1*S5/
   k   Demand Nodes /D1*D4/;

Parameters
   supply_capacity(i) Supply Capacities
   / S1 100, S2 150, S3 200, S4 120, S5 180 /
   demand_requirement(k) Demand Requirements
   / D1 80, D2 90, D3 70, D4 110 /
   cost_s_d(i,k)   Shipping Costs from Supply Nodes to Demand Nodes
   / S1.D1 22, S1.D2 18, S1.D3 25, S1.D4 20,
     S2.D1 30, S2.D2 24, S2.D3 28, S2.D4 21,
     S3.D1 37, S3.D2 33, S3.D3 40, S3.D4 36,
     S4.D1 26, S4.D2 31, S4.D3 29, S4.D4 27,
     S5.D1 40, S5.D2 36, S5.D3 45, S5.D4 34 /;

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
