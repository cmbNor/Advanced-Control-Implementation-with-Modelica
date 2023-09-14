within MPC.Blocks;
block extNoiseGeneratorBlock "Block that calls the external function NoiseGenerator"

// This code generates a random noise signal that is used as a
  // disturbance input to the system.
  // The noise signal has a magnitude in the range [-range, range].
  // The noise signal is generated as
  // result = 2 * range * (rand() - 0.5);
  // External parameters
  Modelica.Blocks.Interfaces.RealInput rangeInn(start = 0.25) annotation(
    Placement(transformation(extent = {{-140, -20}, {-100, 20}})));
  Modelica.Blocks.Interfaces.RealOutput y_ext annotation(
    Placement(transformation(extent = {{100, -10}, {120, 10}})));

record NoiseGeneratorData
  Real range "Range for noise generation";
  Real result "Resulting generated noise signal";
  end NoiseGeneratorData;

  //*_*_*_*_*_*_*_*_*_*_*_*_*---External Object class---*_*_*_*_*_*_*_*_*_*_*_*_*_*
  // This class represents an external object that interacts with a C-based noise generator.
  class NoiseGeneratorExternalObject
    extends ExternalObject;

// Constructor for the external object.
    function constructor
      output NoiseGeneratorExternalObject noiseGeneratorExternalObject;
      input NoiseGeneratorData noiseGeneratorData(range = rangeInn, result = 0.0);
      // External C function call to initialize the noise generator.
    
  external "C" noiseGeneratorExternalObject = initialiseNoiseGenerator(noiseGeneratorData.range,
                                                                                                        noiseGeneratorData.result)
      
      annotation(
        IncludeDirectory = "modelica://MPC/Resources/Include/",
        Include = "#include \"NoiseGenerator.c\"");
    end constructor;

  // Destructor for the external object.
    function destructor
      input NoiseGeneratorExternalObject noiseGeneratorExternalObject;
    
      external "C" closeNoiseGenerator(noiseGeneratorExternalObject) annotation(
        IncludeDirectory = "modelica://MPC/Resources/Include/",
        Include = "#include \"NoiseGenerator.c\"");
    end destructor;
  end NoiseGeneratorExternalObject;
  
//*_*_*_*_*_*_*_*---Modelica Function that calles the external function ---*_*_*_*_*_*_*_*
  // This function calls the external C function that generates the noise.
  function noiseGenerationCall
  input NoiseGeneratorExternalObject noiseGeneratorExternalObject;
  output NoiseGeneratorData noiseGeneratorData;
  // External C function call to generate the noise.
          external "C" NoiseGenerator(noiseGeneratorExternalObject,noiseGeneratorData) annotation(
      IncludeDirectory = "modelica://MPC/Resources/Include/",
      Include = "#include \"NoiseGenerator.c\"");
  end noiseGenerationCall;

  //*_*_*_*_*_*_*_*_*_*_*_*_*---MainBlock()---*_*_*_*_*_*_*_*_*_*_*_*_*_*
  // Create an instance ofthe NoiseGeneratorExternalObject class.
  NoiseGeneratorExternalObject noiseGeneratorExternalObject = NoiseGeneratorExternalObject();
  // Data structure to store the generated noise.
  NoiseGeneratorData noiseGeneratorData;

// Calculate the output based on the C function noiseGenerationCall.
algorithm
  noiseGeneratorData := noiseGenerationCall(noiseGeneratorExternalObject);
  y_ext := noiseGeneratorData.result;
  
  
  annotation(
    Icon(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}), graphics = {Bitmap(origin = {0, -1}, extent = {{-100, 99}, {100, -99}}, fileName = "modelica://MPC/Resources/Images/NoiseGenIcon.png")}),
    Diagram(coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}})),
    experiment(StartTime = 0, StopTime = 600, Tolerance = 1e-06, Interval = 1.2),
  Documentation(info = "<html><head></head><body><h1>extNoiseGeneratorBlock</h1><div><font size=\"5\">This block is based on calling external C code based on the Modelica external object procedure. The values are written from Modelica external object class into the constructor that is initiated within the C source code with a corresponding struct of the same format. This noise generator is extended from the one implemented in the functions folder by seeding the random generator with the current time a displayed in line 26 in the attached source code.</font></div><div><div style=\"font-family: 'MS Shell Dlg 2'; font-size: 12px;\"><font size=\"5\"><br></font></div><div style=\"font-family: 'MS Shell Dlg 2'; font-size: 12px;\"><font size=\"5\">The block consists of a class that has both the constructor and destructor for the external object that calls constructor and destructor in the external C source code, a Modelica function to call the external function, and code that sets up an object based on the class and calls the Modelica function to calculate the results. The block also has a record that store all the output data from the external source code.</font></div><div style=\"font-family: 'MS Shell Dlg 2'; font-size: 12px;\"><font size=\"5\"><br></font></div><h2 style=\"font-family: 'MS Shell Dlg 2';\"><font size=\"5\">The external source code for the constructor, destructor and the function call</font><span style=\"font-size: x-large;\">&nbsp;is presented below:</span></h2></div><div><font size=\"5\"><div>#include &lt;stdio.h&gt;</div><div>#include &lt;stdlib.h&gt;</div><div>#include &lt;time.h&gt;</div><div><br></div><div>//-------------------Declare the struct--------------------------</div><div>typedef struct{</div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>double range;</div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>double result;</div><div>}NoiseGeneratorData;</div><div><br></div><div><br></div><div>//-------------------Initialise construct function--------------------------</div><div>void* initialiseNoiseGenerator(double range, double result)</div><div>{</div><div><br></div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>// Allocate memory for the optimization data input</div><div>&nbsp; &nbsp; NoiseGeneratorData* noiseGeneratorDataInput = malloc(sizeof(NoiseGeneratorData));</div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>if (noiseGeneratorDataInput == NULL)</div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">		</span>ModelicaError(\"Insufficient memory to allocate noiseGeneratorDataInput\");</div><div><br></div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>// Initialize the optimization data input</div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>noiseGeneratorDataInput-&gt;range = range;</div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>noiseGeneratorDataInput-&gt;result = result;</div><div><br></div><div>&nbsp; &nbsp; // Seed the random number generator</div><div>&nbsp; &nbsp; srand(time(NULL));</div><div><br></div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>printf(\"Initialisation of input successful! 	\");</div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>return (void *)noiseGeneratorDataInput;</div><div>}</div><div><br></div><div>//-------------------Close and destruct --------------------------</div><div>void closeNoiseGenerator(void *externalObject)</div><div>{</div><div>&nbsp; &nbsp; NoiseGeneratorData* noiseGeneratorDataInput = (NoiseGeneratorData *)externalObject;</div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>if(noiseGeneratorDataInput != NULL)</div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>{</div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">		</span>free(noiseGeneratorDataInput);</div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">		</span> &nbsp; &nbsp;printf(\"Destruction of input successful!	\");</div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>}</div><div>}</div><div><br></div><div><br></div><div>void NoiseGenerator(void *externalObject, void *externalObject2)</div><div>{</div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>NoiseGeneratorData* noiseGeneratorDataInput = (NoiseGeneratorData *)externalObject;</div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>NoiseGeneratorData* noiseGeneratorOutput = (NoiseGeneratorData *)externalObject2;</div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span></div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>double random = 0;</div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>random = ((double)rand() / (double)RAND_MAX) - 0.5;</div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span></div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>//Only return the noise component</div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>noiseGeneratorOutput-&gt;result = random * noiseGeneratorDataInput-&gt;range;</div><div><br></div><div>}</div></font></div></body></html>"));
end extNoiseGeneratorBlock;
