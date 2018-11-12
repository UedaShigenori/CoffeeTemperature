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
  
    constant IdealGases.Common.DataRecord N2(
      name="N2",
      MM=0.0280134,
      Hf=0,
      H0=309498.4543111511,
      Tlimit=1000,
      alow={22103.71497,-381.846182,6.08273836,-0.00853091441,1.384646189e-005,-9.62579362e-009,
          2.519705809e-012},
      blow={710.846086,-10.76003744},
      ahigh={587712.406,-2239.249073,6.06694922,-0.00061396855,1.491806679e-007,-1.923105485e-011,
          1.061954386e-015},
      bhigh={12832.10415,-15.86640027},
      R=296.8033869505308);
  
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
