//Somwhat working code to call the version function. Did not return correct values,
//but compiler gave no error.

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <nlopt.h>
//#include "C:\path\To\Header\File\nlopt.h" - Alternative

typedef struct{
	int major;
	int minor;
	int bugfix;
	int counter;
}NloptVersion2Struct;


//Initialise construct for the version function
void* initialiseNloptVersion()
{
	NloptVersion2Struct* nloptVersion2Struct = (NloptVersion2Struct *)malloc(sizeof(NloptVersion2Struct));
	if (nloptVersion2Struct == NULL)
		ModelicaError("Insufficient memory to allocate NloptVersion2Struct");

	//Initialise
	nloptVersion2Struct->major = 0;
	nloptVersion2Struct->minor = 0;
    nloptVersion2Struct->bugfix = 0;
	nloptVersion2Struct->counter = 0;
    
	printf("Initialisation successful! \t");
	return (void *)nloptVersion2Struct;
}


//Close and destruct the version function
void closeNloptVersion(void *externalObject)
{
	NloptVersion2Struct* nloptVersion2Struct = (NloptVersion2Struct *)externalObject;
	if(nloptVersion2Struct != NULL)
	{
		free(nloptVersion2Struct);
		    printf("Destruction successful!\t");
	}
}




// Call the function
void nloptVersion(void *externalObject, void *externalObject2)
{
	//Seting up the struct object
	NloptVersion2Struct* nloptVersion2Struct = (NloptVersion2Struct*)externalObject;
	NloptVersion2Struct* nloptVersion2Struct2 = (NloptVersion2Struct*)externalObject2;
	//Define how many times the fuction call is printed to the modelica terminal
	int numIterations = 2;

    // Get the version information and write it to the struct
    nlopt_version(&(nloptVersion2Struct2->major),
					&(nloptVersion2Struct2->minor),
					&(nloptVersion2Struct2->bugfix));
					
	
	if (nloptVersion2Struct->counter < numIterations){
		printf("nloptVersion function run %d of %d - ", nloptVersion2Struct->counter+1, numIterations);
		printf("nloptVersion is %d.%d.%d - ", nloptVersion2Struct2->major,
												nloptVersion2Struct2->minor,
												nloptVersion2Struct2->bugfix,
												nloptVersion2Struct->counter);
		nloptVersion2Struct->counter++;

	}
	//return nloptVersion2Struct2;
}














