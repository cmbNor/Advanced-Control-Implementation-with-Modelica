within MPC.ExternalObjects;
class NoiseGeneratorExternalObject"Class that defines the constructor and destructor for calling noise generator external code"
  extends ExternalObject;

  //Initialize the external object and reserve memory space
function constructor
    input Real range;
    output NoiseGeneratorExternalObject noiseGeneratorExternalObject;

  external "C" noiseGeneratorExternalObject = initialiseNoiseGenerator(range)
    annotation (LibraryDirectory="modelica://MPC/Resources/Library/win64/",
                Library = "NoiseGenerator2",
                IncludeDirectory = "modelica://MPC/Resources/Include/",
                Include="#include \"NoiseGenerator2.h\"");
  end constructor;

  //Close the external object and free up allocated memory space
function destructor
    input NoiseGeneratorExternalObject noiseGeneratorExternalObject;
    
external "C" closeNoiseGenerator(noiseGeneratorExternalObject)
    annotation (LibraryDirectory="modelica://MPC/Resources/Library/win64/",
                Library = "NoiseGenerator2",
                IncludeDirectory = "modelica://MPC/Resources/Include/",
                Include="#include \"NoiseGenerator2.h\"");
  end destructor;

end NoiseGeneratorExternalObject;
