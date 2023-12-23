Sets
   i   Supply Nodes /S1*S5/
   j   Hub Nodes    /H1*H3/
   k   Demand Nodes /D1*D4/;

Parameters
   cost_s_h(i,j)   Shipping Costs from Supply Nodes to Hubs
   / S1.H1 10, S1.H2 15, S1.H3 20,
     S2.H1 18, S2.H2 12, S2.H3 16,
     S3.H1 25, S3.H2 18, S3.H3 28,
     S4.H1 14, S4.H2 19, S4.H3 17,
     S5.H1 30, S5.H2 18, S5.H3 35 /
   warehouse_cost(i,j) Warehouse Costs
   / S1.H1 5, S1.H2 6, S1.H3 8,
     S2.H1 6, S2.H2 5, S2.H3 7,
     S3.H1 7, S3.H2 9, S3.H3 6,
     S4.H1 4, S4.H2 7, S4.H3 5,
     S5.H1 8, S5.H2 10, S5.H3 9 /
   cost_h_d(j,k) Shipping Costs from Hubs to Demand Nodes
   / H1.D1 12, H1.D2 8, H1.D3 15, H1.D4 10,
     H2.D1 10, H2.D2 14, H2.D3 12, H2.D4 7,
     H3.D1 15, H3.D2 11, H3.D3 18, H3.D4 14 /
   hub_cost(j) Hub Costs
   / H1 5000, H2 6000, H3 7000 /
   supply_capacity(i) Supply Capacities
   / S1 100, S2 150, S3 200, S4 120, S5 180 /
   demand_requirement(k) Demand Requirements
   / D1 80, D2 90, D3 70, D4 110 /
   warehouse_capacity(i, j) Warehouse Capacities
   / S1.H1 120, S1.H2 150, S1.H3 180,
     S2.H1 130, S2.H2 160, S2.H3 190,
     S3.H1 110, S3.H2 140, S3.H3 170,
     S4.H1 100, S4.H2 130, S4.H3 160,
     S5.H1 90, S5.H2 120, S5.H3 150 /;

Variables
   x(i,j) Goods Shipped from Supply Nodes to Hubs
   w(i,j) Goods Stored at Warehouses
   y(j,k) Goods Shipped from Hubs to Demand Nodes
   hub_presence(j) Binary Variable for Hub Presence
   Z;  

Positive Variable x, w, y;  

Binary Variable hub_presence(j);

Equations
   supply_constraint(i) Supply Constraint
   demand_constraint(k) Demand Constraint
   warehouse_capacity_constraint(i,j) Warehouse Capacity Constraint
   flow_conservation_at_hub(j) Flow Conservation at Hub
   hub_presence_constraints_positive(j) Hub Presence Constraints (Positive)
   hub_presence_constraints_negative(j) Hub Presence Constraints (Negative)
   objective_function Objective Function;
   
supply_constraint(i).. sum(j, x(i,j)) =l= supply_capacity(i);

demand_constraint(k).. sum(j, y(j,k)) =g= demand_requirement(k);

warehouse_capacity_constraint(i,j).. w(i,j) =l= warehouse_capacity(i,j);

flow_conservation_at_hub(j).. sum(i, x(i,j)) + sum(i, w(i,j)) =e= sum(k, y(j,k));

hub_presence_constraints_positive(j).. hub_presence(j) =l= sum(i, w(i,j));

hub_presence_constraints_negative(j).. hub_presence(j) =g= sum(i, w(i,j));

objective_function.. Z =e= sum((i,j), x(i,j) * cost_s_h(i,j) + w(i,j) * warehouse_cost(i,j))
                  + sum((j,k), y(j,k) * cost_h_d(j,k) + hub_cost(j) * hub_presence(j));

Model transport /all/;

Solve transport using MIP minimizing Z;

Display x.l, w.l, y.l, hub_presence.l, Z.l;
