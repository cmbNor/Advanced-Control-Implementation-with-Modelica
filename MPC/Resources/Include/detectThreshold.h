#ifndef DETECTTHRESHOLD_H_INCLUDED
#define DETECTTHRESHOLD_H_INCLUDED

void* initialiseDetectThreshold(double threshold);
void closeDetectThreshold(void *externalObject);
double detectThreshold(double u, double t, void *externalObject);

#endif // DETECTTHRESHOLD_H_INCLUDED
