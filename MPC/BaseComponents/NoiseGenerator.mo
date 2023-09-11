within MPC.BaseComponents;
model NoiseGenerator "Simple random noise generator"

  //Parameters
  parameter Real range = 0.5;
  parameter Real samplePeriode = 1.0;

  //External connectors
  Modelica.Blocks.Interfaces.RealOutput noiseGenerator_out annotation(
    Placement(transformation(extent = {{100, -10}, {120, 10}})));

initial equation
  noiseGenerator_out = Functions.extNoiseGenerator(range);

equation
  when sample(0, samplePeriode) then
    noiseGenerator_out = Functions.extNoiseGenerator(range);
  end when;

  annotation(
    Placement(transformation(extent = {{-140, -20}, {-100, 20}})),
    Icon(coordinateSystem(preserveAspectRatio = false), graphics = {Bitmap(extent = {{-96, -96}, {96, 96}}, fileName = "modelica://MPC/Resources/Images/SignalNoise.jpg"), Rectangle(extent = {{-100, 48}, {100, -48}}, lineColor = {28, 108, 200}), Text(extent = {{-100, 100}, {100, 48}}, lineColor = {28, 108, 200}, textString = "Noise Generator")}),
    Diagram(coordinateSystem(preserveAspectRatio = false)),
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002),
  Documentation(info = "<html><head></head><body><h1>NoiseGenerator</h1><div><font size=\"5\">The noise generator model calls the Modelica function named &lt;&lt;extNoiseGenerator&gt;&gt; that again calls an external function written in C. This implementation does not use the Modelica external object standard for calling external source code and by this does not allocate any memory for the computation.</font></div><div><br></div></body></html>"));
end NoiseGenerator;
