model ValveTest
  replaceable package Medium = Modelica.Media.Water.StandardWater;

  Modelica.Fluid.Pipes.StaticPipe pipe1(redeclare package Medium = Medium, diameter = 0.01, length = 0.01) annotation(
    Placement(visible = true, transformation(origin = {-26, -32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    
    Modelica.Blocks.Sources.Step step1(height = 1, startTime = 1)  annotation(
    Placement(visible = true, transformation(origin = {22, 4}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  Modelica.Fluid.Valves.ValveIncompressible valveIncompressible1(redeclare package Medium = Medium, dp_nominal = 10000, m_flow_nominal = 0.01) annotation(
    Placement(visible = true, transformation(origin = {22, -32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.FixedBoundary boundary1(redeclare package Medium = Medium, nPorts = 1)  annotation(
    Placement(visible = true, transformation(origin = {72, -32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  inner Modelica.Fluid.System system annotation(
    Placement(visible = true, transformation(origin = {80, 34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Fluid.Sources.FixedBoundary boundaryredeclare(redeclare package Medium = Medium, nPorts = 1, p = 2.01325 * 10 ^ 5) annotation(
    Placement(visible = true, transformation(origin = {-62, -32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(step1.y, valveIncompressible1.opening) annotation(
    Line(points = {{33, 4}, {27, 4}, {27, 4}, {23, 4}, {23, -24}, {21, -24}, {21, -24}, {21, -24}}, color = {0, 0, 127}));
  connect(pipe1.port_b, valveIncompressible1.port_a) annotation(
    Line(points = {{-16, -32}, {12, -32}}, color = {0, 127, 255}));
  connect(valveIncompressible1.port_b, boundary1.ports[1]) annotation(
    Line(points = {{32, -32}, {82, -32}}, color = {0, 127, 255}));
  connect(boundaryredeclare.ports[1], pipe1.port_a) annotation(
    Line(points = {{-52, -32}, {-36, -32}, {-36, -32}, {-36, -32}}, color = {0, 127, 255}, thickness = 0.5));
  annotation(
    uses(Modelica(version = "3.2.2")));end ValveTest;
