#include <stdio.h>
#include <math.h>
#include <nlopt.h>


//-------------------Declare the struct--------------------------
// Define the optimization object structure
    typedef struct {
        double x1R; 		//Optimization variable
		double x1LbR; 		//Lower bound of x1
		double xlUbR; 		//Upper bound of x1
		double min_costR;	//Minimum value of the objective function after optimization
		int nR; 			//Number of optimization variables
		double TolR; 		//Termination tolerance
    } ModelData;


//-------------------Initialise construct function Input--------------------------
void* initialiseNloptMPCInput()
{
	//Construnct the external object for data storage based on the struct
    ModelData* optimizationDataInputObject = malloc(sizeof(ModelData));
	if (optimizationDataInputObject == NULL)
		ModelicaError("Insufficient memory to allocate optimizationDataInputObject");


	printf("Initialisation of input successful! \t");
	return (void *)optimizationDataInputObject;
}

//-------------------Close and destruct the Input --------------------------
void closeNloptMPCInput(void *externalObject)
{
	ModelData* optimizationDataInputObject = (ModelData *)externalObject;
	if(optimizationDataInputObject != NULL)
	{
		free(optimizationDataInputObject);
		    printf("Destruction of input successful!\t");
	}
	
	
}



//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-Functions Called by Modelica*-*-*-*-*-*-*-*-*-*-*-*-

void mainFunctionMPC(void *externalObject1, void *externalObject2, void *externalObject3){
	ModelData* optimizationDataInputObject = (ModelData *)externalObject1;
	ModelData* optimizationDataInput = (ModelData *)externalObject2;
	ModelData* optimizationDataOutput = (ModelData *)externalObject3;

	//Initialize the external object with the input data defined in Modelica
	optimizationDataInputObject->x1R = optimizationDataInput->x1R;
	optimizationDataInputObject->x1LbR = optimizationDataInput->x1LbR;
	optimizationDataInputObject->xlUbR = optimizationDataInput->xlUbR;
	optimizationDataInputObject->min_costR = optimizationDataInput->min_costR;
	optimizationDataInputObject->nR = optimizationDataInput->nR;
	optimizationDataInputObject->TolR = optimizationDataInput->TolR;

/*
// Objective function for optimization
	double objective(unsigned n, const double* x, double* grad, void* data)
	{
		// Compute the objective value based on the input variable `x`
		double result = pow(*x - 3.0, 2);

		// If the gradient is requested, calculate it
		if (grad) {
			*grad = 2 * (*x - 3.0);
		}
		return result;
	}
   */
   
   // Objective function for built as a state space model
	double objective(double xInput[])
	{
		// Define the state space model parameters
	#define NUM_STATES 1
	#define NUM_INPUTS 1
	#define NUM_OUTPUTS 1

		// Define the state space model matrices
		double A[NUM_STATES][NUM_STATES] = {-0.04348};
		double B[NUM_STATES][NUM_INPUTS] = {1.0};
		double C[NUM_OUTPUTS][NUM_STATES] = { 0.152173913043478 };
		double D[NUM_OUTPUTS][NUM_INPUTS] = { {0.0} };
	
		// Define the state space model variables
		double x[NUM_STATES] = { 0.0 };
		double u[NUM_INPUTS] = { 0.0 };
		double y[NUM_OUTPUTS] = { 0.0 };
	
		double update_model() {
			// Compute the next state
			int i, j;
			double next_x[NUM_STATES] = { 0.0 };
			for (i = 0; i < NUM_STATES; i++) {
				for (j = 0; j < NUM_STATES; j++) {
					next_x[i] += A[i][j] * x[j];
				}
				next_x[i] += B[i][0] * u[0];
			}

			// Update the state and output variables
			for (i = 0; i < NUM_STATES; i++) {
				x[i] = next_x[i];
			}

			for (i = 0; i < NUM_OUTPUTS; i++) {
				y[i] = 0.0;
				for (j = 0; j < NUM_STATES; j++) {
					y[i] += C[i][j] * x[j];
				}
				y[i] += D[i][0] * u[0];
			}
			return y[0];
		}

	
		 // Set the input value
		u[0] = 22.0;

		// Initialize the state variables
		int i;
		for (i = 0; i < NUM_STATES; i++) {
			x[i] = 0.0;
		}

		// Update the state space model
		double y1;
		y1 = update_model();
		

	
	
	return = y1;
	
	
	
	}
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
    // Create an NLOpt optimizer
    nlopt_opt optimizer = nlopt_create(NLOPT_LN_COBYLA, 1); // Use the LN_COBYLA algorithm

    // Set the objective function
    nlopt_set_min_objective(optimizer, objective, optimizationDataInput);

    // Set lower and upper bounds for the variable
    nlopt_set_lower_bounds(optimizer, &optimizationDataInputObject->x1LbR);
    nlopt_set_upper_bounds(optimizer, &optimizationDataInputObject->xlUbR);

    // Set initial guess
    double x[] = {0.0};

    // Optimize the problem
    nlopt_optimize(optimizer, &x, &optimizationDataInputObject->min_costR);

    // Print the optimal solution and objective value
    printf("Optimal solution: %f\n", x);
    printf("Minimum cost: %f\n", optimizationDataInputObject->min_costR);
	
	//Data returned to Modelica from the input struct to the output
	//struct so it will be passed on to the output of the Modelica function call.

	//Writing values from external function to be returned as the output of the Modelica function
	optimizationDataOutput->x1R = x;
	optimizationDataOutput->x1LbR = optimizationDataInputObject->x1LbR;
	optimizationDataOutput->xlUbR = optimizationDataInputObject->xlUbR;
	optimizationDataOutput->min_costR = optimizationDataInputObject->min_costR;
	optimizationDataOutput->nR = optimizationDataInputObject->nR;
	optimizationDataOutput-> TolR = optimizationDataInputObject->TolR;			
	

	// Destroy the optimizer object

	nlopt_destroy(optimizer);
	printf("Destruction of optimizer successful!\t");
}
