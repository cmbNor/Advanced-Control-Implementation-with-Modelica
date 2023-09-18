within MPC.Blocks;

block NloptUniOptiBlock
  //Parameters
  parameter Real x1Lb = -5.0 "Lower bound of x1";
  parameter Real x1Ub = 5.0 "Upper bound of x1";
  parameter Integer n = 1 "Number of optimization variables";
  parameter Real Tol = 1e-6 "Optimizer termination tolerance";
  parameter Integer max_iter = 100 "Maximum number of iterations for the optimizer";

  record OptimizationData
    Real x1R "Optimization variable";
    Real x1LbR "Lower bound of x1";
    Real x1UbR "Upper bound of x1";
    Real min_costR "Minimum value of the objective function after optimization";
    Integer nR "Number of optimization variables";
    Real TolR "Optimizer termination tolerance";
    Integer max_iterR "Maximum number of iterations for the optimizer";
  end OptimizationData;

  record Summary
    Real x1 "Optimization variable";
    Real min_cost "Minimum value of the objective function after optimization_";
  end Summary;

  //*_*_*_*_*_*_*_*_*_*_*_*_*---Constructor and destructor for the external object ---*_*_*_*_*_*_*_*_*_*_*_*_*_*

  class NloptUnivariateEO
    extends ExternalObject;
    // Constructor for the external object.

    function constructor
      output NloptUnivariateEO nloptUnivariateEO;
      
      // Initialize the data struct for shared data between C and Modelica.
      input OptimizationData optimizationDataInput(x1R = 0, x1LbR = x1Lb, x1UbR = x1Ub, min_costR = 0, nR = n, TolR = Tol, max_iterR = max_iter);

      // External C function call to initialize the NloptUniOptimize input.
      external "C" nloptUnivariateEO = initialiseUniNloptInput(optimizationDataInput.x1R, optimizationDataInput.x1LbR, optimizationDataInput.x1UbR, optimizationDataInput.min_costR, optimizationDataInput.nR, optimizationDataInput.TolR, optimizationDataInput.max_iterR) annotation(
        IncludeDirectory = "modelica://Resources/Include/",
        Include = "#include \"nloptUniOptimize.c\"");
    end constructor;

    // Destructor for the external object.
    function destructor
      input NloptUnivariateEO nloptUnivariateEO;
      // External C function call to close the NloptUniOptimize input and free up allocated memory space.
    
      external "C" closeNloptUniInput(nloptUnivariateEO) annotation(
        IncludeDirectory = "modelica://Resources/Include/",
        Include = "#include \"nloptUniOptimize.c\"");
    end destructor;
    annotation(
      Documentation(info = "<html><head></head><body><div><h1>Source code called in external C source code</h1></div><div><font size=\"5\"><br></font></div><div><font size=\"5\">#include &lt;stdio.h&gt;</font></div><div><font size=\"5\">#include &lt;stdlib.h&gt;</font></div><div><font size=\"5\">#include &lt;nlopt.h&gt;</font></div><div><br></div><div><font size=\"5\">//-------------------Declare the struct--------------------------</font></div><div><font size=\"5\">// Define the optimization object structure</font></div><div><font size=\"5\">&nbsp; &nbsp; typedef struct {</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">		</span>double x1; &nbsp; &nbsp; &nbsp; &nbsp;// Optimization variable</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">		</span>double x1Lb; &nbsp; &nbsp; &nbsp;// Lower bound of x1</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">		</span>double x1Ub; &nbsp; &nbsp; &nbsp;// Upper bound of x1</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">		</span>double min_cost; &nbsp;// Minimum value of the objective function after optimization</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">		</span>int n; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;// Number of optimization variables</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">		</span>double tol; &nbsp; &nbsp; &nbsp; // Termination tolerance</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">		</span>int<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>max_iter;<span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span> &nbsp;// Maximum number of iterations for the optimizer</font></div><div><font size=\"5\">&nbsp; &nbsp; } OptimizationData;</font></div><div><font size=\"5\"><br></font></div><div><font size=\"5\">//-------------------Initialise construct function--------------------------</font></div><div><font size=\"5\">void* initialiseUniNloptInput(double xl, double x1Lb, double x1Ub, double min_cost, int n, double tol, int max_iter)</font></div><div><font size=\"5\">{</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>// Check input</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>if (x1Lb &gt; x1Ub)</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">		</span>ModelicaError(\"x1Lb must be smaller than x1Ub\");</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>if (n &lt;= 0)</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">		</span>ModelicaError(\"n must be larger than 0\");</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>if (tol &lt;= 0)</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">		</span>ModelicaError(\"tol must be larger than 0\");</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>if (max_iter &lt;= 0)</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">		</span>ModelicaError(\"max_iter must be larger than 0\");</font></div><div><font size=\"5\"><br></font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>// Allocate memory for the optimization data input</font></div><div><font size=\"5\">&nbsp; &nbsp; OptimizationData* optimizationDataInput = malloc(sizeof(OptimizationData));</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>if (optimizationDataInput == NULL)</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">		</span>ModelicaError(\"Insufficient memory to allocate optimizationDataInput\");</font></div><div><font size=\"5\"><br></font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>// Initialize the optimization data input</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>optimizationDataInput-&gt;x1 = 0;</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>optimizationDataInput-&gt;x1Lb = x1Lb;</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>optimizationDataInput-&gt;x1Ub = x1Ub;</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>optimizationDataInput-&gt;min_cost = 0;</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>optimizationDataInput-&gt;n = n;</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>optimizationDataInput-&gt;tol = tol;</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>optimizationDataInput-&gt;max_iter = max_iter;</font></div><div><font size=\"5\"><br></font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>printf(\"Initialisation of input successful! 	\");</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>return (void *)optimizationDataInput;</font></div><div><font size=\"5\">}</font></div><div><font size=\"5\"><br></font></div><div><font size=\"5\">//-------------------Close and destruct --------------------------</font></div><div><font size=\"5\">void closeNloptUniInput(void *externalObject)</font></div><div><font size=\"5\">{</font></div><div><font size=\"5\">&nbsp; &nbsp; OptimizationData* optimizationDataInput = (OptimizationData *)externalObject;</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>if(optimizationDataInput != NULL)</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>{</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">		</span>free(optimizationDataInput);</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">		</span> &nbsp; &nbsp;printf(\"Destruction of input successful!	\");</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>}</font></div><div><font size=\"5\">}</font></div></body></html>"));
  end NloptUnivariateEO;

  //*_*_*_*_*_*_*_*_*_*_*_*_*---Modelica Function that calles the external function ---*_*_*_*_*_*_*_*_*_*_*_*_*_*
  // This function calls the external C function to perform univariate optimization.

  function nloptOptimizationFuncCall
    //Variables
    input NloptUnivariateEO nloptUnivariateEOInput;
    output OptimizationData optimizeOut;
    
    //Calling the external function
    external "C" mainFunctionUni(nloptUnivariateEOInput, optimizeOut) annotation(
      LibraryDirectory = "modelica://MPC/Resources/Library/win64/",
      Library = "nlopt",
      IncludeDirectory = "modelica://MPC/Resources/Include/",
      Include = "#include \"nloptUniOptimize.c\"");
  end nloptOptimizationFuncCall;

  //*_*_*_*_*_*_*_*_*_*_*_*_*---MainBlock()---*_*_*_*_*_*_*_*_*_*_*_*_*_*
  // Construct the records to store the optimization results.
  OptimizationData optimizeData "Record that stores the values from the external C code";
  // Create an instance of the NloptUnivariateEOInput class.
  NloptUnivariateEO nloptUnivariateEOInput = NloptUnivariateEO();
  Summary summary(x1 = optimizeData.x1R, min_cost = optimizeData.min_costR);
equation
// Call the 'nloptOptimizationFuncCall' function to perform univariate optimization.
  optimizeData = nloptOptimizationFuncCall(nloptUnivariateEOInput);
  annotation(
    Icon(graphics = {Bitmap(extent = {{-98, -98}, {98, 98}}, fileName = "modelica://MPC/Resources/Images/PlotOfUnivariateFunction.png")}),
    experiment(StartTime = 0, StopTime = 600, Tolerance = 1e-06, Interval = 1.2),
    Documentation(info = "<html><head></head><body><h1><span style=\"font-family: 'MS Shell Dlg 2';\">NLoptUniOptiBlock</span></h1><div><span style=\"font-family: 'MS Shell Dlg 2'; font-size: x-large;\">This block calculates a single optimum value based on a given function.</span></div><div><span style=\"font-family: 'MS Shell Dlg 2'; font-size: x-large;\"><br></span></div><div><div style=\"font-family: 'MS Shell Dlg 2'; font-size: 12px;\"><font size=\"5\">This block is based on the NLopt library that was installed with the use of vcpkg for windows.</font></div><div style=\"font-family: 'MS Shell Dlg 2'; font-size: 12px;\"><font size=\"5\"><br></font></div><div style=\"font-family: 'MS Shell Dlg 2'; font-size: 12px;\"><font size=\"5\">From the installed library the nlopt.dll was copied from the default location into the library directory for this package. In addition, the nlopt header file was copied into the Include folder.</font></div></div><div style=\"font-family: 'MS Shell Dlg 2'; font-size: 12px;\"><font size=\"5\"><br></font></div><div style=\"font-family: 'MS Shell Dlg 2'; font-size: 12px;\"><font size=\"5\">This block calls the constructor, destructor, and the optimization function from the external source code. The optimization object is presented in the C source code. The source code for the constructor and destructor is documented under the NloptUnivariateEOInput class in this package.</font></div><div style=\"font-family: 'MS Shell Dlg 2'; font-size: 12px;\"><h1 style=\"font-family: -webkit-standard;\">Plot of function</h1></div> 

<img src=\"modelica://MPC/Resources/Images/PlotOfUnivariateFunction.png\" width=\"600\" alt=\"plot\"> 

<h1>Source code called in external C source code</h1><div><br></div><div>
<p><font size=\"5\">The source code is available at&nbsp;<span>the
source code presented in a GitHub repository:</span></font><span><font size=\"5\">  </font><a href=\"https://github.com/cmbNor/Advanced-Control-Implementation-with-Modelica/blob/518b4cda868148e9f8656f3995b4f0fb207a1d98/MPC/Resources/Include/nloptUniOptimize.c\" style=\"font-size: 11pt;\"><u>Link to source code</u></a> </span></p>







<pre style=\"margin-top: 0px; margin-bottom: 0px;\"><!--EndFragment--></pre></div>




</body></html>"));
end NloptUniOptiBlock;
