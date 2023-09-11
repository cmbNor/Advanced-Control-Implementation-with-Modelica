within MPC.DuplicateComponents;

model NoiseGeneratorWithIO "Simple random noise generator"
  //Parameters
  parameter Real samplePeriode = 1.0;

//External connectors
  Modelica.Blocks.Interfaces.RealOutput noiseGenerator_out annotation(
    Placement(transformation(extent = {{100, -10}, {120, 10}})));
  Modelica.Blocks.Interfaces.RealInput range(start=0.25) annotation(
    Placement(visible = true, transformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-118, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));

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
    experiment(StartTime = 0, StopTime = 600, Tolerance = 1e-06, Interval = 1.2),
  Documentation(info = "<html><head></head><body><h1>NoiseGeneratorWithIO</h1><div><span style=\"font-family: Arial; font-size: x-large;\">This model is an extension of the base component with adaptations to that the model can be simulated in an environment together with other components.</span></div></body></html>"));
end NoiseGeneratorWithIO;
