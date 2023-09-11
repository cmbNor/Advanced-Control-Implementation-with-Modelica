within MPC.Examples;

model PIDAirHeater
  extends Modelica.Icons.Example;
  DuplicateComponents.AirHeaterWithIO airHeaterTextWithIO annotation(
    Placement(transformation(extent = {{40, -20}, {60, 0}})));
  Modelica.Blocks.Continuous.LimPID PID(Td = 0, Ti = 12, controllerType = Modelica.Blocks.Types.SimpleController.PI, initType = Modelica.Blocks.Types.Init.InitialOutput, k = 1.56, yMax = 5, yMin = 0) annotation(
    Placement(transformation(extent = {{-20, -20}, {0, 0}})));
  Modelica.Blocks.Sources.Step AmbientTemperature(height = -2, offset = 20, startTime = 100) annotation(
    Placement(transformation(extent = {{-20, 20}, {0, 40}})));
  Modelica.Blocks.Sources.Step Reference(height = 5, offset = 20, startTime = 200) annotation(
    Placement(visible = true, transformation(origin = {0, 0}, extent = {{-60, -20}, {-40, 0}}, rotation = 0)));
equation
  connect(airHeaterTextWithIO.u_ext, PID.y) annotation(
    Line(points = {{38, -10}, {1, -10}}, color = {0, 0, 127}));
  connect(airHeaterTextWithIO.T_Out_ext, PID.u_m) annotation(
    Line(points = {{61.8, -9.8}, {76, -9.8}, {76, -40}, {-10, -40}, {-10, -22}}, color = {0, 0, 127}));
  connect(AmbientTemperature.y, airHeaterTextWithIO.T_amb_ext) annotation(
    Line(points = {{1, 30}, {50, 30}, {50, 2}}, color = {0, 0, 127}));
  connect(PID.u_s, Reference.y) annotation(
    Line(points = {{-22, -10}, {-39, -10}}, color = {0, 0, 127}, pattern = LinePattern.Solid));
  annotation(
    Icon(coordinateSystem(preserveAspectRatio = false)),
    Diagram(coordinateSystem(preserveAspectRatio = false)),
    experiment(StopTime = 600),
    Documentation(info = "<html><head></head><body><h1>PIDAirHeater</h1><div><font size=\"5\">Air heater connected to a PID controller for feed-back control.</font></div><div><font size=\"5\"><br></font></div><div><font size=\"5\">The controller is in PI mode with the following paramters:</font></div><div><font size=\"5\">k = 1.56</font></div><div><font size=\"5\">Ti = 12</font></div><div><font size=\"5\"><br></font></div><div><font size=\"5\">Step change in environmental temperature at t=100[s]</font></div><div><font size=\"5\">Step change in setpoint at t=200[s]</font></div><div><font size=\"5\"><br></font></div></body></html>"));
end PIDAirHeater;
