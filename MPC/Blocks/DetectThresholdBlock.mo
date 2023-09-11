within MPC.Blocks;

block DetectThresholdBlock
  /*The archive file is compiled with the gcc command: <gcc -c -o libdetectThreshold.a detectThreshold.c> and placed in the Library folder. Prototypes from .c file is present in the .h file placed in Include folder.*/
  //*_*_*_*_*_*_*_*_*_*_*_*_*---External Object class---*_*_*_*_*_*_*_*_*_*_*_*_*_*
  // This class represents an external object that interacts with a C-based threshold detection library.

  class DetectThresholdExternalObject
    extends ExternalObject;
    // Constructor for the external object.

    function constructor
      input Real threshold;
      output DetectThresholdExternalObject detectThresholdExternalObject;
      // External C function call to initialize the threshold detection.
    
      external "C" detectThresholdExternalObject = initialiseDetectThreshold(threshold) annotation(
        Library = "detectThreshold",
        IncludeDirectory = "modelica://MPC/Resources/Include/",
        Include = "#include \"detectThreshold.h\"");
    end constructor;

    // Destructor for the external object.

    function destructor
      input DetectThresholdExternalObject detectThresholdExternalObject;
      // External C function call to close the threshold detection.
    
      external "C" closeDetectThreshold(detectThresholdExternalObject) annotation(
        Library = "detectThreshold",
        IncludeDirectory = "modelica://MPC/Resources/Include/",
        Include = "#include \"detectThreshold.h\"");
    end destructor;
  end DetectThresholdExternalObject;

  //*_*_*_*_*_*_*_*_*_*_*_*_*---Function to call external C code---*_*_*_*_*_*_*_*_*_*_*_*_*_*
  // This function calls the external C function that performs the threshold detection.

  function detectThreshold
    input Real u;
    input Modelica.Units.SI.Time simulationTime;
    input DetectThresholdExternalObject detectThresholdExternalObject;
    output Modelica.Units.SI.Time timeThresholdTriggerd;
    // External C function call to perform the threshold detection.
  
    external "C" timeThresholdTriggerd = detectThreshold(u, simulationTime, detectThresholdExternalObject) annotation(
      Library = "detectThreshold",
      IncludeDirectory = "modelica://MPC/Resources/Include/",
      Include = "#include \"detectThreshold.h\"");
  end detectThreshold;

  //*_*_*_*_*_*_*_*_*_*_*_*_*---Main()---*_*_*_*_*_*_*_*_*_*_*_*_*_*
  // Create an instance of the DetectThresholdExternalObject class with a threshold of 0.5.
  DetectThresholdExternalObject detectThresholdExternalObject = DetectThresholdExternalObject(threshold = 0.5);
  // Variables for simulation.
  Modelica.Units.SI.Time timeThresholdTriggered;
  Real u;
equation
// Simulate a sine input for 'u'.
  u = sin(time);
// Call the 'detectThreshold' function to perform threshold detection.
  timeThresholdTriggered = detectThreshold(u = u, simulationTime = time, detectThresholdExternalObject = detectThresholdExternalObject);
  annotation(
    Icon(graphics = {Bitmap(origin = {1, -1}, extent = {{-99, 99}, {99, -99}}, fileName = "modelica://MPC/Resources/Images/detectThresholdIcon.png")}),
    experiment(StartTime = 0, StopTime = 10, Tolerance = 1e-06, Interval = 0.02),
    Documentation(info = "<html><head></head><body><h1>DetectThresholdBlock</h1><div><br></div><div><font size=\"5\">The block is built based on an example presented on the web page of Claytex
<a href=\"https://www.claytex.com/tech-blog/external-object-example-detecting-initial-rising-edge/\">Claytex Example</a>.</font></div><div><font size=\"5\"><br></font></div><div><font size=\"5\">This example presents how to implement the Modelica external object, and how to use it for calling external C code. In this example the external source code was compiled into an archive file (.a) and the header (.h) file is used when calling the external function. The archive file was compiled with the use of GCC and the following command: &lt;</font><span style=\"color: rgb(0, 150, 0); font-family: 'Courier New';\"><font size=\"5\"><b>gcc -c -o libdetectThreshold.a detectThreshold.c</b></font></span><span style=\"font-size: x-large;\">&gt;. It is also possible to call the external functions straight from the source (.c) file.</span></div>
<div><font size=\"5\"><br></font></div><div><font size=\"5\">The block consists of a class that has both the constructor and destructor for the external object that calls constructor and destructor in the external C source code, a Modelica function to call the external function, and code that sets up an object based on the class and calls the Modelica function to calculate the results.</font></div><div><font size=\"5\"><br></font></div><h2><font size=\"5\">The external source code for the constructor, destructor and the threshold detection is presented below:</font></h2><div><font size=\"5\"><div>#include &lt;stdio.h&gt;</div><div>#include &lt;stdlib.h&gt;</div><div>#include \"detectThreshold.h\"</div><div><br></div><div>typedef struct{</div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>double threshold;</div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>int triggered;</div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>double triggeringTime;</div><div>}DetectThresholdStruct;</div><div><br></div><div><br></div><div>//Initialise construct the detect threshold function</div><div><br></div><div>void* initialiseDetectThreshold(double threshold)</div><div>{</div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>DetectThresholdStruct* detectThresholdStruct = (DetectThresholdStruct *)malloc(sizeof(DetectThresholdStruct));</div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>if (detectThresholdStruct == NULL)</div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">		</span>ModelicaError(\"Insufficient memory to allocate DetectThresholdStruct\");</div><div><br></div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>/* Initialise */</div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>detectThresholdStruct-&gt;threshold = threshold;</div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>detectThresholdStruct-&gt;triggered = 0;</div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>detectThresholdStruct-&gt;triggeringTime = 0;</div><div><br></div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>return (void *)detectThresholdStruct;</div><div>}</div><div><br></div><div>//Close destruct the detect threshold function</div><div><br></div><div>void closeDetectThreshold(void *externalObject)</div><div>{</div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>DetectThresholdStruct* detectThresholdStruct = (DetectThresholdStruct *)externalObject;</div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>if(detectThresholdStruct != NULL)</div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>{</div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">		</span>free(detectThresholdStruct);</div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>}</div><div>}</div><div><br></div><div>//Call the detect threshold function</div><div><br></div><div>double detectThreshold(double u, double t, void *externalObject)</div><div>{</div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>DetectThresholdStruct* detectThresholdStruct = (DetectThresholdStruct *)externalObject;</div><div><br></div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>/* If not triggered or simulation time is less than triggeringTime then check threshold*/</div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>if(detectThresholdStruct-&gt;triggered == 0 || t&lt;detectThresholdStruct-&gt;triggeringTime)</div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>{</div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">		</span>if(u &gt; detectThresholdStruct-&gt;threshold)</div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">		</span>{</div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">			</span>detectThresholdStruct-&gt;triggeringTime = t;</div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">			</span>detectThresholdStruct-&gt;triggered = 1;</div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">		</span>}</div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>}</div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>return detectThresholdStruct-&gt;triggeringTime;</div><div><br></div><div>}</div><div><br></div><div><br></div></font></div></body></html>"));
end DetectThresholdBlock;
