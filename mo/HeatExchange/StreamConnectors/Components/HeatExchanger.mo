within StreamConnectors.Components;

model HeatExchanger
  //parameter
  parameter DieselEngineLibrary.SIunits.MMLength Dy(min = 0) = 25 "Cell ⊿y ・・高さピッチ";
  parameter DieselEngineLibrary.SIunits.MMLength Dz(min = 0) = 2 "Cell ⊿z ・・厚みピッチ";  
  parameter DieselEngineLibrary.SIunits.MMLength Lrw(min = 0) = 700 "ラジエータ幅" annotation(Dialog(group = "搭載ラジエータ"));
  parameter DieselEngineLibrary.SIunits.MMLength Lrh(min = 0) = 700 "ラジエータ高さ" annotation(Dialog(group = "搭載ラジエータ"));
  parameter DieselEngineLibrary.SIunits.MMLength Lrd(min = 0) = 46 "ラジエータ厚さ" annotation(Dialog(group = "搭載ラジエータ"));
  parameter DieselEngineLibrary.SIunits.MMLength Lrws(min = 0) = 525 "ラジエータ厚さ" annotation(Dialog(group = "基準ラジエータ"));

//port
  StreamConnectors.Interfaces.FluidPort wind_in annotation(
    Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  StreamConnectors.Interfaces.FluidPort water_in annotation(
    Placement(visible = true, transformation(origin = {0, 98}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  StreamConnectors.Interfaces.FluidPort water_out annotation(
    Placement(visible = true, transformation(origin = {0, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -102}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  StreamConnectors.Interfaces.FluidPort wind_out annotation(
    Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {102, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  StreamConnectors.Components.Cell1 cell[Nj, Nk](each Lrw=Lrw,each Lrws=Lrws) annotation(
    Placement(visible = true, transformation(origin = {1.83479, 0.582059}, extent = {{-10.7634, -9.41794}, {8.07252, 9.41794}}, rotation = 0)));



protected

//  parameter Integer Nj(min = 2) = integer(Lrh/Dy) "Cell 分割数　高さ(j)方向の数 (搭載ラジエータ用)";
//    parameter Integer Nk(min = 2) = integer(Lrd/Dz) "Cell 分割数　厚み(k)方向の数 (搭載ラジエータ用)";
  //debug mode
  parameter Integer Nj(min = 2) = 28 "Cell 分割数　高さ(j)方向の数 (搭載ラジエータ用)";
  parameter Integer Nk(min = 2) = 23 "Cell 分割数　厚み(k)方向の数 (搭載ラジエータ用)";
equation


//wind_in,wind_outポートと端側のCellの接続
  for n in 1:Nj loop
    connect(wind_in, cell[n, 1].wind_in);
    connect(wind_out, cell[n, Nk].wind_out);
  end for;
  
//water_in,water_outポートと上下側のCellの接続
  for m in 1:Nk loop
    connect(water_in, cell[1, m].water_in);
    connect(water_out, cell[Nj, m].water_out);
  end for;
  
//Cell同士の接続
  for p in 1:Nj - 1 loop
    for q in 1:Nk loop
      connect(cell[p, q].water_out, cell[p + 1, q].water_in);
    end for;
  end for;

  for r in 1:Nk - 1 loop
    for s in 1:Nj loop
      connect(cell[s, r].wind_out, cell[s, r + 1].wind_in);
    end for;
  end for;
  
  
annotation(Icon(graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}), Polygon(origin = {-14, -17}, fillColor = {173, 173, 173}, fillPattern = FillPattern.Solid, points = {{-60, 79}, {-60, -57}, {60, -79}, {60, 57}, {-60, 79}}), Polygon(origin = {59, -17}, fillColor = {200, 200, 200}, fillPattern = FillPattern.Solid, points = {{-13, 57}, {13, 79}, {13, -61}, {-13, -79}, {-13, -13}, {-13, 57}}), Polygon(origin = {-1, 62}, fillColor = {218, 218, 218}, fillPattern = FillPattern.Solid, points = {{-73, 0}, {-47, 22}, {73, 0}, {47, -22}, {-73, 0}}), Line(origin = {-14, 31}, points = {{-60, 11}, {60, -11}}), Line(origin = {-14, 31}, points = {{-60, 11}, {60, -11}}), Line(origin = {-14.15, 8.275}, points = {{-60, 11}, {60, -11}}), Line(origin = {-14.15, -14.475}, points = {{-60, 11}, {60, -11}}), Line(origin = {-14.15, -14.475}, points = {{-60, 11}, {60, -11}}), Line(origin = {-14.3, -37.2}, points = {{-60, 11}, {60, -11}}), Line(origin = {-14.275, -61.5}, points = {{-60, 11}, {60, -11}}), Line(origin = {59, 31}, points = {{-13, -11}, {13, 11}}), Line(origin = {59.025, 8.625}, points = {{-13, -11}, {13, 11}}), Line(origin = {58.85, -14.475}, points = {{-13, -11}, {13, 11}}), Line(origin = {58.875, -36.85}, points = {{-13, -11}, {13, 11}}), Line(origin = {59.075, -61.5}, points = {{-13, -11}, {13, 11}}), Line(origin = {6.825, 69}, points = {{-58.825, 11}, {61.175, -11}}), Line(origin = {-0.85, 63.425}, points = {{-58.825, 11}, {61.175, -11}}), Line(origin = {-8, 57.35}, points = {{-58.825, 11}, {61.175, -11}}), Line(origin = {54, -21.775}, points = {{0, 69}, {0, -69}}), Line(origin = {60.675, -17.375}, points = {{0, 69}, {0, -69}}), Line(origin = {67.7, -11.75}, points = {{0, 69}, {0, -69}}), Line(origin = {-72.5086, 83.4913}, points = {{-13, -12}, {-1, -2}}, arrow = {Arrow.None, Arrow.Filled}), Text(origin = {-80, 87}, extent = {{-6, 5}, {6, -5}}, textString = "k"), Line(origin = {-85.5909, 57.5}, points = {{0, 14}, {0, 0}}, arrow = {Arrow.None, Arrow.Filled}), Text(origin = {-90, 67}, extent = {{-6, 5}, {6, -5}}, textString = "j"), Line(origin = {-79.5357, 69.2262}, points = {{-6, 2}, {6, -2}}, arrow = {Arrow.None, Arrow.Filled}), Text(origin = {-72, 71}, extent = {{-6, 5}, {6, -5}}, textString = "i")}, coordinateSystem(initialScale = 0.1)),
    preferredView = "text");
end HeatExchanger;
