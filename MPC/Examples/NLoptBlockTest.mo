within MPC.Examples;
model NLoptBlockTest
  extends Modelica.Icons.Example;
  MPC.Blocks.NloptUniOptiBlock nloptUniOptiBlock(x1Lb = -5.0, x1Ub = 5.0)  annotation(
    Placement(visible = true, transformation(origin = {20, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  MPC.Blocks.NloptMultiOptiBlock nloptMultiOptiBlock(max_iter = 500,x1Lb = -5, x1Ub = 5, x2Lb = -5, x2Ub = 5)  annotation(
    Placement(visible = true, transformation(origin = {-14, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  MPC.Blocks.NLoptVersionBlock nLoptVersionBlock annotation(
    Placement(visible = true, transformation(origin = {-52, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation

annotation(
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-6, Interval = 0.002),
  Documentation(info = "<html><head></head><body><p><font size=\"5\">Simulation of all the NLopt based blocks built in one and same model.</font></p><br></body></html>"));
end NLoptBlockTest;
