package CoffeeTemperature
  package Test
    model CoffeeTest2
      parameter Real R = 70 / 1000 "radius of cup";
      parameter Real L = 85 / 1000 "height of cup";
      parameter Real level_start = 40 / 1000 "初期水位";
      parameter Real cup_thick = 3 / 1000 "thichness of cup";
      parameter Real rho = 2200 "陶器密度　https://www.hakko.co.jp/qa/qakit/html/h01010.htm";
      parameter Real V = ((R + cup_thick) ^ 2 - R ^ 2) * 3.14 * L "volume of cup";
      parameter Real cp = 1050;
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
      Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor2(G = 1.3 * 2 * (R + cup_thick) * 3.14 / cup_thick / 2) annotation(
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

    model CoffeeTest3
      import pi = Modelica.Constants.pi;
      //cup parameter
      parameter Real R = 70 / 1000 "radius of cup";
      parameter Real L = 85 / 1000 "height of cup";
      parameter Real level_start = 40 / 1000 "初期水位";
      parameter Real cup_thick = 3 / 1000 "thichness of cup";
      parameter Real rho = 2200 "陶器密度　https://www.hakko.co.jp/qa/qakit/html/h01010.htm";
      parameter Real V = ((R + cup_thick) ^ 2 - R ^ 2) * 3.14 * L "volume of cup";
      parameter Real cp = 1050;
      //dripper parameter
      parameter Real drip_D = 5 / 1000 "ドリッパーの直径";
      parameter Real drip_L = 10 / 1000 "ドリッパーの長さ";
      replaceable package Medium = Modelica.Media.Water.StandardWater;
      Modelica.Fluid.Vessels.OpenTank cup(redeclare package Medium = Medium, T_start = 273.15 + 90, crossArea = R ^ 2 * 3.14, height = L, level_start = 0, nPorts = 1, portsData = {Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter = 5 / 1000, height = 70 / 1000)}, use_HeatTransfer = true, use_portsData = true) annotation(
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
      Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor2(G = 1.3 * 2 * (R + cup_thick) * 3.14 / cup_thick / 2) annotation(
        Placement(visible = true, transformation(origin = {-58, -76}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor1(C = cp * V * rho, T(fixed = true, start = 363.15)) annotation(
        Placement(visible = true, transformation(origin = {-44, -46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Components.Convection convection3 annotation(
        Placement(visible = true, transformation(origin = {-96, -120}, extent = {{10, 10}, {-10, -10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant const2(k = 1000 * R ^ 2 * 3.14) annotation(
        Placement(visible = true, transformation(origin = {-98, -158}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Vessels.OpenTank tank1(redeclare package Medium = Medium, T_start = 273.15 + 90, crossArea = R ^ 2 * 3.14, height = L, level_start = level_start, nPorts = 1, portsData = {Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter = 5 / 1000)}, use_HeatTransfer = false, use_portsData = true) annotation(
        Placement(visible = true, transformation(origin = {50, 98}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Modelica.Fluid.Pipes.DynamicPipe pipe(redeclare package Medium = Medium, crossArea = pi * drip_D ^ 2 / 4, diameter = drip_D, length = drip_L, perimeter = pi * drip_D) annotation(
        Placement(visible = true, transformation(origin = {50, 34}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    equation
      connect(pipe.port_b, cup.ports[1]) annotation(
        Line(points = {{50, 24}, {50, 24}, {50, -50}, {50, -50}}, color = {0, 127, 255}));
      connect(tank1.ports[1], pipe.port_a) annotation(
        Line(points = {{50, 78}, {50, 78}, {50, 44}, {50, 44}}, color = {0, 127, 255}, thickness = 0.5));
      connect(const2.y, convection3.Gc) annotation(
        Line(points = {{-86, -158}, {-96, -158}, {-96, -130}, {-96, -130}}, color = {0, 0, 127}));
      connect(convection3.fluid, fixedTemperature2.port) annotation(
        Line(points = {{-106, -120}, {-130, -120}, {-130, -10}, {-130, -10}}, color = {191, 0, 0}));
      connect(thermalConductor2.port_a, convection3.solid) annotation(
        Line(points = {{-68, -76}, {-76, -76}, {-76, -120}, {-86, -120}, {-86, -120}}, color = {191, 0, 0}));
      connect(convection1.solid, cup.heatPort) annotation(
        Line(points = {{8, 8}, {17, 8}, {17, -30}, {30, -30}}, color = {191, 0, 0}));
      connect(thermalConductor1.port_b, cup.heatPort) annotation(
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
    end CoffeeTest3;

    model CoffeeTest4
      import pi = Modelica.Constants.pi;
      //cup parameter
      parameter Real R = 70 / 1000 "radius of cup";
      parameter Real L = 85 / 1000 "height of cup";
      parameter Real level_start = 40 / 1000 "初期水位";
      parameter Real cup_thick = 3 / 1000 "thichness of cup";
      parameter Real rho = 2200 "陶器密度　https://www.hakko.co.jp/qa/qakit/html/h01010.htm";
      parameter Real V = ((R + cup_thick) ^ 2 - R ^ 2) * 3.14 * L "volume of cup";
      parameter Real cp = 1050;
      //dripper parameter
      parameter Real drip_D = 5 / 1000 "ドリッパーの直径";
      parameter Real drip_L = 10 / 1000 "ドリッパーの長さ";
      replaceable package Medium = Modelica.Media.Water.StandardWater;
      Modelica.Fluid.Vessels.OpenTank cup(redeclare package Medium = Medium, T_start = 273.15 + 90, crossArea = R ^ 2 * 3.14, height = L, level_start = 0, nPorts = 1, portsData = {Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter = 5 / 1000, height = 70 / 1000)}, use_HeatTransfer = true, use_portsData = true) annotation(
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
      Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor2(G = 1.3 * 2 * (R + cup_thick) * 3.14 / cup_thick / 2) annotation(
        Placement(visible = true, transformation(origin = {-58, -76}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor1(C = cp * V * rho, T(fixed = true, start = 363.15)) annotation(
        Placement(visible = true, transformation(origin = {-44, -46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Components.Convection convection3 annotation(
        Placement(visible = true, transformation(origin = {-96, -120}, extent = {{10, 10}, {-10, -10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant const2(k = 1000 * R ^ 2 * 3.14) annotation(
        Placement(visible = true, transformation(origin = {-98, -158}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Vessels.OpenTank tank1(redeclare package Medium = Medium, T_start = 273.15 + 90, crossArea = R ^ 2 * 3.14, height = L, level_start = level_start, nPorts = 1, portsData = {Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter = 5 / 1000)}, use_HeatTransfer = false, use_portsData = true) annotation(
        Placement(visible = true, transformation(origin = {50, 98}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Modelica.Fluid.Pipes.DynamicPipe pipe(redeclare package Medium = Medium, crossArea = pi * drip_D ^ 2 / 4, diameter = drip_D, length = drip_L, perimeter = pi * drip_D) annotation(
        Placement(visible = true, transformation(origin = {50, 34}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    equation
      connect(pipe.port_b, cup.ports[1]) annotation(
        Line(points = {{50, 24}, {50, 24}, {50, -50}, {50, -50}}, color = {0, 127, 255}));
      connect(tank1.ports[1], pipe.port_a) annotation(
        Line(points = {{50, 78}, {50, 78}, {50, 44}, {50, 44}}, color = {0, 127, 255}, thickness = 0.5));
      connect(const2.y, convection3.Gc) annotation(
        Line(points = {{-86, -158}, {-96, -158}, {-96, -130}, {-96, -130}}, color = {0, 0, 127}));
      connect(convection3.fluid, fixedTemperature2.port) annotation(
        Line(points = {{-106, -120}, {-130, -120}, {-130, -10}, {-130, -10}}, color = {191, 0, 0}));
      connect(thermalConductor2.port_a, convection3.solid) annotation(
        Line(points = {{-68, -76}, {-76, -76}, {-76, -120}, {-86, -120}, {-86, -120}}, color = {191, 0, 0}));
      connect(convection1.solid, cup.heatPort) annotation(
        Line(points = {{8, 8}, {17, 8}, {17, -30}, {30, -30}}, color = {191, 0, 0}));
      connect(thermalConductor1.port_b, cup.heatPort) annotation(
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
    end CoffeeTest4;

    model CoffeeTest5
      import pi = Modelica.Constants.pi;
      //cup parameter
      parameter Real R = 70 / 1000 "radius of cup";
      parameter Real L = 85 / 1000 "height of cup";
      parameter Real level_start = 40 / 1000 "初期水位";
      parameter Real cup_thick = 3 / 1000 "thichness of cup";
      parameter Real rho = 2200 "陶器密度　https://www.hakko.co.jp/qa/qakit/html/h01010.htm";
      parameter Real V = ((R + cup_thick) ^ 2 - R ^ 2) * 3.14 * L "volume of cup";
      parameter Real cp = 1050;
      //dripper parameter
      parameter Real drip_D = 5 / 1000 "ドリッパーの直径";
      parameter Real drip_L = 10 / 1000 "ドリッパーの長さ";
      replaceable package Medium = Modelica.Media.Water.StandardWater;
      Modelica.Fluid.Vessels.OpenTank cup(redeclare package Medium = Medium, T_start = 273.15 + 90, crossArea = R ^ 2 * 3.14, height = L, level_start = 0, nPorts = 1, portsData = {Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter = 5 / 1000, height = 70 / 1000)}, use_HeatTransfer = true, use_portsData = true) annotation(
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
      Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor2(G = 1.3 * 2 * (R + cup_thick) * 3.14 / cup_thick / 2) annotation(
        Placement(visible = true, transformation(origin = {-58, -76}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor1(C = cp * V * rho, T(fixed = true, start = 363.15)) annotation(
        Placement(visible = true, transformation(origin = {-44, -46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Components.Convection convection3 annotation(
        Placement(visible = true, transformation(origin = {-96, -120}, extent = {{10, 10}, {-10, -10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant const2(k = 1000 * R ^ 2 * 3.14) annotation(
        Placement(visible = true, transformation(origin = {-98, -158}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Vessels.OpenTank tank1(redeclare package Medium = Medium, T_start = 273.15 + 90, crossArea = R ^ 2 * 3.14, height = L, level_start = level_start, nPorts = 1, portsData = {Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter = 5 / 1000)}, use_HeatTransfer = false, use_portsData = true) annotation(
        Placement(visible = true, transformation(origin = {50, 98}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    equation
      connect(tank1.ports[1], cup.ports[1]) annotation(
        Line(points = {{50, 78}, {50, 78}, {50, -50}, {50, -50}}, color = {0, 127, 255}, thickness = 0.5));
      connect(const2.y, convection3.Gc) annotation(
        Line(points = {{-86, -158}, {-96, -158}, {-96, -130}, {-96, -130}}, color = {0, 0, 127}));
      connect(convection3.fluid, fixedTemperature2.port) annotation(
        Line(points = {{-106, -120}, {-130, -120}, {-130, -10}, {-130, -10}}, color = {191, 0, 0}));
      connect(thermalConductor2.port_a, convection3.solid) annotation(
        Line(points = {{-68, -76}, {-76, -76}, {-76, -120}, {-86, -120}, {-86, -120}}, color = {191, 0, 0}));
      connect(convection1.solid, cup.heatPort) annotation(
        Line(points = {{8, 8}, {17, 8}, {17, -30}, {30, -30}}, color = {191, 0, 0}));
      connect(thermalConductor1.port_b, cup.heatPort) annotation(
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
    end CoffeeTest5;

    model CoffeeTest6
      import pi = Modelica.Constants.pi;
      //cup parameter
      parameter Real R = 73 / 1000 "radius of cup";
      parameter Real L = 96 / 1000 "height of cup";
      parameter Real level_start = 60 / 1000 "初期水位";
      parameter Real cup_t = 4 / 1000 "thichness of cup";
      parameter Real cup_t_bottom = 4 / 1000 "thichness of cup";
      parameter Real rho = 2200 "陶器密度　https://www.hakko.co.jp/qa/qakit/html/h01010.htm";
      parameter Real V = ((R + cup_t) ^ 2 - R ^ 2) * 3.14 * L "volume of cup";
      parameter Real cp = 1050;
      //dripper parameter
      parameter Real drip_D = 5 / 1000 "ドリッパーの直径";
      parameter Real drip_L = 10 / 1000 "ドリッパーの長さ";
      replaceable package Medium = Modelica.Media.Water.StandardWater;
      Modelica.Fluid.Vessels.OpenTank cup(redeclare package Medium = Medium, T_start = 273.15 + 23, crossArea = R ^ 2 * 3.14, height = L, level_start = 0, nPorts = 1, portsData = {Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter = 15 / 1000, height = 70 / 1000)}, use_HeatTransfer = true, use_portsData = true) annotation(
        Placement(visible = true, transformation(origin = {50, -30}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      inner Modelica.Fluid.System system annotation(
        Placement(visible = true, transformation(origin = {-140, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Components.Convection convection1 annotation(
        Placement(visible = true, transformation(origin = {-2, 8}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant const(k = 10 * R ^ 2 * 3.14) annotation(
        Placement(visible = true, transformation(origin = {-4, 48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor1(G = 1.3 * 2 * (R + cup_t) * 3.14 / cup_t / 2) annotation(
        Placement(visible = true, transformation(origin = {-30, -76}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Components.Convection convection2 annotation(
        Placement(visible = true, transformation(origin = {-94, -76}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant const1(k = 10 * 2 * R * 3.14 * L) annotation(
        Placement(visible = true, transformation(origin = {-94, -38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature2(T = 296.15) annotation(
        Placement(visible = true, transformation(origin = {-140, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor2(G = 1.3 * 2 * (R + cup_t) * 3.14 / cup_t / 2) annotation(
        Placement(visible = true, transformation(origin = {-58, -76}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor1(C = cp * V * rho, T(fixed = true, start = 296.15)) annotation(
        Placement(visible = true, transformation(origin = {-44, -46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Components.Convection convection3 annotation(
        Placement(visible = true, transformation(origin = {-96, -120}, extent = {{10, 10}, {-10, -10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant const2(k = 1000 * R ^ 2 * 3.14) annotation(
        Placement(visible = true, transformation(origin = {-98, -158}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Vessels.OpenTank tank1(redeclare package Medium = Medium, T_start = 273.15 + 90, crossArea = R ^ 2 * 3.14, height = L, level_start = level_start, nPorts = 1, portsData = {Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter = 5 / 1000)}, use_HeatTransfer = false, use_portsData = true) annotation(
        Placement(visible = true, transformation(origin = {50, 162}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Modelica.Fluid.Pipes.StaticPipe pipe(redeclare package Medium = Medium, diameter = 15 / 1000, height_ab = -50 / 1000, length = 50 / 1000) annotation(
        Placement(visible = true, transformation(origin = {50, 92}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Fluid.Valves.ValveIncompressible valveIncompressible1(redeclare package Medium = Medium, dp_nominal = 100000, filteredOpening = true, m_flow_nominal = 1) annotation(
        Placement(visible = true, transformation(origin = {50, 48}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Blocks.Sources.Ramp ramp1(duration = 5, offset = 1e-6, startTime = 5) annotation(
        Placement(visible = true, transformation(origin = {90, 50}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
    equation
      connect(valveIncompressible1.port_b, cup.ports[1]) annotation(
        Line(points = {{50, 38}, {50, 38}, {50, -50}, {50, -50}}, color = {0, 127, 255}));
      connect(pipe.port_b, valveIncompressible1.port_a) annotation(
        Line(points = {{50, 82}, {50, 82}, {50, 58}, {50, 58}}, color = {0, 127, 255}));
      connect(tank1.ports[1], pipe.port_a) annotation(
        Line(points = {{50, 142}, {50, 142}, {50, 102}, {50, 102}}, color = {0, 127, 255}, thickness = 0.5));
      connect(valveIncompressible1.opening, ramp1.y) annotation(
        Line(points = {{58, 48}, {80, 48}, {80, 50}}, color = {0, 0, 127}));
      connect(const2.y, convection3.Gc) annotation(
        Line(points = {{-86, -158}, {-96, -158}, {-96, -130}, {-96, -130}}, color = {0, 0, 127}));
      connect(convection3.fluid, fixedTemperature2.port) annotation(
        Line(points = {{-106, -120}, {-130, -120}, {-130, -10}, {-130, -10}}, color = {191, 0, 0}));
      connect(thermalConductor2.port_a, convection3.solid) annotation(
        Line(points = {{-68, -76}, {-76, -76}, {-76, -120}, {-86, -120}, {-86, -120}}, color = {191, 0, 0}));
      connect(convection1.solid, cup.heatPort) annotation(
        Line(points = {{8, 8}, {17, 8}, {17, -30}, {30, -30}}, color = {191, 0, 0}));
      connect(thermalConductor1.port_b, cup.heatPort) annotation(
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
        __OpenModelica_commandLineOptions = "",
        experiment(StartTime = 0, StopTime = 1200, Tolerance = 1e-6, Interval = 1.2));
    end CoffeeTest6;

    model CoffeeTest7
      import pi = Modelica.Constants.pi;
      //ambient
      parameter Real Tamb = 273.15 + 24.8 "radius of cup";
      //cup parameter
      parameter Real R = 73 / 1000 / 2 "radius of cup";
      parameter Real L = 96 / 1000 "height of cup";
      parameter Real level_start = 60 / 1000 "初期水位";
      parameter Real cup_t = 4 / 1000 "thichness of cup";
      parameter Real cup_t_bottom = 4 / 1000 "thichness of cup";
      parameter Real rho = 2200 "陶器密度　https://www.hakko.co.jp/qa/qakit/html/h01010.htm";
      parameter Real V = ((R + cup_t) ^ 2 - R ^ 2) * pi * L "volume of cup";
      parameter Real cp = 1050;
      parameter Real h = 15 "カップ-外気の熱伝達率";
      //dripper parameter
      parameter Real drip_D = 5 / 1000 "ドリッパーの直径";
      parameter Real drip_L = 10 / 1000 "ドリッパーの長さ";
      replaceable package Medium = Modelica.Media.Water.StandardWater;
      Modelica.Fluid.Vessels.OpenTank cup(redeclare package Medium = Medium, T_start = Tamb, crossArea = R ^ 2 * pi, height = L, level_start = 0, nPorts = 1, portsData = {Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter = R, height = 70 / 1000)}, use_HeatTransfer = true, use_portsData = true) annotation(
        Placement(visible = true, transformation(origin = {50, -30}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      inner Modelica.Fluid.System system annotation(
        Placement(visible = true, transformation(origin = {-114, 136}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Components.Convection convection1 annotation(
        Placement(visible = true, transformation(origin = {-2, 8}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant const(k = 30 * R ^ 2 * pi) annotation(
        Placement(visible = true, transformation(origin = {-4, 48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor1(G = 1.3 * 2 * (R + cup_t) * pi / cup_t / 2) annotation(
        Placement(visible = true, transformation(origin = {-2, -76}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Components.Convection convection2 annotation(
        Placement(visible = true, transformation(origin = {-94, -76}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant const1(k = h * 2 * (R + cup_t) * pi * L) annotation(
        Placement(visible = true, transformation(origin = {-94, -38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature2(T = Tamb) annotation(
        Placement(visible = true, transformation(origin = {-140, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor2(G = 1.3 * 2 * (R + cup_t) * pi / cup_t / 2) annotation(
        Placement(visible = true, transformation(origin = {-58, -76}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor1(C = cp * V * rho, T(fixed = true, start = Tamb)) annotation(
        Placement(visible = true, transformation(origin = {-44, -46}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Components.Convection convection3 annotation(
        Placement(visible = true, transformation(origin = {-96, -120}, extent = {{10, 10}, {-10, -10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant const2(k = h * (R + cup_t) ^ 2 * pi) annotation(
        Placement(visible = true, transformation(origin = {-98, -158}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Vessels.OpenTank yakan(redeclare package Medium = Medium, T_start = 273.15 + 98, crossArea = R ^ 2 * pi, height = L, level_start = level_start, nPorts = 1, portsData = {Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter = 5 / 1000)}, use_HeatTransfer = false, use_portsData = true) annotation(
        Placement(visible = true, transformation(origin = {50, 162}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Modelica.Fluid.Pipes.StaticPipe pipe(redeclare package Medium = Medium, diameter = 15 / 1000, height_ab = -50 / 1000, length = 50 / 1000) annotation(
        Placement(visible = true, transformation(origin = {50, 92}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Fluid.Valves.ValveIncompressible valveIncompressible1(redeclare package Medium = Medium, dp_nominal = 100000, filteredOpening = true, m_flow_nominal = 1) annotation(
        Placement(visible = true, transformation(origin = {50, 48}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Blocks.Sources.Ramp ramp1(duration = 1, offset = 1e-6, startTime = 0) annotation(
        Placement(visible = true, transformation(origin = {166, 50}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.CombiTimeTable combiTimeTable1(columns = 2:2, fileName = "C:/Work/2018/Coffee/Experiment/WaterTemp_1.txt", tableName = "Tab1", tableOnFile = true) annotation(
        Placement(visible = true, transformation(origin = {176, -180}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant const3(k = 1) annotation(
        Placement(visible = true, transformation(origin = {92, 48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      connect(const3.y, valveIncompressible1.opening) annotation(
        Line(points = {{103, 48}, {58, 48}}, color = {0, 0, 127}));
      connect(heatCapacitor1.port, thermalConductor1.port_a) annotation(
        Line(points = {{-44, -56}, {-44, -76}, {-12, -76}}, color = {191, 0, 0}));
      connect(thermalConductor1.port_b, cup.heatPort) annotation(
        Line(points = {{8, -76}, {16, -76}, {16, -30}, {30, -30}}, color = {191, 0, 0}));
      connect(valveIncompressible1.port_b, cup.ports[1]) annotation(
        Line(points = {{50, 38}, {50, 38}, {50, -50}, {50, -50}}, color = {0, 127, 255}));
      connect(pipe.port_b, valveIncompressible1.port_a) annotation(
        Line(points = {{50, 82}, {50, 82}, {50, 58}, {50, 58}}, color = {0, 127, 255}));
      connect(yakan.ports[1], pipe.port_a) annotation(
        Line(points = {{50, 142}, {50, 142}, {50, 102}, {50, 102}}, color = {0, 127, 255}, thickness = 0.5));
      connect(const2.y, convection3.Gc) annotation(
        Line(points = {{-86, -158}, {-96, -158}, {-96, -130}, {-96, -130}}, color = {0, 0, 127}));
      connect(convection3.fluid, fixedTemperature2.port) annotation(
        Line(points = {{-106, -120}, {-130, -120}, {-130, -10}, {-130, -10}}, color = {191, 0, 0}));
      connect(thermalConductor2.port_a, convection3.solid) annotation(
        Line(points = {{-68, -76}, {-76, -76}, {-76, -120}, {-86, -120}, {-86, -120}}, color = {191, 0, 0}));
      connect(convection1.solid, cup.heatPort) annotation(
        Line(points = {{8, 8}, {17, 8}, {17, -30}, {30, -30}}, color = {191, 0, 0}));
      connect(const1.y, convection2.Gc) annotation(
        Line(points = {{-83, -38}, {-84.5, -38}, {-84.5, -38}, {-88, -38}, {-88, -36}, {-97, -36}, {-97, -64}, {-95, -64}, {-95, -66}, {-95, -66}, {-95, -66}, {-95, -66}}, color = {0, 0, 127}));
      connect(convection2.fluid, fixedTemperature2.port) annotation(
        Line(points = {{-104, -76}, {-130, -76}, {-130, -10}}, color = {191, 0, 0}));
      connect(thermalConductor2.port_a, convection2.solid) annotation(
        Line(points = {{-68, -76}, {-84, -76}}, color = {191, 0, 0}));
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
        __OpenModelica_commandLineOptions = "",
        experiment(StartTime = 0, StopTime = 2400, Tolerance = 1e-06, Interval = 2.4));
    end CoffeeTest7;

    model CoffeeTest8
      import pi = Modelica.Constants.pi;
      //ambient
      parameter Real Tamb = 273.15 + 24.8 "radius of cup";
      //cup parameter
      parameter Real R = 73 / 1000 / 2 "radius of cup";
      parameter Real L = 96 / 1000 "height of cup";
      parameter Real level_start = 60 / 1000 "初期水位";
      parameter Real cup_t = 4 / 1000 "thichness of cup";
      parameter Real cup_t_bottom = 4 / 1000 "thichness of cup";
      parameter Real V = ((R + cup_t) ^ 2 - R ^ 2) * pi * L "volume of cup";
      parameter Real Sin = 2 * R * pi * L "volume of cup";
      parameter Real Sout = 2 * (R + cup_t) * pi * L "volume of cup";
      //cup materials
      parameter Real rho = 2200 "陶器密度　https://www.hakko.co.jp/qa/qakit/html/h01010.htm";
      parameter Real k = 1.3 "熱伝導率";
      parameter Real cp = 1050;
      parameter Real h = 10 "カップ-外気の熱伝達率";
      //liquid parameter
      parameter Real h_l = 1000 "カップ内固液熱伝導率";
      //dripper parameter
      parameter Real drip_D = 5 / 1000 "ドリッパーの直径";
      parameter Real drip_L = 10 / 1000 "ドリッパーの長さ";
      replaceable package Medium = Modelica.Media.Water.StandardWater;
      Modelica.Fluid.Vessels.OpenTank cup(redeclare package Medium = Medium, T_start = Tamb, crossArea = R ^ 2 * pi, height = L, level_start = 0, nPorts = 1, portsData = {Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter = R, height = 70 / 1000)}, use_HeatTransfer = true, use_portsData = true) annotation(
        Placement(visible = true, transformation(origin = {50, -30}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      inner Modelica.Fluid.System system annotation(
        Placement(visible = true, transformation(origin = {100, 176}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Components.Convection convection1 annotation(
        Placement(visible = true, transformation(origin = {-52, 30}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant const(k = 100 * R ^ 2 * pi) annotation(
        Placement(visible = true, transformation(origin = {-54, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor1(G = 2 * pi * k * L / log((R + cup_t / 2) / R)) annotation(
        Placement(visible = true, transformation(origin = {-42, -82}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Components.Convection convection2 annotation(
        Placement(visible = true, transformation(origin = {-142, -82}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant const1(k = h * 2 * (R + cup_t) * pi * L) annotation(
        Placement(visible = true, transformation(origin = {-142, -44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature2(T = Tamb) annotation(
        Placement(visible = true, transformation(origin = {-186, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor2(G = 2 * pi * k * L / log(R / (R - cup_t / 2))) annotation(
        Placement(visible = true, transformation(origin = {-98, -82}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor1(C = cp * V * rho, T(fixed = true, start = Tamb)) annotation(
        Placement(visible = true, transformation(origin = {-72, -48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Components.Convection convection3 annotation(
        Placement(visible = true, transformation(origin = {-142, -126}, extent = {{10, 10}, {-10, -10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant const2(k = h * (R + cup_t) ^ 2 * pi) annotation(
        Placement(visible = true, transformation(origin = {-144, -164}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Vessels.OpenTank yakan(redeclare package Medium = Medium, T_start = 273.15 + 98, crossArea = R ^ 2 * pi, height = L, level_start = level_start, nPorts = 1, portsData = {Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter = 5 / 1000)}, use_HeatTransfer = true, use_portsData = true) annotation(
        Placement(visible = true, transformation(origin = {50, 162}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Modelica.Fluid.Pipes.StaticPipe pipe(redeclare package Medium = Medium, diameter = 15 / 1000, height_ab = -50 / 1000, length = 50 / 1000) annotation(
        Placement(visible = true, transformation(origin = {50, 92}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Fluid.Valves.ValveIncompressible valveIncompressible1(redeclare package Medium = Medium, dp_nominal = 100000, filteredOpening = true, leakageOpening = 1e-6, m_flow_nominal = 1) annotation(
        Placement(visible = true, transformation(origin = {50, 48}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Blocks.Sources.Ramp ramp1(duration = 1, offset = 1e-6, startTime = 0) annotation(
        Placement(visible = true, transformation(origin = {166, 50}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.CombiTimeTable combiTimeTable1(columns = 2:2, fileName = "C:/Work/2018/Coffee/CoffeeTemperature/Experiment/WaterTemp_1.txt", tableName = "Tab1", tableOnFile = true) annotation(
        Placement(visible = true, transformation(origin = {176, -180}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant const3(k = 1) annotation(
        Placement(visible = true, transformation(origin = {168, 92}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Components.Convection convection4 annotation(
        Placement(visible = true, transformation(origin = {-2, -84}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant const4(k = Sin * h_l) annotation(
        Placement(visible = true, transformation(origin = {-2, -120}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      Modelica.Blocks.Sources.Constant const5(k = 2 * R * pi * L * h) annotation(
        Placement(visible = true, transformation(origin = {-8, 130}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      Modelica.Thermal.HeatTransfer.Components.Convection convection5 annotation(
        Placement(visible = true, transformation(origin = {-8, 166}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
      Modelica.Blocks.Sources.TimeTable timeTable1(table = [0, 0; 5, 0; 15, 1; 20, 0; 25, 0]) annotation(
        Placement(visible = true, transformation(origin = {90, 48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      connect(cup.heatPort, convection1.solid) annotation(
        Line(points = {{30, -30}, {0, -30}, {0, 30}, {-42, 30}, {-42, 30}}, color = {191, 0, 0}));
      connect(const.y, convection1.Gc) annotation(
        Line(points = {{-43, 70}, {-51, 70}, {-51, 40}, {-53, 40}}, color = {0, 0, 127}));
      connect(fixedTemperature2.port, convection1.fluid) annotation(
        Line(points = {{-176, -8}, {-119, -8}, {-119, 30}, {-62, 30}}, color = {191, 0, 0}));
      connect(heatCapacitor1.port, thermalConductor1.port_a) annotation(
        Line(points = {{-72, -58}, {-72, -82}, {-52, -82}}, color = {191, 0, 0}));
      connect(thermalConductor2.port_b, heatCapacitor1.port) annotation(
        Line(points = {{-88, -82}, {-72, -82}, {-72, -58}, {-72, -58}}, color = {191, 0, 0}));
      connect(thermalConductor2.port_a, convection2.solid) annotation(
        Line(points = {{-108, -82}, {-132, -82}}, color = {191, 0, 0}));
      connect(thermalConductor2.port_a, convection3.solid) annotation(
        Line(points = {{-108, -82}, {-122, -82}, {-122, -126}, {-132, -126}}, color = {191, 0, 0}));
      connect(convection4.solid, thermalConductor1.port_b) annotation(
        Line(points = {{-12, -84}, {-32, -84}, {-32, -82}}, color = {191, 0, 0}));
      connect(const2.y, convection3.Gc) annotation(
        Line(points = {{-133, -164}, {-143, -164}, {-143, -136}, {-143, -136}}, color = {0, 0, 127}));
      connect(convection3.fluid, fixedTemperature2.port) annotation(
        Line(points = {{-152, -126}, {-176, -126}, {-176, -8}}, color = {191, 0, 0}));
      connect(convection2.fluid, fixedTemperature2.port) annotation(
        Line(points = {{-152, -82}, {-176, -82}, {-176, -8}}, color = {191, 0, 0}));
      connect(convection5.solid, fixedTemperature2.port) annotation(
        Line(points = {{-18, 166}, {-176, 166}, {-176, -8}}, color = {191, 0, 0}));
      connect(timeTable1.y, valveIncompressible1.opening) annotation(
        Line(points = {{102, 48}, {60, 48}, {60, 48}, {58, 48}}, color = {0, 0, 127}));
      connect(const5.y, convection5.Gc) annotation(
        Line(points = {{-8, 142}, {-8, 142}, {-8, 156}, {-8, 156}}, color = {0, 0, 127}));
      connect(convection5.fluid, yakan.heatPort) annotation(
        Line(points = {{2, 166}, {28, 166}, {28, 162}, {30, 162}}, color = {191, 0, 0}));
      connect(convection4.fluid, cup.heatPort) annotation(
        Line(points = {{8, -84}, {28, -84}, {28, -30}, {30, -30}}, color = {191, 0, 0}));
      connect(const4.y, convection4.Gc) annotation(
        Line(points = {{-2, -108}, {-2, -94}}, color = {0, 0, 127}));
      connect(const1.y, convection2.Gc) annotation(
        Line(points = {{-131, -44}, {-133.75, -44}, {-133.75, -44}, {-132.5, -44}, {-132.5, -44}, {-136, -44}, {-136, -42}, {-145, -42}, {-145, -70}, {-143, -70}, {-143, -72}, {-143, -72}, {-143, -72}, {-148, -72}, {-148, -72}, {-143, -72}}, color = {0, 0, 127}));
      connect(valveIncompressible1.port_b, cup.ports[1]) annotation(
        Line(points = {{50, 38}, {50, 38}, {50, -50}, {50, -50}}, color = {0, 127, 255}));
      connect(pipe.port_b, valveIncompressible1.port_a) annotation(
        Line(points = {{50, 82}, {50, 82}, {50, 58}, {50, 58}}, color = {0, 127, 255}));
      connect(yakan.ports[1], pipe.port_a) annotation(
        Line(points = {{50, 142}, {50, 142}, {50, 102}, {50, 102}}, color = {0, 127, 255}, thickness = 0.5));
      annotation(
        Documentation(info = "<html>
<p>
熱伝導率
http://japan-miyabi.com/thermal_light/data/03/conductivity.htm
</p>
</html>"),
        uses(Modelica(version = "3.2.2")),
        Diagram(coordinateSystem(extent = {{-300, -300}, {300, 300}})),
        Icon(coordinateSystem(extent = {{-200, -200}, {200, 200}})),
        version = "",
        __OpenModelica_commandLineOptions = "",
        experiment(StartTime = 0, StopTime = 2400, Tolerance = 1e-06, Interval = 2.4));
    end CoffeeTest8;

    model CoffeeTest8_Optim
      import pi = Modelica.Constants.pi;
      //Ojbective
      Real y;
      //ambient
      parameter Real Tamb = 273.15 + 24.8 "radius of cup";
      //cup parameter
      parameter Real R = 73 / 1000 / 2 "radius of cup";
      parameter Real L = 96 / 1000 "height of cup";
      parameter Real level_start = 60 / 1000 "初期水位";
      parameter Real cup_t = 4 / 1000 "thichness of cup";
      parameter Real cup_t_bottom = 4 / 1000 "thichness of cup";
      parameter Real V = ((R + cup_t) ^ 2 - R ^ 2) * pi * L "volume of cup";
      parameter Real Sin = 2 * R * pi * L "inner surface of cup";
      parameter Real Sout = 2 * (R + cup_t) * pi * L "outer surface of cup";
      //cup materials
      parameter Real rho = 2200 "陶器密度　https://www.hakko.co.jp/qa/qakit/html/h01010.htm";
      parameter Real k = 1.3 "熱伝導率";
      parameter Real cp = 1050;
      input Real h(min = 1, max = 300) "カップ-外気の熱伝達率";
      //liquid parameter
      input Real h_l(min = 1, max = 3000) "カップ内固液熱伝導率";
      //dripper parameter
      parameter Real drip_D = 5 / 1000 "ドリッパーの直径";
      parameter Real drip_L = 10 / 1000 "ドリッパーの長さ";
      replaceable package Medium = Modelica.Media.Water.StandardWater;
      Modelica.Fluid.Vessels.OpenTank cup(redeclare package Medium = Medium, T_start = Tamb, crossArea = R ^ 2 * pi, height = L, level_start = 0, nPorts = 1, portsData = {Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter = R, height = 70 / 1000)}, use_HeatTransfer = true, use_portsData = true) annotation(
        Placement(visible = true, transformation(origin = {50, -30}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      inner Modelica.Fluid.System system annotation(
        Placement(visible = true, transformation(origin = {-164, 184}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Components.Convection convection1 annotation(
        Placement(visible = true, transformation(origin = {-50, 2}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant const(k = 100 * R ^ 2 * pi) annotation(
        Placement(visible = true, transformation(origin = {-52, 42}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor1(G = 2 * pi * k * L / log((R + cup_t / 2) / R)) annotation(
        Placement(visible = true, transformation(origin = {-50, -82}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Components.Convection convection2 annotation(
        Placement(visible = true, transformation(origin = {-142, -82}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant const1(k = h * 2 * (R + cup_t) * pi * L) annotation(
        Placement(visible = true, transformation(origin = {-142, -44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature2(T = Tamb) annotation(
        Placement(visible = true, transformation(origin = {-188, -16}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor2(G = 2 * pi * k * L / log(R / (R - cup_t / 2))) annotation(
        Placement(visible = true, transformation(origin = {-106, -82}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor1(C = cp * V * rho, T(fixed = true, start = Tamb)) annotation(
        Placement(visible = true, transformation(origin = {-92, -52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Components.Convection convection3 annotation(
        Placement(visible = true, transformation(origin = {-144, -126}, extent = {{10, 10}, {-10, -10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant const2(k = h * (R + cup_t) ^ 2 * pi) annotation(
        Placement(visible = true, transformation(origin = {-146, -164}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Vessels.OpenTank yakan(redeclare package Medium = Medium, T_start = 273.15 + 98, crossArea = R ^ 2 * pi, height = L, level_start = level_start, nPorts = 1, portsData = {Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter = 5 / 1000)}, use_HeatTransfer = true, use_portsData = true) annotation(
        Placement(visible = true, transformation(origin = {50, 162}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Modelica.Fluid.Pipes.StaticPipe pipe(redeclare package Medium = Medium, diameter = 15 / 1000, height_ab = -50 / 1000, length = 50 / 1000) annotation(
        Placement(visible = true, transformation(origin = {50, 92}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Fluid.Valves.ValveIncompressible valveIncompressible1(redeclare package Medium = Medium, dp_nominal = 100000, filteredOpening = true, leakageOpening = 1e-6, m_flow_nominal = 1) annotation(
        Placement(visible = true, transformation(origin = {50, 48}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Blocks.Sources.Ramp ramp1(duration = 1, offset = 1e-6, startTime = 0) annotation(
        Placement(visible = true, transformation(origin = {166, 50}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.CombiTimeTable combiTimeTable1(columns = 2:2, fileName = "C:/Work/2018/Coffee/Experiment/WaterTemp_1.txt", tableName = "Tab1", tableOnFile = true) annotation(
        Placement(visible = true, transformation(origin = {176, -180}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant const3(k = 1) annotation(
        Placement(visible = true, transformation(origin = {168, 92}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Components.Convection convection4 annotation(
        Placement(visible = true, transformation(origin = {-2, -84}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant const4(k = Sin * h_l) annotation(
        Placement(visible = true, transformation(origin = {-2, -120}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      Modelica.Blocks.Sources.Constant const5(k = 2 * R * pi * L * h) annotation(
        Placement(visible = true, transformation(origin = {-8, 130}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      Modelica.Thermal.HeatTransfer.Components.Convection convection5 annotation(
        Placement(visible = true, transformation(origin = {-8, 166}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
      Modelica.Blocks.Sources.TimeTable timeTable1(table = [0, 0; 5, 0; 15, 1; 20, 0; 25, 0]) annotation(
        Placement(visible = true, transformation(origin = {90, 48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      y = (cup.heatPort.T - combiTimeTable1.y[1]) ^ 2;
      connect(timeTable1.y, valveIncompressible1.opening) annotation(
        Line(points = {{102, 48}, {60, 48}, {60, 48}, {58, 48}}, color = {0, 0, 127}));
      connect(convection5.solid, fixedTemperature2.port) annotation(
        Line(points = {{-18, 166}, {-178, 166}, {-178, -16}, {-178, -16}}, color = {191, 0, 0}));
      connect(const5.y, convection5.Gc) annotation(
        Line(points = {{-8, 142}, {-8, 142}, {-8, 156}, {-8, 156}}, color = {0, 0, 127}));
      connect(convection5.fluid, yakan.heatPort) annotation(
        Line(points = {{2, 166}, {28, 166}, {28, 162}, {30, 162}}, color = {191, 0, 0}));
      connect(convection4.fluid, cup.heatPort) annotation(
        Line(points = {{8, -84}, {28, -84}, {28, -30}, {30, -30}}, color = {191, 0, 0}));
      connect(convection4.solid, thermalConductor1.port_b) annotation(
        Line(points = {{-12, -84}, {-40, -84}, {-40, -82}, {-40, -82}}, color = {191, 0, 0}));
      connect(const4.y, convection4.Gc) annotation(
        Line(points = {{-2, -108}, {-2, -94}}, color = {0, 0, 127}));
      connect(heatCapacitor1.port, thermalConductor1.port_a) annotation(
        Line(points = {{-92, -62}, {-92, -82}, {-60, -82}}, color = {191, 0, 0}));
      connect(convection1.solid, cup.heatPort) annotation(
        Line(points = {{-40, 2}, {-31, 2}, {-31, -36}, {16.5, -36}, {16.5, -30}, {30, -30}}, color = {191, 0, 0}));
      connect(const.y, convection1.Gc) annotation(
        Line(points = {{-40, 42}, {-50, 42}, {-50, 12}, {-50, 12}}, color = {0, 0, 127}));
      connect(const2.y, convection3.Gc) annotation(
        Line(points = {{-135, -164}, {-145, -164}, {-145, -136}, {-145, -136}}, color = {0, 0, 127}));
      connect(thermalConductor2.port_a, convection3.solid) annotation(
        Line(points = {{-116, -82}, {-125, -82}, {-125, -82}, {-124, -82}, {-124, -126}, {-134, -126}, {-134, -126}, {-134, -126}, {-134, -126}}, color = {191, 0, 0}));
      connect(convection3.fluid, fixedTemperature2.port) annotation(
        Line(points = {{-154, -126}, {-166, -126}, {-166, -126}, {-178, -126}, {-178, -16}, {-178, -16}}, color = {191, 0, 0}));
      connect(thermalConductor2.port_b, heatCapacitor1.port) annotation(
        Line(points = {{-96, -82}, {-99, -82}, {-99, -82}, {-92, -82}, {-92, -62}, {-94, -62}, {-94, -62}, {-92, -62}}, color = {191, 0, 0}));
      connect(thermalConductor2.port_a, convection2.solid) annotation(
        Line(points = {{-116, -82}, {-132, -82}}, color = {191, 0, 0}));
      connect(fixedTemperature2.port, convection1.fluid) annotation(
        Line(points = {{-178, -16}, {-179, -16}, {-179, -16}, {-176, -16}, {-176, 2}, {-60, 2}, {-60, 2}, {-60, 2}, {-60, 2}}, color = {191, 0, 0}));
      connect(convection2.fluid, fixedTemperature2.port) annotation(
        Line(points = {{-152, -82}, {-167, -82}, {-167, -82}, {-178, -82}, {-178, -49}, {-178, -49}, {-178, -16}}, color = {191, 0, 0}));
      connect(const1.y, convection2.Gc) annotation(
        Line(points = {{-131, -44}, {-133.75, -44}, {-133.75, -44}, {-132.5, -44}, {-132.5, -44}, {-136, -44}, {-136, -42}, {-145, -42}, {-145, -70}, {-143, -70}, {-143, -72}, {-143, -72}, {-143, -72}, {-148, -72}, {-148, -72}, {-143, -72}}, color = {0, 0, 127}));
      connect(valveIncompressible1.port_b, cup.ports[1]) annotation(
        Line(points = {{50, 38}, {50, 38}, {50, -50}, {50, -50}}, color = {0, 127, 255}));
      connect(pipe.port_b, valveIncompressible1.port_a) annotation(
        Line(points = {{50, 82}, {50, 82}, {50, 58}, {50, 58}}, color = {0, 127, 255}));
      connect(yakan.ports[1], pipe.port_a) annotation(
        Line(points = {{50, 142}, {50, 142}, {50, 102}, {50, 102}}, color = {0, 127, 255}, thickness = 0.5));
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
        __OpenModelica_commandLineOptions = "",
        experiment(StartTime = 0, StopTime = 2400, Tolerance = 1e-06, Interval = 2.4));
    end CoffeeTest8_Optim;

    model CoffeeTest9
      import pi = Modelica.Constants.pi;
      //ambient
      parameter Real Tamb = 273.15 + 24.8 "radius of cup";
      //cup parameter
      parameter Real R = 73 / 1000 / 2 "radius of cup";
      parameter Real L = 96 / 1000 "height of cup";
      parameter Real level_start = 60 / 1000 "初期水位";
      parameter Real cup_t = 4 / 1000 "thichness of cup";
      parameter Real cup_t_bottom = 4 / 1000 "thichness of cup";
      parameter Real V = ((R + cup_t) ^ 2 - R ^ 2) * pi * L "volume of cup";
      parameter Real Sin = 2 * R * pi * L "volume of cup";
      parameter Real Sout = 2 * (R + cup_t) * pi * L "volume of cup";
      //cup materials
      parameter Real rho = 2200 "陶器密度　https://www.hakko.co.jp/qa/qakit/html/h01010.htm";
      parameter Real k = 1.3 "熱伝導率";
      parameter Real cp = 1050;
      parameter Real h = 10 "カップ-外気の熱伝達率";
      //liquid parameter
      parameter Real h_l = 1000 "カップ内固液熱伝導率";
      //dripper parameter
      parameter Real drip_D = 5 / 1000 "ドリッパーの直径";
      parameter Real drip_L = 10 / 1000 "ドリッパーの長さ";
      replaceable package Medium = Modelica.Media.Water.StandardWater;
      Modelica.Fluid.Vessels.OpenTank cup(redeclare package Medium = Medium, T_start = Tamb, crossArea = R ^ 2 * pi, height = L, level_start = 0, nPorts = 1, portsData = {Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter = R, height = 70 / 1000)}, use_HeatTransfer = true, use_portsData = true) annotation(
        Placement(visible = true, transformation(origin = {50, -30}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      inner Modelica.Fluid.System system annotation(
        Placement(visible = true, transformation(origin = {100, 176}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor1(G = 2 * pi * k * L / log((R + cup_t / 2) / R)) annotation(
        Placement(visible = true, transformation(origin = {-42, -82}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature2(T = Tamb) annotation(
        Placement(visible = true, transformation(origin = {-186, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor2(G = 2 * pi * k * L / log(R / (R - cup_t / 2))) annotation(
        Placement(visible = true, transformation(origin = {-98, -82}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor1(C = cp * V * rho, T(fixed = true, start = Tamb)) annotation(
        Placement(visible = true, transformation(origin = {-72, -48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Vessels.OpenTank yakan(redeclare package Medium = Medium, T_start = 273.15 + 98, crossArea = R ^ 2 * pi, height = L, level_start = level_start, nPorts = 1, portsData = {Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter = 5 / 1000)}, use_HeatTransfer = true, use_portsData = true) annotation(
        Placement(visible = true, transformation(origin = {50, 162}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Modelica.Fluid.Pipes.StaticPipe pipe(redeclare package Medium = Medium, diameter = 15 / 1000, height_ab = -50 / 1000, length = 50 / 1000) annotation(
        Placement(visible = true, transformation(origin = {50, 92}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Fluid.Valves.ValveIncompressible valveIncompressible1(redeclare package Medium = Medium, dp_nominal = 100000, filteredOpening = true, leakageOpening = 1e-6, m_flow_nominal = 1) annotation(
        Placement(visible = true, transformation(origin = {50, 48}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Blocks.Sources.CombiTimeTable combiTimeTable1(columns = 2:2, fileName = "C:/Work/2018/Coffee/CoffeeTemperature/Experiment/WaterTemp_1.txt", tableName = "Tab1", tableOnFile = true) annotation(
        Placement(visible = true, transformation(origin = {176, -180}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant const5(k = 2 * R * pi * L * h) annotation(
        Placement(visible = true, transformation(origin = {-8, 130}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      Modelica.Thermal.HeatTransfer.Components.Convection convection5 annotation(
        Placement(visible = true, transformation(origin = {-8, 166}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
      Modelica.Blocks.Sources.TimeTable timeTable1(table = [0, 0; 5, 0; 15, 1; 20, 0; 25, 0]) annotation(
        Placement(visible = true, transformation(origin = {90, 48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Components.Convection convection1 annotation(
        Placement(visible = true, transformation(origin = {-52, 30}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant const(k = 65 * R ^ 2 * pi) annotation(
        Placement(visible = true, transformation(origin = {-54, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      CoffeeTemperature.UnitTest.NaturalConvection2 naturalConvection1(L = 2 * (R + cup_t), area = 2 * (R + cup_t) * pi * L, convectionType = CoffeeTemperature.UnitTest.ConvectionType.vertical_planes_cylinder) annotation(
        Placement(visible = true, transformation(origin = {-142, -74}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      CoffeeTemperature.UnitTest.NaturalConvection2 naturalConvection21(L = (R + cup_t) ^ 2 * pi / ((R + cup_t) * 2 * pi), area = 2 * (R + cup_t) ^ 2 * pi, convectionType = CoffeeTemperature.UnitTest.ConvectionType.LowerSurface_of_heatedPlates) annotation(
        Placement(visible = true, transformation(origin = {-142, -124}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      CoffeeTemperature.UnitTest.EnclosedConvection enclosedConvection1(H = L, L = R, area = Sin) annotation(
        Placement(visible = true, transformation(origin = {2, -82}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      connect(enclosedConvection1.fluid, cup.heatPort) annotation(
        Line(points = {{12, -82}, {30, -82}, {30, -30}, {30, -30}}, color = {191, 0, 0}));
      connect(enclosedConvection1.solid, thermalConductor1.port_b) annotation(
        Line(points = {{-8, -82}, {-32, -82}, {-32, -82}, {-32, -82}}, color = {191, 0, 0}));
      connect(naturalConvection21.fluid, fixedTemperature2.port) annotation(
        Line(points = {{-152, -124}, {-176, -124}, {-176, -8}, {-176, -8}}, color = {191, 0, 0}));
      connect(thermalConductor2.port_a, naturalConvection21.solid) annotation(
        Line(points = {{-108, -82}, {-108, -82}, {-108, -124}, {-132, -124}, {-132, -124}}, color = {191, 0, 0}));
      connect(naturalConvection1.fluid, fixedTemperature2.port) annotation(
        Line(points = {{-152, -74}, {-176, -74}, {-176, -8}, {-176, -8}}, color = {191, 0, 0}));
      connect(naturalConvection1.solid, thermalConductor2.port_a) annotation(
        Line(points = {{-132, -74}, {-108, -74}, {-108, -82}, {-108, -82}}, color = {191, 0, 0}));
      connect(const.y, convection1.Gc) annotation(
        Line(points = {{-43, 70}, {-51, 70}, {-51, 40}, {-53, 40}}, color = {0, 0, 127}));
      connect(cup.heatPort, convection1.solid) annotation(
        Line(points = {{30, -30}, {0, -30}, {0, 30}, {-42, 30}, {-42, 30}}, color = {191, 0, 0}));
      connect(fixedTemperature2.port, convection1.fluid) annotation(
        Line(points = {{-176, -8}, {-119, -8}, {-119, 30}, {-62, 30}}, color = {191, 0, 0}));
      connect(heatCapacitor1.port, thermalConductor1.port_a) annotation(
        Line(points = {{-72, -58}, {-72, -82}, {-52, -82}}, color = {191, 0, 0}));
      connect(thermalConductor2.port_b, heatCapacitor1.port) annotation(
        Line(points = {{-88, -82}, {-72, -82}, {-72, -58}, {-72, -58}}, color = {191, 0, 0}));
      connect(convection5.solid, fixedTemperature2.port) annotation(
        Line(points = {{-18, 166}, {-176, 166}, {-176, -8}}, color = {191, 0, 0}));
      connect(timeTable1.y, valveIncompressible1.opening) annotation(
        Line(points = {{102, 48}, {60, 48}, {60, 48}, {58, 48}}, color = {0, 0, 127}));
      connect(const5.y, convection5.Gc) annotation(
        Line(points = {{-8, 142}, {-8, 142}, {-8, 156}, {-8, 156}}, color = {0, 0, 127}));
      connect(convection5.fluid, yakan.heatPort) annotation(
        Line(points = {{2, 166}, {28, 166}, {28, 162}, {30, 162}}, color = {191, 0, 0}));
      connect(valveIncompressible1.port_b, cup.ports[1]) annotation(
        Line(points = {{50, 38}, {50, 38}, {50, -50}, {50, -50}}, color = {0, 127, 255}));
      connect(pipe.port_b, valveIncompressible1.port_a) annotation(
        Line(points = {{50, 82}, {50, 82}, {50, 58}, {50, 58}}, color = {0, 127, 255}));
      connect(yakan.ports[1], pipe.port_a) annotation(
        Line(points = {{50, 142}, {50, 142}, {50, 102}, {50, 102}}, color = {0, 127, 255}, thickness = 0.5));
      annotation(
        Documentation(info = "<html>
<p>
熱伝導率
http://japan-miyabi.com/thermal_light/data/03/conductivity.htm
</p>
</html>"),
        uses(Modelica(version = "3.2.2")),
        Diagram(coordinateSystem(extent = {{-300, -300}, {300, 300}})),
        Icon(coordinateSystem(extent = {{-200, -200}, {200, 200}})),
        version = "",
        __OpenModelica_commandLineOptions = "",
        experiment(StartTime = 0, StopTime = 2400, Tolerance = 1e-06, Interval = 2.4));
    end CoffeeTest9;

    model CoffeeTest10
      import pi = Modelica.Constants.pi;
      //target reslut
      Real res;
      //ambient
      parameter Real Tamb = 273.15 + 24.8 "radius of cup";
      //cup parameter
      parameter Real R = 73 / 1000 / 2 "radius of cup";
      parameter Real L = 96 / 1000 "height of cup";
      parameter Real level_start = 60 / 1000 "初期水位";
      parameter Real cup_t = 4 / 1000 "thichness of cup";
      parameter Real cup_t_bottom = 4 / 1000 "thichness of cup";
      parameter Real V = ((R + cup_t) ^ 2 - R ^ 2) * pi * L "volume of cup";
      parameter Real Sin = 2 * R * pi * L "inner surface of cup";
      parameter Real Sout = 2 * (R + cup_t) * pi * L "outer surface of cup";
      //cup materials
      parameter Real rho = 2200 "陶器密度　https://www.hakko.co.jp/qa/qakit/html/h01010.htm";
      parameter Real k = 1.3 "熱伝導率";
      parameter Real cp = 1050;
      parameter Real h = 90 "カップ-外気の熱伝達率";
      //liquid parameter
      parameter Real h_l = 1000 "カップ内固液熱伝導率";
      //dripper parameter
      parameter Real drip_D = 5 / 1000 "ドリッパーの直径";
      parameter Real drip_L = 10 / 1000 "ドリッパーの長さ";
      replaceable package Medium = Modelica.Media.Water.StandardWater;
      Modelica.Fluid.Vessels.OpenTank cup(redeclare package Medium = Medium, T_start = Tamb, crossArea = R ^ 2 * pi, height = L, level_start = 0, nPorts = 1, portsData = {Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter = R, height = 70 / 1000)}, use_HeatTransfer = true, use_portsData = true) annotation(
        Placement(visible = true, transformation(origin = {50, -30}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      inner Modelica.Fluid.System system annotation(
        Placement(visible = true, transformation(origin = {100, 176}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor1(G = 2 * pi * k * L / log((R + cup_t / 2) / R)) annotation(
        Placement(visible = true, transformation(origin = {-42, -82}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature2(T = Tamb) annotation(
        Placement(visible = true, transformation(origin = {-186, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor2(G = 2 * pi * k * L / log(R / (R - cup_t / 2))) annotation(
        Placement(visible = true, transformation(origin = {-98, -82}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor1(C = cp * V * rho, T(fixed = true, start = Tamb)) annotation(
        Placement(visible = true, transformation(origin = {-72, -48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Vessels.OpenTank yakan(redeclare package Medium = Medium, T_start = 273.15 + 98, crossArea = R ^ 2 * pi, height = L, level_start = level_start, nPorts = 1, portsData = {Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter = 5 / 1000)}, use_HeatTransfer = true, use_portsData = true) annotation(
        Placement(visible = true, transformation(origin = {50, 162}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Modelica.Fluid.Pipes.StaticPipe pipe(redeclare package Medium = Medium, diameter = 15 / 1000, height_ab = -50 / 1000, length = 50 / 1000) annotation(
        Placement(visible = true, transformation(origin = {50, 92}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Fluid.Valves.ValveIncompressible valveIncompressible1(redeclare package Medium = Medium, dp_nominal = 100000, filteredOpening = true, leakageOpening = 1e-6, m_flow_nominal = 1) annotation(
        Placement(visible = true, transformation(origin = {50, 48}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Blocks.Sources.CombiTimeTable combiTimeTable1(columns = 2:2, fileName = "C:/Work/2018/Coffee/CoffeeTemperature/Experiment/WaterTemp_1.txt", tableName = "Tab1", tableOnFile = true) annotation(
        Placement(visible = true, transformation(origin = {176, -180}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant const5(k = 2 * R * pi * L * h) annotation(
        Placement(visible = true, transformation(origin = {-8, 130}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      Modelica.Thermal.HeatTransfer.Components.Convection convection5 annotation(
        Placement(visible = true, transformation(origin = {-8, 166}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
      Modelica.Blocks.Sources.TimeTable timeTable1(table = [0, 0; 5, 0; 15, 1; 20, 0; 25, 0]) annotation(
        Placement(visible = true, transformation(origin = {90, 48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Components.Convection convection1 annotation(
        Placement(visible = true, transformation(origin = {-52, 30}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant const(k = 65 * R ^ 2 * pi) annotation(
        Placement(visible = true, transformation(origin = {-54, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      CoffeeTemperature.UnitTest.NaturalConvection2 naturalConvection1(L = 2 * (R + cup_t), area = 2 * (R + cup_t) * pi * L, convectionType = CoffeeTemperature.UnitTest.ConvectionType.vertical_planes_cylinder) annotation(
        Placement(visible = true, transformation(origin = {-142, -74}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      CoffeeTemperature.UnitTest.NaturalConvection2 naturalConvection21(L = (R + cup_t) ^ 2 * pi / ((R + cup_t) * 2 * pi), area = 2 * (R + cup_t) ^ 2 * pi, convectionType = CoffeeTemperature.UnitTest.ConvectionType.LowerSurface_of_heatedPlates) annotation(
        Placement(visible = true, transformation(origin = {-142, -124}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      CoffeeTemperature.UnitTest.EnclosedConvection enclosedConvection1(H = L, L = R, area = Sin) annotation(
        Placement(visible = true, transformation(origin = {2, -82}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      connect(enclosedConvection1.fluid, cup.heatPort) annotation(
        Line(points = {{12, -82}, {30, -82}, {30, -30}, {30, -30}}, color = {191, 0, 0}));
      connect(enclosedConvection1.solid, thermalConductor1.port_b) annotation(
        Line(points = {{-8, -82}, {-32, -82}, {-32, -82}, {-32, -82}}, color = {191, 0, 0}));
      connect(naturalConvection21.fluid, fixedTemperature2.port) annotation(
        Line(points = {{-152, -124}, {-176, -124}, {-176, -8}, {-176, -8}}, color = {191, 0, 0}));
      connect(thermalConductor2.port_a, naturalConvection21.solid) annotation(
        Line(points = {{-108, -82}, {-108, -82}, {-108, -124}, {-132, -124}, {-132, -124}}, color = {191, 0, 0}));
      connect(naturalConvection1.fluid, fixedTemperature2.port) annotation(
        Line(points = {{-152, -74}, {-176, -74}, {-176, -8}, {-176, -8}}, color = {191, 0, 0}));
      connect(naturalConvection1.solid, thermalConductor2.port_a) annotation(
        Line(points = {{-132, -74}, {-108, -74}, {-108, -82}, {-108, -82}}, color = {191, 0, 0}));
      connect(const.y, convection1.Gc) annotation(
        Line(points = {{-43, 70}, {-51, 70}, {-51, 40}, {-53, 40}}, color = {0, 0, 127}));
      connect(cup.heatPort, convection1.solid) annotation(
        Line(points = {{30, -30}, {0, -30}, {0, 30}, {-42, 30}, {-42, 30}}, color = {191, 0, 0}));
      connect(fixedTemperature2.port, convection1.fluid) annotation(
        Line(points = {{-176, -8}, {-119, -8}, {-119, 30}, {-62, 30}}, color = {191, 0, 0}));
      connect(heatCapacitor1.port, thermalConductor1.port_a) annotation(
        Line(points = {{-72, -58}, {-72, -82}, {-52, -82}}, color = {191, 0, 0}));
      connect(thermalConductor2.port_b, heatCapacitor1.port) annotation(
        Line(points = {{-88, -82}, {-72, -82}, {-72, -58}, {-72, -58}}, color = {191, 0, 0}));
      connect(convection5.solid, fixedTemperature2.port) annotation(
        Line(points = {{-18, 166}, {-176, 166}, {-176, -8}}, color = {191, 0, 0}));
      connect(timeTable1.y, valveIncompressible1.opening) annotation(
        Line(points = {{102, 48}, {60, 48}, {60, 48}, {58, 48}}, color = {0, 0, 127}));
      connect(const5.y, convection5.Gc) annotation(
        Line(points = {{-8, 142}, {-8, 142}, {-8, 156}, {-8, 156}}, color = {0, 0, 127}));
      connect(convection5.fluid, yakan.heatPort) annotation(
        Line(points = {{2, 166}, {28, 166}, {28, 162}, {30, 162}}, color = {191, 0, 0}));
      connect(valveIncompressible1.port_b, cup.ports[1]) annotation(
        Line(points = {{50, 38}, {50, 38}, {50, -50}, {50, -50}}, color = {0, 127, 255}));
      connect(pipe.port_b, valveIncompressible1.port_a) annotation(
        Line(points = {{50, 82}, {50, 82}, {50, 58}, {50, 58}}, color = {0, 127, 255}));
      connect(yakan.ports[1], pipe.port_a) annotation(
        Line(points = {{50, 142}, {50, 142}, {50, 102}, {50, 102}}, color = {0, 127, 255}, thickness = 0.5));
      res=(cup.heatPort.T-273.15- combiTimeTable1.y[1])^2;
      annotation(
        Documentation(info = "<html>
<p>
熱伝導率
http://japan-miyabi.com/thermal_light/data/03/conductivity.htm
</p>
</html>"),
        uses(Modelica(version = "3.2.2")),
        Diagram(coordinateSystem(extent = {{-300, -300}, {300, 300}})),
        Icon(coordinateSystem(extent = {{-200, -200}, {200, 200}})),
        version = "",
        __OpenModelica_commandLineOptions = "",
        experiment(StartTime = 0, StopTime = 2400, Tolerance = 1e-06, Interval = 2.4));
    end CoffeeTest10;

    model CoffeeTest11
      import pi = Modelica.Constants.pi;
      //target reslut
      Real res;
      //ambient
      parameter Real Tamb = 273.15 + 24.8 "radius of cup";
      //cup parameter
      parameter Real R = 73 / 1000 / 2 "radius of cup";
      parameter Real L = 96 / 1000 "height of cup";
      parameter Real level_start = 60 / 1000 "初期水位";
      parameter Real cup_t = 4 / 1000 "thichness of cup";
      parameter Real cup_t_bottom = 4 / 1000 "thichness of cup";
      parameter Real V = ((R + cup_t) ^ 2 - R ^ 2) * pi * L "volume of cup";
      parameter Real Sin = 2 * R * pi * L "inner surface of cup";
      parameter Real Sout = 2 * (R + cup_t) * pi * L "outer surface of cup";
      //cup materials
      parameter Real rho = 2200 "陶器密度　https://www.hakko.co.jp/qa/qakit/html/h01010.htm";
      parameter Real k = 1.3 "熱伝導率";
      parameter Real cp = 1050;
      parameter Real h = 90 "カップ-外気の熱伝達率";
      //liquid parameter
      parameter Real h_l = 1000 "カップ内固液熱伝導率";
      //dripper parameter
      parameter Real drip_D = 5 / 1000 "ドリッパーの直径";
      parameter Real drip_L = 10 / 1000 "ドリッパーの長さ";
      replaceable package Medium = Modelica.Media.Water.StandardWater;
      Modelica.Fluid.Vessels.OpenTank cup(redeclare package Medium = Medium, T_start = Tamb, crossArea = R ^ 2 * pi, height = L, level_start = 0, nPorts = 1, portsData = {Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter = R, height = 70 / 1000)}, use_HeatTransfer = true, use_portsData = true) annotation(
        Placement(visible = true, transformation(origin = {50, -30}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      inner Modelica.Fluid.System system annotation(
        Placement(visible = true, transformation(origin = {100, 176}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor1(G = 2 * pi * k * L / log((R + cup_t / 2) / R)) annotation(
        Placement(visible = true, transformation(origin = {-42, -82}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature2(T = Tamb) annotation(
        Placement(visible = true, transformation(origin = {-186, -8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor2(G = 2 * pi * k * L / log(R / (R - cup_t / 2))) annotation(
        Placement(visible = true, transformation(origin = {-98, -82}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor1(C = cp * V * rho, T(fixed = true, start = Tamb)) annotation(
        Placement(visible = true, transformation(origin = {-72, -48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Vessels.OpenTank yakan(redeclare package Medium = Medium, T_start = 273.15 + 98, crossArea = R ^ 2 * pi, height = L, level_start = level_start, nPorts = 1, portsData = {Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter = 5 / 1000)}, use_HeatTransfer = true, use_portsData = true) annotation(
        Placement(visible = true, transformation(origin = {50, 162}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Modelica.Fluid.Pipes.StaticPipe pipe(redeclare package Medium = Medium, diameter = 15 / 1000, height_ab = -50 / 1000, length = 50 / 1000) annotation(
        Placement(visible = true, transformation(origin = {50, 92}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Fluid.Valves.ValveIncompressible valveIncompressible1(redeclare package Medium = Medium, dp_nominal = 100000, filteredOpening = true, leakageOpening = 1e-6, m_flow_nominal = 1) annotation(
        Placement(visible = true, transformation(origin = {50, 48}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Blocks.Sources.CombiTimeTable combiTimeTable1(columns = 2:2, fileName = "C:/Work/2018/Coffee/CoffeeTemperature/Experiment/WaterTemp_1.txt", tableName = "Tab1", tableOnFile = true) annotation(
        Placement(visible = true, transformation(origin = {176, -180}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant const5(k = 2 * R * pi * L * h) annotation(
        Placement(visible = true, transformation(origin = {-8, 130}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      Modelica.Thermal.HeatTransfer.Components.Convection convection5 annotation(
        Placement(visible = true, transformation(origin = {-8, 166}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
      Modelica.Blocks.Sources.TimeTable timeTable1(table = [0, 0; 5, 0; 15, 1; 20, 0; 25, 0]) annotation(
        Placement(visible = true, transformation(origin = {90, 48}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Components.Convection convection1 annotation(
        Placement(visible = true, transformation(origin = {-52, 30}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      Modelica.Blocks.Sources.Constant const(k = 65 * R ^ 2 * pi) annotation(
        Placement(visible = true, transformation(origin = {-54, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      CoffeeTemperature.CoffeeThermal.NaturalConvection naturalConvection1(L = 2 * (R + cup_t), area = 2 * (R + cup_t) * pi * L, convectionType = CoffeeTemperature.CoffeeThermal.ConvectionType.vertical_planes_cylinder) annotation(
        Placement(visible = true, transformation(origin = {-142, -74}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      CoffeeTemperature.CoffeeThermal.NaturalConvection naturalConvection21(L = (R + cup_t) ^ 2 * pi / ((R + cup_t) * 2 * pi), area = 2 * (R + cup_t) ^ 2 * pi, convectionType = CoffeeTemperature.CoffeeThermal.ConvectionType.vertical_planes_cylinder) annotation(
        Placement(visible = true, transformation(origin = {-142, -124}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
      CoffeeTemperature.CoffeeThermal.EnclosedConvection enclosedConvection1(H = L, L = R, area = Sin) annotation(
        Placement(visible = true, transformation(origin = {2, -82}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      connect(enclosedConvection1.fluid, cup.heatPort) annotation(
        Line(points = {{12, -82}, {30, -82}, {30, -30}, {30, -30}}, color = {191, 0, 0}));
      connect(enclosedConvection1.solid, thermalConductor1.port_b) annotation(
        Line(points = {{-8, -82}, {-32, -82}, {-32, -82}, {-32, -82}}, color = {191, 0, 0}));
      connect(naturalConvection21.fluid, fixedTemperature2.port) annotation(
        Line(points = {{-152, -124}, {-176, -124}, {-176, -8}, {-176, -8}}, color = {191, 0, 0}));
      connect(thermalConductor2.port_a, naturalConvection21.solid) annotation(
        Line(points = {{-108, -82}, {-108, -82}, {-108, -124}, {-132, -124}, {-132, -124}}, color = {191, 0, 0}));
      connect(naturalConvection1.fluid, fixedTemperature2.port) annotation(
        Line(points = {{-152, -74}, {-176, -74}, {-176, -8}, {-176, -8}}, color = {191, 0, 0}));
      connect(naturalConvection1.solid, thermalConductor2.port_a) annotation(
        Line(points = {{-132, -74}, {-108, -74}, {-108, -82}, {-108, -82}}, color = {191, 0, 0}));
      connect(const.y, convection1.Gc) annotation(
        Line(points = {{-43, 70}, {-51, 70}, {-51, 40}, {-53, 40}}, color = {0, 0, 127}));
      connect(cup.heatPort, convection1.solid) annotation(
        Line(points = {{30, -30}, {0, -30}, {0, 30}, {-42, 30}, {-42, 30}}, color = {191, 0, 0}));
      connect(fixedTemperature2.port, convection1.fluid) annotation(
        Line(points = {{-176, -8}, {-119, -8}, {-119, 30}, {-62, 30}}, color = {191, 0, 0}));
      connect(heatCapacitor1.port, thermalConductor1.port_a) annotation(
        Line(points = {{-72, -58}, {-72, -82}, {-52, -82}}, color = {191, 0, 0}));
      connect(thermalConductor2.port_b, heatCapacitor1.port) annotation(
        Line(points = {{-88, -82}, {-72, -82}, {-72, -58}, {-72, -58}}, color = {191, 0, 0}));
      connect(convection5.solid, fixedTemperature2.port) annotation(
        Line(points = {{-18, 166}, {-176, 166}, {-176, -8}}, color = {191, 0, 0}));
      connect(timeTable1.y, valveIncompressible1.opening) annotation(
        Line(points = {{102, 48}, {60, 48}, {60, 48}, {58, 48}}, color = {0, 0, 127}));
      connect(const5.y, convection5.Gc) annotation(
        Line(points = {{-8, 142}, {-8, 142}, {-8, 156}, {-8, 156}}, color = {0, 0, 127}));
      connect(convection5.fluid, yakan.heatPort) annotation(
        Line(points = {{2, 166}, {28, 166}, {28, 162}, {30, 162}}, color = {191, 0, 0}));
      connect(valveIncompressible1.port_b, cup.ports[1]) annotation(
        Line(points = {{50, 38}, {50, 38}, {50, -50}, {50, -50}}, color = {0, 127, 255}));
      connect(pipe.port_b, valveIncompressible1.port_a) annotation(
        Line(points = {{50, 82}, {50, 82}, {50, 58}, {50, 58}}, color = {0, 127, 255}));
      connect(yakan.ports[1], pipe.port_a) annotation(
        Line(points = {{50, 142}, {50, 142}, {50, 102}, {50, 102}}, color = {0, 127, 255}, thickness = 0.5));
      res = (cup.heatPort.T - 273.15 - combiTimeTable1.y[1]) ^ 2;
      annotation(
        Documentation(info = "<html>
<p>
熱伝導率
http://japan-miyabi.com/thermal_light/data/03/conductivity.htm
</p>
</html>"),
        uses(Modelica(version = "3.2.2")),
        Diagram(coordinateSystem(extent = {{-300, -300}, {300, 300}})),
        Icon(coordinateSystem(extent = {{-200, -200}, {200, 200}})),
        version = "",
        __OpenModelica_commandLineOptions = "",
        experiment(StartTime = 0, StopTime = 2400, Tolerance = 1e-06, Interval = 2.4));
    end CoffeeTest11;










  end Test;

  package UnitTest
    model valveTest1
      import pi = Modelica.Constants.pi;
      //cup parameter
      parameter Real R = 70 / 1000 "radius of cup";
      parameter Real L = 85 / 1000 "height of cup";
      parameter Real level_start = 40 / 1000 "初期水位";
      parameter Real cup_thick = 3 / 1000 "thichness of cup";
      parameter Real rho = 2200 "陶器密度　https://www.hakko.co.jp/qa/qakit/html/h01010.htm";
      parameter Real V = ((R + cup_thick) ^ 2 - R ^ 2) * 3.14 * L "volume of cup";
      parameter Real cp = 1050;
      //dripper parameter
      parameter Real drip_D = 5 / 1000 "ドリッパーの直径";
      parameter Real drip_L = 10 / 1000 "ドリッパーの長さ";
      replaceable package Medium = Modelica.Media.Water.StandardWater;
      Modelica.Fluid.Vessels.OpenTank cup(redeclare package Medium = Medium, T_start = 273.15 + 90, crossArea = R ^ 2 * 3.14, height = L, level_start = 0, nPorts = 1, portsData = {Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter = 5 / 1000, height = 70 / 1000)}, use_HeatTransfer = true, use_portsData = true) annotation(
        Placement(visible = true, transformation(origin = {50, -30}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      inner Modelica.Fluid.System system annotation(
        Placement(visible = true, transformation(origin = {-16, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Vessels.OpenTank tank1(redeclare package Medium = Medium, T_start = 273.15 + 90, crossArea = R ^ 2 * 3.14, height = L, level_start = level_start, nPorts = 1, portsData = {Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter = 5 / 1000)}, use_HeatTransfer = false, use_portsData = true) annotation(
        Placement(visible = true, transformation(origin = {50, 98}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Modelica.Fluid.Pipes.StaticPipe pipe(redeclare package Medium = Medium, diameter = 15 / 1000, height_ab = -50 / 1000, length = 50 / 1000) annotation(
        Placement(visible = true, transformation(origin = {50, 36}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    equation
      connect(pipe.port_b, cup.ports[1]) annotation(
        Line(points = {{50, 26}, {52, 26}, {52, -50}, {50, -50}}, color = {0, 127, 255}));
      connect(tank1.ports[1], pipe.port_a) annotation(
        Line(points = {{50, 78}, {50, 78}, {50, 46}, {50, 46}}, color = {0, 127, 255}, thickness = 0.5));
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
    end valveTest1;

    model valveTest2
      import pi = Modelica.Constants.pi;
      //cup parameter
      parameter Real R = 70 / 1000 "radius of cup";
      parameter Real L = 85 / 1000 "height of cup";
      parameter Real level_start = 40 / 1000 "初期水位";
      parameter Real cup_thick = 3 / 1000 "thichness of cup";
      parameter Real rho = 2200 "陶器密度　https://www.hakko.co.jp/qa/qakit/html/h01010.htm";
      parameter Real V = ((R + cup_thick) ^ 2 - R ^ 2) * 3.14 * L "volume of cup";
      parameter Real cp = 1050;
      //dripper parameter
      parameter Real drip_D = 5 / 1000 "ドリッパーの直径";
      parameter Real drip_L = 10 / 1000 "ドリッパーの長さ";
      replaceable package Medium = Modelica.Media.Water.StandardWater;
      Modelica.Fluid.Vessels.OpenTank cup(redeclare package Medium = Medium, T_start = 273.15 + 23, crossArea = R ^ 2 * 3.14, height = L, level_start = 0, nPorts = 1, portsData = {Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter = 15 / 1000, height = 70 / 1000)}, use_HeatTransfer = true, use_portsData = true) annotation(
        Placement(visible = true, transformation(origin = {48, -62}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      inner Modelica.Fluid.System system annotation(
        Placement(visible = true, transformation(origin = {-16, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Vessels.OpenTank tank1(redeclare package Medium = Medium, T_start = 273.15 + 90, crossArea = R ^ 2 * 3.14, height = L, level_start = level_start, nPorts = 1, portsData = {Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter = 5 / 1000)}, use_HeatTransfer = false, use_portsData = true) annotation(
        Placement(visible = true, transformation(origin = {50, 98}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Modelica.Fluid.Pipes.StaticPipe pipe(redeclare package Medium = Medium, diameter = 15 / 1000, height_ab = -50 / 1000, length = 50 / 1000) annotation(
        Placement(visible = true, transformation(origin = {50, 36}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Fluid.Valves.ValveIncompressible valveIncompressible1(redeclare package Medium = Medium, dp_nominal = 100000, m_flow_nominal = 1) annotation(
        Placement(visible = true, transformation(origin = {50, -6}, extent = {{-10, 10}, {10, -10}}, rotation = -90)));
      Modelica.Blocks.Sources.Ramp ramp1(duration = 0, offset = 1e-6, startTime = 5) annotation(
        Placement(visible = true, transformation(origin = {0, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      connect(ramp1.y, valveIncompressible1.opening) annotation(
        Line(points = {{12, -6}, {42, -6}, {42, -6}, {42, -6}}, color = {0, 0, 127}));
      connect(pipe.port_b, valveIncompressible1.port_a) annotation(
        Line(points = {{50, 26}, {50, 4}}, color = {0, 127, 255}));
      connect(valveIncompressible1.port_b, cup.ports[1]) annotation(
        Line(points = {{50, -16}, {48, -16}, {48, -82}}, color = {0, 127, 255}));
      connect(tank1.ports[1], pipe.port_a) annotation(
        Line(points = {{50, 78}, {50, 78}, {50, 46}, {50, 46}}, color = {0, 127, 255}, thickness = 0.5));
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
        __OpenModelica_commandLineOptions = "",
        experiment(StartTime = 0, StopTime = 100, Tolerance = 1e-6, Interval = 0.1));
    end valveTest2;

    model tankTest1
      import pi = Modelica.Constants.pi;
      //cup parameter
      parameter Real R = 70 / 1000 "radius of cup";
      parameter Real L = 85 / 1000 "height of cup";
      parameter Real level_start = 40 / 1000 "初期水位";
      parameter Real cup_thick = 3 / 1000 "thichness of cup";
      parameter Real rho = 2200 "陶器密度　https://www.hakko.co.jp/qa/qakit/html/h01010.htm";
      parameter Real V = ((R + cup_thick) ^ 2 - R ^ 2) * 3.14 * L "volume of cup";
      parameter Real cp = 1050;
      //dripper parameter
      parameter Real drip_D = 5 / 1000 "ドリッパーの直径";
      parameter Real drip_L = 10 / 1000 "ドリッパーの長さ";
      replaceable package Medium = Modelica.Media.Water.StandardWater;
      Modelica.Fluid.Vessels.OpenTank cup(redeclare package Medium = Medium, T_start = 273.15 + 23, crossArea = R ^ 2 * 3.14, height = L, level_start = 0, nPorts = 1, portsData = {Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter = 15 / 1000, height = 70 / 1000)}, use_HeatTransfer = true, redeclare model HeatTransfer = Modelica.Fluid.Vessels.BaseClasses.HeatTransfer.IdealHeatTransfer(k = 10), use_portsData = true) annotation(
        Placement(visible = true, transformation(origin = {48, -62}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      inner Modelica.Fluid.System system annotation(
        Placement(visible = true, transformation(origin = {-16, 90}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Fluid.Vessels.OpenTank tank1(redeclare package Medium = Medium, T_start = 273.15 + 90, crossArea = R ^ 2 * 3.14, height = L, level_start = level_start, nPorts = 1, portsData = {Modelica.Fluid.Vessels.BaseClasses.VesselPortsData(diameter = 5 / 1000)}, use_HeatTransfer = false, use_portsData = true) annotation(
        Placement(visible = true, transformation(origin = {40, 102}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
      Modelica.Fluid.Pipes.StaticPipe pipe(redeclare package Medium = Medium, diameter = 15 / 1000, height_ab = -50 / 1000, length = 50 / 1000) annotation(
        Placement(visible = true, transformation(origin = {50, 36}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
      Modelica.Fluid.Valves.ValveIncompressible valveIncompressible1(redeclare package Medium = Medium, dp_nominal = 100000, m_flow_nominal = 1) annotation(
        Placement(visible = true, transformation(origin = {50, -6}, extent = {{-10, 10}, {10, -10}}, rotation = -90)));
      Modelica.Blocks.Sources.Ramp ramp1(duration = 0, offset = 1e-6, startTime = 5) annotation(
        Placement(visible = true, transformation(origin = {0, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      connect(tank1.ports[1], pipe.port_a) annotation(
        Line(points = {{40, 82}, {40, 62}, {50, 62}, {50, 46}}, color = {0, 127, 255}, thickness = 0.5));
      connect(ramp1.y, valveIncompressible1.opening) annotation(
        Line(points = {{12, -6}, {42, -6}, {42, -6}, {42, -6}}, color = {0, 0, 127}));
      connect(pipe.port_b, valveIncompressible1.port_a) annotation(
        Line(points = {{50, 26}, {50, 4}}, color = {0, 127, 255}));
      connect(valveIncompressible1.port_b, cup.ports[1]) annotation(
        Line(points = {{50, -16}, {48, -16}, {48, -82}}, color = {0, 127, 255}));
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
        __OpenModelica_commandLineOptions = "",
        experiment(StartTime = 0, StopTime = 100, Tolerance = 1e-06, Interval = 0.1));
    end tankTest1;

  end UnitTest;

  package CoffeeThermal
  model NaturalConvection "Lumped thermal element for heat convection (Q_flow = Gc*dT)"
    Modelica.SIunits.HeatFlowRate Q_flow "Heat flow rate from solid -> fluid";
    Modelica.SIunits.TemperatureDifference dT "= solid.T - fluid.T";
    Modelica.SIunits.Temperature T;
    Real Gc;
    parameter Modelica.SIunits.Area area;
    parameter Modelica.SIunits.Length L "characteristicLength, heated Area/Perimeter length";
    Modelica.SIunits.CoefficientOfHeatTransfer h;
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a solid annotation(
      Placement(transformation(extent = {{-110, -10}, {-90, 10}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b fluid annotation(
      Placement(transformation(extent = {{90, -10}, {110, 10}})));
    //Nusselt Number Cal
    //import Modelica.Media;
    replaceable package medium = Modelica.Media.Air.DryAirNasa;
    medium.ThermodynamicState state;
    constant Real g = 9.81;
    constant Real p = 101325;
    //Physics properties
    Real C;
    Real n;
    Real k;
    Real Cp;
    Real d;
    Real Pr;
    Real mu "dynamic viscosity";
    Real beta;
    Real Gr;
    parameter CoffeeTemperature.CoffeeThermal.ConvectionType convectionType;
    Real Nu;
    Real Ra "Rayleigh number";
    Real A1, A2;
  equation
    dT = solid.T - fluid.T;
    T = (solid.T + fluid.T) / 2;
    solid.Q_flow = Q_flow;
    fluid.Q_flow = -Q_flow;
    Gc = area * h;
    Q_flow = Gc * dT;
    
    state = medium.setState_pT(p, T);
    mu = medium.dynamicViscosity(state);
    
    d = medium.density(state);
    k = medium.thermalConductivity(state);
    Cp = medium.specificHeatCapacityCp(state);
    mu = medium.dynamicViscosity(state);
    beta = medium.density_derT_p(state) * (-1 / d);
    Ra = Pr * Gr;
    Pr = mu * Cp / k;
    Gr = g * d ^ 2 * beta * dT * L ^ 3 / mu ^ 2;
    if convectionType == ConvectionType.vertical_planes_cylinder then
      A1 = 0.387 * (Pr * Gr) ^ (1 / 6);
      A2 = (1 + (0.492 / Pr) ^ 9 / 16) ^ (8 / 27);
      Nu = (0.825 + A1 / A2) ^ 2;
      h = k / L * Nu;
  //dummy
      C = 1;
      n = 1;
    elseif convectionType == ConvectionType.LowerSurface_of_heatedPlates then
      C = 0.27;
      n = 1 / 4;
      Nu = C * Ra ^ n;
  //dummy
      A1 = 1;
      A2 = 1;
      if Ra > 10 ^ 5 then
        h = k / L * Nu;
      else
        h = 5;
      end if;
    end if;
    annotation(
      Icon(coordinateSystem(initialScale = 0.1), graphics = {Rectangle(lineColor = {255, 255, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-62, 80}, {98, -80}}), Rectangle(fillColor = {192, 192, 192}, fillPattern = FillPattern.Backward, extent = {{-90, 80}, {-60, -80}}), Text(lineColor = {0, 0, 255}, extent = {{-150, -90}, {150, -130}}, textString = "%name"), Line(points = {{100, 0}, {100, 0}}, color = {0, 127, 255}), Line(points = {{-60, 20}, {76, 20}}, color = {191, 0, 0}), Line(points = {{-60, -20}, {76, -20}}, color = {191, 0, 0}), Line(points = {{-34, 80}, {-34, -80}}, color = {0, 127, 255}), Line(points = {{6, 80}, {6, -80}}, color = {0, 127, 255}), Line(points = {{40, 80}, {40, -80}}, color = {0, 127, 255}), Line(points = {{76, 80}, {76, -80}}, color = {0, 127, 255}), Line(points = {{-34, -80}, {-44, -60}}, color = {0, 127, 255}), Line(points = {{-34, -80}, {-24, -60}}, color = {0, 127, 255}), Line(points = {{6, -80}, {-4, -60}}, color = {0, 127, 255}), Line(points = {{6, -80}, {16, -60}}, color = {0, 127, 255}), Line(points = {{40, -80}, {30, -60}}, color = {0, 127, 255}), Line(points = {{40, -80}, {50, -60}}, color = {0, 127, 255}), Line(points = {{76, -80}, {66, -60}}, color = {0, 127, 255}), Line(points = {{76, -80}, {86, -60}}, color = {0, 127, 255}), Line(points = {{56, -30}, {76, -20}}, color = {191, 0, 0}), Line(points = {{56, -10}, {76, -20}}, color = {191, 0, 0}), Line(points = {{56, 10}, {76, 20}}, color = {191, 0, 0}), Line(points = {{56, 30}, {76, 20}}, color = {191, 0, 0}), Text(origin = {-23, 90}, lineThickness = 1.5, extent = {{-41, 20}, {103, -20}}, textString = "NaturalConvection")}),
      Documentation(info = "<html>
  <p>
  This is a model of linear heat convection, e.g., the heat transfer between a plate and the surrounding air; see also:
  <a href=\"modelica://Modelica.Thermal.HeatTransfer.Components.ConvectiveResistor\">ConvectiveResistor</a>.
  It may be used for complicated solid geometries and fluid flow over the solid by determining the
  convective thermal conductance Gc by measurements. The basic constitutive equation for convection is
  </p>
  <pre>
  Q_flow = Gc*(solid.T - fluid.T);
  Q_flow: Heat flow rate from connector 'solid' (e.g., a plate)
    to connector 'fluid' (e.g., the surrounding air)
  </pre>
  <p>
  Gc = G.signal[1] is an input signal to the component, since Gc is
  nearly never constant in practice. For example, Gc may be a function
  of the speed of a cooling fan. For simple situations,
  Gc may be <i>calculated</i> according to
  </p>
  <pre>
  Gc = A*h
  A: Convection area (e.g., perimeter*length of a box)
  h: Heat transfer coefficient
  </pre>
  <p>
  where the heat transfer coefficient h is calculated
  from properties of the fluid flowing over the solid. Examples:
  </p>
  <p>
  <b>Machines cooled by air</b> (empirical, very rough approximation according
  to R. Fischer: Elektrische Maschinen, 10th edition, Hanser-Verlag 1999,
  p. 378):
  </p>
  <pre>
  h = 7.8*v^0.78 [W/(m2.K)] (forced convection)
    = 12         [W/(m2.K)] (free convection)
  where
    v: Air velocity in [m/s]
  </pre>
  <p><b>Laminar</b> flow with constant velocity of a fluid along a
  <b>flat plate</b> where the heat flow rate from the plate
  to the fluid (= solid.Q_flow) is kept constant
  (according to J.P.Holman: Heat Transfer, 8th edition,
  McGraw-Hill, 1997, p.270):
  </p>
  <pre>
  h  = Nu*k/x;
  Nu = 0.453*Re^(1/2)*Pr^(1/3);
  where
    h  : Heat transfer coefficient
    Nu : = h*x/k       (Nusselt number)
    Re : = v*x*rho/mue (Reynolds number)
    Pr : = cp*mue/k    (Prandtl number)
    v  : Absolute velocity of fluid
    x  : distance from leading edge of flat plate
    rho: density of fluid (material constant
    mue: dynamic viscosity of fluid (material constant)
    cp : specific heat capacity of fluid (material constant)
    k  : thermal conductivity of fluid (material constant)
  and the equation for h holds, provided
    Re &lt; 5e5 and 0.6 &lt; Pr &lt; 50
  </pre>
  </html>"),
      Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-90, 80}, {-60, -80}}, lineColor = {0, 0, 0}, fillColor = {192, 192, 192}, fillPattern = FillPattern.Backward), Line(points = {{100, 0}, {100, 0}}, color = {0, 127, 255}), Line(points = {{100, 0}, {100, 0}}, color = {0, 127, 255}), Line(points = {{100, 0}, {100, 0}}, color = {0, 127, 255}), Text(extent = {{-40, 40}, {80, 20}}, lineColor = {255, 0, 0}, textString = "Q_flow"), Line(points = {{-60, 20}, {76, 20}}, color = {191, 0, 0}), Line(points = {{-60, -20}, {76, -20}}, color = {191, 0, 0}), Line(points = {{-34, 80}, {-34, -80}}, color = {0, 127, 255}), Line(points = {{6, 80}, {6, -80}}, color = {0, 127, 255}), Line(points = {{40, 80}, {40, -80}}, color = {0, 127, 255}), Line(points = {{76, 80}, {76, -80}}, color = {0, 127, 255}), Line(points = {{-34, -80}, {-44, -60}}, color = {0, 127, 255}), Line(points = {{-34, -80}, {-24, -60}}, color = {0, 127, 255}), Line(points = {{6, -80}, {-4, -60}}, color = {0, 127, 255}), Line(points = {{6, -80}, {16, -60}}, color = {0, 127, 255}), Line(points = {{40, -80}, {30, -60}}, color = {0, 127, 255}), Line(points = {{40, -80}, {50, -60}}, color = {0, 127, 255}), Line(points = {{76, -80}, {66, -60}}, color = {0, 127, 255}), Line(points = {{76, -80}, {86, -60}}, color = {0, 127, 255}), Line(points = {{56, -30}, {76, -20}}, color = {191, 0, 0}), Line(points = {{56, -10}, {76, -20}}, color = {191, 0, 0}), Line(points = {{56, 10}, {76, 20}}, color = {191, 0, 0}), Line(points = {{56, 30}, {76, 20}}, color = {191, 0, 0})}));
  end NaturalConvection;

model EnclosedConvection "Lumped thermal element for heat convection (Q_flow = Gc*dT)"
    Modelica.SIunits.HeatFlowRate Q_flow "Heat flow rate from solid -> fluid";
    Modelica.SIunits.TemperatureDifference dT "= solid.T - fluid.T";
    Modelica.SIunits.Temperature T;
    Real Gc;
    parameter Modelica.SIunits.Area area;
    parameter Modelica.SIunits.Length L "length";
    parameter Modelica.SIunits.Length H "Height";
    Modelica.SIunits.CoefficientOfHeatTransfer h;
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a solid annotation(
      Placement(transformation(extent = {{-110, -10}, {-90, 10}})));
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b fluid annotation(
      Placement(transformation(extent = {{90, -10}, {110, 10}})));
    //Nusselt Number Cal
    replaceable package medium = Modelica.Media.Water.StandardWater;
    medium.ThermodynamicState state;
    constant Real g = 9.81;
    constant Real p = 101325;
    //Physics properties
    Real k;
    Real Cp;
    Real d;
    Real Pr;
    Real mu "dynamic viscosity";
    Real beta;
    Real Gr;
    Real Nu;
    Real Ra "Rayleigh number";
    Real A1;
  equation
    dT = solid.T - fluid.T;
    T = (solid.T + fluid.T) / 2;
    solid.Q_flow = Q_flow;
    fluid.Q_flow = -Q_flow;
    Gc = area * h;
    Q_flow = Gc * dT;
    state = medium.setState_pT(p, T);
    d = medium.density(state);
    k = medium.thermalConductivity(state);
    Cp = medium.specificHeatCapacityCp(state);
    mu = medium.dynamicViscosity(state);
  //beta = medium.density_derT_p(state) * (-1 / d);
    beta = 2.1;
    Ra = Pr * Gr;
    Pr = mu * Cp / k;
    Gr = g * d ^ 2 * beta * dT * L ^ 3 / mu ^ 2;
    A1 = Pr * Ra / (0.2 + Pr);
    if 2 < H / L and H / L < 10 and Pr < 10 ^ 5 and 10 ^ 3 < Ra and Ra < 10 ^ 10 then
      Nu = 0.22 * A1 ^ 0.28 * (H / L) * (-1 / 4);
      h = k / L * Nu;
    elseif 1 < H / L and H / L < 2 and 10 ^ (-3) < Pr and Pr < 10 ^ 5 and A1 > 10 ^ 2 then
      Nu = 0.18 * A1 ^ 0.29;
      h = k / L * Nu;
    else
      Nu = 1;
      h = 1000;
    end if;
    annotation(
      Icon(coordinateSystem(initialScale = 0.1), graphics = {Rectangle(lineColor = {255, 255, 255}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-62, 80}, {98, -80}}), Rectangle(fillColor = {192, 192, 192}, fillPattern = FillPattern.Backward, extent = {{-90, 80}, {-60, -80}}), Text(lineColor = {0, 0, 255}, extent = {{-150, -90}, {150, -130}}, textString = "%name"), Line(points = {{100, 0}, {100, 0}}, color = {0, 127, 255}), Line(points = {{-60, 20}, {76, 20}}, color = {191, 0, 0}), Line(points = {{-60, -20}, {76, -20}}, color = {191, 0, 0}), Line(points = {{-34, 80}, {-34, -80}}, color = {0, 127, 255}), Line(points = {{6, 80}, {6, -80}}, color = {0, 127, 255}), Line(points = {{40, 80}, {40, -80}}, color = {0, 127, 255}), Line(points = {{76, 80}, {76, -80}}, color = {0, 127, 255}), Line(points = {{-34, -80}, {-44, -60}}, color = {0, 127, 255}), Line(points = {{-34, -80}, {-24, -60}}, color = {0, 127, 255}), Line(points = {{6, -80}, {-4, -60}}, color = {0, 127, 255}), Line(points = {{6, -80}, {16, -60}}, color = {0, 127, 255}), Line(points = {{40, -80}, {30, -60}}, color = {0, 127, 255}), Line(points = {{40, -80}, {50, -60}}, color = {0, 127, 255}), Line(points = {{76, -80}, {66, -60}}, color = {0, 127, 255}), Line(points = {{76, -80}, {86, -60}}, color = {0, 127, 255}), Line(points = {{56, -30}, {76, -20}}, color = {191, 0, 0}), Line(points = {{56, -10}, {76, -20}}, color = {191, 0, 0}), Line(points = {{56, 10}, {76, 20}}, color = {191, 0, 0}), Line(points = {{56, 30}, {76, 20}}, color = {191, 0, 0}), Text(origin = {-23, 90}, lineThickness = 1.5, extent = {{-41, 20}, {103, -20}}, textString = "NaturalConvection")}),
      Documentation(info = "<html>
  <p>
  This is a model of linear heat convection, e.g., the heat transfer between a plate and the surrounding air; see also:
  <a href=\"modelica://Modelica.Thermal.HeatTransfer.Components.ConvectiveResistor\">ConvectiveResistor</a>.
  It may be used for complicated solid geometries and fluid flow over the solid by determining the
  convective thermal conductance Gc by measurements. The basic constitutive equation for convection is
  </p>
  <pre>
  Q_flow = Gc*(solid.T - fluid.T);
  Q_flow: Heat flow rate from connector 'solid' (e.g., a plate)
    to connector 'fluid' (e.g., the surrounding air)
  </pre>
  <p>
  Gc = G.signal[1] is an input signal to the component, since Gc is
  nearly never constant in practice. For example, Gc may be a function
  of the speed of a cooling fan. For simple situations,
  Gc may be <i>calculated</i> according to
  </p>
  <pre>
  Gc = A*h
  A: Convection area (e.g., perimeter*length of a box)
  h: Heat transfer coefficient
  </pre>
  <p>
  where the heat transfer coefficient h is calculated
  from properties of the fluid flowing over the solid. Examples:
  </p>
  <p>
  <b>Machines cooled by air</b> (empirical, very rough approximation according
  to R. Fischer: Elektrische Maschinen, 10th edition, Hanser-Verlag 1999,
  p. 378):
  </p>
  <pre>
  h = 7.8*v^0.78 [W/(m2.K)] (forced convection)
    = 12         [W/(m2.K)] (free convection)
  where
    v: Air velocity in [m/s]
  </pre>
  <p><b>Laminar</b> flow with constant velocity of a fluid along a
  <b>flat plate</b> where the heat flow rate from the plate
  to the fluid (= solid.Q_flow) is kept constant
  (according to J.P.Holman: Heat Transfer, 8th edition,
  McGraw-Hill, 1997, p.270):
  </p>
  <pre>
  h  = Nu*k/x;
  Nu = 0.453*Re^(1/2)*Pr^(1/3);
  where
    h  : Heat transfer coefficient
    Nu : = h*x/k       (Nusselt number)
    Re : = v*x*rho/mue (Reynolds number)
    Pr : = cp*mue/k    (Prandtl number)
    v  : Absolute velocity of fluid
    x  : distance from leading edge of flat plate
    rho: density of fluid (material constant
    mue: dynamic viscosity of fluid (material constant)
    cp : specific heat capacity of fluid (material constant)
    k  : thermal conductivity of fluid (material constant)
  and the equation for h holds, provided
    Re &lt; 5e5 and 0.6 &lt; Pr &lt; 50
  </pre>
  </html>"),
      Diagram(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Rectangle(extent = {{-90, 80}, {-60, -80}}, lineColor = {0, 0, 0}, fillColor = {192, 192, 192}, fillPattern = FillPattern.Backward), Line(points = {{100, 0}, {100, 0}}, color = {0, 127, 255}), Line(points = {{100, 0}, {100, 0}}, color = {0, 127, 255}), Line(points = {{100, 0}, {100, 0}}, color = {0, 127, 255}), Text(extent = {{-40, 40}, {80, 20}}, lineColor = {255, 0, 0}, textString = "Q_flow"), Line(points = {{-60, 20}, {76, 20}}, color = {191, 0, 0}), Line(points = {{-60, -20}, {76, -20}}, color = {191, 0, 0}), Line(points = {{-34, 80}, {-34, -80}}, color = {0, 127, 255}), Line(points = {{6, 80}, {6, -80}}, color = {0, 127, 255}), Line(points = {{40, 80}, {40, -80}}, color = {0, 127, 255}), Line(points = {{76, 80}, {76, -80}}, color = {0, 127, 255}), Line(points = {{-34, -80}, {-44, -60}}, color = {0, 127, 255}), Line(points = {{-34, -80}, {-24, -60}}, color = {0, 127, 255}), Line(points = {{6, -80}, {-4, -60}}, color = {0, 127, 255}), Line(points = {{6, -80}, {16, -60}}, color = {0, 127, 255}), Line(points = {{40, -80}, {30, -60}}, color = {0, 127, 255}), Line(points = {{40, -80}, {50, -60}}, color = {0, 127, 255}), Line(points = {{76, -80}, {66, -60}}, color = {0, 127, 255}), Line(points = {{76, -80}, {86, -60}}, color = {0, 127, 255}), Line(points = {{56, -30}, {76, -20}}, color = {191, 0, 0}), Line(points = {{56, -10}, {76, -20}}, color = {191, 0, 0}), Line(points = {{56, 10}, {76, 20}}, color = {191, 0, 0}), Line(points = {{56, 30}, {76, 20}}, color = {191, 0, 0})}));
  end EnclosedConvection;
  
  type ConvectionType = enumeration(vertical_planes_cylinder, LowerSurface_of_heatedPlates);
  end CoffeeThermal;





  package Media
    import Cv = Modelica.SIunits.Conversions;
    import SI = Modelica.SIunits;
    /*
                    package DryAirNasa "Air: Detailed dry air model as ideal gas (200..6000 K)"
                    
                    extends Modelica.Icons.MaterialProperty;
                    extends Modelica.Media.IdealGases.Common.SingleGasNasa(
                      mediumName="Air",
                      data=CoffeeTemperature.Media.SingleGasesData.Air,
                      fluidConstants={CoffeeTemperature.Media.FluidData.N2});
                  
                    redeclare function dynamicViscosity
                      "Return dynamic viscosity of dry air (simple polynomial, moisture influence small, valid from 123.15 K to 1273.15 K, outside of this range linear extrapolation is used)"
                      extends Modelica.Icons.Function;
                      input ThermodynamicState state "Thermodynamic state record";
                      output DynamicViscosity eta "Dynamic viscosity";
                      import Modelica.Media.Incompressible.TableBased.Polynomials_Temp;
                    algorithm
                      eta := 1e-6*Polynomials_Temp.evaluateWithRange(
                          {9.7391102886305869E-15,-3.1353724870333906E-11,4.3004876595642225E-08,
                          -3.8228016291758240E-05,5.0427874367180762E-02,1.7239260139242528E+01},
                          Cv.to_degC(123.15),
                          Cv.to_degC(1273.15),
                          Cv.to_degC(state.T));
                      annotation (smoothOrder=2, Documentation(info="<html>
                  <p>Dynamic viscosity is computed from temperature using a simple polynomial for dry air. Range of validity is from 123.15 K to 1273.15 K. The influence of pressure is neglected. </p>
                  <p>Source: VDI Waermeatlas, 8th edition. </p>
                  </html>"));
                    end dynamicViscosity;
                  
                    redeclare function thermalConductivity
                      "Return thermal conductivity of dry air (simple polynomial, moisture influence small, valid from 123.15 K to 1273.15 K, outside of this range linear extrapolation is used)"
                      extends Modelica.Icons.Function;
                      input ThermodynamicState state "Thermodynamic state record";
                      input Integer method=1 "Dummy for compatibility reasons";
                      output ThermalConductivity lambda "Thermal conductivity";
                      import Modelica.Media.Incompressible.TableBased.Polynomials_Temp;
                      import Cv = Modelica.SIunits.Conversions;
                    algorithm
                      lambda := 1e-3*Polynomials_Temp.evaluateWithRange(
                          {6.5691470817717812E-15,-3.4025961923050509E-11,5.3279284846303157E-08,
                          -4.5340839289219472E-05,7.6129675309037664E-02,2.4169481088097051E+01},
                          Cv.to_degC(123.15),
                          Cv.to_degC(1273.15),
                          Cv.to_degC(state.T));
                  
                      annotation (smoothOrder=2, Documentation(info="<html>
                  <p>Thermal conductivity is computed from temperature using a simple polynomial for dry air. Range of validity is from 123.15 K to 1273.15 K. The influence of pressure is neglected. </p>
                  <p>Source: VDI Waermeatlas, 8th edition. </p>
                  </html>"));
                    end thermalConductivity;
                  
                    annotation (Documentation(info="<html>
                  <p>
                      <IMG src=\"modelica://Modelica/Resources/Images/Media/IdealGases/SingleGases/Air.png\">
                  </p>
                  
                  <p>
                  Ideal gas medium model for dry air based on the package <a href=\"modelica://Modelica.Media.IdealGases\">IdealGases</a> with additional functions for dynamic viscosity and thermal conductivity in a limited temperature range.
                  </p>
                  </html>"));
                  end DryAirNasa;
                
                
                
                
                
                  
                  package FluidData "Critical data, dipole moments and related data"
                    extends Modelica.Icons.Package;
                    import Modelica.Media.Interfaces.PartialMixtureMedium;
                    import Modelica.Media.IdealGases.Common.SingleGasesData;
                    constant Modelica.Media.Interfaces.Types.IdealGas.FluidConstants N2(chemicalFormula = "N2", iupacName = "unknown", structureFormula = "unknown", casRegistryNumber = "7727-37-9", meltingPoint = 63.15, normalBoilingPoint = 77.35, criticalTemperature = 126.20, criticalPressure = 33.98e5, criticalMolarVolume = 90.10e-6, acentricFactor = 0.037, dipoleMoment = 0.0, molarMass = SingleGasesData.N2.MM, hasDipoleMoment = true, hasIdealGasHeatCapacity = true, hasCriticalData = true, hasAcentricFactor = true);
                    constant Modelica.Media.Interfaces.Types.IdealGas.FluidConstants O2(chemicalFormula = "O2", iupacName = "unknown", structureFormula = "unknown", casRegistryNumber = "7782-44-7", meltingPoint = 54.36, normalBoilingPoint = 90.17, criticalTemperature = 154.58, criticalPressure = 50.43e5, criticalMolarVolume = 73.37e-6, acentricFactor = 0.022, dipoleMoment = 0.0, molarMass = SingleGasesData.O2.MM, hasDipoleMoment = true, hasIdealGasHeatCapacity = true, hasCriticalData = true, hasAcentricFactor = true);
                    
                    constant Modelica.Media.Interfaces.Types.IdealGas.FluidConstants CO2(chemicalFormula = "CO2", iupacName = "unknown", structureFormula = "unknown", casRegistryNumber = "124-38-9", meltingPoint = 216.58, normalBoilingPoint = -1.0, criticalTemperature = 304.12, criticalPressure = 73.74e5, criticalMolarVolume = 94.07e-6, acentricFactor = 0.225, dipoleMoment = 0.0, molarMass = SingleGasesData.CO2.MM, hasDipoleMoment = true, hasIdealGasHeatCapacity = true, hasCriticalData = true, hasAcentricFactor = true);
                    // does not exist!
                    constant Modelica.Media.Interfaces.Types.IdealGas.FluidConstants CO(chemicalFormula = "CO", iupacName = "unknown", structureFormula = "unknown", casRegistryNumber = "630-08-0", meltingPoint = 68.15, normalBoilingPoint = 81.66, criticalTemperature = 132.85, criticalPressure = 34.94e5, criticalMolarVolume = 93.10e-6, acentricFactor = 0.045, dipoleMoment = 0.1, molarMass = SingleGasesData.CO.MM, hasDipoleMoment = true, hasIdealGasHeatCapacity = true, hasCriticalData = true, hasAcentricFactor = true);
                    constant Modelica.Media.Interfaces.Types.IdealGas.FluidConstants H2(chemicalFormula = "H2", iupacName = "unknown", structureFormula = "unknown", casRegistryNumber = "800000-51-5", meltingPoint = 13.56, normalBoilingPoint = 20.38, criticalTemperature = 33.25, criticalPressure = 12.97e5, criticalMolarVolume = 65.00e-6, acentricFactor = -0.216, dipoleMoment = 0.0, molarMass = SingleGasesData.H2.MM, hasDipoleMoment = true, hasIdealGasHeatCapacity = true, hasCriticalData = true, hasAcentricFactor = true);
                    constant Modelica.Media.Interfaces.Types.IdealGas.FluidConstants H2O(chemicalFormula = "H2O", iupacName = "oxidane", structureFormula = "H2O", casRegistryNumber = "7732-18-5", meltingPoint = 273.15, normalBoilingPoint = 373.124, criticalTemperature = 647.096, criticalPressure = 220.64e5, criticalMolarVolume = 55.95e-6, acentricFactor = 0.344, dipoleMoment = 1.8, molarMass = SingleGasesData.H2O.MM, hasDipoleMoment = true, hasIdealGasHeatCapacity = true, hasCriticalData = true, hasAcentricFactor = true);
                   
                    constant Modelica.Media.Interfaces.Types.IdealGas.FluidConstants Ar(chemicalFormula = "Ar", iupacName = "unknown", structureFormula = "unknown", casRegistryNumber = "7440-37-1", meltingPoint = 83.80, normalBoilingPoint = 87.27, criticalTemperature = 150.86, criticalPressure = 48.98e5, criticalMolarVolume = 74.57e-6, acentricFactor = -0.002, dipoleMoment = 0.0, molarMass = SingleGasesData.Ar.MM, hasDipoleMoment = true, hasIdealGasHeatCapacity = true, hasCriticalData = true, hasAcentricFactor = true);
                    constant Modelica.Media.Interfaces.Types.IdealGas.FluidConstants He(chemicalFormula = "He", iupacName = "unknown", structureFormula = "unknown", casRegistryNumber = "7440-59-7", meltingPoint = 2.15, normalBoilingPoint = 4.30, criticalTemperature = 5.19, criticalPressure = 2.27e5, criticalMolarVolume = 57.30e-6, acentricFactor = -0.390, dipoleMoment = 0.0, molarMass = SingleGasesData.He.MM, hasDipoleMoment = true, hasIdealGasHeatCapacity = true, hasCriticalData = true, hasAcentricFactor = true);
                    
                    annotation(
                      Documentation(info = "<html>
                  <p>
                  This package contains FluidConstants data records for the following 37 gases
                  (see also the description in
                  <a href=\"modelica://Modelica.Media.IdealGases\">Modelica.Media.IdealGases</a>):
                  </p>
                  <pre>
                  Argon             Methane          Methanol       Carbon Monoxide  Carbon Dioxide
                  Acetylene         Ethylene         Ethanol        Ethane           Propylene
                  Propane           1-Propanol       1-Butene       N-Butane         1-Pentene
                  N-Pentane         Benzene          1-Hexene       N-Hexane         1-Heptane
                  N-Heptane         Ethylbenzene     N-Octane       Chlorine         Fluorine
                  Hydrogen          Steam            Helium         Ammonia          Nitric Oxide
                  Nitrogen Dioxide  Nitrogen         Nitrous        Oxide            Neon Oxygen
                  Sulfur Dioxide    Sulfur Trioxide
                  </pre>
                  
                  </html>"));
                  end FluidData;
                  */

    package Examples
      model AirTest1
        /*
                                   とりあえず空気の密度を出力してみる
                                   IdealGases_Light.SimpleAirは保存時間2秒程度
                                   他は10秒程度
                                   
                                  */
        import Modelica.Media;
        //package medium = Modelica.Media.Air.DryAirNasa;
        //package medium = CoffeeTemperature.Media.DryAirNasa;
        //package medium = Modelica.Media.Air.SimpleAir;
        package medium = IdealGases_Light.SimpleAir;
        medium.ThermodynamicState state;
        parameter Real p = 101325;
        parameter Real T = 300;
        Real d;
      equation
        state = medium.setState_pT(p, T);
        d = medium.density(state);
      end AirTest1;

      model AirTest2
        /*
                                   IdealGases_Light.SimpleAirは保存時間2秒程度
                                   他は10秒程度
                                  */
        import Modelica.Media;
        //package medium = Modelica.Media.Air.DryAirNasa;
        //package medium = CoffeeTemperature.Media.DryAirNasa;
        //package medium = Modelica.Media.Air.SimpleAir;
        package medium = IdealGases_Light.SimpleAir;
        medium.ThermodynamicState state;
        constant Real p = 101325;
        parameter Real T = 20 + 273.15;
        Real k;
        Real Cp;
        Real d;
        Real mu;
        Real Pr;
        Real dynamicViscosity;
      equation
        state = medium.setState_pT(p, T);
        d = medium.density(state);
        k = medium.thermalConductivity(state);
        Cp = medium.specificHeatCapacityCp(state);
        mu = medium.dynamicViscosity(state) * d;
        dynamicViscosity = medium.dynamicViscosity(state);
        Pr = mu * Cp / k;
      end AirTest2;

      model AirTest3
        /*
                                      SimpleAirの動粘度が文献とずれるのでDryAirNasaと比較
                                           
                                          */
        import Modelica.Media;
        package medium = Modelica.Media.Air.DryAirNasa;
        //package medium = CoffeeTemperature.Media.DryAirNasa;
        //package medium = Modelica.Media.Air.SimpleAir;
        //package medium = IdealGases_Light.SimpleAir;
        medium.ThermodynamicState state;
        constant Real p = 101325;
        parameter Real T = 20 + 273.15;
        Real k;
        Real Cp;
        Real d;
        Real mu;
        Real Pr;
        Real dynamicViscosity;
        inner Modelica.Fluid.System system annotation(
          Placement(visible = true, transformation(origin = {-36, -10}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      equation
        state = medium.setState_pT(p, T);
        d = medium.density(state);
        k = medium.thermalConductivity(state);
        Cp = medium.specificHeatCapacityCp(state);
        mu = medium.dynamicViscosity(state) * d;
        dynamicViscosity = medium.dynamicViscosity(state);
        Pr = mu * Cp / k;
      end AirTest3;

      model AirTest4
        /*
                                      ローカルクラスを作らずに計算
                                          */
        CoffeeTemperature.Media.IdealGases_Light.SimpleAir.ThermodynamicState state;
        parameter Real p = 101325;
        parameter Real T = 300;
        Real d;
      equation
        state = CoffeeTemperature.Media.IdealGases_Light.SimpleAir.setState_pT(p, T);
        d = CoffeeTemperature.Media.IdealGases_Light.SimpleAir.density(state);
      end AirTest4;

      model AirTest5
        /*
                                           Gr作成
                                          */
        import Modelica.Media;
        //package medium = IdealGases_Light.SimpleAir;
        package medium = Modelica.Media.Air.DryAirNasa;
        medium.ThermodynamicState state;
        constant Real g = 9.81;
        constant Real p = 101325;
        parameter Real T = 273.15;
        Real k;
        Real Cp;
        Real d;
        Real mu;
        Real Pr;
        Real dynamicViscosity;
        Real beta;
        Real Gr;
        parameter Real dT = 10;
        parameter Real L = 1;
      equation
        state = medium.setState_pT(p, T);
        d = medium.density(state);
        k = medium.thermalConductivity(state);
        Cp = medium.specificHeatCapacityCp(state);
        mu = medium.dynamicViscosity(state) * d;
        dynamicViscosity = medium.dynamicViscosity(state);
        beta = medium.density_derT_p(state) * (-1 / d);
        Pr = mu * Cp / k;
        Gr = g * d ^ 2 * beta * dT * L ^ 3 / mu ^ 2;
//dT=Ts-Tbulk;
      end AirTest5;

      model AirTest6
        import Modelica.Media;
        //package medium = IdealGases_Light.SimpleAir;
        package medium = Modelica.Media.Air.DryAirNasa;
        medium.ThermodynamicState state;
        constant Real g = 9.81;
        constant Real p = 101325;
        parameter Real T = 273.15;
        Real k;
        Real Cp;
        Real d;
        Real mu;
        Real Pr;
        Real dynamicViscosity;
        Real beta;
        Real Gr;
        Real C;
        Real m;
        Real Nu;
        Real h;
        parameter Real dT = 10;
        parameter Real L = 1;
      equation
        state = medium.setState_pT(p, T);
        d = medium.density(state);
        k = medium.thermalConductivity(state);
        Cp = medium.specificHeatCapacityCp(state);
        mu = medium.dynamicViscosity(state) * d;
        dynamicViscosity = medium.dynamicViscosity(state);
        beta = medium.density_derT_p(state) * (-1 / d);
        Pr = mu * Cp / k;
        Gr = g * d ^ 2 * beta * dT * L ^ 3 / mu ^ 2;
        if Pr * Gr >= 10 ^ 5 and Pr * Gr <= 10 ^ 8 then
          C = 0.56;
          m = 0.25;
        elseif Pr * Gr > 10 ^ 8 then
          C = 0.12;
          m = 0.33;
        else
          C = 0;
          m = 0;
          assert(Pr * Gr > 10 ^ 5, "Pr*Gr<10^5 Can't adapt this model");
        end if;
        Nu = C * (Pr * Gr) ^ m;
        h = k / L * Nu;
        assert(Pr > 0.72, "Pr < 0.72  Can't adapt this model");
//dT=Ts-Tbulk;
      end AirTest6;
    end Examples;

    package SingleGasesData "Ideal gas data based on the NASA Glenn coefficients"
      extends Modelica.Icons.Package;
      import Modelica.Media.IdealGases;
      constant IdealGases.Common.DataRecord Air(name = "Air", MM = 0.0289651159, Hf = -4333.833858403446, H0 = 298609.6803431054, Tlimit = 1000, alow = {10099.5016, -196.827561, 5.00915511, -0.00576101373, 1.06685993e-005, -7.94029797e-009, 2.18523191e-012}, blow = {-176.796731, -3.921504225}, ahigh = {241521.443, -1257.8746, 5.14455867, -0.000213854179, 7.06522784e-008, -1.07148349e-011, 6.57780015e-016}, bhigh = {6462.26319, -8.147411905}, R = 287.0512249529787);
      constant IdealGases.Common.DataRecord N2(name = "N2", MM = 0.0280134, Hf = 0, H0 = 309498.4543111511, Tlimit = 1000, alow = {22103.71497, -381.846182, 6.08273836, -0.00853091441, 1.384646189e-005, -9.62579362e-009, 2.519705809e-012}, blow = {710.846086, -10.76003744}, ahigh = {587712.406, -2239.249073, 6.06694922, -0.00061396855, 1.491806679e-007, -1.923105485e-011, 1.061954386e-015}, bhigh = {12832.10415, -15.86640027}, R = 296.8033869505308);
      annotation(
        Documentation(info = "<html>
  <p>This package contains ideal gas models for the 1241 ideal gases from</p>
  <blockquote>
  <p>McBride B.J., Zehe M.J., and Gordon S. (2002): <b>NASA Glenn Coefficients
  for Calculating Thermodynamic Properties of Individual Species</b>. NASA
  report TP-2002-211556</p>
  </blockquote>
  
  <pre>
  
  </pre>
  </html>"));
    end SingleGasesData;

    package IdealGases_Light
      package FluidData "Critical data, dipole moments and related data"
        extends Modelica.Icons.Package;
        import Modelica.Media.Interfaces.PartialMixtureMedium;
        import Modelica.Media.IdealGases.Common.SingleGasesData;
        constant Modelica.Media.Interfaces.Types.IdealGas.FluidConstants N2(chemicalFormula = "N2", iupacName = "unknown", structureFormula = "unknown", casRegistryNumber = "7727-37-9", meltingPoint = 63.15, normalBoilingPoint = 77.35, criticalTemperature = 126.20, criticalPressure = 33.98e5, criticalMolarVolume = 90.10e-6, acentricFactor = 0.037, dipoleMoment = 0.0, molarMass = SingleGasesData.N2.MM, hasDipoleMoment = true, hasIdealGasHeatCapacity = true, hasCriticalData = true, hasAcentricFactor = true);
        constant Modelica.Media.Interfaces.Types.IdealGas.FluidConstants O2(chemicalFormula = "O2", iupacName = "unknown", structureFormula = "unknown", casRegistryNumber = "7782-44-7", meltingPoint = 54.36, normalBoilingPoint = 90.17, criticalTemperature = 154.58, criticalPressure = 50.43e5, criticalMolarVolume = 73.37e-6, acentricFactor = 0.022, dipoleMoment = 0.0, molarMass = SingleGasesData.O2.MM, hasDipoleMoment = true, hasIdealGasHeatCapacity = true, hasCriticalData = true, hasAcentricFactor = true);
        constant Modelica.Media.Interfaces.Types.IdealGas.FluidConstants CO2(chemicalFormula = "CO2", iupacName = "unknown", structureFormula = "unknown", casRegistryNumber = "124-38-9", meltingPoint = 216.58, normalBoilingPoint = -1.0, criticalTemperature = 304.12, criticalPressure = 73.74e5, criticalMolarVolume = 94.07e-6, acentricFactor = 0.225, dipoleMoment = 0.0, molarMass = SingleGasesData.CO2.MM, hasDipoleMoment = true, hasIdealGasHeatCapacity = true, hasCriticalData = true, hasAcentricFactor = true);
        // does not exist!
        constant Modelica.Media.Interfaces.Types.IdealGas.FluidConstants CO(chemicalFormula = "CO", iupacName = "unknown", structureFormula = "unknown", casRegistryNumber = "630-08-0", meltingPoint = 68.15, normalBoilingPoint = 81.66, criticalTemperature = 132.85, criticalPressure = 34.94e5, criticalMolarVolume = 93.10e-6, acentricFactor = 0.045, dipoleMoment = 0.1, molarMass = SingleGasesData.CO.MM, hasDipoleMoment = true, hasIdealGasHeatCapacity = true, hasCriticalData = true, hasAcentricFactor = true);
        constant Modelica.Media.Interfaces.Types.IdealGas.FluidConstants H2(chemicalFormula = "H2", iupacName = "unknown", structureFormula = "unknown", casRegistryNumber = "800000-51-5", meltingPoint = 13.56, normalBoilingPoint = 20.38, criticalTemperature = 33.25, criticalPressure = 12.97e5, criticalMolarVolume = 65.00e-6, acentricFactor = -0.216, dipoleMoment = 0.0, molarMass = SingleGasesData.H2.MM, hasDipoleMoment = true, hasIdealGasHeatCapacity = true, hasCriticalData = true, hasAcentricFactor = true);
        constant Modelica.Media.Interfaces.Types.IdealGas.FluidConstants H2O(chemicalFormula = "H2O", iupacName = "oxidane", structureFormula = "H2O", casRegistryNumber = "7732-18-5", meltingPoint = 273.15, normalBoilingPoint = 373.124, criticalTemperature = 647.096, criticalPressure = 220.64e5, criticalMolarVolume = 55.95e-6, acentricFactor = 0.344, dipoleMoment = 1.8, molarMass = SingleGasesData.H2O.MM, hasDipoleMoment = true, hasIdealGasHeatCapacity = true, hasCriticalData = true, hasAcentricFactor = true);
        constant Modelica.Media.Interfaces.Types.IdealGas.FluidConstants Ar(chemicalFormula = "Ar", iupacName = "unknown", structureFormula = "unknown", casRegistryNumber = "7440-37-1", meltingPoint = 83.80, normalBoilingPoint = 87.27, criticalTemperature = 150.86, criticalPressure = 48.98e5, criticalMolarVolume = 74.57e-6, acentricFactor = -0.002, dipoleMoment = 0.0, molarMass = SingleGasesData.Ar.MM, hasDipoleMoment = true, hasIdealGasHeatCapacity = true, hasCriticalData = true, hasAcentricFactor = true);
        constant Modelica.Media.Interfaces.Types.IdealGas.FluidConstants He(chemicalFormula = "He", iupacName = "unknown", structureFormula = "unknown", casRegistryNumber = "7440-59-7", meltingPoint = 2.15, normalBoilingPoint = 4.30, criticalTemperature = 5.19, criticalPressure = 2.27e5, criticalMolarVolume = 57.30e-6, acentricFactor = -0.390, dipoleMoment = 0.0, molarMass = SingleGasesData.He.MM, hasDipoleMoment = true, hasIdealGasHeatCapacity = true, hasCriticalData = true, hasAcentricFactor = true);
        annotation(
          Documentation(info = "<html>
  <p>
  This package contains FluidConstants data records for the following 37 gases
  (see also the description in
  <a href=\"modelica://Modelica.Media.IdealGases\">Modelica.Media.IdealGases</a>):
  </p>
  <pre>
  Argon             Methane          Methanol       Carbon Monoxide  Carbon Dioxide
  Acetylene         Ethylene         Ethanol        Ethane           Propylene
  Propane           1-Propanol       1-Butene       N-Butane         1-Pentene
  N-Pentane         Benzene          1-Hexene       N-Hexane         1-Heptane
  N-Heptane         Ethylbenzene     N-Octane       Chlorine         Fluorine
  Hydrogen          Steam            Helium         Ammonia          Nitric Oxide
  Nitrogen Dioxide  Nitrogen         Nitrous        Oxide            Neon Oxygen
  Sulfur Dioxide    Sulfur Trioxide
  </pre>
  
  </html>"));
      end FluidData;

      package SingleGasesData "Ideal gas data based on the NASA Glenn coefficients"
        extends Modelica.Icons.Package;
        import Modelica.Media.IdealGases;
        constant IdealGases.Common.DataRecord Air(name = "Air", MM = 0.0289651159, Hf = -4333.833858403446, H0 = 298609.6803431054, Tlimit = 1000, alow = {10099.5016, -196.827561, 5.00915511, -0.00576101373, 1.06685993e-005, -7.94029797e-009, 2.18523191e-012}, blow = {-176.796731, -3.921504225}, ahigh = {241521.443, -1257.8746, 5.14455867, -0.000213854179, 7.06522784e-008, -1.07148349e-011, 6.57780015e-016}, bhigh = {6462.26319, -8.147411905}, R = 287.0512249529787);
        constant IdealGases.Common.DataRecord N2(name = "N2", MM = 0.0280134, Hf = 0, H0 = 309498.4543111511, Tlimit = 1000, alow = {22103.71497, -381.846182, 6.08273836, -0.00853091441, 1.384646189e-005, -9.62579362e-009, 2.519705809e-012}, blow = {710.846086, -10.76003744}, ahigh = {587712.406, -2239.249073, 6.06694922, -0.00061396855, 1.491806679e-007, -1.923105485e-011, 1.061954386e-015}, bhigh = {12832.10415, -15.86640027}, R = 296.8033869505308);
        annotation(
          Documentation(info = "<html>
  <p>This package contains ideal gas models for the 1241 ideal gases from</p>
  <blockquote>
    <p>McBride B.J., Zehe M.J., and Gordon S. (2002): <b>NASA Glenn Coefficients
    for Calculating Thermodynamic Properties of Individual Species</b>. NASA
    report TP-2002-211556</p>
  </blockquote>
  
  <pre>
   
  </pre>
  </html>"));
      end SingleGasesData;

      package SimpleAir "Air: Simple dry air model (0..100 degC)"
        //import Modelica.Media.Interfaces;
        import Modelica.Constants;
        import Cv = Modelica.SIunits.Conversions;
        extends Modelica.Icons.MaterialProperty;
        extends Modelica.Media.Interfaces.PartialSimpleIdealGasMedium(mediumName = "SimpleAir", cp_const = 1005.45, MM_const = 0.0289651159, R_gas = Constants.R / 0.0289651159, eta_const = 1.82e-5, lambda_const = 0.026, T_min = Cv.from_degC(0), T_max = Cv.from_degC(100), fluidConstants = airConstants, Temperature(min = Modelica.SIunits.Conversions.from_degC(0), max = Modelica.SIunits.Conversions.from_degC(100)));
        constant Modelica.Media.Interfaces.Types.Basic.FluidConstants[nS] airConstants = {Modelica.Media.Interfaces.Types.Basic.FluidConstants(iupacName = "simple air", casRegistryNumber = "not a real substance", chemicalFormula = "N2, O2", structureFormula = "N2, O2", molarMass = IdealGases_Light.SingleGasesData.N2.MM)} "Constant data for the fluid";
        annotation(
          Documentation(info = "<html>
                              <h4>Simple Ideal gas air model for low temperatures</h4>
                              <p>This model demonstrates how to use the PartialSimpleIdealGas base class to build a
                              simple ideal gas model with a limited temperature validity range.</p>
                              </html>"));
      end SimpleAir;
    end IdealGases_Light;
  end Media;
  annotation(
    uses(Modelica(version = "3.2.2")));
end CoffeeTemperature;
