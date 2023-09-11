within MPC.BaseComponents;
model ContinuousStirredReactor

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

// Variables
  // Manipulated input
  SI.Temperature Tj    "Jacket cooling temperature";

//Outputs
  SI.Temperature T      "Temperature of medium in reactor";
  SI.Concentration CA   "Concentration of reactant inseide the tank";

equation

if time>0 and time<100 then
      Tj = 280;
    elseif time>=100 and time<130 then
      Tj = 300;
    elseif time>=130 and time<200 then
      Tj = 305;
    elseif time>=200 and time<400 then
      Tj = 250;
    else
      Tj = 320;
end if;

der(T) = (F/V)*(Tf-T)-(delH/rhoCp)*k0*exp(-E/(R*T))*CA+((UA)/(rhoCp*V))*(Tj-T);
der(CA) = (F/V)*(CAf-CA)-k0*exp((-E)/(R*T))*CA;

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Bitmap(extent={{-118,-100},{116,56}}, fileName="modelica://MPC/Resources/Images/MixingTank.png"),
        Text(
          extent={{-100,100},{100,48}},
          lineColor={28,108,200},
          textString="CSTR")}), Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=600),
  Documentation(info = "<html><head></head><body><h1>ContinuousStirredReactor

</h1><div><font size=\"5\">The model is based on first principal equations presented in the book named Process Dynamics and Control [1].</font></div><div><font size=\"5\"><br></font></div><div><font size=\"5\">The figure below presents the basics of the model with the temperature of the tank jacket as controllable, and measurement of the reactant temperature and concentration as the outputs.</font></div><div><font size=\"5\"><br></font></div><div><br></div>
<img src=\"modelica://MPC/Resources/Images/CSTR.png\" width=\"600\" alt=\"CSTR\">











<div><br></div><div><!--StartFragment--><div data-style=\"ieee\" data-url=\"/csl/bibtex/28feb61544e6ab3777a22e117ea8df26a/gdmcbain?formatEmbedded=true\" id=\"csl-container\">  <div class=\"csl-entry\">
    <div class=\"csl-left-margin\"><br></div><div class=\"csl-left-margin\"><br></div><div class=\"csl-left-margin\"><br></div><div class=\"csl-left-margin\"><br></div><div class=\"csl-left-margin\"><font size=\"5\">[1] D. E. Seborg, D. A. Mellichamp, and T. F. Edgar, <i>Process Dynamics and Control</i>, Third. John Wiley &amp; Sons, 2011.</font></div>
  </div>
</div><!--EndFragment--></div></body></html>"));
end ContinuousStirredReactor;
