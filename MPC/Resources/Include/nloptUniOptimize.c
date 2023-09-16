#include <stdio.h>
#include <stdlib.h>
#include <nlopt.h>

//Summary of all elements in file
//1. Declare the struct
//2. Initialise construct function Input
//3. Close and destruct the Input
//4. Main function
//5. Objective function for the optimization problem
//6. Functions Called by Modelica

//-------------------Declare the struct--------------------------
// Define the optimization object structure
    typedef struct {
		double x1;        // Optimization variable
		double x1Lb;      // Lower bound of x1
		double x1Ub;      // Upper bound of x1
		double min_cost;  // Minimum value of the objective function after optimization
		int n;            // Number of optimization variables
		double tol;       // Termination tolerance
		int	max_iter;	  // Maximum number of iterations for the optimizer
    } OptimizationDataUni;

//-------------------Initialise construct function--------------------------
void* initialiseUniNloptInput(double xl, double x1Lb, double x1Ub, double min_cost, int n, double tol, int max_iter)
{
	// Check input
	if (x1Lb > x1Ub)
		ModelicaError("x1Lb must be smaller than x1Ub");
	if (n <= 0)
		ModelicaError("n must be larger than 0");
	if (tol <= 0)
		ModelicaError("tol must be larger than 0");
	if (max_iter <= 0)
		ModelicaError("max_iter must be larger than 0");

	// Allocate memory for the optimization data input
    OptimizationDataUni* optimizationDataInput = malloc(sizeof(OptimizationDataUni));
	if (optimizationDataInput == NULL)
		ModelicaError("Insufficient memory to allocate optimizationDataInput");

	// Initialize the optimization data input
	optimizationDataInput->x1 = 0;
	optimizationDataInput->x1Lb = x1Lb;
	optimizationDataInput->x1Ub = x1Ub;
	optimizationDataInput->min_cost = 0;
	optimizationDataInput->n = n;
	optimizationDataInput->tol = tol;
	optimizationDataInput->max_iter = max_iter;

	printf("Initialisation of input successful! \t");
	return (void *)optimizationDataInput;
}

//-------------------Close and destruct --------------------------
void closeNloptUniInput(void *externalObject)
{
    OptimizationDataUni* optimizationDataInput = (OptimizationDataUni *)externalObject;
	if(optimizationDataInput != NULL)
	{
		free(optimizationDataInput);
		    printf("Destruction of input successful!\t");
	}
}

//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-Functions Called by Modelica*-*-*-*-*-*-*-*-*-*-*-*-

/* This code is used to optimize the objective function using the NLOPT
 * library. 
 * The optimization problem is to find the minimum of the objective function
 * f(x) = pow(x - 3.0, 2)
 * The solution is found using the LN_COBYLA algorithm
 */

void mainFunctionUni(void *externalObject, void *externalObject2){
	OptimizationDataUni* optimizationDataInput = (OptimizationDataUni *)externalObject;
	OptimizationDataUni* optimizationDataOutput = (OptimizationDataUni *)externalObject2;

// Objective function for optimization
double objective(unsigned n, const double* x, double* grad, void* data)
{
	// Compute the objective value based on the input variable `x`
	// The objective function is f(x) = pow(x - 3.0, 2)
	double result = pow(*x - 3.0, 2);
	return result;
}
	double x = 0.0;     // Set initial guess
	
 	// Create an NLOpt optimizer
    nlopt_opt optimizer = nlopt_create(NLOPT_LN_COBYLA, optimizationDataInput->n); // Use the LN_COBYLA algorithm

    // Set the objective function
    nlopt_set_min_objective(optimizer, objective, NULL);

    // Set lower and upper bounds for the variable
    nlopt_set_lower_bounds(optimizer, &optimizationDataInput->x1Lb);
    nlopt_set_upper_bounds(optimizer, &optimizationDataInput->x1Ub);

	// Set the maximum number of iterations
    nlopt_set_maxeval(optimizer, optimizationDataInput->max_iter);

    // Optimize the problem
    nlopt_optimize(optimizer, &x, &optimizationDataInput->min_cost);

    // Print the optimal solution and objective value
    printf("Optimal solution: %f\n", x);
    printf("Objective value: %f\n", optimizationDataInput->min_cost);
	
	//Values returned as the output values back to Modelica.
	optimizationDataOutput->x1 = x;
	optimizationDataOutput->x1Lb = optimizationDataInput->x1Lb;
	optimizationDataOutput->x1Ub = optimizationDataInput->x1Ub;
	optimizationDataOutput->min_cost = optimizationDataInput->min_cost;
	optimizationDataOutput->n = optimizationDataInput->n;
	optimizationDataOutput->tol = optimizationDataInput->tol;
	optimizationDataOutput->max_iter = optimizationDataInput->max_iter;
	
    // Destroy the optimizer
    nlopt_destroy(optimizer);
}