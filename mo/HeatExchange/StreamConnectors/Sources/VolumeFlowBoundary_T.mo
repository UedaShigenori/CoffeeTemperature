within StreamConnectors.Sources;
model VolumeFlowBoundary_T
  "Boundary value component with fixed Volume flow rate and T"
  
  parameter Modelica.Thermal.FluidHeatFlow.Media.Medium medium=Modelica.Thermal.FluidHeatFlow.Media.Medium()
    "Medium in the component"
    annotation(choicesAllMatching=true);
    
  input Modelica.SIunits.VolumeFlowRate V_flow "Volume flow rate" annotation(Dialog);
  input Modelica.SIunits.ThermodynamicTemperature T "Temperature" annotation(Dialog);



  Interfaces.FluidPort port annotation (Placement(transformation(extent={{100,-10},
            {120,10}}), iconTransformation(extent={{100,-10},{120,10}})));
equation
  port.m_flow = -V_flow*medium.rho;
  port.h_outflow = medium.cp*T;

  annotation (
    preferredView="info",
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={Rectangle(lineColor = {28, 108, 200}, fillColor = {28, 108, 200}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}),Text(lineColor = {255, 255, 255}, fillColor = {28, 108, 200}, fillPattern = FillPattern.Solid, extent = {{-80, 60}, {80, -60}}, textString = "(V,T)")}),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Note that it is not necessary to specify if the boundary component is a source or a sink. The enthalpy is only relevant when the component acts as a source, i.e. when the mass flow leaves the component.</p>
<p>However, if you look in the equation section you&apos;ll se that the default direction of the mass flow is out of the component.</p>
</html>"));
end VolumeFlowBoundary_T;
