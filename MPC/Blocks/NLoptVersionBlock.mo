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
    Documentation(info = "<html><head></head><body><h1>NLoptVersionBlock</h1><div><font size=\"5\">This block is based on the NLopt library that was installed with the use of vcpkg for windows.</font></div><div><font size=\"5\"><br></font></div><div><font size=\"5\">From the installed library the nlopt.dll was copied from the default location into the library directory for this package. In addition, the nlopt header file was copied into the Include folder.</font></div><div><font size=\"5\"><br></font></div><div><font size=\"5\">In this example the constructor and destructor are not dependent on the nlopt library, and is called as its own (.c) source file, while calling the version function in NLopt is performed with the use of the nlopt library and header file. The values returned from the function call is stored in the NloptVersion2Struct record.</font></div><div><h2 style=\"font-family: 'MS Shell Dlg 2';\"><br></h2></div>

<h1>Source code called in external C source code</h1><div>
<p><font size=\"5\">The source code is available at&nbsp;<span>the
source code presented in a GitHub repository:</span></font><span><font size=\"5\">  </font><a href=\"https://github.com/cmbNor/Advanced-Control-Implementation-with-Modelica/blob/518b4cda868148e9f8656f3995b4f0fb207a1d98/MPC/Resources/Include/nloptVersion.c\" style=\"font-size: 11pt;\"><u>Link to source code</u></a> </span></p></div></body></html>"));
end NLoptVersionBlock;
