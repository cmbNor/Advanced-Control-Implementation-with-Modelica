within MPC.BaseComponents;
model AirHeaterTF "Model based on a transfer function"
  Modelica.Blocks.Continuous.TransferFunction transferFunction(b={0,3.5}, a={23,
        1}) annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Modelica.Blocks.Nonlinear.FixedDelay fixedDelay(delayTime=3)
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
equation
  connect(transferFunction.u, fixedDelay.y)
    annotation (Line(points={{-2,0},{-19,0}},   color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={Bitmap(extent={
              {-98,-122},{100,76}}, fileName=
              "modelica://MPC/Resources/Images/AirHeater.png"), Text(
          extent={{-98,98},{100,56}},
          lineColor={29,40,200},
          textString="Transfer function")}),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=600),
    Documentation(info= "<html><head></head><body><h1><span style=\"font-family: Arial; font-size: x-large;\">AirHeaterTF</span></h1><h1><span style=\"font-family: Arial; font-size: x-large;\">Model of the air heater built with the use of a transfer function.</span></h1><h1><span style=\"font-family: Arial; font-size: x-large;\">The implemented transfer function is displayed in equation below:</span></h1>
<p><img src=\"modelica://MPC/Resources/Images/equations/equation-9WlQjcTz.png\" alt=\"3.5/(23*s+1)*exp(3*s)\"></p>
</body></html>"));
end AirHeaterTF;
