within MPC.DuplicateComponents;
model AirHeaterWithIO "USN air heater - www.http://techteach.no/air_heater/"

// Import
  import Modelica.Units.SI;
  import Modelica.Units.NonSI;

// Constants
  constant SI.Time T_CONST = 23.0              "Time constant";
  constant SI.Time T_DELAY = 3.0               "Time delay";
  constant Real Kh(unit="C/V") = 3.5           "Heater gain";

// Inputs and outputs
  Modelica.Blocks.Interfaces.RealInput u_ext(start=0, fixed = true)
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput T_amb_ext(start=20, fixed = true) annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={0,120})));

  Modelica.Blocks.Interfaces.RealOutput T_Out_ext
    annotation (Placement(transformation(extent={{100,-16},{136,20}})));

initial equation
  T_Out_ext = T_amb_ext;


equation
  T_CONST * der(T_Out_ext) = (T_amb_ext - T_Out_ext) + Kh * delay(u_ext, 3);

  annotation(experiment(StartTime=0, StopTime=600, Tolerance = 1e-06, Interval = 1.2),
              Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,100},{100,-100}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Bitmap(extent={{-100,-118},{100,84}}, fileName=
              "modelica://MPC/Resources/Images/AirHeater.png"),
        Text(
          extent={{-98,100},{98,58}},
          pattern=LinePattern.None,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineColor={29,40,200},
          textString="Equation")}),                              Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html><head></head><body><h1><font face=\"Arial\">AirHeaterWithIO</font></h1><div><font face=\"Arial\" size=\"5\">This model is an extension of the base component with adaptations to that the model can be simulated in an environment together with other components.</font></div>
</body></html>"));
end AirHeaterWithIO;
