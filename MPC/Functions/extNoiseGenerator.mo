within MPC.Functions;
function extNoiseGenerator
  
  //Function parameters
  input Real range    "Total range of noise to be generated centerd around input signal";
  output Real y_ext   "Distorted output signal";

  //Call of the external function in OpenModelica
  external "C" y_ext = NoiseGenerator(range)
    annotation(IncludeDirectory="MPC.Resources.Source",
                Include="#include \"NoiseGeneratorOld.c\"");
                
                
                
annotation(
    Documentation(info = "<html><head></head><body><h1>extNoiseGenerator</h1><div><br></div><font size=\"5\">The function calls external C source code and generates a sudo random number that is returned by this Modelica function.</font><div><font size=\"5\"><br></font></div><h2><font size=\"5\">The C source code is presented below:</font></h2><div><font size=\"5\"><div>#include &lt;stdio.h&gt;</div><div>#include &lt;stdlib.h&gt;</div><div><br></div><div>double NoiseGenerator(double range)</div><div>{</div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>double result = 0;</div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>double span = 2*range;</div><div><br></div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>//Only return the noise component</div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>result = ((double)(rand() /(RAND_MAX/(span)))-range);</div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span></div><div><span class=\"Apple-tab-span\" style=\"white-space:pre\">	</span>return result;</div><div><br></div><div>}</div></font></div></body></html>"));

end extNoiseGenerator;
