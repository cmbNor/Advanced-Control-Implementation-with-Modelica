within MPC.Blocks;
block NloptAirHeaterSSmpc
    extends Modelica.Blocks.Icons.Block;

//*_*_*_*_*_*_*_*_*_*_*_*_*---Input and output connectors---*_*_*_*_*_*_*_*_*_*_*_*_*_*
  /*
    Modelica.Blocks.Interfaces.RealInput u annotation(
      Placement(visible = true, transformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-110, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
    Modelica.Blocks.Interfaces.RealOutput y annotation(
      Placement(visible = true, transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {108, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  
  */
 //*_*_*_*_*_*_*_*_*_*_*_*_*---Parameters---*_*_*_*_*_*_*_*_*_*_*_*_*_*
  parameter Real x1Lb =0.0 "Lower bound of x1";
  parameter Real x1Ub = 5.0 "Upper bound of x1";
  parameter Integer n = 11 "Number of optimization variables";
  parameter Real Tol = 1e-6 "Optimizer termination tolerance";

//*_*_*_*_*_*_*_*_*_*_*_*_*---Records---*_*_*_*_*_*_*_*_*_*_*_*_*_*

record ModelData "Record that is mirrored with the struct in the C source code"
  Real x1R "Optimization variable";
  Real x1LbR "Lower bound of x1";
  Real x1UbR "Upper bound of x1";
  Real min_costR "Minimum value of the objective function after optimization";
  Integer nR "Number of optimization variables";
  Real TolR "Optimizer termination tolerance";
end ModelData;

record Summary "Record to store most relevant data from simulation"
    Real x "Optimization variable";
    Real min_cost "Minimum value of the objective function after optimization";
end Summary;

//*_*_*_*_*_*_*_*_*_*_*_*_*---External Object class---*_*_*_*_*_*_*_*_*_*_*_*_*_*
class NloptAirHeaterMPCExternalObject
  extends ExternalObject;
 //Initialize the external object and reserve memory space
  function constructor
      output NloptAirHeaterMPCExternalObject nloptAirHeaterMPCExternalObject;
  //Initialize the data struct for shared data between C and Modelica
    
 external "C" nloptAirHeaterMPCExternalObject = initialiseNloptMPCInput()
      annotation (IncludeDirectory = "modelica://MPC/Resources/Include/",
                  Include="#include \"nloptAirHeaterMPC.c\"");
    
    end constructor;
  
//Close the external object and free up allocated memory space
  function destructor
      input NloptAirHeaterMPCExternalObject nloptAirHeaterMPCExternalObject;
      
  external "C" closeNloptMPCInput(nloptAirHeaterMPCExternalObject)
      annotation (IncludeDirectory = "modelica://MPC/Resources/Include/",
                  Include="#include \"nloptAirHeaterMPC.c\"");
    end destructor;
end NloptAirHeaterMPCExternalObject;


//*_*_*_*_*_*_*_*_*_*_*_*_*---Function to call external C code---*_*_*_*_*_*_*_*_*_*_*_*_*_*

function nloptOptimizationFuncCall
 //Variables
  input NloptAirHeaterMPCExternalObject nloptAirHeaterMPCExternalObject;
  input ModelData modelDataInn(x1R, x1LbR, x1UbR,  min_costR, nR, TolR);
  output ModelData modelDataOut(x1R, x1LbR, x1UbR,  min_costR, nR, TolR);
  
//Calling the external function
   external "C" mainFunctionMPC(nloptAirHeaterMPCExternalObject, modelDataInn, modelDataOut)
    annotation (LibraryDirectory="modelica://MPC/Resources/Library/win64/",
                Library = "nlopt",
                IncludeDirectory = "modelica://MPC/Resources/Include/",
                Include="#include \"nloptAirHeaterMPC.c\"");
end nloptOptimizationFuncCall;


//*_*_*_*_*_*_*_*_*_*_*_*_*---Main()---*_*_*_*_*_*_*_*_*_*_*_*_*_*
  //Construct the records
  NloptAirHeaterMPCExternalObject nloptAirHeaterMPCExternalObject = NloptAirHeaterMPCExternalObject();
  ModelData modelDataOut(x1R, x1LbR, x1UbR,  min_costR, nR, TolR) "Record that stores the values from the external C code";
  
  ModelData modelDataInn(x1R=0.0, x1LbR=x1Lb, x1UbR=x1Ub, min_costR=0, nR=n, TolR=Tol)"Record that store variables that are used in the external C code";
  
  Summary summary(x=modelDataOut.x1R, min_cost=modelDataOut.min_costR)"Record that summarizes the most relevant variables";

equation
  modelDataOut = nloptOptimizationFuncCall(nloptAirHeaterMPCExternalObject, modelDataInn);


annotation(
    Documentation);
end NloptAirHeaterSSmpc;
