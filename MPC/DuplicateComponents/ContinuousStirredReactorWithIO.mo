within MPC.DuplicateComponents;
model ContinuousStirredReactorWithIO

// Import
  import Modelica.Units.SI;

// Constants
  constant Real R = 1.98589            "gas constant";

// Parameters
  parameter SI.Temperature V = 1.0      "Liquid volume of reactor";
  parameter Real F = 1.0                "Volumetric flow rate";
  parameter Real E = 11843.0            "Activation energy";
  parameter Real UA = 150.0             "U=overall heat transfer; A heat transfer area";
  parameter Real delH = -5960.0         "Heat of reaction per mole";
  parameter Real rhoCp = 500.0          "mass dencity and heat capacity";
  parameter Real k0 = 34930800.0        "Frequency factor";
  parameter SI.Temperature Tf = 298.15  "Temperature of liquid";
  parameter Real CAf = 10               "Concentration";

//Inputs and outputs
  Modelica.Blocks.Interfaces.RealInput Tj_ext(start=298.15, fixed = false) "Jacket coolant temperature"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput T_ext "Temperature of reactant"
    annotation (Placement(transformation(extent={{100,50},{120,70}})));
  Modelica.Blocks.Interfaces.RealOutput CA_ext "Concentration of reactant"
    annotation (Placement(transformation(extent={{100,-70},{120,-50}})));

initial equation
    T_ext = 311.267;
    CA_ext = 8.5695;

equation
der(T_ext) = (F/V)*(Tf-T_ext)-(delH/rhoCp)*k0*exp(-E/(R*T_ext))*CA_ext+((UA)/(rhoCp*V))*(Tj_ext-T_ext);

der(CA_ext) = (F/V)*(CAf-CA_ext)-k0*exp((-E)/(R*T_ext))*CA_ext;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Bitmap(extent={{-116,-98},{116,58}},  fileName="modelica://MPC/Resources/Images/MixingTank.png"),
        Text(
          extent={{-100,100},{100,48}},
          lineColor={28,108,200},
          textString="CSTR")}), Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime = 50, StartTime = 0, Tolerance = 1e-06, Interval = 0.1),
  Documentation(info = "<html><head></head><body><h1>ContinuousStirredReactorWithIO</h1><div><span style=\"font-family: Arial; font-size: x-large;\">This model is an extension of the base component with adaptations to that the model can be simulated in an environment together with other components.</span></div></body></html>"));
end ContinuousStirredReactorWithIO;
