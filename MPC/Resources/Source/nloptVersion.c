#include <stdio.h>
#include <stdlib.h>

typedef struct{
	int major;
	int minor;
	int bugfix;
}NloptVersion2Struct;


//Initialise construct for the version function
void* initialiseNloptVersion()
{
	NloptVersion2Struct* nloptVersion2Struct = (NloptVersion2Struct *)malloc(sizeof(NloptVersion2Struct));
	if (nloptVersion2Struct == NULL)
		ModelicaError("Insufficient memory to allocate NloptVersion2Struct");

	/* Initialise */
	nloptVersion2Struct->major = 0;
	nloptVersion2Struct->minor = 0;
    nloptVersion2Struct->bugfix = 0;
    printf("test");
	return (void *)nloptVersion2Struct;
}

//Close destruct the version function
void closeNloptVersion(void *externalObject)
{
	NloptVersion2Struct* nloptVersion2Struct = (NloptVersion2Struct *)externalObject;
	if(nloptVersion2Struct != NULL)
	{
		free(nloptVersion2Struct);
	}
}
