#include <stdio.h>
#include <stdlib.h>

double NoiseGenerator(double range)
{
	double result = 0;
	double span = 2*range;
	
	//Return both noise and signal
	//result = x + ((double)(rand() /(RAND_MAX/(span)))-range);

	//Only return the noise component
	result = ((double)(rand() /(RAND_MAX/(span)))-range);
	
	return result;

}