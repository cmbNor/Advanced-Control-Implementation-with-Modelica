#include <stdio.h>
#include <stdlib.h>
#include "C:\vcpkg\packages\nlopt_x64-windows\include\nlopt.h"

typedef struct{
	int major;
	int minor;
	int bugfix;
}NloptVersion2Struct;


// Call the noise function
int nloptVersion(void *externalObject)
{
	NloptVersion2Struct* nloptVersion2Struct = (NloptVersion2Struct *)externalObject;
    int a = 0;
    int b = 0;
    int c = 0;

    void nlopt_version(int *a, int *b, int *c);

    nloptVersion2Struct->major = a;
    nloptVersion2Struct->major = b;
    nloptVersion2Struct->major = c;

	return nloptVersion2Struct->major;
}
