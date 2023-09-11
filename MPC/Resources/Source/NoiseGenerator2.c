#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "NoiseGenerator2.h"

typedef struct{
	double range;
	double span;
	double result;
}NoiseGenerator2Struct;


//Initialise construct for the noise generator function
void* initialiseNoiseGenerator(double range)
{
	NoiseGenerator2Struct* noiseGenerator2Struct = (NoiseGenerator2Struct *)malloc(sizeof(NoiseGenerator2Struct));
	if (noiseGenerator2Struct == NULL)
		ModelicaError("Insufficient memory to allocate noiseGenerator2Struct");

	/* Initialise */
	noiseGenerator2Struct->range = range;

    // Seed the random number generator
    srand(time(NULL));

	return (void *)noiseGenerator2Struct;
}

//Close destruct the noise generator function
void closeNoiseGenerator(void *externalObject)
{
	NoiseGenerator2Struct* noiseGenerator2Struct = (NoiseGenerator2Struct *)externalObject;
	if(noiseGenerator2Struct != NULL)
	{
		free(noiseGenerator2Struct);
	}
}

// Call the noise function
double NoiseGenerator(double range, void *externalObject)
{
	NoiseGenerator2Struct* noiseGenerator2Struct = (NoiseGenerator2Struct *)externalObject;
	double random = 0;
	
    // Generate a random number between -0.5 and 0.5
    random = ((double)rand() / (double)RAND_MAX) - 0.5;
	
    // Calculate the noise within the specified range
	noiseGenerator2Struct->result = random * range;
	
	return noiseGenerator2Struct->result;
}