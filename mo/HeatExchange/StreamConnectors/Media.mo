within StreamConnectors;

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
    extends Modelica.Thermal.FluidHeatFlow.Media.Medium(rho = 0.9825, cp = 1009.8, cv = 720, lamda = 0.0264, nue = 16.3E-6);
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
