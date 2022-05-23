package DieselEngineLibrary
  package Components
    package Radiator
      model HeatExchanger
        //parameter
        parameter Integer Nj(min = 1) = 21 "高さ方向の分割数";
        parameter Integer Nk(min = 1) = 18 "奥行方向の分割数";
        parameter Real Lrw(min = 0) = 525 "幅";
        parameter Real Lrh(min = 0) = 525 "高さ";
        parameter Real Lrd(min = 0) = 36 "奥行";
        //port
        Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a wind_in annotation(
          Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a water_in annotation(
          Placement(visible = true, transformation(origin = {0, 98}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b water_out annotation(
          Placement(visible = true, transformation(origin = {0, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -102}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b wind_out annotation(
          Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {102, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        DieselEngineLibrary.Components.Radiator.HeatExchangerCell1 cell[Nj, Nk] annotation(
          Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        //  each V_flow_water = 1e-3/Nk,
        //  each V_flow_wind = 0.55/Nj,
      equation
        for n in 1:Nj loop
          connect(wind_in, cell[n, 1].Ta1);
          connect(wind_out, cell[n, Nk].Ta2);
        end for;
        for m in 1:Nk loop
          connect(water_in, cell[1, m].Tw1);
          connect(water_out, cell[Nj, m].Tw2);
        end for;
        for p in 1:Nj - 1 loop
          for q in 1:Nk - 1 loop
            connect(cell[p, q].Ta2, cell[p, q + 1].Ta1);
            connect(cell[p, q].Tw2, cell[p + 1, q].Ta1);
          end for;
        end for;
        
        annotation(
          Icon(graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}), Polygon(origin = {-14, -17}, fillColor = {173, 173, 173}, fillPattern = FillPattern.Solid, points = {{-60, 79}, {-60, -57}, {60, -79}, {60, 57}, {-60, 79}}), Polygon(origin = {59, -17}, fillColor = {200, 200, 200}, fillPattern = FillPattern.Solid, points = {{-13, 57}, {13, 79}, {13, -61}, {-13, -79}, {-13, -13}, {-13, 57}}), Polygon(origin = {-1, 62}, fillColor = {218, 218, 218}, fillPattern = FillPattern.Solid, points = {{-73, 0}, {-47, 22}, {73, 0}, {47, -22}, {-73, 0}}), Line(origin = {-14, 31}, points = {{-60, 11}, {60, -11}}), Line(origin = {-14, 31}, points = {{-60, 11}, {60, -11}}), Line(origin = {-14.15, 8.275}, points = {{-60, 11}, {60, -11}}), Line(origin = {-14.15, -14.475}, points = {{-60, 11}, {60, -11}}), Line(origin = {-14.15, -14.475}, points = {{-60, 11}, {60, -11}}), Line(origin = {-14.3, -37.2}, points = {{-60, 11}, {60, -11}}), Line(origin = {-14.275, -61.5}, points = {{-60, 11}, {60, -11}}), Line(origin = {59, 31}, points = {{-13, -11}, {13, 11}}), Line(origin = {59.025, 8.625}, points = {{-13, -11}, {13, 11}}), Line(origin = {58.85, -14.475}, points = {{-13, -11}, {13, 11}}), Line(origin = {58.875, -36.85}, points = {{-13, -11}, {13, 11}}), Line(origin = {59.075, -61.5}, points = {{-13, -11}, {13, 11}}), Line(origin = {6.825, 69}, points = {{-58.825, 11}, {61.175, -11}}), Line(origin = {-0.85, 63.425}, points = {{-58.825, 11}, {61.175, -11}}), Line(origin = {-8, 57.35}, points = {{-58.825, 11}, {61.175, -11}}), Line(origin = {54, -21.775}, points = {{0, 69}, {0, -69}}), Line(origin = {60.675, -17.375}, points = {{0, 69}, {0, -69}}), Line(origin = {67.7, -11.75}, points = {{0, 69}, {0, -69}})}, coordinateSystem(initialScale = 0.1)));
      end HeatExchanger;

      model HeatExchangerCell1
        import SI = Modelica.SIunits;
        parameter Modelica.Thermal.FluidHeatFlow.Media.Medium waterMedium = DieselEngineLibrary.Media.LLC() "Cooling water" annotation(
          choicesAllMatching = true);
        parameter Modelica.Thermal.FluidHeatFlow.Media.Medium windMedium = DieselEngineLibrary.Media.Air_75degC() "Cooling wind" annotation(
          choicesAllMatching = true);
        parameter Modelica.SIunits.Length Lrws = 0.525 "wide of sample radiator";
        parameter Modelica.SIunits.Length Lrw = 0.525 "wide of radiator";
        //water
        parameter Modelica.SIunits.VolumeFlowRate V_flow_water = 0 annotation(
          Dialog(group = "initialization"));
        parameter Boolean fixed_V_flow_water = true annotation(
          Dialog(group = "initialization"));
        //  parameter SI.Temperature T_water = 373 annotation(
        //    Dialog(group = "initialization"));
        parameter Modelica.SIunits.Temperature T_water = 373 annotation(
          Dialog(group = "initialization"));
        parameter Boolean fixed_T_water = false annotation(
          Dialog(group = "initialization"));
        parameter Modelica.SIunits.Mass m_water = 0;
        //wind
        parameter Modelica.SIunits.VolumeFlowRate V_flow_wind = 0 annotation(
          Dialog(group = "initialization"));
        parameter Boolean fixed_V_flow_wind = true annotation(
          Dialog(group = "initialization"));
        parameter Modelica.SIunits.Temperature T_wind = 313 annotation(
          Dialog(group = "initialization"));
        parameter Boolean fixed_T_wind = false annotation(
          Dialog(group = "initialization"));
        parameter Modelica.SIunits.Mass m_wind = 0;
        //table data
        parameter String tableName = "Tab1" "Table name on file or in function usertab (see docu)" annotation(
          Dialog(group = "Table data definition"));
        parameter String fileName = "C:\\Work\\2020\\DieselEngineLibrary\\csv\\data_K.txt" "File where matrix is stored" annotation(
          Dialog(group = "Table data definition", loadSelector(filter = "Text files (*.txt);;csv-files (*.csv)", caption = "Open file in which table is present")));
        parameter Modelica.SIunits.Temperature T0_water;
        parameter Modelica.SIunits.Temperature T0_wind;
        //port
        Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a Ta1(medium = windMedium) annotation(
          Placement(visible = true, transformation(origin = {-142, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b Tw2(medium = waterMedium) annotation(
          Placement(visible = true, transformation(origin = {0, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -100}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b Ta2(medium = windMedium) annotation(
          Placement(visible = true, transformation(origin = {140, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        //pipe
        //DieselEngineLibrary.Components.Commons.HeatedPipe
        Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a Tw1(medium = waterMedium) annotation(
          Placement(visible = true, transformation(origin = {0, 98}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        Modelica.Blocks.Tables.CombiTable2D combiTable2D(fileName = fileName, tableName = tableName, tableOnFile = true) annotation(
          Placement(visible = true, transformation(origin = {-102, 54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Blocks.Math.Gain gain(k = Lrw / Lrws * 1000) annotation(
          Placement(visible = true, transformation(origin = {-72, 54}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Modelica.Thermal.HeatTransfer.Components.Convection convection annotation(
          Placement(visible = true, transformation(origin = {-36, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        DieselEngineLibrary.Sensors.FlowSensor flowSensor(medium = windMedium) annotation(
          Placement(visible = true, transformation(origin = {-122, 0}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
        DieselEngineLibrary.Components.Radiator.HeatedPipeFixedVolumeFlow pipeAir(T0 = T0_wind, medium = windMedium) annotation(
          Placement(visible = true, transformation(origin = {-60, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        DieselEngineLibrary.Sensors.FlowSensor flowSensor1(medium = waterMedium) annotation(
          Placement(visible = true, transformation(origin = {0, 76}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        DieselEngineLibrary.Components.Radiator.HeatedPipeFixedVolumeFlow pipeWater(T0 = T0_water, medium = waterMedium) annotation(
          Placement(visible = true, transformation(origin = {0, 30}, extent = {{-10, 10}, {10, -10}}, rotation = -90)));
      equation
        connect(combiTable2D.y, gain.u) annotation(
          Line(points = {{-91, 54}, {-84, 54}}, color = {0, 0, 127}));
        connect(gain.y, convection.Gc) annotation(
          Line(points = {{-60, 54}, {-36, 54}, {-36, 40}, {-36, 40}}, color = {0, 0, 127}));
        connect(Ta1, flowSensor.flowPort_a) annotation(
          Line(points = {{-142, 0}, {-132, 0}}, color = {255, 0, 0}));
        connect(flowSensor.flowPort_b, pipeAir.flowPort_a) annotation(
          Line(points = {{-112, 0}, {-70, 0}}, color = {255, 0, 0}));
        connect(pipeAir.port_a, convection.solid) annotation(
          Line(points = {{-60, 10}, {-60, 30}, {-46, 30}}, color = {191, 0, 0}));
        connect(Tw1, flowSensor1.flowPort_a) annotation(
          Line(points = {{0, 98}, {0, 98}, {0, 86}, {0, 86}}, color = {255, 0, 0}));
        connect(flowSensor1.flowPort_b, pipeWater.flowPort_a) annotation(
          Line(points = {{0, 66}, {0, 40}}, color = {255, 0, 0}));
        connect(pipeWater.port_a, convection.fluid) annotation(
          Line(points = {{-10, 30}, {-26, 30}, {-26, 30}, {-26, 30}}, color = {191, 0, 0}));
        connect(pipeWater.flowPort_b, Tw2) annotation(
          Line(points = {{0, 20}, {0, 20}, {0, -100}, {0, -100}}, color = {255, 0, 0}));
        connect(pipeAir.flowPort_b, Ta2) annotation(
          Line(points = {{-50, 0}, {-4, 0}, {-4, 6}, {4, 6}, {4, 0}, {140, 0}}, color = {255, 0, 0}));
  connect(flowSensor.y, combiTable2D.u1) annotation(
          Line(points = {{-122, 12}, {-122, 12}, {-122, 60}, {-114, 60}, {-114, 60}}, color = {0, 0, 127}));
  connect(flowSensor1.y, combiTable2D.u2) annotation(
          Line(points = {{-10, 76}, {-130, 76}, {-130, 48}, {-114, 48}, {-114, 48}}, color = {0, 0, 127}));
        annotation(
          Icon(graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}), Polygon(origin = {-8, -19}, fillColor = {188, 188, 188}, fillPattern = FillPattern.Solid, points = {{-60, 79}, {-60, -41}, {60, -61}, {60, 59}, {-60, 79}}), Polygon(origin = {65, -19}, fillColor = {203, 203, 203}, fillPattern = FillPattern.Solid, points = {{-13, 59}, {7, 79}, {7, -41}, {-13, -61}, {-13, -13}, {-13, 59}}), Polygon(origin = {5, 60}, fillColor = {229, 229, 229}, fillPattern = FillPattern.Solid, points = {{-73, 0}, {-53, 20}, {67, 0}, {47, -20}, {-73, 0}}), Text(origin = {31, 93}, extent = {{-77, 13}, {11, -27}}, textString = "cooling water"), Text(origin = {-37, -11}, extent = {{-77, 13}, {11, -27}}, textString = "cooling wind")}, coordinateSystem(initialScale = 0.1)),
          Diagram(coordinateSystem(extent = {{-140, -100}, {140, 100}})));
      end HeatExchangerCell1;

      model FixedVolumeFlow1 "Partial model of two port"
        parameter Modelica.Thermal.FluidHeatFlow.Media.Medium medium = Modelica.Thermal.FluidHeatFlow.Media.Medium() "Medium in the component" annotation(
          choicesAllMatching = true);
        parameter Modelica.SIunits.VolumeFlowRate V_flow "Volume flow";
        parameter Modelica.SIunits.Temperature T_a "Temperature at flowPort_a";
        Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a flowPort_a(final medium = medium) annotation(
          Placement(transformation(extent = {{90, -10}, {110, 10}})));
      algorithm
        flowPort_a.m_flow := -V_flow * medium.rho;
        flowPort_a.h := T_a * medium.cp;
        flowPort_a.H_flow := flowPort_a.h * flowPort_a.m_flow;
//  y := V_flow;
        annotation(
          Documentation(info = "<html>
      <p>Fan resp. pump with constant volume flow rate. Pressure increase is the response of the whole system.</p>
      <p>Coolant's temperature and enthalpy flow are not affected.</p>
      <p>
      Setting parameter m (mass of medium within fan/pump) to zero
      leads to neglect of temperature transient cv*m*der(T).
      </p>
      <p>Thermodynamic equations are defined by Partials.TwoPort.</p>
      </html>"),
          Icon(coordinateSystem(initialScale = 0.1), graphics = {Ellipse(lineColor = {255, 0, 0}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, extent = {{-90, 90}, {90, -90}}, endAngle = 360), Polygon(lineColor = {255, 0, 0}, fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid, points = {{-60, 68}, {90, 10}, {90, -10}, {-60, -68}, {-60, 68}}), Text(extent = {{-40, 30}, {20, -30}}, textString = "V"), Text(lineColor = {0, 0, 255}, extent = {{-150, -140}, {150, -100}}, textString = "%name")}));
      end FixedVolumeFlow1;

      model Ambient2 "Partial model of a single port at the left"
        parameter Modelica.Thermal.FluidHeatFlow.Media.Medium medium = Modelica.Thermal.FluidHeatFlow.Media.Medium() "Medium" annotation(
          choicesAllMatching = true);
        Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a flowPort(final medium = medium) annotation(
          Placement(transformation(extent = {{-110, -10}, {-90, 10}})));
        parameter Modelica.SIunits.Pressure p = 0;
        //  Modelica.SIunits.SpecificEnthalpy h "Specific enthalpy in the volume";
      equation
        flowPort.p = p;
//  T_port = flowPort.h / medium.cp;
//  T = h / medium.cp;
//  h = flowPort.h;
        annotation(
          Documentation(info = "<html>
      <p>(Infinite) ambient with constant pressure and temperature.</p>
      <p>Thermodynamic equations are defined by Partials.Ambient.</p>
      </html>"),
          Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Ellipse(extent = {{-90, 90}, {90, -90}}, lineColor = {255, 0, 0}, fillColor = {0, 0, 255}, fillPattern = FillPattern.Solid), Text(extent = {{20, 80}, {80, 20}}, textString = "p"), Text(extent = {{20, -20}, {80, -80}}, textString = "T")}));
      end Ambient2;

      model HeatedPipeFixedVolumeFlow "Partial model of two port"
        parameter Modelica.Thermal.FluidHeatFlow.Media.Medium medium = Modelica.Thermal.FluidHeatFlow.Media.Medium() "Medium in the component" annotation(
          choicesAllMatching = true);
        parameter Real loss = 0.1;
        parameter Modelica.SIunits.Temperature T0;
        Modelica.SIunits.Pressure dp "Pressure drop a->b";
        Modelica.SIunits.HeatFlowRate Q_flow "Heat exchange with ambient";
        //  output Modelica.SIunits.Temperature T(start = T0, fixed = T0fixed) "Outlet temperature of medium";
        Modelica.SIunits.Temperature T_a(start = T0) "Temperature at flowPort_a";
        Modelica.SIunits.Temperature T_b(start = T0) "Temperature at flowPort_b";
        Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a flowPort_a(final medium = medium) annotation(
          Placement(transformation(extent = {{-110, -10}, {-90, 10}})));
        Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b flowPort_b(final medium = medium) annotation(
          Placement(transformation(extent = {{90, -10}, {110, 10}})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a annotation(
          Placement(visible = true, transformation(origin = {-2, 98}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-2, 98}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        //initial algorithm
        //  Q_flow := port_a.Q_flow;
        //  flowPort_b.m_flow := -flowPort_a.m_flow;
        //  T_a := flowPort_a.h / medium.cp;
        //  flowPort_b.H_flow := -(flowPort_a.H_flow + Q_flow);
        //  flowPort_b.h := flowPort_b.H_flow / flowPort_b.m_flow;
        //  T_b := flowPort_b.h / medium.cp;
        //  port_a.T := (T_b - T_a) / 2 + T_a;
      algorithm
        Q_flow := port_a.Q_flow;
        flowPort_b.m_flow := -flowPort_a.m_flow;
        T_a := flowPort_a.h / medium.cp;
        flowPort_b.H_flow := -(flowPort_a.H_flow + Q_flow);
        flowPort_b.h := flowPort_b.H_flow / flowPort_b.m_flow;
        T_b := flowPort_b.h / medium.cp;
        port_a.T := T_a;
      equation
        dp = flowPort_a.p - flowPort_b.p;
        flowPort_b.m_flow = loss * dp;
        annotation(
          Icon(coordinateSystem(initialScale = 0.1), graphics = {Rectangle(origin = {0, 1}, fillColor = {0, 170, 255}, fillPattern = FillPattern.HorizontalCylinder, extent = {{-90, 39}, {90, -41}}), Line(origin = {-2, -72}, points = {{-82, 0}, {82, 0}}, color = {0, 85, 255}, thickness = 1, arrow = {Arrow.None, Arrow.Filled}, arrowSize = 10)}));
      end HeatedPipeFixedVolumeFlow;
    end Radiator;

    package Commons
      model HeatedPipe "Pipe with heat exchange"
        extends Modelica.Thermal.FluidHeatFlow.Components.Pipe(final useHeatPort = true);
        extends Modelica.Icons.ObsoleteModel;
        Modelica.Blocks.Interfaces.RealOutput y annotation(
          Placement(visible = true, transformation(origin = {-54, 64}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 108}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
      equation
        y = V_flow;
        annotation(
          obsolete = "Obsolete model - use Modelica.Thermal.FluidHeatFlow.Components.Pipe(useHeatPort=true) instead",
          Documentation(info = "<html>
    <p>
    This model simply extends from the <a href=\"modelica://Modelica.Thermal.FluidHeatFlow.Components.Pipe\">Pipe</a> model
    with parameter useHeatPort = true and is kept for compatibility reasons. In the future, it will be removed.
    </p>
    </html>"),
          Icon(graphics = {Text(origin = {-22, 92}, extent = {{-26, 6}, {74, -16}}, textString = "V_flow")}));
      end HeatedPipe;
    end Commons;
  end Components;

  package Media "Medium properties"
    extends Modelica.Icons.MaterialPropertiesPackage;

    record Air_40degC "Medium: properties of air at 40 degC and 1 bar"
      extends Modelica.Thermal.FluidHeatFlow.Media.Medium(rho = 1.091, cp = 1010, cv = 720, lamda = 0.0264, nue = 16.3E-6);
      annotation(
        defaultComponentPrefixes = "parameter",
        Documentation(info = "<html>
  Medium: properties of air at 40&deg;C and 1 bar
  </html>"));
    end Air_40degC;

    record Air_75degC "Medium: properties of air at 75 degC and 1 bar"
      extends Modelica.Thermal.FluidHeatFlow.Media.Medium(rho = 0.983, cp = 1007, cv = 720, lamda = 0.0264, nue = 16.3E-6);
      annotation(
        defaultComponentPrefixes = "parameter",
        Documentation(info = "<html>
    Medium: properties of air at 75&deg;C and 1 bar
    </html>"));
    end Air_75degC;

    record LLC "Medium: properties of LLC"
      extends Modelica.Thermal.FluidHeatFlow.Media.Medium(rho = 1035, cp = 3320, cv = 720, lamda = 0.0264, nue = 16.3E-6);
      annotation(
        defaultComponentPrefixes = "parameter",
        Documentation(info = "<html>
    Medium: properties of LLC
    </html>"));
    end LLC;
  end Media;

  package Examples
    package RadiatorTest
      model PipeTest1
        parameter Modelica.SIunits.Temperature TAmb(displayUnit = "degC") = 373.15 "Ambient temperature";
        output Modelica.SIunits.TemperatureDifference dTSource = prescribedHeatFlow.port.T - TAmb "Source over Ambient";
        output Modelica.SIunits.TemperatureDifference dTtoPipe = prescribedHeatFlow.port.T - pipe.T_q "Source over Coolant";
        output Modelica.SIunits.TemperatureDifference dTCoolant = pipe.dT "Coolant's temperature increase";
        Modelica.Thermal.FluidHeatFlow.Sources.Ambient ambient1(constantAmbientTemperature = TAmb, medium = llc, constantAmbientPressure = 0) annotation(
          Placement(visible = true, transformation(extent = {{-26, -10}, {-46, 10}}, rotation = 0)));
        Modelica.Thermal.FluidHeatFlow.Sources.VolumeFlow pump(T0 = TAmb, constantVolumeFlow = 1e-3, m = 0, medium = llc, useVolumeFlowInput = false) annotation(
          Placement(visible = true, transformation(extent = {{-6, -10}, {14, 10}}, rotation = 0)));
        Modelica.Thermal.FluidHeatFlow.Components.Pipe pipe(medium = llc, m = 0.1, T0 = TAmb, V_flowLaminar = 0.1, dpLaminar(displayUnit = "Pa") = 0.1, V_flowNominal = 1, dpNominal(displayUnit = "Pa") = 1, h_g = 0, T0fixed = true, useHeatPort = true) annotation(
          Placement(visible = true, transformation(extent = {{34, -10}, {54, 10}}, rotation = 0)));
        Modelica.Thermal.FluidHeatFlow.Sources.Ambient ambient2(constantAmbientTemperature = TAmb, medium = llc, constantAmbientPressure = 0) annotation(
          Placement(visible = true, transformation(extent = {{74, -10}, {94, 10}}, rotation = 0)));
        Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(C = 0.1, T(start = TAmb, fixed = true)) annotation(
          Placement(visible = true, transformation(origin = {74, -50}, extent = {{-10, 10}, {10, -10}}, rotation = 90)));
        Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow annotation(
          Placement(visible = true, transformation(extent = {{4, -40}, {24, -60}}, rotation = 0)));
        Modelica.Blocks.Sources.Constant volumeFlow(k = 1) annotation(
          Placement(visible = true, transformation(extent = {{-26, 10}, {-6, 30}}, rotation = 0)));
        Modelica.Blocks.Sources.Constant heatFlow(k = 1000) annotation(
          Placement(visible = true, transformation(extent = {{-26, -60}, {-6, -40}}, rotation = 0)));
        Modelica.Thermal.HeatTransfer.Components.Convection convection annotation(
          Placement(visible = true, transformation(origin = {44, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
        Modelica.Blocks.Sources.Constant thermalConductance(k = 1) annotation(
          Placement(visible = true, transformation(extent = {{4, -40}, {24, -20}}, rotation = 0)));
        //  Modelica.Thermal.FluidHeatFlow.Sources.VolumeFlow
        //Modelica.Thermal.FluidHeatFlow.Sources.Ambient
        //Modelica.Thermal.FluidHeatFlow.Sources.Ambient
        parameter DieselEngineLibrary.Media.LLC llc(cp = 3320, rho(displayUnit = "kg/m3") = 1035) annotation(
          Placement(visible = true, transformation(origin = {-126, 36}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        //  Modelica.Thermal.FluidHeatFlow.Sources.Ambient
        //  Modelica.Thermal.FluidHeatFlow.Sources.Ambient
        //  Modelica.Thermal.FluidHeatFlow.Sources.VolumeFlow
        DieselEngineLibrary.Components.Radiator.Ambient2 ambient21(medium = llc) annotation(
          Placement(visible = true, transformation(origin = {-90, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        DieselEngineLibrary.Components.Radiator.FixedVolumeFlow1 fixedVolumeFlow11(T_a = 373.15, V_flow = 0.001, medium = llc) annotation(
          Placement(visible = true, transformation(origin = {-166, 8}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        DieselEngineLibrary.Components.Radiator.HeatedPipeFixedVolumeFlow heatedPipeFixedVolumeFlow(medium = llc) annotation(
          Placement(visible = true, transformation(origin = {-126, 8}, extent = {{-10, 10}, {10, -10}}, rotation = 0)));
        Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow(Q_flow = 1000) annotation(
          Placement(visible = true, transformation(origin = {-182, -28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      equation
        connect(heatedPipeFixedVolumeFlow.flowPort_a, fixedVolumeFlow11.flowPort_a) annotation(
          Line(points = {{-136, 8}, {-156, 8}}, color = {255, 0, 0}));
        connect(heatedPipeFixedVolumeFlow.flowPort_b, ambient21.flowPort) annotation(
          Line(points = {{-116, 8}, {-100, 8}}, color = {255, 0, 0}));
        connect(fixedHeatFlow.port, heatedPipeFixedVolumeFlow.port_a) annotation(
          Line(points = {{-172, -28}, {-172, -20}, {-126, -20}, {-126, -2}}, color = {191, 0, 0}));
        connect(ambient1.flowPort, pump.flowPort_a) annotation(
          Line(points = {{-26, 0}, {-6, 0}}, color = {255, 0, 0}));
        connect(pump.flowPort_b, pipe.flowPort_a) annotation(
          Line(points = {{14, 0}, {34, 0}}, color = {255, 0, 0}));
        connect(pipe.flowPort_b, ambient2.flowPort) annotation(
          Line(points = {{54, 0}, {74, 0}}, color = {255, 0, 0}));
        connect(heatFlow.y, prescribedHeatFlow.Q_flow) annotation(
          Line(points = {{-5, -50}, {4, -50}}, color = {0, 0, 255}));
        connect(convection.solid, prescribedHeatFlow.port) annotation(
          Line(points = {{44, -40}, {44, -50}, {24, -50}}, color = {191, 0, 0}));
        connect(convection.solid, heatCapacitor.port) annotation(
          Line(points = {{44, -40}, {44, -50}, {64, -50}}, color = {191, 0, 0}));
        connect(pipe.heatPort, convection.fluid) annotation(
          Line(points = {{44, -10}, {44, -20}}, color = {191, 0, 0}));
        connect(thermalConductance.y, convection.Gc) annotation(
          Line(points = {{25, -30}, {34, -30}}, color = {0, 0, 127}));
        connect(volumeFlow.y, pump.volumeFlow) annotation(
          Line(points = {{-5, 20}, {4, 20}, {4, 10}}, color = {0, 0, 127}));
        annotation(
          experiment(StartTime = 0, StopTime = 100, Tolerance = 1e-06, Interval = 0.2),
          Diagram(coordinateSystem(extent = {{-200, -200}, {100, 100}}, initialScale = 0.1), graphics = {Text(origin = {-97, 86}, extent = {{-39, 14}, {139, -42}}, textString = "配管モデル単体検証　同じ結果となることを確認")}),
          Icon(coordinateSystem(extent = {{-200, -200}, {100, 100}})));
      end PipeTest1;

      model CellTest3
        DieselEngineLibrary.Components.Radiator.HeatExchangerCell1 heatExchangerCell(T0_water = 373.15, T0_wind = 313.15,V_flow_water = 1e-3, V_flow_wind = 0.55, fixed_T_water = false, fixed_T_wind = false, fixed_V_flow_water = false, fixed_V_flow_wind = false, m_water = 0, m_wind = 0, waterMedium = llc, windMedium = air) annotation(
          Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        //  Modelica.Thermal.FluidHeatFlow.Sources.VolumeFlow
        //Modelica.Thermal.FluidHeatFlow.Sources.Ambient
        //Modelica.Thermal.FluidHeatFlow.Sources.Ambient
        parameter DieselEngineLibrary.Media.LLC llc(cp = 3320, rho(displayUnit = "kg/m3") = 1035) annotation(
          Placement(visible = true, transformation(origin = {-44, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        //  Modelica.Thermal.FluidHeatFlow.Sources.Ambient
        //  Modelica.Thermal.FluidHeatFlow.Sources.Ambient
        //  Modelica.Thermal.FluidHeatFlow.Sources.VolumeFlow
        parameter DieselEngineLibrary.Media.Air_75degC air(cp = 1010) annotation(
          Placement(visible = true, transformation(origin = {-70, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        DieselEngineLibrary.Components.Radiator.FixedVolumeFlow1 fixedVolumeFlow11(T_a = 373.15, V_flow = 0.001, medium = llc) annotation(
          Placement(visible = true, transformation(origin = {-14, 58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        DieselEngineLibrary.Components.Radiator.Ambient2 ambient21(medium = llc) annotation(
          Placement(visible = true, transformation(origin = {12, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        DieselEngineLibrary.Components.Radiator.Ambient2 ambient2(medium = air) annotation(
          Placement(visible = true, transformation(origin = {68, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        DieselEngineLibrary.Components.Radiator.FixedVolumeFlow1 fixedVolumeFlow1(T_a = 313.15, V_flow = 0.55, medium = air) annotation(
          Placement(visible = true, transformation(origin = {-68, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      equation
        connect(fixedVolumeFlow1.flowPort_a, heatExchangerCell.Ta1) annotation(
          Line(points = {{-58, 0}, {-10, 0}, {-10, 0}, {-10, 0}}, color = {255, 0, 0}));
  connect(heatExchangerCell.Tw1, fixedVolumeFlow11.flowPort_a) annotation(
          Line(points = {{0, 10}, {-2, 10}, {-2, 58}, {-4, 58}, {-4, 58}}, color = {255, 0, 0}));
  connect(heatExchangerCell.Tw2, ambient21.flowPort) annotation(
          Line(points = {{0, -10}, {0, -10}, {0, -60}, {2, -60}, {2, -60}}, color = {255, 0, 0}));
  connect(heatExchangerCell.Ta2, ambient2.flowPort) annotation(
          Line(points = {{10, 0}, {58, 0}, {58, 0}, {58, 0}}, color = {255, 0, 0}));
        annotation(
          experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002));
      end CellTest3;

      model RadTest1
        parameter DieselEngineLibrary.Media.LLC llc(cp = 3320)  annotation(
          Placement(visible = true, transformation(origin = {-44, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        parameter DieselEngineLibrary.Media.Air_75degC air annotation(
          Placement(visible = true, transformation(origin = {-70, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        DieselEngineLibrary.Components.Radiator.HeatExchanger heatExchanger(Nj = 1, Nk = 1) annotation(
          Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Components.Radiator.Ambient2 ambient2(medium = air) annotation(
          Placement(visible = true, transformation(origin = {68, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        DieselEngineLibrary.Components.Radiator.Ambient2 ambient21(medium = llc) annotation(
          Placement(visible = true, transformation(origin = {10, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        Components.Radiator.FixedVolumeFlow1 fixedVolumeFlow1(T_a = 313.15, V_flow = 0.55, medium = air) annotation(
          Placement(visible = true, transformation(origin = {-68, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        DieselEngineLibrary.Components.Radiator.FixedVolumeFlow1 fixedVolumeFlow11(T_a = 373.15, V_flow = 0.001, medium = llc) annotation(
          Placement(visible = true, transformation(origin = {-10, 62}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      equation
        connect(fixedVolumeFlow1.flowPort_a, heatExchanger.wind_in) annotation(
          Line(points = {{-58, 0}, {-10, 0}, {-10, 0}, {-10, 0}}, color = {255, 0, 0}));
  connect(heatExchanger.water_out, ambient21.flowPort) annotation(
          Line(points = {{0, -10}, {0, -10}, {0, -60}, {0, -60}}, color = {255, 0, 0}));
  connect(heatExchanger.wind_out, ambient2.flowPort) annotation(
          Line(points = {{10, 0}, {58, 0}, {58, 0}, {58, 0}}, color = {255, 0, 0}));
  connect(heatExchanger.water_in, fixedVolumeFlow11.flowPort_a) annotation(
          Line(points = {{0, 10}, {0, 10}, {0, 62}, {0, 62}}, color = {255, 0, 0}));
        annotation(
          experiment(StartTime = 0, StopTime = 100, Tolerance = 1e-06, Interval = 0.2));
      end RadTest1;

      model CellTest5
        Modelica.Blocks.Tables.CombiTable2D combiTable2D(fileName = "C:/Work/2020/DieselEngineLibrary/csv/data_K.txt", tableName = "Tab1", tableOnFile = true) annotation(
          Placement(visible = true, transformation(origin = {-120, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        parameter DieselEngineLibrary.Media.LLC llc annotation(
          Placement(visible = true, transformation(origin = {-44, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        parameter DieselEngineLibrary.Media.Air_75degC air annotation(
          Placement(visible = true, transformation(origin = {-70, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        //DieselEngineLibrary.Components.Radiator.HeatedPipe
        //DieselEngineLibrary.Components.Commons.HeatedPipe
        DieselEngineLibrary.Components.Radiator.HeatedPipeFixedVolumeFlow heatedPipe3(medium = llc) annotation(
          Placement(visible = true, transformation(origin = {0, -18}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
        DieselEngineLibrary.Components.Radiator.HeatedPipeFixedVolumeFlow heatedPipe(medium = air) annotation(
          Placement(visible = true, transformation(origin = {-178, -44}, extent = {{-10, 10}, {10, -10}}, rotation = -90)));
        Modelica.Thermal.HeatTransfer.Components.Convection convection annotation(
          Placement(visible = true, transformation(origin = {-96, -28}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        DieselEngineLibrary.Components.Radiator.FixedVolumeFlow1 fixedVolumeFlow1(T_a = 373.15, V_flow = 0.01, medium = air) annotation(
          Placement(visible = true, transformation(origin = {-188, 38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        DieselEngineLibrary.Components.Radiator.Ambient2 ambient2(medium = air) annotation(
          Placement(visible = true, transformation(origin = {-166, -78}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        DieselEngineLibrary.Components.Radiator.FixedVolumeFlow1 fixedVolumeFlow11(T_a = 353.15, V_flow = 9, medium = llc) annotation(
          Placement(visible = true, transformation(origin = {-28, 44}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        DieselEngineLibrary.Components.Radiator.Ambient2 ambient21(medium = llc) annotation(
          Placement(visible = true, transformation(origin = {18, -72}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        DieselEngineLibrary.Sensors.FlowSensor flowSensor(medium = air) annotation(
          Placement(visible = true, transformation(origin = {-176, -4}, extent = {{-10, 10}, {10, -10}}, rotation = -90)));
        DieselEngineLibrary.Sensors.FlowSensor flowSensor1(medium = llc) annotation(
          Placement(visible = true, transformation(origin = {0, 18}, extent = {{-10, 10}, {10, -10}}, rotation = -90)));
      equation
        connect(combiTable2D.y, convection.Gc) annotation(
          Line(points = {{-108, 20}, {-96, 20}, {-96, -18}, {-96, -18}}, color = {0, 0, 127}));
        connect(ambient2.flowPort, heatedPipe.flowPort_b) annotation(
          Line(points = {{-176, -78}, {-178, -78}, {-178, -54}, {-178, -54}}, color = {255, 0, 0}));
        connect(heatedPipe.port_a, convection.solid) annotation(
          Line(points = {{-188, -44}, {-194, -44}, {-194, -28}, {-106, -28}, {-106, -28}}, color = {191, 0, 0}));
        connect(convection.fluid, heatedPipe3.port_a) annotation(
          Line(points = {{-86, -28}, {8, -28}, {8, -18}, {10, -18}}, color = {191, 0, 0}));
        connect(ambient21.flowPort, heatedPipe3.flowPort_b) annotation(
          Line(points = {{8, -72}, {-2, -72}, {-2, -28}, {0, -28}}, color = {255, 0, 0}));
        connect(fixedVolumeFlow1.flowPort_a, flowSensor.flowPort_a) annotation(
          Line(points = {{-178, 38}, {-176, 38}, {-176, 6}, {-176, 6}}, color = {255, 0, 0}));
        connect(flowSensor.flowPort_b, heatedPipe.flowPort_a) annotation(
          Line(points = {{-176, -14}, {-178, -14}, {-178, -34}, {-178, -34}}, color = {255, 0, 0}));
        connect(flowSensor.y, combiTable2D.u1) annotation(
          Line(points = {{-164, -4}, {-156, -4}, {-156, 26}, {-132, 26}, {-132, 26}}, color = {0, 0, 127}));
        connect(fixedVolumeFlow11.flowPort_a, flowSensor1.flowPort_a) annotation(
          Line(points = {{-18, 44}, {0, 44}, {0, 28}}, color = {255, 0, 0}));
        connect(flowSensor1.flowPort_b, heatedPipe3.flowPort_a) annotation(
          Line(points = {{0, 8}, {0, 8}, {0, -8}, {0, -8}}, color = {255, 0, 0}));
        connect(flowSensor1.y, combiTable2D.u2) annotation(
          Line(points = {{12, 18}, {-84, 18}, {-84, 2}, {-142, 2}, {-142, 14}, {-132, 14}, {-132, 14}}, color = {0, 0, 127}));
        annotation(
          experiment(StartTime = 0, StopTime = 100, Tolerance = 1e-06, Interval = 0.2),
          Diagram(coordinateSystem(extent = {{-200, -200}, {200, 200}})),
          Icon(coordinateSystem(extent = {{-200, -200}, {200, 200}})));
      end CellTest5;

      package Utilities
        block SmoothRamp
          extends Modelica.Blocks.Interfaces.SignalSource;
          parameter Real height = 1 "Height of ramps" annotation(
            Dialog(groupImage = "modelica://Modelica/Resources/Images/Blocks/Sources/Ramp.png"));
          parameter Modelica.SIunits.Time duration(min = 0.0, start = 2) "Duration of ramp";
        algorithm
          y := Modelica.Fluid.Utilities.regStep(time - startTime - duration / 2, offset + height, offset, duration / 2);
          annotation(
            experiment(StartTime = 0, StopTime = 15, Tolerance = 1e-06, Interval = 0.002));
        end SmoothRamp;
      end Utilities;

      model SimpleCooling "Simple cooling circuit"
        extends Modelica.Icons.Example;
        parameter DieselEngineLibrary.Media.LLC llc(cp = 3320, rho(displayUnit = "kg/m3") = 1035) annotation(
          Placement(visible = true, transformation(origin = {-44, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
        parameter Modelica.SIunits.Temperature TAmb(displayUnit = "degC") = 373.15 "Ambient temperature";
        output Modelica.SIunits.TemperatureDifference dTSource = prescribedHeatFlow.port.T - TAmb "Source over Ambient";
        output Modelica.SIunits.TemperatureDifference dTtoPipe = prescribedHeatFlow.port.T - pipe.T_q "Source over Coolant";
        output Modelica.SIunits.TemperatureDifference dTCoolant = pipe.dT "Coolant's temperature increase";
        Modelica.Thermal.FluidHeatFlow.Sources.Ambient ambient1(constantAmbientTemperature = TAmb, medium = llc, constantAmbientPressure = 0) annotation(
          Placement(transformation(extent = {{-60, -10}, {-80, 10}})));
        Modelica.Thermal.FluidHeatFlow.Sources.VolumeFlow pump(T0 = TAmb, constantVolumeFlow = 1e-3, m = 0, medium = llc, useVolumeFlowInput = false) annotation(
          Placement(transformation(extent = {{-40, -10}, {-20, 10}})));
        Modelica.Thermal.FluidHeatFlow.Components.Pipe pipe(medium = llc, m = 0.1, T0 = TAmb, V_flowLaminar = 0.1, dpLaminar(displayUnit = "Pa") = 0.1, V_flowNominal = 1, dpNominal(displayUnit = "Pa") = 1, h_g = 0, T0fixed = true, useHeatPort = true) annotation(
          Placement(transformation(extent = {{0, -10}, {20, 10}})));
        Modelica.Thermal.FluidHeatFlow.Sources.Ambient ambient2(constantAmbientTemperature = TAmb, medium = llc, constantAmbientPressure = 0) annotation(
          Placement(transformation(extent = {{40, -10}, {60, 10}})));
        Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(C = 0.1, T(start = TAmb, fixed = true)) annotation(
          Placement(transformation(origin = {40, -50}, extent = {{-10, 10}, {10, -10}}, rotation = 90)));
        Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow annotation(
          Placement(transformation(extent = {{-30, -40}, {-10, -60}})));
        Modelica.Blocks.Sources.Constant volumeFlow(k = 1) annotation(
          Placement(transformation(extent = {{-60, 10}, {-40, 30}})));
        Modelica.Blocks.Sources.Constant heatFlow(k = 1000) annotation(
          Placement(transformation(extent = {{-60, -60}, {-40, -40}})));
        Modelica.Thermal.HeatTransfer.Components.Convection convection annotation(
          Placement(transformation(origin = {10, -30}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
        Modelica.Blocks.Sources.Constant thermalConductance(k = 1) annotation(
          Placement(transformation(extent = {{-30, -40}, {-10, -20}})));
      equation
        connect(ambient1.flowPort, pump.flowPort_a) annotation(
          Line(points = {{-60, 0}, {-40, 0}}, color = {255, 0, 0}));
        connect(pump.flowPort_b, pipe.flowPort_a) annotation(
          Line(points = {{-20, 0}, {0, 0}}, color = {255, 0, 0}));
        connect(pipe.flowPort_b, ambient2.flowPort) annotation(
          Line(points = {{20, 0}, {40, 0}}, color = {255, 0, 0}));
        connect(heatFlow.y, prescribedHeatFlow.Q_flow) annotation(
          Line(points = {{-39, -50}, {-30, -50}}, color = {0, 0, 255}));
        connect(convection.solid, prescribedHeatFlow.port) annotation(
          Line(points = {{10, -40}, {10, -50}, {-10, -50}}, color = {191, 0, 0}));
        connect(convection.solid, heatCapacitor.port) annotation(
          Line(points = {{10, -40}, {10, -50}, {30, -50}}, color = {191, 0, 0}));
        connect(pipe.heatPort, convection.fluid) annotation(
          Line(points = {{10, -10}, {10, -20}}, color = {191, 0, 0}));
        connect(thermalConductance.y, convection.Gc) annotation(
          Line(points = {{-9, -30}, {0, -30}}, color = {0, 0, 127}));
        connect(volumeFlow.y, pump.volumeFlow) annotation(
          Line(points = {{-39, 20}, {-30, 20}, {-30, 10}}, color = {0, 0, 127}));
        annotation(
          Documentation(info = "<html>
      <p>
      1st test example: SimpleCooling
      </p>
      A prescribed heat source dissipates its heat through a thermal conductor to a coolant flow. The coolant flow is taken from an ambient and driven by a pump with prescribed mass flow.<br>
      <strong>Results</strong>:<br>
      <table>
      <tr>
      <td><strong>output</strong></td>
      <td><strong>explanation</strong></td>
      <td><strong>formula</strong></td>
      <td><strong>actual steady-state value</strong></td>
      </tr>
      <tr>
      <td>dTSource</td>
      <td>Source over Ambient</td>
      <td>dtCoolant + dtToPipe</td>
      <td>20 K</td>
      </tr>
      <tr>
      <td>dTtoPipe</td>
      <td>Source over Coolant</td>
      <td>Losses / ThermalConductor.G</td>
      <td>10 K</td>
      </tr>
      <tr>
      <td>dTCoolant</td>
      <td>Coolant's temperature increase</td>
      <td>Losses * cp * massFlow</td>
      <td>10 K</td>
      </tr>
      </table>
      </html>"),
          experiment(StopTime = 1.0, Interval = 0.001));
      end SimpleCooling;
    end RadiatorTest;
  end Examples;

  package Test
    model HeatExchangerBasic
      //parameter
      parameter Integer Nj(min = 1) = 21 "高さ方向の分割数";
      parameter Integer Nk(min = 1) = 18 "奥行方向の分割数";
      parameter Real Lrw(min = 0) = 525 "幅";
      parameter Real Lrh(min = 0) = 525 "高さ";
      parameter Real Lrd(min = 0) = 36 "奥行";
      //port
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a wind_in annotation(
        Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a water_in annotation(
        Placement(visible = true, transformation(origin = {0, 98}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b water_out annotation(
        Placement(visible = true, transformation(origin = {0, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -102}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b wind_out annotation(
        Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {102, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      //  each V_flow_water = 1e-3/Nk,
      //  each V_flow_wind = 0.55/Nj,
      DieselEngineLibrary.Components.Radiator.HeatExchangerCell1 heatExchangerCell(m_water = 0.1, m_wind = 0.1) annotation(
        Placement(visible = true, transformation(origin = {-60, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      DieselEngineLibrary.Components.Radiator.HeatExchangerCell1 heatExchangerCell1 annotation(
        Placement(visible = true, transformation(origin = {0, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      DieselEngineLibrary.Components.Radiator.HeatExchangerCell1 heatExchangerCell2 annotation(
        Placement(visible = true, transformation(origin = {60, 40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      DieselEngineLibrary.Components.Radiator.HeatExchangerCell1 heatExchangerCell3 annotation(
        Placement(visible = true, transformation(origin = {0, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      DieselEngineLibrary.Components.Radiator.HeatExchangerCell1 heatExchangerCell4(m_water = 0.1, m_wind = 0.1) annotation(
        Placement(visible = true, transformation(origin = {-60, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      DieselEngineLibrary.Components.Radiator.HeatExchangerCell1 heatExchangerCell5 annotation(
        Placement(visible = true, transformation(origin = {60, -40}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      connect(wind_in, heatExchangerCell.Tw1) annotation(
        Line(points = {{-100, 0}, {-80, 0}, {-80, 40}, {-70, 40}}, color = {255, 0, 0}));
      connect(wind_in, heatExchangerCell4.Tw1) annotation(
        Line(points = {{-100, 0}, {-80, 0}, {-80, -38}, {-70, -38}, {-70, -40}}, color = {255, 0, 0}));
      connect(heatExchangerCell5.Tw2, wind_out) annotation(
        Line(points = {{70, -40}, {80, -40}, {80, 0}, {100, 0}, {100, 0}}, color = {255, 0, 0}));
      connect(heatExchangerCell2.Tw2, wind_out) annotation(
        Line(points = {{70, 40}, {80, 40}, {80, 0}, {100, 0}, {100, 0}}, color = {255, 0, 0}));
      connect(water_in, heatExchangerCell1.Ta1) annotation(
        Line(points = {{0, 98}, {0, 98}, {0, 50}, {0, 50}}, color = {255, 0, 0}));
      connect(water_in, heatExchangerCell.Ta1) annotation(
        Line(points = {{0, 98}, {0, 98}, {0, 60}, {-60, 60}, {-60, 50}, {-60, 50}}, color = {255, 0, 0}));
      connect(heatExchangerCell.Tw2, heatExchangerCell1.Tw1) annotation(
        Line(points = {{-50, 40}, {-10, 40}, {-10, 40}, {-10, 40}}, color = {255, 0, 0}));
      connect(heatExchangerCell1.Ta2, heatExchangerCell3.Ta1) annotation(
        Line(points = {{0, 30}, {0, 30}, {0, -30}, {0, -30}}, color = {255, 0, 0}));
      connect(heatExchangerCell.Ta2, heatExchangerCell4.Ta1) annotation(
        Line(points = {{-60, 30}, {-60, 30}, {-60, -30}, {-60, -30}}, color = {255, 0, 0}));
      connect(heatExchangerCell4.Tw2, heatExchangerCell3.Tw1) annotation(
        Line(points = {{-50, -40}, {-10, -40}, {-10, -40}, {-10, -40}}, color = {255, 0, 0}));
      connect(heatExchangerCell4.Ta2, water_out) annotation(
        Line(points = {{-60, -50}, {-60, -50}, {-60, -72}, {0, -72}, {0, -100}, {0, -100}}, color = {255, 0, 0}));
      connect(heatExchangerCell3.Ta2, water_out) annotation(
        Line(points = {{0, -50}, {0, -50}, {0, -100}, {0, -100}}, color = {255, 0, 0}));
      connect(heatExchangerCell5.Ta2, water_out) annotation(
        Line(points = {{60, -50}, {60, -50}, {60, -72}, {0, -72}, {0, -100}, {0, -100}}, color = {255, 0, 0}));
      connect(heatExchangerCell3.Tw2, heatExchangerCell5.Tw1) annotation(
        Line(points = {{10, -40}, {50, -40}, {50, -40}, {50, -40}}, color = {255, 0, 0}));
      connect(heatExchangerCell1.Tw2, heatExchangerCell2.Tw1) annotation(
        Line(points = {{10, 40}, {50, 40}, {50, 40}, {50, 40}}, color = {255, 0, 0}));
      connect(heatExchangerCell2.Ta2, heatExchangerCell5.Ta1) annotation(
        Line(points = {{60, 30}, {60, 30}, {60, -30}, {60, -30}}, color = {255, 0, 0}));
      connect(heatExchangerCell2.Ta1, water_in) annotation(
        Line(points = {{60, 50}, {60, 50}, {60, 60}, {0, 60}, {0, 98}, {0, 98}}, color = {255, 0, 0}));
      annotation(
        Icon(graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}), Polygon(origin = {-14, -17}, fillColor = {173, 173, 173}, fillPattern = FillPattern.Solid, points = {{-60, 79}, {-60, -57}, {60, -79}, {60, 57}, {-60, 79}}), Polygon(origin = {59, -17}, fillColor = {200, 200, 200}, fillPattern = FillPattern.Solid, points = {{-13, 57}, {13, 79}, {13, -61}, {-13, -79}, {-13, -13}, {-13, 57}}), Polygon(origin = {-1, 62}, fillColor = {218, 218, 218}, fillPattern = FillPattern.Solid, points = {{-73, 0}, {-47, 22}, {73, 0}, {47, -22}, {-73, 0}}), Line(origin = {-14, 31}, points = {{-60, 11}, {60, -11}}), Line(origin = {-14, 31}, points = {{-60, 11}, {60, -11}}), Line(origin = {-14.15, 8.275}, points = {{-60, 11}, {60, -11}}), Line(origin = {-14.15, -14.475}, points = {{-60, 11}, {60, -11}}), Line(origin = {-14.15, -14.475}, points = {{-60, 11}, {60, -11}}), Line(origin = {-14.3, -37.2}, points = {{-60, 11}, {60, -11}}), Line(origin = {-14.275, -61.5}, points = {{-60, 11}, {60, -11}}), Line(origin = {59, 31}, points = {{-13, -11}, {13, 11}}), Line(origin = {59.025, 8.625}, points = {{-13, -11}, {13, 11}}), Line(origin = {58.85, -14.475}, points = {{-13, -11}, {13, 11}}), Line(origin = {58.875, -36.85}, points = {{-13, -11}, {13, 11}}), Line(origin = {59.075, -61.5}, points = {{-13, -11}, {13, 11}}), Line(origin = {6.825, 69}, points = {{-58.825, 11}, {61.175, -11}}), Line(origin = {-0.85, 63.425}, points = {{-58.825, 11}, {61.175, -11}}), Line(origin = {-8, 57.35}, points = {{-58.825, 11}, {61.175, -11}}), Line(origin = {54, -21.775}, points = {{0, 69}, {0, -69}}), Line(origin = {60.675, -17.375}, points = {{0, 69}, {0, -69}}), Line(origin = {67.7, -11.75}, points = {{0, 69}, {0, -69}})}, coordinateSystem(initialScale = 0.1)));
    end HeatExchangerBasic;

    model CellTest1
      //DieselEngineLibrary.Components.Radiator.HeatedPipe
      //DieselEngineLibrary.Components.Commons.HeatedPipe
      parameter DieselEngineLibrary.Media.LLC llc annotation(
        Placement(visible = true, transformation(origin = {-108, 116}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Components.Radiator.FixedVolumeFlow1 fixedVolumeFlow1(T_a = 373.15, V_flow = 0.01, medium = llc) annotation(
        Placement(visible = true, transformation(origin = {-66, 68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      DieselEngineLibrary.Components.Radiator.Ambient2 ambient2(medium = llc, p = 0) annotation(
        Placement(visible = true, transformation(origin = {-20, 68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      DieselEngineLibrary.Components.Radiator.FixedVolumeFlow1 fixedVolumeFlow11(T_a = 373.15, V_flow = 0.01, medium = llc) annotation(
        Placement(visible = true, transformation(origin = {-130, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      DieselEngineLibrary.Components.Radiator.Ambient2 ambient21(medium = llc, p = 0) annotation(
        Placement(visible = true, transformation(origin = {64, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow(Q_flow = 1) annotation(
        Placement(visible = true, transformation(origin = {-30, 20}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      DieselEngineLibrary.Components.Radiator.HeatedPipeFixedVolumeFlow heatedPipeFixedVolumeFlow(medium = llc) annotation(
        Placement(visible = true, transformation(origin = {-2, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Sensors.FlowSensor flowSensor(medium = llc) annotation(
        Placement(visible = true, transformation(origin = {-78, -6}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      connect(fixedVolumeFlow1.flowPort_a, ambient2.flowPort) annotation(
        Line(points = {{-56, 68}, {-30, 68}, {-30, 68}, {-30, 68}}, color = {255, 0, 0}));
      connect(heatedPipeFixedVolumeFlow.flowPort_b, ambient21.flowPort) annotation(
        Line(points = {{8, -6}, {52, -6}, {52, -6}, {54, -6}}, color = {255, 0, 0}));
      connect(fixedHeatFlow.port, heatedPipeFixedVolumeFlow.port_a) annotation(
        Line(points = {{-20, 20}, {-2, 20}, {-2, 4}, {-2, 4}}, color = {191, 0, 0}));
      connect(fixedVolumeFlow11.flowPort_a, flowSensor.flowPort_a) annotation(
        Line(points = {{-120, -6}, {-90, -6}, {-90, -6}, {-88, -6}}, color = {255, 0, 0}));
      connect(flowSensor.flowPort_b, heatedPipeFixedVolumeFlow.flowPort_a) annotation(
        Line(points = {{-68, -6}, {-12, -6}, {-12, -6}, {-12, -6}}, color = {255, 0, 0}));
    protected
      annotation(
        experiment(StartTime = 0, StopTime = 100, Tolerance = 1e-06, Interval = 0.2),
        Diagram(coordinateSystem(extent = {{-200, -200}, {200, 200}})),
        Icon(coordinateSystem(extent = {{-200, -200}, {200, 200}})));
    end CellTest1;

    model RadTestBasic1
      //  Modelica.Thermal.FluidHeatFlow.Sources.VolumeFlow
      //Modelica.Thermal.FluidHeatFlow.Sources.Ambient
      //Modelica.Thermal.FluidHeatFlow.Sources.Ambient
      parameter DieselEngineLibrary.Media.LLC llc annotation(
        Placement(visible = true, transformation(origin = {-44, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      //  Modelica.Thermal.FluidHeatFlow.Sources.Ambient
      //  Modelica.Thermal.FluidHeatFlow.Sources.Ambient
      //  Modelica.Thermal.FluidHeatFlow.Sources.VolumeFlow
      parameter DieselEngineLibrary.Media.Air_75degC air annotation(
        Placement(visible = true, transformation(origin = {-70, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      DieselEngineLibrary.Components.Radiator.FixedVolumeFlow1 fixedVolumeFlow11(T_a = 373.15, V_flow = 0.01, medium = llc) annotation(
        Placement(visible = true, transformation(origin = {-14, 58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      DieselEngineLibrary.Components.Radiator.Ambient2 ambient21(medium = llc) annotation(
        Placement(visible = true, transformation(origin = {10, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      DieselEngineLibrary.Components.Radiator.Ambient2 ambient2(medium = air) annotation(
        Placement(visible = true, transformation(origin = {68, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      DieselEngineLibrary.Components.Radiator.FixedVolumeFlow1 fixedVolumeFlow1(T_a = 313.15, V_flow = 0.55, medium = air) annotation(
        Placement(visible = true, transformation(origin = {-68, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      DieselEngineLibrary.Test.HeatExchangerBasic heatExchanger(Nj = 2, Nk = 1) annotation(
        Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      connect(fixedVolumeFlow1.flowPort_a, heatExchanger.wind_in) annotation(
        Line(points = {{-58, 0}, {-10, 0}}, color = {255, 0, 0}));
      connect(heatExchanger.wind_out, ambient2.flowPort) annotation(
        Line(points = {{10, 0}, {58, 0}}, color = {255, 0, 0}));
      connect(heatExchanger.water_out, ambient21.flowPort) annotation(
        Line(points = {{0, -10}, {0, -60}}, color = {255, 0, 0}));
      connect(heatExchanger.water_in, fixedVolumeFlow11.flowPort_a) annotation(
        Line(points = {{0, 10}, {0, 58}, {-4, 58}}, color = {255, 0, 0}));
      annotation(
        experiment(StartTime = 0, StopTime = 100, Tolerance = 1e-06, Interval = 0.2));
    end RadTestBasic1;

    model HeatExchangerBasic2
      //parameter
      parameter Modelica.Thermal.FluidHeatFlow.Media.Medium waterMedium = DieselEngineLibrary.Media.LLC() "Cooling water" annotation(
        choicesAllMatching = true);
      parameter Modelica.Thermal.FluidHeatFlow.Media.Medium windMedium = DieselEngineLibrary.Media.Air_75degC() "Cooling wind" annotation(
        choicesAllMatching = true);
      parameter Integer Nj(min = 1) = 2 "高さ方向の分割数";
      parameter Integer Nk(min = 1) = 1 "奥行方向の分割数";
      parameter Real Lrw(min = 0) = 525 "幅";
      parameter Real Lrh(min = 0) = 525 "高さ";
      parameter Real Lrd(min = 0) = 36 "奥行";
      parameter Modelica.SIunits.Temperature T0_water;
      parameter Modelica.SIunits.Temperature T0_wind;
      //variable
      Modelica.SIunits.Temperature Tin_water;
      Modelica.SIunits.Temperature Tout_water;
      Modelica.SIunits.Temperature Tin_wind;
      Modelica.SIunits.Temperature Tout_wind;
      //port
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a wind_in annotation(
        Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a water_in annotation(
        Placement(visible = true, transformation(origin = {0, 98}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b water_out annotation(
        Placement(visible = true, transformation(origin = {0, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -102}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b wind_out annotation(
        Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {102, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      //  DieselEngineLibrary.Components.Radiator.HeatExchangerCell1 cell[2]  annotation(
      //    Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      DieselEngineLibrary.Components.Radiator.HeatExchangerCell1 cell[2, 1] annotation(
        Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      connect(wind_in, cell[1, 1].Tw1);
      connect(wind_in, cell[2, 1].Tw1);
      connect(wind_out, cell[1, 1].Tw2);
      connect(wind_out, cell[2, 1].Tw2);
      connect(water_in, cell[1, 1].Ta1);
      connect(water_out, cell[2, 1].Ta2);
      connect(cell[1, 1].Ta2, cell[2, 1].Ta1);
//  for n in 1:2 loop
//    connect(wind_in, cell[n, 1].Tw1);
//    connect(wind_out, cell[n, Nk].Tw2);
//  end for;
//  for m in 1:Nk loop
//    connect(water_in, cell[1, m].Ta1);
//    connect(water_out, cell[Nj, m].Ta2);
//  end for;
//  for p in 1:Nj - 1 loop
//    for q in 1:Nk - 1 loop
//      connect(cell[p, q].Tw2, cell[p, q + 1].Tw1);
//      connect(cell[p, q].Ta2, cell[p + 1, q].Ta1);
//    end for;
//  end for;
//output
      Tin_water = water_in.h / waterMedium.cp;
      Tout_water = water_out.h / waterMedium.cp;
      Tin_wind = wind_in.h / windMedium.cp;
      Tout_wind = wind_out.h / windMedium.cp;
      annotation(
        Icon(graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}), Polygon(origin = {-14, -17}, fillColor = {173, 173, 173}, fillPattern = FillPattern.Solid, points = {{-60, 79}, {-60, -57}, {60, -79}, {60, 57}, {-60, 79}}), Polygon(origin = {59, -17}, fillColor = {200, 200, 200}, fillPattern = FillPattern.Solid, points = {{-13, 57}, {13, 79}, {13, -61}, {-13, -79}, {-13, -13}, {-13, 57}}), Polygon(origin = {-1, 62}, fillColor = {218, 218, 218}, fillPattern = FillPattern.Solid, points = {{-73, 0}, {-47, 22}, {73, 0}, {47, -22}, {-73, 0}}), Line(origin = {-14, 31}, points = {{-60, 11}, {60, -11}}), Line(origin = {-14, 31}, points = {{-60, 11}, {60, -11}}), Line(origin = {-14.15, 8.275}, points = {{-60, 11}, {60, -11}}), Line(origin = {-14.15, -14.475}, points = {{-60, 11}, {60, -11}}), Line(origin = {-14.15, -14.475}, points = {{-60, 11}, {60, -11}}), Line(origin = {-14.3, -37.2}, points = {{-60, 11}, {60, -11}}), Line(origin = {-14.275, -61.5}, points = {{-60, 11}, {60, -11}}), Line(origin = {59, 31}, points = {{-13, -11}, {13, 11}}), Line(origin = {59.025, 8.625}, points = {{-13, -11}, {13, 11}}), Line(origin = {58.85, -14.475}, points = {{-13, -11}, {13, 11}}), Line(origin = {58.875, -36.85}, points = {{-13, -11}, {13, 11}}), Line(origin = {59.075, -61.5}, points = {{-13, -11}, {13, 11}}), Line(origin = {6.825, 69}, points = {{-58.825, 11}, {61.175, -11}}), Line(origin = {-0.85, 63.425}, points = {{-58.825, 11}, {61.175, -11}}), Line(origin = {-8, 57.35}, points = {{-58.825, 11}, {61.175, -11}}), Line(origin = {54, -21.775}, points = {{0, 69}, {0, -69}}), Line(origin = {60.675, -17.375}, points = {{0, 69}, {0, -69}}), Line(origin = {67.7, -11.75}, points = {{0, 69}, {0, -69}})}));
    end HeatExchangerBasic2;

    model RadTestBasic2
      //  Modelica.Thermal.FluidHeatFlow.Sources.VolumeFlow
      //Modelica.Thermal.FluidHeatFlow.Sources.Ambient
      //Modelica.Thermal.FluidHeatFlow.Sources.Ambient
      parameter DieselEngineLibrary.Media.LLC llc annotation(
        Placement(visible = true, transformation(origin = {-44, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      //  Modelica.Thermal.FluidHeatFlow.Sources.Ambient
      //  Modelica.Thermal.FluidHeatFlow.Sources.Ambient
      //  Modelica.Thermal.FluidHeatFlow.Sources.VolumeFlow
      parameter DieselEngineLibrary.Media.Air_75degC air annotation(
        Placement(visible = true, transformation(origin = {-70, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      DieselEngineLibrary.Components.Radiator.FixedVolumeFlow1 fixedVolumeFlow11(T_a = 373.15, V_flow = 0.01, medium = llc) annotation(
        Placement(visible = true, transformation(origin = {-14, 58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      DieselEngineLibrary.Components.Radiator.Ambient2 ambient21(medium = llc) annotation(
        Placement(visible = true, transformation(origin = {10, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      DieselEngineLibrary.Components.Radiator.Ambient2 ambient2(medium = air) annotation(
        Placement(visible = true, transformation(origin = {68, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      DieselEngineLibrary.Components.Radiator.FixedVolumeFlow1 fixedVolumeFlow1(T_a = 313.15, V_flow = 0.55, medium = air) annotation(
        Placement(visible = true, transformation(origin = {-68, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      DieselEngineLibrary.Test.HeatExchangerBasic2 heatExchanger(Nj = 2, Nk = 1, T0_water = 313.15, T0_wind = 373.15) annotation(
        Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      connect(fixedVolumeFlow1.flowPort_a, heatExchanger.wind_in) annotation(
        Line(points = {{-58, 0}, {-10, 0}}, color = {255, 0, 0}));
      connect(heatExchanger.wind_out, ambient2.flowPort) annotation(
        Line(points = {{10, 0}, {58, 0}}, color = {255, 0, 0}));
      connect(heatExchanger.water_out, ambient21.flowPort) annotation(
        Line(points = {{0, -10}, {0, -60}}, color = {255, 0, 0}));
      connect(heatExchanger.water_in, fixedVolumeFlow11.flowPort_a) annotation(
        Line(points = {{0, 10}, {0, 58}, {-4, 58}}, color = {255, 0, 0}));
      annotation(
        experiment(StartTime = 0, StopTime = 100, Tolerance = 1e-06, Interval = 0.2));
    end RadTestBasic2;

    model HeatExchangerBasic3
      //parameter
      parameter Modelica.Thermal.FluidHeatFlow.Media.Medium waterMedium = DieselEngineLibrary.Media.LLC() "Cooling water" annotation(
        choicesAllMatching = true);
      parameter Modelica.Thermal.FluidHeatFlow.Media.Medium windMedium = DieselEngineLibrary.Media.Air_75degC() "Cooling wind" annotation(
        choicesAllMatching = true);
      parameter Integer Nj(min = 1) = 2 "高さ方向の分割数";
      parameter Integer Nk(min = 1) = 1 "奥行方向の分割数";
      parameter Real Lrw(min = 0) = 525 "幅";
      parameter Real Lrh(min = 0) = 525 "高さ";
      parameter Real Lrd(min = 0) = 36 "奥行";
      parameter Modelica.SIunits.Temperature T0_water;
      parameter Modelica.SIunits.Temperature T0_wind;
      //variable
      Modelica.SIunits.Temperature Tin_water;
      Modelica.SIunits.Temperature Tout_water;
      Modelica.SIunits.Temperature Tin_wind;
      Modelica.SIunits.Temperature Tout_wind;
      //port
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a wind_in annotation(
        Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a water_in annotation(
        Placement(visible = true, transformation(origin = {0, 98}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b water_out annotation(
        Placement(visible = true, transformation(origin = {0, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -102}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b wind_out annotation(
        Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {102, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      //  DieselEngineLibrary.Components.Radiator.HeatExchangerCell1 cell[2]  annotation(
      //    Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      DieselEngineLibrary.Components.Radiator.HeatExchangerCell1 cell[Nj, Nk] annotation(
        Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    protected
      parameter Integer Mj = max(1, Nj - 1);
      parameter Integer Mk = max(1, Nk - 1);
    equation
//if Nk == 1
//  connect(wind_in, cell[1,1].Tw1);
//  connect(wind_in, cell[2,1].Tw1);
//  connect(wind_out, cell[1,1].Tw2);
//  connect(wind_out, cell[2,1].Tw2);
//  connect(water_in, cell[1,1].Ta1);
//  connect(water_out, cell[2,1].Ta2);
//if Nj == 1
//  connect(wind_in, cell[1,1].Tw1);
//  connect(wind_out, cell[1,1].Tw2);
//  connect(water_in, cell[1,1].Ta1);
//  connect(water_in, cell[1,2].Ta1);
//  connect(water_out, cell[1,1].Ta2);
//  connect(water_out, cell[1,2].Ta2);
      for n in 1:Nj loop
        connect(wind_in, cell[n, 1].Tw1);
        connect(wind_out, cell[n, Nk].Tw2);
      end for;
      for m in 1:Nk loop
        connect(water_in, cell[1, m].Ta1);
        connect(water_out, cell[Nj, m].Ta2);
      end for;
//  connect(cell[1, 1].Ta2, cell[2, 1].Ta1);
      if Nj > 1 and Nk == 1 then
        for p in 1:Mj loop
          for q in 1:Mk loop
            connect(cell[p, q].Ta2, cell[p + 1, q].Ta1);
          end for;
        end for;
      elseif Nj == 1 and Nk > 1 then
        for p in 1:Mj loop
          for q in 1:Mk loop
            connect(cell[p, q].Tw2, cell[p, q + 1].Tw1);
//connect(cell[p, q].Ta2, cell[p + 1, q].Ta1);
          end for;
        end for;
      else
        for p in 1:Mj loop
          for q in 1:Mk loop
            connect(cell[p, q].Tw2, cell[p, q + 1].Tw1);
            connect(cell[p, q].Ta2, cell[p + 1, q].Ta1);
          end for;
        end for;
      end if;
//output
      Tin_water = water_in.h / waterMedium.cp;
      Tout_water = water_out.h / waterMedium.cp;
      Tin_wind = wind_in.h / windMedium.cp;
      Tout_wind = wind_out.h / windMedium.cp;
      annotation(
        Icon(graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}), Polygon(origin = {-14, -17}, fillColor = {173, 173, 173}, fillPattern = FillPattern.Solid, points = {{-60, 79}, {-60, -57}, {60, -79}, {60, 57}, {-60, 79}}), Polygon(origin = {59, -17}, fillColor = {200, 200, 200}, fillPattern = FillPattern.Solid, points = {{-13, 57}, {13, 79}, {13, -61}, {-13, -79}, {-13, -13}, {-13, 57}}), Polygon(origin = {-1, 62}, fillColor = {218, 218, 218}, fillPattern = FillPattern.Solid, points = {{-73, 0}, {-47, 22}, {73, 0}, {47, -22}, {-73, 0}}), Line(origin = {-14, 31}, points = {{-60, 11}, {60, -11}}), Line(origin = {-14, 31}, points = {{-60, 11}, {60, -11}}), Line(origin = {-14.15, 8.275}, points = {{-60, 11}, {60, -11}}), Line(origin = {-14.15, -14.475}, points = {{-60, 11}, {60, -11}}), Line(origin = {-14.15, -14.475}, points = {{-60, 11}, {60, -11}}), Line(origin = {-14.3, -37.2}, points = {{-60, 11}, {60, -11}}), Line(origin = {-14.275, -61.5}, points = {{-60, 11}, {60, -11}}), Line(origin = {59, 31}, points = {{-13, -11}, {13, 11}}), Line(origin = {59.025, 8.625}, points = {{-13, -11}, {13, 11}}), Line(origin = {58.85, -14.475}, points = {{-13, -11}, {13, 11}}), Line(origin = {58.875, -36.85}, points = {{-13, -11}, {13, 11}}), Line(origin = {59.075, -61.5}, points = {{-13, -11}, {13, 11}}), Line(origin = {6.825, 69}, points = {{-58.825, 11}, {61.175, -11}}), Line(origin = {-0.85, 63.425}, points = {{-58.825, 11}, {61.175, -11}}), Line(origin = {-8, 57.35}, points = {{-58.825, 11}, {61.175, -11}}), Line(origin = {54, -21.775}, points = {{0, 69}, {0, -69}}), Line(origin = {60.675, -17.375}, points = {{0, 69}, {0, -69}}), Line(origin = {67.7, -11.75}, points = {{0, 69}, {0, -69}})}));
    end HeatExchangerBasic3;

    model RadTestBasic3
      //  Modelica.Thermal.FluidHeatFlow.Sources.VolumeFlow
      //Modelica.Thermal.FluidHeatFlow.Sources.Ambient
      //Modelica.Thermal.FluidHeatFlow.Sources.Ambient
      parameter DieselEngineLibrary.Media.LLC llc annotation(
        Placement(visible = true, transformation(origin = {-44, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      //  Modelica.Thermal.FluidHeatFlow.Sources.Ambient
      //  Modelica.Thermal.FluidHeatFlow.Sources.Ambient
      //  Modelica.Thermal.FluidHeatFlow.Sources.VolumeFlow
      parameter DieselEngineLibrary.Media.Air_75degC air annotation(
        Placement(visible = true, transformation(origin = {-70, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      DieselEngineLibrary.Components.Radiator.FixedVolumeFlow1 fixedVolumeFlow11(T_a = 373.15, V_flow = 0.01, medium = llc) annotation(
        Placement(visible = true, transformation(origin = {-14, 58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      DieselEngineLibrary.Components.Radiator.Ambient2 ambient21(medium = llc) annotation(
        Placement(visible = true, transformation(origin = {10, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      DieselEngineLibrary.Components.Radiator.Ambient2 ambient2(medium = air) annotation(
        Placement(visible = true, transformation(origin = {68, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      DieselEngineLibrary.Components.Radiator.FixedVolumeFlow1 fixedVolumeFlow1(T_a = 313.15, V_flow = 0.55, medium = air) annotation(
        Placement(visible = true, transformation(origin = {-68, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      DieselEngineLibrary.Test.HeatExchangerBasic3 heatExchanger(Nj = 1, Nk = 2, T0_water = 313.15, T0_wind = 373.15) annotation(
        Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      connect(fixedVolumeFlow1.flowPort_a, heatExchanger.wind_in) annotation(
        Line(points = {{-58, 0}, {-10, 0}}, color = {255, 0, 0}));
      connect(heatExchanger.wind_out, ambient2.flowPort) annotation(
        Line(points = {{10, 0}, {58, 0}}, color = {255, 0, 0}));
      connect(heatExchanger.water_out, ambient21.flowPort) annotation(
        Line(points = {{0, -10}, {0, -60}}, color = {255, 0, 0}));
      connect(heatExchanger.water_in, fixedVolumeFlow11.flowPort_a) annotation(
        Line(points = {{0, 10}, {0, 58}, {-4, 58}}, color = {255, 0, 0}));
      annotation(
        experiment(StartTime = 0, StopTime = 100, Tolerance = 1e-06, Interval = 0.2));
    end RadTestBasic3;

    model HeatExchangerBasic4
      //parameter
      parameter Modelica.Thermal.FluidHeatFlow.Media.Medium waterMedium = DieselEngineLibrary.Media.LLC() "Cooling water" annotation(
        choicesAllMatching = true);
      parameter Modelica.Thermal.FluidHeatFlow.Media.Medium windMedium = DieselEngineLibrary.Media.Air_75degC() "Cooling wind" annotation(
        choicesAllMatching = true);
      parameter Integer Nj(min = 1) = 2 "高さ方向の分割数";
      parameter Integer Nk(min = 1) = 2 "奥行方向の分割数";
      parameter Real Lrw(min = 0) = 525 "幅";
      parameter Real Lrh(min = 0) = 525 "高さ";
      parameter Real Lrd(min = 0) = 36 "奥行";
      parameter Modelica.SIunits.Temperature T0_water;
      parameter Modelica.SIunits.Temperature T0_wind;
      //variable
      Modelica.SIunits.Temperature Tin_water;
      Modelica.SIunits.Temperature Tout_water;
      Modelica.SIunits.Temperature Tin_wind;
      Modelica.SIunits.Temperature Tout_wind;
      //port
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a wind_in annotation(
        Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a water_in annotation(
        Placement(visible = true, transformation(origin = {0, 98}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 100}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b water_out annotation(
        Placement(visible = true, transformation(origin = {0, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, -102}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b wind_out annotation(
        Placement(visible = true, transformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {102, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      //  DieselEngineLibrary.Components.Radiator.HeatExchangerCell1 cell[2]  annotation(
      //    Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      DieselEngineLibrary.Components.Radiator.HeatExchangerCell1 cell[Nj, Nk] annotation(
        Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    protected
      parameter Integer Mj = max(1, Nj - 1);
      parameter Integer Mk = max(1, Nk - 1);
    equation
//if Nk == 1
//  connect(wind_in, cell[1,1].Tw1);
//  connect(wind_in, cell[2,1].Tw1);
//  connect(wind_out, cell[1,1].Tw2);
//  connect(wind_out, cell[2,1].Tw2);
//  connect(water_in, cell[1,1].Ta1);
//  connect(water_out, cell[2,1].Ta2);
//if Nj == 1
//  connect(wind_in, cell[1,1].Tw1);
//  connect(wind_out, cell[1,1].Tw2);
//  connect(water_in, cell[1,1].Ta1);
//  connect(water_in, cell[1,2].Ta1);
//  connect(water_out, cell[1,1].Ta2);
//  connect(water_out, cell[1,2].Ta2);
      for n in 1:Nj loop
        connect(wind_in, cell[n, 1].Tw1);
        connect(wind_out, cell[n, Nk].Tw2);
      end for;
      for m in 1:Nk loop
        connect(water_in, cell[1, m].Ta1);
        connect(water_out, cell[Nj, m].Ta2);
      end for;
//  connect(cell[1, 1].Tw2, cell[1, 2].Tw1);
//  connect(cell[2, 1].Tw2, cell[2, 2].Tw1);
//  connect(cell[1, 1].Ta2, cell[2, 1].Ta1);
//  connect(cell[1, 2].Ta2, cell[2, 2].Ta1);
      for p in 1:Nj loop
        for q in 1:Nk - 1 loop
          connect(cell[p, q].Tw2, cell[p, q + 1].Tw1);
        end for;
      end for;
      for r in 1:Nk loop
        for s in 1:Nj - 1 loop
          connect(cell[s, r].Ta2, cell[s + 1, r].Ta1);
        end for;
      end for;
//mid connect
//  if Nj > 1 and Nk == 1 then
//    for p in 1:Mj loop
//      for q in 1:Mk loop
//        connect(cell[p, q].Ta2, cell[p + 1, q].Ta1);
//      end for;
//    end for;
//  elseif Nj == 1 and Nk > 1 then
//    for p in 1:Mj loop
//      for q in 1:Mk loop
//        connect(cell[p, q].Tw2, cell[p, q + 1].Tw1);
//      end for;
//    end for;
//  else
//    for p in 1:Mj loop
//      for q in 1:Mk loop
//        connect(cell[p, q].Tw2, cell[p + 1, q].Tw1);
//        connect(cell[p, q].Ta2, cell[p, q + 1].Ta1);
//      end for;
//    end for;
//  end if;
//output
      Tin_water = water_in.h / waterMedium.cp;
      Tout_water = water_out.h / waterMedium.cp;
      Tin_wind = wind_in.h / windMedium.cp;
      Tout_wind = wind_out.h / windMedium.cp;
      annotation(
        Icon(graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}), Polygon(origin = {-14, -17}, fillColor = {173, 173, 173}, fillPattern = FillPattern.Solid, points = {{-60, 79}, {-60, -57}, {60, -79}, {60, 57}, {-60, 79}}), Polygon(origin = {59, -17}, fillColor = {200, 200, 200}, fillPattern = FillPattern.Solid, points = {{-13, 57}, {13, 79}, {13, -61}, {-13, -79}, {-13, -13}, {-13, 57}}), Polygon(origin = {-1, 62}, fillColor = {218, 218, 218}, fillPattern = FillPattern.Solid, points = {{-73, 0}, {-47, 22}, {73, 0}, {47, -22}, {-73, 0}}), Line(origin = {-14, 31}, points = {{-60, 11}, {60, -11}}), Line(origin = {-14, 31}, points = {{-60, 11}, {60, -11}}), Line(origin = {-14.15, 8.275}, points = {{-60, 11}, {60, -11}}), Line(origin = {-14.15, -14.475}, points = {{-60, 11}, {60, -11}}), Line(origin = {-14.15, -14.475}, points = {{-60, 11}, {60, -11}}), Line(origin = {-14.3, -37.2}, points = {{-60, 11}, {60, -11}}), Line(origin = {-14.275, -61.5}, points = {{-60, 11}, {60, -11}}), Line(origin = {59, 31}, points = {{-13, -11}, {13, 11}}), Line(origin = {59.025, 8.625}, points = {{-13, -11}, {13, 11}}), Line(origin = {58.85, -14.475}, points = {{-13, -11}, {13, 11}}), Line(origin = {58.875, -36.85}, points = {{-13, -11}, {13, 11}}), Line(origin = {59.075, -61.5}, points = {{-13, -11}, {13, 11}}), Line(origin = {6.825, 69}, points = {{-58.825, 11}, {61.175, -11}}), Line(origin = {-0.85, 63.425}, points = {{-58.825, 11}, {61.175, -11}}), Line(origin = {-8, 57.35}, points = {{-58.825, 11}, {61.175, -11}}), Line(origin = {54, -21.775}, points = {{0, 69}, {0, -69}}), Line(origin = {60.675, -17.375}, points = {{0, 69}, {0, -69}}), Line(origin = {67.7, -11.75}, points = {{0, 69}, {0, -69}})}));
    end HeatExchangerBasic4;

    model RadTestBasic4
      //  Modelica.Thermal.FluidHeatFlow.Sources.VolumeFlow
      //Modelica.Thermal.FluidHeatFlow.Sources.Ambient
      //Modelica.Thermal.FluidHeatFlow.Sources.Ambient
      parameter DieselEngineLibrary.Media.LLC llc annotation(
        Placement(visible = true, transformation(origin = {-44, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      //  Modelica.Thermal.FluidHeatFlow.Sources.Ambient
      //  Modelica.Thermal.FluidHeatFlow.Sources.Ambient
      //  Modelica.Thermal.FluidHeatFlow.Sources.VolumeFlow
      parameter DieselEngineLibrary.Media.Air_75degC air annotation(
        Placement(visible = true, transformation(origin = {-70, 78}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      DieselEngineLibrary.Components.Radiator.FixedVolumeFlow1 fixedVolumeFlow11(T_a = 373.15, V_flow = 0.01, medium = llc) annotation(
        Placement(visible = true, transformation(origin = {-14, 58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      DieselEngineLibrary.Components.Radiator.Ambient2 ambient21(medium = llc) annotation(
        Placement(visible = true, transformation(origin = {10, -60}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      DieselEngineLibrary.Components.Radiator.Ambient2 ambient2(medium = air) annotation(
        Placement(visible = true, transformation(origin = {68, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      DieselEngineLibrary.Components.Radiator.FixedVolumeFlow1 fixedVolumeFlow1(T_a = 313.15, V_flow = 0.55, medium = air) annotation(
        Placement(visible = true, transformation(origin = {-68, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
      DieselEngineLibrary.Test.HeatExchangerBasic4 heatExchanger(Nj = 2, Nk = 6, T0_water = 313.15, T0_wind = 373.15) annotation(
        Placement(visible = true, transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
    equation
      connect(fixedVolumeFlow1.flowPort_a, heatExchanger.wind_in) annotation(
        Line(points = {{-58, 0}, {-10, 0}}, color = {255, 0, 0}));
      connect(heatExchanger.wind_out, ambient2.flowPort) annotation(
        Line(points = {{10, 0}, {58, 0}}, color = {255, 0, 0}));
      connect(heatExchanger.water_out, ambient21.flowPort) annotation(
        Line(points = {{0, -10}, {0, -60}}, color = {255, 0, 0}));
      connect(heatExchanger.water_in, fixedVolumeFlow11.flowPort_a) annotation(
        Line(points = {{0, 10}, {0, 58}, {-4, 58}}, color = {255, 0, 0}));
      annotation(
        experiment(StartTime = 0, StopTime = 100, Tolerance = 1e-06, Interval = 0.2));
    end RadTestBasic4;
  end Test;

  package Interfaces
    model InputVflow
      Modelica.Blocks.Interfaces.RealInput u annotation(
        Placement(visible = true, transformation(origin = {-110, 2}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-110, 2}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    equation

    end InputVflow;

    connector FlowInput
      input Real m_flow;
      input Real T;
    end FlowInput;
  end Interfaces;

  package Sensors
    extends Modelica.Icons.SensorsPackage;

    model FlowSensor "Partial model of flow sensor"
      //extends Modelica.Icons.RotationalSensor;
      Modelica.Blocks.Interfaces.RealOutput y annotation(
        Placement(transformation(origin = {0, -110}, extent = {{10, -10}, {-10, 10}}, rotation = 90)));
      parameter Modelica.Thermal.FluidHeatFlow.Media.Medium medium = Modelica.Thermal.FluidHeatFlow.Media.Medium() "Medium in the component" annotation(
        choicesAllMatching = true);
      Modelica.Units.SI.Pressure dp "Pressure drop a->b";
      //  output Modelica.Units.SI.Temperature T(start = T0, fixed = T0fixed) "Outlet temperature of medium";
      Modelica.Units.SI.Temperature T_a "Temperature at flowPort_a";
      Modelica.Units.SI.Temperature T_b "Temperature at flowPort_b";
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_a flowPort_a(final medium = medium) annotation(
        Placement(transformation(extent = {{-110, -10}, {-90, 10}})));
      Modelica.Thermal.FluidHeatFlow.Interfaces.FlowPort_b flowPort_b(final medium = medium) annotation(
        Placement(transformation(extent = {{90, -10}, {110, 10}})));
    algorithm
      flowPort_b.m_flow := -flowPort_a.m_flow;
      T_a := flowPort_a.h / medium.cp;
      flowPort_b.H_flow := -flowPort_a.H_flow;
      flowPort_b.h := flowPort_b.H_flow / flowPort_b.m_flow;
      T_b := flowPort_b.h / medium.cp;
      y := flowPort_a.m_flow / medium.rho;
    equation
      dp = flowPort_a.p - flowPort_b.p;
      dp = 0;
      annotation(
        Documentation(info = "<html>
    <p>Partial model for a flow sensor (mass flow/heat flow).</p>
    <p>Pressure, mass flow, temperature and enthalpy flow of medium are not affected, but mixing rule is applied.</p>
    </html>"),
        Icon(coordinateSystem(initialScale = 0.1), graphics = {Line(points = {{-70, 0}, {-90, 0}}), Line(points = {{70, 0}, {90, 0}}), Line(points = {{0, -100}, {0, -70}}), Line(origin = {-2, 80.0312}, points = {{-82, 0}, {82, 0}}, color = {0, 85, 255}, thickness = 1, arrow = {Arrow.None, Arrow.Filled}, arrowSize = 10), Text(lineColor = {0, 0, 255}, extent = {{-150, 100}, {150, 140}}, textString = "%name")}));
    end FlowSensor;
  end Sensors;
  annotation(
    uses(Modelica(version = "3.2.3")));
end DieselEngineLibrary;
