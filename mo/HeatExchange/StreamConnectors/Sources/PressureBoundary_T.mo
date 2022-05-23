within StreamConnectors.Sources;
model PressureBoundary_T
  "Boundary value component with fixed pressure and enthalpy"

  parameter Modelica.Thermal.FluidHeatFlow.Media.Medium medium=Modelica.Thermal.FluidHeatFlow.Media.Medium()
    "Medium in the component"
    annotation(choicesAllMatching=true);
    
  parameter Real p=1 "Pressure [bar]";
  parameter Real T=100
    "[T]";

  Interfaces.FluidPort port annotation (Placement(transformation(extent={{100,-10},
            {120,10}}), iconTransformation(extent={{100,-10},{120,10}})));
equation
  port.p = p;
  port.h_outflow = T*medium.cp;

  annotation (
    preferredView="text",
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={Rectangle(lineColor = {28, 108, 200}, fillColor = {28, 108, 200}, fillPattern = FillPattern.Solid, extent = {{-100, 100}, {100, -100}}),Text(lineColor = {255, 255, 255}, fillColor = {28, 108, 200}, fillPattern = FillPattern.Solid, extent = {{-80, 60}, {80, -60}}, textString = "(p,T)")}),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>Note that it is not necessary to specify if the boundary component is a source or a sink. The enthalpy is only relevant when the component acts as a source, i.e. when the mass flow leaves the component.</p>
</html>"));
end PressureBoundary_T;
