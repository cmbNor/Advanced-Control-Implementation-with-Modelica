within MPC.Examples;
model SimpleCSTR
  extends Modelica.Icons.Example;
  DuplicateComponents.ContinuousStirredReactorWithIO
    continuousStirredReactorWithIO
    annotation (Placement(transformation(extent={{0,0},{20,20}})));
  Modelica.Blocks.Sources.Step step(
    height=20,
    offset=298.15,
    startTime=100)
    annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
equation
  connect(continuousStirredReactorWithIO.Tj_ext, step.y)
    annotation (Line(points={{-2,10},{-39,10}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime = 200, StartTime = 0, Tolerance = 1e-06, Interval = 0.4),
  Documentation(info = "<html><head></head><body><h1>SimpleCSTR</h1><div><font size=\"5\">Step change to the cstr model.</font></div></body></html>"));
end SimpleCSTR;
