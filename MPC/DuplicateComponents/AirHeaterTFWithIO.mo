within MPC.DuplicateComponents;
model AirHeaterTFWithIO
  extends BaseComponents.AirHeaterTF;
  Modelica.Blocks.Interfaces.RealInput u_ext
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput T_out_ext
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealInput T_amb_ext annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={0,120})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{64,-10},{84,10}})));
equation
  connect(T_amb_ext, add.u1) annotation (Line(points={{0,120},{0,60},{40,60},{
          40,6},{62,6}},   color={0,0,127}));
  connect(add.y, T_out_ext) annotation (Line(points={{85,0},{110,0}},
                   color={0,0,127}));
  connect(transferFunction.y, add.u2)
    annotation (Line(points={{21,0},{40,0},{40,-6},{62,-6}}, color={0,0,127}));
  connect(fixedDelay.u, u_ext) annotation (Line(points={{-42,0},{-86,0},{-86,0},
          {-120,0}},    color={0,0,127}));
annotation(
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-6, Interval = 0.002),
  Documentation(info = "<html><head></head><body><h1>AirHeaterTFWithIO</h1><div><span style=\"font-family: Arial; font-size: x-large;\">This model is an extension of the base component with adaptations to that the model can be simulated in an environment together with other components.</span></div></body></html>"));
end AirHeaterTFWithIO;
