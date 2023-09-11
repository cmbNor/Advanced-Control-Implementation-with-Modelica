within MPC.DuplicateComponents;
model AirHeaterSSwithIO
  Modelica.Blocks.Continuous.StateSpace continuousStateSpace(
    A=[-36.7101449275362,-6.6159420289855,-7.65536231884058,6.2616038647343,
        3.76414685990339,-1.67716663446055,-0.545042619431027,1.23348130971551,
        1.7557135229916,1.20944823522395,-0.0493652340907831; 100,-2.07301986981474e-15,
        4.06661948586751e-15,3.98523825450699e-15,-9.13593748715871e-16,-2.04617452131031e-16,
        1.19055383585877e-15,6.01421562056504e-15,-1.27754505831381e-14,
        1.64348744598105e-14,8.12615624652681e-15; 0,10,1.33907987224807e-15,
        3.74351322127406e-15,6.13454452543879e-16,-6.03587750116804e-16,
        1.30065236284308e-16,1.6536679733558e-16,-1.2554487342403e-15,
        2.20807857485831e-15,2.13198180336727e-15; 0,0,-10,-3.84508713473349e-15,
        5.094923604681e-15,3.82472374016006e-15,-1.71513254255834e-15,
        4.70843074561815e-16,7.62416120957997e-16,-1.06691916701129e-15,-1.45351007807018e-15;
        0,0,0,10,2.08169146111602e-16,-9.35002420625499e-16,-1.15529698271845e-16,
        -3.38554043069654e-15,2.32422876810713e-15,-2.94266352611298e-15,-9.31849163678325e-16;
        0,0,0,0,-10,3.06865151449365e-15,-1.81327591545141e-15,-2.05996035292852e-15,
        -2.75172994938553e-15,-1.38840088216141e-15,-1.48048579712227e-15; 0,0,
        0,0,0,10,-1.18103320538715e-15,-2.90984616406911e-15,-4.14378666028816e-15,
        8.69571204726832e-16,6.25332591048254e-16; 0,0,0,0,0,0,-1,-2.00496458124039e-16,
        -1.18678414193152e-15,5.12781852892598e-16,4.35799679317935e-17; 0,0,0,
        0,0,0,0,0.999999999999998,7.07260241014436e-16,-3.5975729713928e-15,-1.33416436034521e-15;
        0,0,0,0,0,0,0,0,1,-2.66063492386505e-15,-1.73801627225452e-16; 0,0,0,0,
        0,0,0,0,0,-1,2.99760216648792e-15],
    B=[0.1; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0],
    C=[1.52173913043478,-0.557971014492755,1.00434782608695,1.16057971014493,-0.947806763285022,
        -0.568684057971015,0.252748470209339,0.818423617820717,-1.84145314009662,
        2.59167478976562,1.72778319317706],
    D=[0],
    initType=Modelica.Blocks.Types.Init.NoInit)
    annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
  Modelica.Blocks.Discrete.StateSpace discreteStateSpace1(
    A=[0.632898550724638,-0.066159420289855,-0.0765536231884058,
        0.062616038647343,0.0376414685990339,-0.0167716663446055,-0.00545042619431027,
        0.0123348130971551,0.017557135229916,0.0120944823522395,-0.000493652340907831;
        1,1,4.06661948586751e-17,3.98523825450699e-17,-9.13593748715871e-18,-2.04617452131031e-18,
        1.19055383585878e-17,6.01421562056504e-17,-1.27754505831381e-16,
        1.64348744598105e-16,8.12615624652681e-17; 0,0.1,1,3.74351322127407e-17,
        6.13454452543879e-18,-6.03587750116804e-18,1.30065236284308e-18,
        1.6536679733558e-18,-1.2554487342403e-17,2.20807857485831e-17,
        2.13198180336727e-17; 0,0,-0.1,1,5.094923604681e-17,
        3.82472374016006e-17,-1.71513254255834e-17,4.70843074561815e-18,
        7.62416120957997e-18,-1.06691916701129e-17,-1.45351007807018e-17; 0,0,0,
        0.1,1,-9.35002420625499e-18,-1.15529698271845e-18,-3.38554043069654e-17,
        2.32422876810713e-17,-2.94266352611298e-17,-9.31849163678325e-18; 0,0,0,
        0,-0.1,1,-1.81327591545141e-17,-2.05996035292852e-17,-2.75172994938553e-17,
        -1.38840088216141e-17,-1.48048579712227e-17; 0,0,0,0,0,0.1,1,-2.90984616406911e-17,
        -4.14378666028816e-17,8.69571204726832e-18,6.25332591048254e-18; 0,0,0,
        0,0,0,-0.01,1,-1.18678414193152e-17,5.12781852892598e-18,
        4.35799679317935e-19; 0,0,0,0,0,0,0,0.00999999999999998,1,-3.5975729713928e-17,
        -1.33416436034521e-17; 0,0,0,0,0,0,0,0,0.01,1,-1.73801627225452e-18; 0,
        0,0,0,0,0,0,0,0,-0.01,1],
    B=[0.001; 0; 0; 0; 0; 0; 0; 0; 0; 0; 0],
    C=[1.52173913043478,-0.557971014492755,1.00434782608695,1.16057971014493,-0.947806763285022,
        -0.568684057971015,0.252748470209339,0.818423617820717,-1.84145314009662,
        2.59167478976562,1.72778319317706],
    D=[0],
    samplePeriod=0.01)
    annotation (Placement(transformation(extent={{-40,-60},{-20,-40}})));
  Modelica.Blocks.Interfaces.RealInput u_ext
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput T_out_ext_cont
    annotation (Placement(transformation(extent={{100,40},{120,60}})));
  Modelica.Blocks.Interfaces.RealInput T_amb_ext annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={0,120})));
  Modelica.Blocks.Interfaces.RealOutput T_out_ext_discrete
    annotation (Placement(transformation(extent={{100,-60},{120,-40}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{40,40},{60,60}})));
  Modelica.Blocks.Math.Add add1
    annotation (Placement(transformation(extent={{40,-60},{60,-40}})));
equation
  connect(continuousStateSpace.u[1], u_ext) annotation (Line(points={{-42,50},{
          -72,50},{-72,0},{-120,0}}, color={0,0,127}));
  connect(discreteStateSpace1.u[1], u_ext) annotation (Line(points={{-42,-50},{
          -72,-50},{-72,0},{-120,0}}, color={0,0,127}));
  connect(T_out_ext_cont, add.y)
    annotation (Line(points={{110,50},{61,50}}, color={0,0,127}));
  connect(continuousStateSpace.y[1], add.u2) annotation (Line(points={{-19,50},
          {-10,50},{-10,44},{38,44}}, color={0,0,127}));
  connect(T_amb_ext, add.u1)
    annotation (Line(points={{0,120},{0,56},{38,56}}, color={0,0,127}));
  connect(add1.y, T_out_ext_discrete)
    annotation (Line(points={{61,-50},{110,-50}}, color={0,0,127}));
  connect(discreteStateSpace1.y[1], add1.u2) annotation (Line(points={{-19,-50},
          {-10,-50},{-10,-56},{38,-56}}, color={0,0,127}));
  connect(T_amb_ext, add1.u1)
    annotation (Line(points={{0,120},{0,-44},{38,-44}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={Bitmap(extent={
              {-98,-122},{100,76}}, fileName=
              "modelica://MPC/Resources/Images/AirHeater.png"), Text(
          extent={{-98,98},{100,56}},
          lineColor={29,40,200},
          textString="State Space")}),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info= "<html><head></head><body><h1><span style=\"font-family: Arial; font-size: x-large;\">AirHeaterSSwithIO</span></h1><p><span style=\"font-family: Arial; font-size: x-large;\">This model is an extension of the base component with adaptations to that the model can be simulated in an environment together with other components.</span></p><p><br></p><p><font size=\"5\">The discrete state space model is sampled with a sample rate of 0.01 and euler as method.</font></p>
</body></html>"),
  experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-6, Interval = 0.002));
end AirHeaterSSwithIO;
