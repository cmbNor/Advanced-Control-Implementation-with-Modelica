within MPC.BaseComponents;
model AirHeater "USN air heater"

// Import
  import Modelica.Units.SI;
  import Modelica.Units.NonSI;

// Constants
  constant SI.Time T_CONST = 23.0              "Time constant";
  constant SI.Time T_DELAY = 3.0               "Time delay";
  constant Real Kh(unit="C/V") = 3.5           "Heater gain";

// Parameters
  parameter NonSI.Temperature_degC T_amb = 20  "Ambient/Room temperature";
  parameter SI.Voltage u(min=0, max=5) = 1     "Control Signal";

// Variables
  NonSI.Temperature_degC T_Out(min=T_amb)      "Temperature output from heater";

initial equation
  T_Out = T_amb;

equation
  T_CONST * der(T_Out) = (T_amb - T_Out) + Kh * delay(u, 3);

  annotation(experiment(StartTime=0, StopTime=500),
              Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Bitmap(extent={{-98,-122},{100,76}},   fileName=
              "modelica://MPC/Resources/Images/AirHeater.png"), Text(
          extent={{-100,100},{100,54}},
          lineColor={29,40,200},
          textString="EQUATION")}),                              Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info= "<html><head></head><body><h1><font size=\"5\">AirHeater</font></h1>
<p><font size=\"5\">The model was constructed based on a first principal model of a USN air heater.</font></p>
<p><font size=\"5\">More information about the air heater and the parameters can be found <a href=\"http://techteach.no/air_heater/\">here</a>.</font></p>
</body></html>"));
end AirHeater;
