#ifndef NOISEGENERATOR2_H_INCLUDED
#define NOISEGENERATOR2_H_INCLUDED

void* initialiseNoiseGenerator(double range);
void closeNoiseGenerator(void *externalObject);
double NoiseGenerator(double range, void *externalObject);

#endif // NOISEGENERATOR2_H_INCLUDED
