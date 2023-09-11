within MPC.Blocks;

block NLoptVersionBlock
  //extends Modelica.Blocks.Icons.Block;

  record NloptVersion2Struct "Record to store data from calling external C function to read nlopt version"
    Integer major;
    Integer minor;
    Integer bugfix;
    Integer counter;
  end NloptVersion2Struct;

  //*_*_*_*_*_*_*_*_*_*_*_*_*---Constructor and destructor for the external object ---*_*_*_*_*_*_*_*_*_*_*_*_*_*
  // This class represents an external object that interacts with the NLopt library to read its version.

  class NLoptVersionExternalObject "Class that defines the constructor and destructor for calling external object"
    extends ExternalObject;
    // Constructor for the external object.

    function constructor
      output NLoptVersionExternalObject nLoptVersionExternalObject;
      input NloptVersion2Struct nloptVersion2Struct(major = 0, minor = 0, bugfix = 0, counter = 0);
      // External C function call to initialize the NLopt version reading.
    
      external "C" nLoptVersionExternalObject = initialiseNloptVersion(nloptVersion2Struct.major, nloptVersion2Struct.minor, nloptVersion2Struct.bugfix, nloptVersion2Struct.counter) annotation(
        IncludeDirectory = "modelica://MPC/Resources/Include/",
        Include = "#include \"nloptVersion.c\"");
    end constructor;

    // Destructor for the external object.

    function destructor
      input NLoptVersionExternalObject nLoptVersionExternalObject;
      // External C function call to close the NLopt version reading.
    
      external "C" closeNloptVersion(nLoptVersionExternalObject) annotation(
        IncludeDirectory = "modelica://MPC/Resources/Include/",
        Include = "#include \"nloptVersion.c\"");
    end destructor;
  end NLoptVersionExternalObject;

  //*_*_*_*_*_*_*_*_*_*_*_*_*---Modelica Function that calles the external function ---*_*_*_*_*_*_*_*_*_*_*_*_*_*
  // This function calls the external C function to read the NLopt version.

  function nloptVersion "Function that calls external C function"
    //Variables
    input NLoptVersionExternalObject nLoptVersionExternalObject "External object";
    output NloptVersion2Struct nloptversion2Struct "Record to store utput from C struct";
    // Calling the external function to read the NLopt version.
  
    external "C" nloptVersion(nLoptVersionExternalObject, nloptversion2Struct) annotation(
      LibraryDirectory = "modelica://MPC/Resources/Library/win64/",
      Library = "nlopt",
      IncludeDirectory = "modelica://MPC/Resources/Include/",
      Include = "#include \"nlopt.h\"");
  end nloptVersion;

  //*_*_*_*_*_*_*_*_*_*_*_*_*---MainBlock()---*_*_*_*_*_*_*_*_*_*_*_*_*_*
  // Construct the records to store the NLopt version information.
  NloptVersion2Struct nloptversion2Struct "Record that stores the values from the external C code";
  // Create an instance of the NLoptVersionExternalObject class.
  NLoptVersionExternalObject nLoptVersionExternalObject = NLoptVersionExternalObject();
equation
// Call the 'nloptVersion' function to read the NLopt version.
  nloptversion2Struct = nloptVersion(nLoptVersionExternalObject);
  annotation(
    experiment(StartTime = 0, StopTime = 1, Tolerance = 1e-06, Interval = 0.002),
    Icon(graphics = {Text(extent = {{-98, 100}, {100, -100}}, lineColor = {28, 108, 200}, textString = "NLopt

Version")}),
    Documentation(info = "<html><head></head><body><h1>NLoptVersionBlock</h1><div><font size=\"5\">This block is based on the NLopt library that was installed with the use of vcpkg for windows.</font></div><div><font size=\"5\"><br></font></div><div><font size=\"5\">From the installed library the nlopt.dll was copied from the default location into the library directory for this package. In addition, the nlopt header file was copied into the Include folder.</font></div><div><font size=\"5\"><br></font></div><div><font size=\"5\">In this example the constructor and destructor are not dependent on the nlopt library, and is called as its own (.c) source file, while calling the version function in NLopt is performed with the use of the nlopt library and header file. The values returned from the function call is stored in the NloptVersion2Struct record.</font></div><div><font size=\"5\"><br></font></div><div><h2 style=\"font-family: 'MS Shell Dlg 2';\"><font size=\"5\">The external source code for the constructor, destructor and the function call</font><span style=\"font-size: x-large;\">&nbsp;is presented below:</span></h2></div><div><div><br></div><div><font size=\"5\">#include &lt;stdio.h&gt;</font></div><div><font size=\"5\">#include &lt;stdlib.h&gt;</font></div><div><font size=\"5\">#include &lt;math.h&gt;</font></div><div><font size=\"5\">#include &lt;nlopt.h&gt;</font></div><div><font size=\"5\">//#include \"C:\path\To\Header\File\nlopt.h\" - Alternative</font></div><div><font size=\"5\"><br></font></div><div><font size=\"5\">typedef struct{</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>int major;</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>int minor;</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>int bugfix;</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>int counter;</font></div><div><font size=\"5\">}NloptVersion2Struct;</font></div><div><font size=\"5\"><br></font></div><div><font size=\"5\"><br></font></div><div><font size=\"5\">//Initialise construct for the version function</font></div><div><font size=\"5\">void* initialiseNloptVersion()</font></div><div><font size=\"5\">{</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>NloptVersion2Struct* nloptVersion2Struct = (NloptVersion2Struct *)malloc(sizeof(NloptVersion2Struct));</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>if (nloptVersion2Struct == NULL)</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">		</span>ModelicaError(\"Insufficient memory to allocate NloptVersion2Struct\");</font></div><div><font size=\"5\"><br></font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>//Initialise</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>nloptVersion2Struct-&gt;major = 0;</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>nloptVersion2Struct-&gt;minor = 0;</font></div><div><font size=\"5\">&nbsp; &nbsp; nloptVersion2Struct-&gt;bugfix = 0;</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>nloptVersion2Struct-&gt;counter = 0;</font></div><div><font size=\"5\">&nbsp; &nbsp;&nbsp;</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>printf(\"Initialisation successful! \t\");</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>return (void *)nloptVersion2Struct;</font></div><div><font size=\"5\">}</font></div><div><font size=\"5\"><br></font></div><div><font size=\"5\">//Close and destruct the version function</font></div><div><font size=\"5\">void closeNloptVersion(void *externalObject)</font></div><div><font size=\"5\">{</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>NloptVersion2Struct* nloptVersion2Struct = (NloptVersion2Struct *)externalObject;</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>if(nloptVersion2Struct != NULL)</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>{</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">		</span>free(nloptVersion2Struct);</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">		</span> &nbsp; &nbsp;printf(\"Destruction successful!\t\");</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>}</font></div><div><font size=\"5\">}</font></div><div><font size=\"5\"><br></font></div><div><font size=\"5\">// Call the function</font></div><div><font size=\"5\">void nloptVersion(void *externalObject, void *externalObject2)</font></div><div><font size=\"5\">{</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>//Seting up the struct object</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>NloptVersion2Struct* nloptVersion2Struct = (NloptVersion2Struct*)externalObject;</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>NloptVersion2Struct* nloptVersion2Struct2 = (NloptVersion2Struct*)externalObject2;</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>//Define how many times the fuction call is printed to the modelica terminal</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>int numIterations = 2;</font></div><div><font size=\"5\"><br></font></div><div><font size=\"5\">&nbsp; &nbsp; // Get the version information and write it to the struct</font></div><div><font size=\"5\">&nbsp; &nbsp; nlopt_version(&amp;(nloptVersion2Struct2-&gt;major),</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">					</span>&amp;(nloptVersion2Struct2-&gt;minor),</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">					</span>&amp;(nloptVersion2Struct2-&gt;bugfix));</font></div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\"><font size=\"5\">					</font></span></div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\"><font size=\"5\">	</font></span></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>if (nloptVersion2Struct-&gt;counter &lt; numIterations){</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">		</span>printf(\"nloptVersion function run %d of %d - \", nloptVersion2Struct-&gt;counter+1, numIterations);</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">		</span>printf(\"nloptVersion is %d.%d.%d - \", nloptVersion2Struct2-&gt;major,</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">												</span>nloptVersion2Struct2-&gt;minor,</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">												</span>nloptVersion2Struct2-&gt;bugfix,</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">												</span>nloptVersion2Struct-&gt;counter);</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">		</span>nloptVersion2Struct-&gt;counter++;</font></div><div><font size=\"5\"><br></font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>}</font></div><div><font size=\"5\"><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>//return nloptVersion2Struct2;</font></div><div><font size=\"5\">}</font></div><div><font size=\"5\"><br></font></div><div><font size=\"5\"><br></font></div><div><font size=\"5\"><br></font></div><div><font size=\"5\"><br></font></div><div><font size=\"5\"><br></font></div><div><font size=\"5\"><br></font></div><div><font size=\"5\"><br></font></div><div><font size=\"5\"><br></font></div><div><font size=\"5\"><br></font></div><div><font size=\"5\"><br></font></div><div><font size=\"5\"><br></font></div><div><font size=\"5\"><br></font></div><div><font size=\"5\"><br></font></div><div style=\"font-size: x-large;\"><br></div></div></body></html>"));
end NLoptVersionBlock;
