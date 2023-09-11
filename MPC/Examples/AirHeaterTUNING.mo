within MPC.Examples;
model AirHeaterTUNING
  extends Modelica.Icons.Example;
  DuplicateComponents.AirHeaterWithIO airHeaterTextWithIO(u_ext(fixed=false))
    annotation (Placement(transformation(extent={{40,-20},{60,0}})));
  Modelica.Blocks.Sources.Step AmbientTemperature(
    height=0,
    offset=20,
    startTime=0)
    annotation (Placement(transformation(extent={{-20,20},{0,40}})));
  Modelica.Blocks.Sources.Step Reference(
    height=4.5,
    offset=0,
    startTime=200)
    annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
equation
  connect(AmbientTemperature.y, airHeaterTextWithIO.T_amb_ext)
    annotation (Line(points={{1,30},{50,30},{50,2}},  color={0,0,127}));
  connect(Reference.y, airHeaterTextWithIO.u_ext)
    annotation (Line(points={{-39,-10},{38,-10}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime = 600, StartTime = 0, Tolerance = 1e-06, Interval = 1.2),
  Documentation(info = "<html><head></head><body><h1>AirHeaterTuning</h1><div><br></div><div><font face=\"Arial\" size=\"5\">Simulation used to gather the air heater dynamics used to manually calculate the PID parameters from the plotted response.</font></div></body></html>"));
end AirHeaterTUNING;
