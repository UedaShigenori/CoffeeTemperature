within StreamConnectors.Components;

model Cell1

//table data
  parameter String tableName = "Tab1" "Table name on file or in function usertab (see docu)" annotation(
    Dialog(group = "Table data definition"));
  parameter String fileName = "C:\\Work\\2020\\DieselEngineLibrary\\csv\\data_K.txt" "File where matrix is stored" annotation(
    Dialog(group = "Table data definition", loadSelector(filter = "Text files (*.txt);;csv-files (*.csv)", caption = "Open file in which table is present")));

  parameter Modelica.Thermal.FluidHeatFlow.Media.Medium waterMedium = StreamConnectors.Media.LLC() "Cooling water" annotation(
    choicesAllMatching = true);
  parameter Modelica.Thermal.FluidHeatFlow.Media.Medium windMedium = StreamConnectors.Media.Air_75degC() "Cooling wind" annotation(
    choicesAllMatching = true);
  parameter DieselEngineLibrary.SIunits.MMLength Lrws "基準ラジエーター幅   : Lrws  (サンプルデータ)";
  parameter DieselEngineLibrary.SIunits.MMLength Lrw "ラジエータ幅";

//output
  output Modelica.SIunits.ThermodynamicTemperature Twind_out;
  output Modelica.SIunits.ThermodynamicTemperature Twater_out;

//instance
  StreamConnectors.Components.HeatedPipeOneDirection pipe_water(medium = waterMedium)  annotation(
    Placement(visible = true, transformation(origin = {0, 34}, extent = {{-10, 10}, {10, -10}}, rotation = -90)));
  StreamConnectors.Sensors.VFlow vFlow1(medium = waterMedium)  annotation(
    Placement(visible = true, transformation(origin = {0, 74}, extent = {{-10, 10}, {10, -10}}, rotation = -90)));
  StreamConnectors.Sensors.VFlow vFlow(medium = windMedium)  annotation(
    Placement(visible = true, transformation(origin = {-156, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Thermal.HeatTransfer.Components.Convection convection annotation(
    Placement(visible = true, transformation(origin = {-32, 34}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  StreamConnectors.Components.HeatedPipeOneDirection pipe_wind(medium = windMedium)  annotation(
    Placement(visible = true, transformation(origin = {-60, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  StreamConnectors.Interfaces.FluidPort wind_in annotation(
    Placement(visible = true, transformation(origin = {-200, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  StreamConnectors.Interfaces.FluidPort wind_out annotation(
    Placement(visible = true, transformation(origin = {150, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  StreamConnectors.Interfaces.FluidPort water_in annotation(
    Placement(visible = true, transformation(origin = {0, 98}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  StreamConnectors.Interfaces.FluidPort water_out annotation(
    Placement(visible = true, transformation(origin = {0, -102}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -98}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Math.Gain gain(k = Lrw / Lrws * 1000) annotation(
    Placement(visible = true, transformation(origin = {-64, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Tables.CombiTable2D combiTable2D(fileName = fileName, tableName = tableName, tableOnFile = true) annotation(
    Placement(visible = true, transformation(origin = {-112, 52}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(vFlow.port_b, pipe_wind.port_a) annotation(
    Line(points = {{-146, 0}, {-71, 0}}));
  connect(vFlow1.port_b, pipe_water.port_a) annotation(
    Line(points = {{0, 64}, {0, 45}}));
  connect(vFlow1.port_a, water_in) annotation(
    Line(points = {{0, 84}, {0, 98}}));
  connect(pipe_water.port_b, water_out) annotation(
    Line(points = {{0, 23}, {0, -102}}));
  connect(vFlow.port_a, wind_in) annotation(
    Line(points = {{-166, 0}, {-200, 0}}));
  connect(combiTable2D.y, gain.u) annotation(
    Line(points = {{-101, 52}, {-76, 52}}, color = {0, 0, 127}));
  connect(pipe_wind.port_b, wind_out) annotation(
    Line(points = {{-49, 0}, {-6, 0}, {-6, 6}, {6, 6}, {6, 0}, {150, 0}}));
  connect(convection.solid, pipe_wind.heatPort) annotation(
    Line(points = {{-42, 34}, {-60, 34}, {-60, 6}}, color = {191, 0, 0}));
  connect(gain.y, convection.Gc) annotation(
    Line(points = {{-52, 52}, {-32, 52}, {-32, 44}}, color = {0, 0, 127}));
  connect(pipe_water.heatPort, convection.fluid) annotation(
    Line(points = {{-6, 34}, {-22, 34}}, color = {191, 0, 0}));
//  Twind_out=wind_in.h_outflow/windMedium.cp;
//  Twater_out=water_in.h_outflow/waterMedium.cp;
  Twind_out = pipe_wind.port_b.h_outflow / windMedium.cp;
  Twater_out=pipe_water.port_b.h_outflow/waterMedium.cp;
  connect(vFlow.m, combiTable2D.u1) annotation(
    Line(points = {{-156, 10}, {-156, 10}, {-156, 58}, {-124, 58}, {-124, 58}}, color = {0, 0, 127}));
  connect(vFlow1.m, combiTable2D.u2) annotation(
    Line(points = {{-8, 74}, {-18, 74}, {-18, 90}, {-148, 90}, {-148, 46}, {-124, 46}, {-124, 46}}, color = {0, 0, 127}));

annotation(
    Diagram(coordinateSystem(extent = {{-200, -100}, {150, 100}}, initialScale = 0.1), graphics = {Text(origin = {-57, 73}, extent = {{-23, 11}, {33, -9}}, textString = "幅を変更する場合のKの見直しと"), Text(origin = {-113, 73}, extent = {{-23, 11}, {23, -11}}, textString = "基準サンプルの熱通過率"), Text(origin = {-57, 63}, extent = {{-23, 11}, {19, -1}}, textString = "kW->Wへの単位変換"), Text(origin = {-121, 55}, extent = {{-23, 11}, {-7, 1}}, textString = "冷却風量"), Text(origin = {-121, 43}, extent = {{-25, 13}, {-7, 1}}, textString = "冷却水流量"), Text(origin = {-185, -21}, extent = {{-23, 11}, {-7, 1}}, textString = "冷却風"), Text(origin = {15, 105}, extent = {{-25, 13}, {-7, 1}}, textString = "冷却水"), Line(origin = {-199, -20}, points = {{-7, 0}, {7, 0}}, arrow = {Arrow.None, Arrow.Filled}), Line(origin = {19.7635, 104.15}, points = {{-7, 0}, {-7, -14}}, arrow = {Arrow.None, Arrow.Filled})}),
    Icon(coordinateSystem(extent = {{-110, -100}, {100, 100}})));
end Cell1;
