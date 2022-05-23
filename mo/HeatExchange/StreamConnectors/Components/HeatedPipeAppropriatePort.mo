within StreamConnectors.Components;
model HeatedPipeAppropriatePort "A simple static pipe with heating/cooling"

  parameter Modelica.Thermal.FluidHeatFlow.Media.Medium medium=Modelica.Thermal.FluidHeatFlow.Media.Medium()
    "Medium in the component"
    annotation(choicesAllMatching=true);

  parameter Real K = dp_nominal / m_flow_nominal ^ 2 "Pressure drop coefficient";
  parameter Real dp_nominal = 0.5 "Nominal pressure drop [bar]" annotation(
    Dialog(group = "Nominal values"));
  parameter Real m_flow_nominal = 1 "Nominal mass flow rate [kg/s]" annotation(
    Dialog(group = "Nominal values"));
  StreamConnectors.Interfaces.FluidPort port_a annotation(
    Placement(transformation(extent = {{-120, -10}, {-100, 10}}), iconTransformation(extent = {{-120, -10}, {-100, 10}})));
  StreamConnectors.Interfaces.FluidPort port_b annotation(
    Placement(transformation(extent = {{100, -10}, {120, 10}}), iconTransformation(extent = {{100, -10}, {120, 10}})));


  Real h_flow_mid;
Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort annotation(
    Placement(visible = true, transformation(origin = {-2, 66}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {0, 62}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation

// Mass balance
  port_a.m_flow + port_b.m_flow = 0;
// Momentum balance
  port_a.p - port_b.p = K * port_a.m_flow * abs(port_a.m_flow);
// Energy balance
  port_a.h_outflow = semiLinear(sign(port_a.m_flow), inStream(port_a.h_outflow), h_flow_mid);
  port_b.h_outflow = semiLinear(sign(port_b.m_flow), inStream(port_b.h_outflow), -h_flow_mid);
//  abs(port_a.m_flow)*h_flow_mid = abs(semiLinear(port_a.m_flow, inStream(port_a.h_outflow), inStream(port_b.h_outflow)))+heatPort.Q_flow;

  h_flow_mid = semiLinear(sign(port_a.m_flow), inStream(port_a.h_outflow), -inStream(port_b.h_outflow))+heatPort.Q_flow/abs(port_a.m_flow);

  abs(port_a.m_flow)*h_flow_mid = heatPort.T*medium.cp;
  
// Alternative to the two equations describing the energy balance you could write (commented below)
//   0 = port_a.m_flow*inStream(port_a.h_outflow) + port_b.m_flow*port_b.h_outflow +
//     Q_flow "This equation is only 'active' when flow enters port_a and leaves port_b";
//   0 = port_a.m_flow*port_a.h_outflow + port_b.m_flow*inStream(port_b.h_outflow) +
//     Q_flow "This equation is only 'active' when flow enters port_b and leaves port_a";
  annotation(
    preferredView = "text",
    Icon(coordinateSystem(preserveAspectRatio = false, initialScale = 0.1), graphics = {Rectangle(lineColor = {28, 108, 200}, fillColor = {28, 108, 200}, fillPattern = FillPattern.Solid, extent = {{-100, 40}, {100, -40}}), Rectangle(fillColor = {215, 215, 215}, fillPattern = FillPattern.Backward, extent = {{-100, 60}, {100, 40}}), Rectangle(fillColor = {215, 215, 215}, fillPattern = FillPattern.Backward, extent = {{-100, -40}, {100, -60}}), Line(points = {{-40, -80}, {40, -80}}), Line(points = {{30, -74}, {40, -80}, {30, -86}}), Line(origin = {-0.318961, -159.958}, rotation = 180, points = {{30, -74}, {40, -80}, {30, -86}})}),
    Diagram(coordinateSystem(preserveAspectRatio = false)),
    Documentation(info = "<html>
<p>This is probably the simplest model of a heated/cooled pipe.</p>
<h4>Governing equations</h4>
<p>The equations &quot;on paper&quot; are:</p>
<p style=\"margin-left: 30px;\">m<sub>in</sub> = m<sub>out</sub></p>
<p style=\"margin-left: 30px;\">p<sub>in</sub> - p<sub>out</sub> = deltaP=K<sup>.</sup>m<sub>in</sub>|m<sub>in</sub>|</p>
<p style=\"margin-left: 30px;\">m<sub>out</sub><sup>.</sup>h<sub>out</sub> = m<sub>in</sub><sup>.</sup>h<sub>in</sub> + Q</p>
<p>Representing the conservation of <i>mass</i>, <i>momentum</i> and <i>energy</i>.</p>
<h4>Implementation</h4>
<p>To understand the implementation and the concept of stream connectors:</p>
<ol>
<li>comment all code in the <code>equation</code> section.</li>
<li>&apos;check&apos; the model (in Dymola, hit the <b>F8</b> key). The code checker will say that the model is unbalanced with <b>six</b> unknowns and <b>two</b> equations.</li>
<li>try to understand why <b>four</b> equations are needed when the model can be described with only <b>three</b> equations on paper.</li>
</ol>
<p><br>The fact is that in Modelica, for each stream connector you need to provide a value for the outgoing stream variable (<code>h_outflow</code> in this case) when or if the mass flow leaves the connector. </p>
<p>In the pipe case it means that you must provide an expression for <code>port_b.h_outflow</code> (obviously) and <code>port_a.h_outflow</code> (for the case of flow reversal).</p>
<p>On the Github Wiki page on <a href=\"https://github.com/justnielsen/ModelicaTutorials/wiki/Stream-connectors\">Stream connectors</a>, I&apos;ve provided one more example similar to this.</p>
</html>"));
end HeatedPipeAppropriatePort;