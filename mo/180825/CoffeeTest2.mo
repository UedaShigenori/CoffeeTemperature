model CoffeeTest2
  parameter Real R = 70/1000 "radius of cup";
  parameter Real L = 85/1000  "height of cup";
  parameter Real level_start = 40/1000  "初期水位";
  parameter Real cup_thick = 3/1000  "thichness of cup";
  parameter Real rho = 2200 "陶器密度　https://www.hakko.co.jp/qa/qakit/html/h01010.htm";
  parameter Real V=((R+cup_thick)^2 - R^2 ) * 3.14 * L  "volume of cup";
   parameter Real cp=1050;
   
  replaceable package Medium = Modelica.Media.Water.StandardWater;
 
  Modelica.Fluid.Vessels.OpenTank tank(redeclare package Medium = Medium, T_start = 273.15 + 90, crossArea = R ^ 2 * 3.14, height = L, level_start = level_start, nPorts = 0, use_HeatTransfer = true, use_portsData = false) annotation(
    Placement(visible = true, transformation(origin = {50, -30}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
  inner Modelica.Fluid.System system annotation(
    Placement(visible = true, transformation(origin = {-140, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.Convection convection1 annotation(
    Placement(visible = true, transformation(origin = {-2, 8}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const(k = 10 * R ^ 2 * 3.14) annotation(
    Placement(visible = true, transformation(origin = {-4, 48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor1(G = 1.3 * 2 * (R + cup_thick) * 3.14 / cup_thick / 2) annotation(
    Placement(visible = true, transformation(origin = {-30, -76}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.Convection convection2 annotation(
    Placement(visible = true, transformation(origin = {-94, -76}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const1(k = 10 * 2 * R * 3.14 * L) annotation(
    Placement(visible = true, transformation(origin = {-94, -38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature2(T = 296.15) annotation(
    Placement(visible = true, transformation(origin = {-140, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor2(G = 1.3 * 2 * (R + cup_thick) * 3.14 / cup_thick / 2)  annotation(
    Placement(visible = true, transformation(origin = {-58, -76}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor1(C = cp * V * rho, T(fixed = true, start = 363.15)) annotation(
    Placement(visible = true, transformation(origin = {-44, -46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.Convection convection3 annotation(
    Placement(visible = true, transformation(origin = {-96, -120}, extent = {{10, 10}, {-10, -10}}, rotation = 0)));
  Modelica.Blocks.Sources.Constant const2(k = 1000 * R ^ 2 * 3.14) annotation(
    Placement(visible = true, transformation(origin = {-98, -158}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(const2.y, convection3.Gc) annotation(
    Line(points = {{-86, -158}, {-96, -158}, {-96, -130}, {-96, -130}}, color = {0, 0, 127}));
  connect(convection3.fluid, fixedTemperature2.port) annotation(
    Line(points = {{-106, -120}, {-130, -120}, {-130, -10}, {-130, -10}}, color = {191, 0, 0}));
  connect(thermalConductor2.port_a, convection3.solid) annotation(
    Line(points = {{-68, -76}, {-76, -76}, {-76, -120}, {-86, -120}, {-86, -120}}, color = {191, 0, 0}));
  connect(convection1.solid, tank.heatPort) annotation(
    Line(points = {{8, 8}, {17, 8}, {17, -30}, {30, -30}}, color = {191, 0, 0}));
  connect(thermalConductor1.port_b, tank.heatPort) annotation(
    Line(points = {{-20, -76}, {16, -76}, {16, -30}, {30, -30}}, color = {191, 0, 0}));
  connect(const1.y, convection2.Gc) annotation(
    Line(points = {{-83, -38}, {-84.5, -38}, {-84.5, -38}, {-88, -38}, {-88, -36}, {-97, -36}, {-97, -64}, {-95, -64}, {-95, -66}, {-95, -66}, {-95, -66}, {-95, -66}}, color = {0, 0, 127}));
  connect(convection2.fluid, fixedTemperature2.port) annotation(
    Line(points = {{-104, -76}, {-130, -76}, {-130, -10}}, color = {191, 0, 0}));
  connect(thermalConductor2.port_a, convection2.solid) annotation(
    Line(points = {{-68, -76}, {-84, -76}}, color = {191, 0, 0}));
  connect(heatCapacitor1.port, thermalConductor1.port_a) annotation(
    Line(points = {{-44, -56}, {-44, -56}, {-44, -56}, {-44, -56}, {-44, -76}, {-40, -76}, {-40, -76}, {-40, -76}, {-40, -76}}, color = {191, 0, 0}));
  connect(thermalConductor2.port_b, heatCapacitor1.port) annotation(
    Line(points = {{-48, -76}, {-44, -76}, {-44, -56}, {-44, -56}}, color = {191, 0, 0}));
  connect(fixedTemperature2.port, convection1.fluid) annotation(
    Line(points = {{-130, -10}, {-128, -10}, {-128, 8}, {-12, 8}, {-12, 8}}, color = {191, 0, 0}));
  connect(const.y, convection1.Gc) annotation(
    Line(points = {{7, 48}, {2.5, 48}, {2.5, 50}, {-2, 50}, {-2, 33}, {-2, 33}, {-2, 18}}, color = {0, 0, 127}));
  annotation(
    Documentation(info = "<html>
<p>
熱伝導率
http://japan-miyabi.com/thermal_light/data/03/conductivity.htm
</p>
</html>"),
    uses(Modelica(version = "3.2.2")),
    Diagram(coordinateSystem(extent = {{-200, -200}, {200, 200}})),
    Icon(coordinateSystem(extent = {{-200, -200}, {200, 200}})),
    version = "",
    __OpenModelica_commandLineOptions = "");
end CoffeeTest2;
