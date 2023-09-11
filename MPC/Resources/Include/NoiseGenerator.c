#include <stdio.h>
#include <stdlib.h>
#include <time.h>

//-------------------Declare the struct--------------------------
typedef struct{
	double range;
	double result;
}NoiseGeneratorData;


//-------------------Initialise construct function--------------------------
void* initialiseNoiseGenerator(double range, double result)
{

	// Allocate memory for the optimization data input
    NoiseGeneratorData* noiseGeneratorDataInput = malloc(sizeof(NoiseGeneratorData));
	if (noiseGeneratorDataInput == NULL)
		ModelicaError("Insufficient memory to allocate noiseGeneratorDataInput");

	// Initialize the optimization data input
	noiseGeneratorDataInput->range = range;
	noiseGeneratorDataInput->result = result;

    // Seed the random number generator
    srand(time(NULL));

	printf("Initialisation of input successful! \t");
	return (void *)noiseGeneratorDataInput;
}

//-------------------Close and destruct --------------------------
void closeNoiseGenerator(void *externalObject)
{
    NoiseGeneratorData* noiseGeneratorDataInput = (NoiseGeneratorData *)externalObject;
	if(noiseGeneratorDataInput != NULL)
	{
		free(noiseGeneratorDataInput);
		    printf("Destruction of input successful!\t");
	}
}


void NoiseGenerator(void *externalObject, void *externalObject2)
{
	NoiseGeneratorData* noiseGeneratorDataInput = (NoiseGeneratorData *)externalObject;
	NoiseGeneratorData* noiseGeneratorOutput = (NoiseGeneratorData *)externalObject2;
	
	double random = 0;
	random = ((double)rand() / (double)RAND_MAX) - 0.5;
	
	//Only return the noise component
	noiseGeneratorOutput->result = random * noiseGeneratorDataInput->range;

}