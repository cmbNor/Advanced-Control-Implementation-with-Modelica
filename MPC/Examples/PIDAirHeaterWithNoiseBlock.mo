within MPC.Examples;

model PIDAirHeaterWithNoiseBlock
  extends Modelica.Icons.Example;
  DuplicateComponents.AirHeaterWithIO airHeaterTextWithIO annotation(
    Placement(transformation(extent = {{60, 0}, {80, 20}})));
  Modelica.Blocks.Continuous.LimPID PID(controllerType = Modelica.Blocks.Types.SimpleController.PI, k = 1.56, Ti = 12, Td = 1, yMax = 5, yMin = 0, initType = Modelica.Blocks.Types.Init.NoInit) annotation(
    Placement(transformation(extent = {{-40, 0}, {-20, 20}})));
  Modelica.Blocks.Sources.Step AmbientTemperature(height = -2, offset = 20, startTime = 100) annotation(
    Placement(transformation(extent = {{-20, 40}, {0, 60}})));
  Modelica.Blocks.Sources.Step SetPoint(height = 5, offset = 20, startTime = 200) annotation(
    Placement(transformation(extent = {{-80, 0}, {-60, 20}})));
  Modelica.Blocks.Math.Add add(k1 = 1, k2 = 1) annotation(
    Placement(transformation(extent = {{20, -36}, {0, -16}})));
  Modelica.Blocks.Sources.Constant const(k = 0.25) annotation(
    Placement(transformation(extent = {{96, -50}, {76, -30}})));
  MPC.DuplicateComponents.NoiseGeneratorWithIO noiseGeneratorWithIO annotation(
    Placement(visible = true, transformation(origin = {48, -40}, extent = {{10, -10}, {-10, 10}}, rotation = 0)));
equation
  connect(AmbientTemperature.y, airHeaterTextWithIO.T_amb_ext) annotation(
    Line(points = {{1, 50}, {70, 50}, {70, 22}}, color = {0, 0, 127}));
  connect(PID.u_s, SetPoint.y) annotation(
    Line(points = {{-42, 10}, {-59, 10}}, color = {0, 0, 127}));
  connect(add.y, PID.u_m) annotation(
    Line(points = {{-1, -26}, {-30, -26}, {-30, -2}}, color = {0, 0, 127}));
  connect(airHeaterTextWithIO.T_Out_ext, add.u1) annotation(
    Line(points = {{81.8, 10.2}, {90, 10.2}, {90, -20}, {22, -20}}, color = {0, 0, 127}));
  connect(PID.y, airHeaterTextWithIO.u_ext) annotation(
    Line(points = {{-18, 10}, {58, 10}}, color = {0, 0, 127}, pattern = LinePattern.Solid));
  connect(noiseGeneratorWithIO.range, const.y) annotation(
    Line(points = {{60, -40}, {74, -40}}, color = {0, 0, 127}, pattern = LinePattern.Solid));
  connect(noiseGeneratorWithIO.noiseGenerator_out, add.u2) annotation(
    Line(points = {{38, -40}, {28, -40}, {28, -32}, {24, -32}}, color = {0, 0, 127}, pattern = LinePattern.Solid));
  annotation(
    Icon(coordinateSystem(preserveAspectRatio = false)),
    Diagram(coordinateSystem(preserveAspectRatio = false)),
    experiment(StopTime = 600, StartTime = 0, Tolerance = 1e-06, Interval = 1.2),
  Documentation(info = "<html><head></head><body><h1>PIDAirHeaterWithNoiseBlock</h1><div><font size=\"5\">Extension of the PIDAirHeater model where there is included a noise generator based on a external function call to the sudo random rand() funtion in C.</font></div></body></html>"));
end PIDAirHeaterWithNoiseBlock;
