#include <stdio.h>
#include <stdlib.h>
#include "detectThreshold.h"

typedef struct{
	double threshold;
	int triggered;
	double triggeringTime;
}DetectThresholdStruct;


//Initialise construct the detect threshold function

void* initialiseDetectThreshold(double threshold)
{
	DetectThresholdStruct* detectThresholdStruct = (DetectThresholdStruct *)malloc(sizeof(DetectThresholdStruct));
	if (detectThresholdStruct == NULL)
		ModelicaError("Insufficient memory to allocate DetectThresholdStruct");

	/* Initialise */
	detectThresholdStruct->threshold = threshold;
	detectThresholdStruct->triggered = 0;
	detectThresholdStruct->triggeringTime = 0;

	return (void *)detectThresholdStruct;
}

//Close destruct the detect threshold function

void closeDetectThreshold(void *externalObject)
{
	DetectThresholdStruct* detectThresholdStruct = (DetectThresholdStruct *)externalObject;
	if(detectThresholdStruct != NULL)
	{
		free(detectThresholdStruct);
	}
}

//Call the detect threshold function

double detectThreshold(double u, double t, void *externalObject)
{
	DetectThresholdStruct* detectThresholdStruct = (DetectThresholdStruct *)externalObject;

	/* If not triggered or simulation time is less than triggeringTime then check threshold*/
	if(detectThresholdStruct->triggered == 0 || t<detectThresholdStruct->triggeringTime)
	{
		if(u > detectThresholdStruct->threshold)
		{
			detectThresholdStruct->triggeringTime = t;
			detectThresholdStruct->triggered = 1;
		}
	}
	return detectThresholdStruct->triggeringTime;

}
