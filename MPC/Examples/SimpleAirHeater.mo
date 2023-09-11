within MPC.Examples;
model SimpleAirHeater
  extends Modelica.Icons.Example;
  DuplicateComponents.AirHeaterWithIO airHeaterTextWithIO(u_ext(fixed = false))
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.Constant EnvironmentalTemperature(k=20)
    annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
  Modelica.Blocks.Sources.Step ControlSignal(
    height= 2,
    offset=1,
    startTime=200)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
equation
  connect(EnvironmentalTemperature.y, airHeaterTextWithIO.T_amb_ext)
    annotation (Line(points={{-39,50},{0,50},{0,12}}, color={0,0,127}));
  connect(airHeaterTextWithIO.u_ext, ControlSignal.y)
    annotation (Line(points={{-12,0},{-39,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime = 600, StartTime = 0, Tolerance = 1e-06, Interval = 1.2),
  Documentation(info = "<html><head></head><body><h1>SimpleAirHeater</h1><div><br></div><div><font size=\"5\">Air heater model in its simplest form with a control signal and environmental temperature as inputs, and the air heater temperature as output.</font></div></body></html>"));
end SimpleAirHeater;
