within MPC.Blocks;
block NloptMultiOptiBlock

  //Parameters
  parameter Real x1Lb = -5.0 "Lower bound of x1";
  parameter Real x1Ub = 5.0 "Upper bound of x1";
  parameter Real x2Lb = -5.0 "Lower bound of x2";
  parameter Real x2Ub = 5.0 "Upper bound of x2";
  parameter Integer n = 2 "Number of optimization variables";
  parameter Real Tol = 1e-6 "Optimizer termination tolerance";
  parameter Integer max_iter = 101 "Maximum number of iterations for the optimizer";
 
  // Define record to store optimization data
  record OptimizationData
    Real x1R "Optimization variable";
    Real x1LbR "Lower bound of x1";
    Real x1UbR "Upper bound of x1";
    Real x2R "Optimization variable";
    Real x2LbR "Lower bound of x2";
    Real x2UbR "Upper bound of x2";
    Real min_costR "Minimum value of the objective function after optimization";
    Integer nR "Number of optimization variables";
    Real TolR "Optimizer termination tolerance";
    Integer max_iterR "Maximum number of iterations for the optimizer";
  end OptimizationData;

  // Define record to store optimization summary
  record Summary
    Real x1 "Optimization variable";
    Real x2 "Optimization variable";
    Real min_cost "Minimum value of the objective function after optimization";
  end Summary;

  //*_*_*_*_*_*_*_*_*_*_*_*_*---Constructor and destructor for the external object ---*_*_*_*_*_*_*_*_*_*_*_*_*_*
  // Define the external object class for NloptMultivariateEOInput

  class NloptMultivariateEOInput
    extends ExternalObject;

    // Constructor to initialize the external object and reserve memory space
    function constructor
      output NloptMultivariateEOInput nloptMultivariateEOInput;
      input OptimizationData optimizationData(x1R = 0.0, x1LbR = x1Lb, x1UbR = x1Ub, x2R = 0.0, x2LbR = x2Lb, x2UbR = x2Ub, min_costR = 0.0, nR = n, TolR = Tol, max_iterR = max_iter);
    
      external "C" nloptMultivariateEOInput = initialiseNloptInput(optimizationData.x1R, optimizationData.x1LbR, optimizationData.x1UbR, optimizationData.x2R, optimizationData.x2LbR, optimizationData.x2UbR, optimizationData.min_costR, optimizationData.nR, optimizationData.TolR, optimizationData.max_iterR) annotation(
        IncludeDirectory = "modelica://Resources/Include/",
        Include = "#include \"nloptMultiOptimize.c\"");
    end constructor;

    // Destructor to close the external object and free up allocated memory space
    function destructor
      input NloptMultivariateEOInput nloptMultivariateEOInput;
    
      external "C" closeNloptInput(nloptMultivariateEOInput) annotation(
        IncludeDirectory = "modelica://Resources/Include/",
        Include = "#include \"nloptMultiOptimize.c\"");
    end destructor;
    annotation(
      Documentation(info = "<html><head></head><body><div><br></div><div><br></div><div><h1>Source code called in external C source code</h1></div><div><br></div><div><div><font size=\"5\">//-------------------Declare the struct--------------------------</font></div><div><font size=\"5\">// Define the optimization object structure</font></div><div><font size=\"5\">&nbsp; &nbsp; typedef struct {</font></div><div><font size=\"5\">&nbsp; &nbsp; &nbsp; &nbsp; double x1; //Optimization variable</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">		</span>double x1Lb; //Lower bound of x1</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">		</span>double xlUb; //Upper bound of x1</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">		</span>double x2; //Optimization variable</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">		</span>double x2Lb; //Lower bound of x2</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">		</span>double x2Ub; //Upper bound of x2</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">		</span>double min_cost; //Minimum value of the objective function after optimization</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">		</span>int n; //Number of optimization variables</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">		</span>double tol; //Termination tolerance</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">		</span>int<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>max_iter;<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span> &nbsp;// Maximum number of iterations for the optimizer</font></div><div><font size=\"5\">&nbsp; &nbsp; } OptimizationData;</font></div><div><font size=\"5\"><br></font></div><div><font size=\"5\"><br></font></div><div><font size=\"5\">//-------------------Initialise construct function Input--------------------------</font></div><div><font size=\"5\">void* initialiseNloptInput(double x1, double x1Lb, double x1Ub,&nbsp;</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">							</span>double x2, double x2Lb, double x2Ub,</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">							</span>double min_cost, int n, double tol, int max_iter)</font></div><div><font size=\"5\">{</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>// Check input</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>if (tol &lt;= 0)</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">		</span>ModelicaError(\"The tolerance needs to be &gt; 0\");</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>if (max_iter &lt;= 0)</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">		</span>ModelicaError(\"The maximum number of iterations needs to be &gt; 0\");</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>if (x1Lb &gt;= x1Ub)</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">		</span>ModelicaError(\"The lower bound of x1 needs to be smaller than the upper bound\");</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>if (x2Lb &gt;= x2Ub)</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">		</span>ModelicaError(\"The lower bound of x2 needs to be smaller than the upper bound\");</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>if (n &lt;= 0)</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">		</span>ModelicaError(\"The number of variables needs to be &gt; 0\");</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>if (n != 2)</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">		</span>ModelicaError(\"This example only works for two variables\");</font></div><div><font size=\"5\"><br></font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>//Construnct the external object for data storage based on the struct</font></div><div><font size=\"5\">&nbsp; &nbsp; OptimizationData* optimizationDataInput = malloc(sizeof(OptimizationData));</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>if (optimizationDataInput == NULL)</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">		</span>ModelicaError(\"Insufficient memory to allocate optimizationDataInput\");</font></div><div><font size=\"5\"><br></font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>// Initialize the optimization data input</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>optimizationDataInput-&gt;x1 = x1;</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>optimizationDataInput-&gt;x1Lb = x1Lb;</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>optimizationDataInput-&gt;xlUb = x1Ub;</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>optimizationDataInput-&gt;x2 = x2;</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>optimizationDataInput-&gt;x2Lb = x2Lb;</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>optimizationDataInput-&gt;x2Ub = x2Ub;</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>optimizationDataInput-&gt;min_cost = min_cost;</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>optimizationDataInput-&gt;n = n;</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>optimizationDataInput-&gt;tol = tol;</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>optimizationDataInput-&gt;max_iter = max_iter;</font></div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\"><font size=\"5\">	</font></span></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>printf(\"Initialisation of input successful! 	\");</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>return (void *)optimizationDataInput;</font></div><div><font size=\"5\">}</font></div><div><font size=\"5\"><br></font></div><div><font size=\"5\">//-------------------Close and destruct the Input --------------------------</font></div><div><font size=\"5\">void closeNloptInput(void *externalObject)</font></div><div><font size=\"5\">{</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>OptimizationData* optimizationDataInput = (OptimizationData *)externalObject;</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>if(optimizationDataInput != NULL)</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>{</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">		</span>free(optimizationDataInput);</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">		</span> &nbsp; &nbsp;printf(\"Destruction of input successful!	\");</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>}</font></div><div><font size=\"5\">}</font></div></div></body></html>"));
  end NloptMultivariateEOInput;

  //*_*_*_*_*_*_*_*_*_*_*_*_*---Modelica Function that calles the external function ---*_*_*_*_*_*_*_*_*_*_*_*_*_*
  // Function to call the external nloptOptimizationFuncCall
  function nloptOptimizationFuncCall

    input NloptMultivariateEOInput nloptMultivariateEOInput;
    output OptimizationData optimizeOut;
  
    // Call the external C function "mainFunctionMulti" and pass nloptMultivariateEOInput and optimizeOut as arguments
    external "C" mainFunctionMulti(nloptMultivariateEOInput, optimizeOut) annotation(
      LibraryDirectory = "modelica://MPC/Resources/Library/win64/",
      Library = "nlopt",
      IncludeDirectory = "modelica://MPC/Resources/Include/",
      Include = "#include \"nloptMultiOptimize.c\"");
  end nloptOptimizationFuncCall;

  //*_*_*_*_*_*_*_*_*_*_*_*_*---MainBlock()---*_*_*_*_*_*_*_*_*_*_*_*_*_*
  // Main block where instances for the external object class are set up
 
  NloptMultivariateEOInput nloptMultivariateEOInput = NloptMultivariateEOInput();
 
  OptimizationData optimizeData "Record that stores the values from the external C code";
  
  Summary summary(x1 = optimizeData.x1R, x2 = optimizeData.x2R, min_cost = optimizeData.min_costR) "Record that summarizes the most relevant variables";

equation
// Call nloptOptimizationFuncCall and store the result in optimizeData
  optimizeData = nloptOptimizationFuncCall(nloptMultivariateEOInput);
  annotation(
    Documentation(info = "<html><head></head><body>

<h1 style=\"font-family: 'MS Shell Dlg 2';\">NLoptUMultiOptiBlock</h1><div><span style=\"font-family: 'MS Shell Dlg 2'; font-size: x-large;\">This block calculates a multiple optimum values based on a given function.</span></div><h1><div style=\"font-family: 'MS Shell Dlg 2'; font-size: 12px; font-weight: normal;\"><div><font size=\"5\">This block is based on the NLopt library that was installed with the use of vcpkg for windows.</font></div><div><font size=\"5\"><br></font></div><div><font size=\"5\">From the installed library the nlopt.dll was copied from the default location into the library directory for this package. In addition, the nlopt header file was copied into the Include folder.</font></div></div><div style=\"font-family: 'MS Shell Dlg 2'; font-size: 12px; font-weight: normal;\"><font size=\"5\"><br></font></div><div style=\"font-family: 'MS Shell Dlg 2'; font-size: 12px; font-weight: normal;\"><font size=\"5\">This block calls the constructor, destructor, and the optimization function from the external source code. The optimization object is presented in the C source code. The source code for the constructor and destructor is documented under the NloptMultivariateEOInput class in this package.</font></div><div style=\"font-family: 'MS Shell Dlg 2'; font-size: 12px; font-weight: normal;\"><font size=\"5\"><br></font></div></h1><h1>Plot of function</h1> 
 <img src=\"modelica://MPC/Resources/Images/PlotOfMultivariateFunction.png\" width=\"600\" alt=\"plot\"> 

<h1>Source code called in external C source code</h1><div><br></div><div>
<p><font size=\"5\">The source code is available at&nbsp;<span>the
source code presented in a GitHub repository:</span></font><span><font size=\"5\">  </font><a href=\"https://github.com/cmbNor/Advanced-Control-Implementation-with-Modelica/blob/518b4cda868148e9f8656f3995b4f0fb207a1d98/MPC/Resources/Include/nloptMultiOptimize.c\" style=\"font-size: 11pt;\"><u>Link to source code</u></a> </span></p>

<h1><br></h1></body></html>"),
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}}), graphics = {Bitmap(extent = {{-98, -96}, {98, 96}}, fileName = "modelica://MPC/Resources/Images/PlotOfMultivariateFunction.png")}),
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002));

end NloptMultiOptiBlock;
