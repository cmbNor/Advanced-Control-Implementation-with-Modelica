#include <stdio.h>
#include <nlopt.h>

//Summary off all elements in file
//1. Declare the struct
//2. Initialise construct function Input
//3. Close and destruct the Input
//4. Main function
//5. Objective function for the optimization problem
//6. Functions Called by Modelica


//-------------------Declare the struct--------------------------
// Define the optimization object structure
    typedef struct {
        double x1; //Optimization variable
		double x1Lb; //Lower bound of x1
		double xlUb; //Upper bound of x1
		double x2; //Optimization variable
		double x2Lb; //Lower bound of x2
		double x2Ub; //Upper bound of x2
		double min_cost; //Minimum value of the objective function after optimization
		int n; //Number of optimization variables
		double tol; //Termination tolerance
		int	max_iter;	  // Maximum number of iterations for the optimizer
    } OptimizationDataMulti;


//-------------------Initialise construct function Input--------------------------
void* initialiseNloptInput(double x1, double x1Lb, double x1Ub, 
							double x2, double x2Lb, double x2Ub,
							double min_cost, int n, double tol, int max_iter)
{
	// Check input
	if (tol <= 0)
		ModelicaError("The tolerance needs to be > 0");
	if (max_iter <= 0)
		ModelicaError("The maximum number of iterations needs to be > 0");
	if (x1Lb >= x1Ub)
		ModelicaError("The lower bound of x1 needs to be smaller than the upper bound");
	if (x2Lb >= x2Ub)
		ModelicaError("The lower bound of x2 needs to be smaller than the upper bound");
	if (n <= 0)
		ModelicaError("The number of variables needs to be > 0");
	if (n != 2)
		ModelicaError("This example only works for two variables");

	//Construnct the external object for data storage based on the struct
    OptimizationDataMulti* optimizationDataInput = malloc(sizeof(OptimizationDataMulti));
	if (optimizationDataInput == NULL)
		ModelicaError("Insufficient memory to allocate optimizationDataInput");

	// Initialize the optimization data input
	optimizationDataInput->x1 = x1;
	optimizationDataInput->x1Lb = x1Lb;
	optimizationDataInput->xlUb = x1Ub;
	optimizationDataInput->x2 = x2;
	optimizationDataInput->x2Lb = x2Lb;
	optimizationDataInput->x2Ub = x2Ub;
	optimizationDataInput->min_cost = min_cost;
	optimizationDataInput->n = n;
	optimizationDataInput->tol = tol;
	optimizationDataInput->max_iter = max_iter;
	
	printf("Initialisation of input successful! \t");
	return (void *)optimizationDataInput;
}

//-------------------Close and destruct the Input --------------------------
void closeNloptInput(void *externalObject)
{
	OptimizationDataMulti* optimizationDataInput = (OptimizationDataMulti *)externalObject;
	if(optimizationDataInput != NULL)
	{
		free(optimizationDataInput);
		    printf("Destruction of input successful!\t");
	}
}

//*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-Functions Called by Modelica*-*-*-*-*-*-*-*-*-*-*-*-

void mainFunctionMulti(void *externalObject2, void *externalObject3){
	OptimizationDataMulti* optimizationDataInput = (OptimizationDataMulti *)externalObject2;
	OptimizationDataMulti* optimizationDataOutput = (OptimizationDataMulti *)externalObject3;

// Objective function for the optimization problem
double objective(unsigned n, const double *x, double *grad, void *data)
{
    // Compute the cost function (e.g., quadratic cost)
    //double cost = x[0] * x[0] + (x[1] * x[1]); //Zero
	double cost = (x[0] - 1.0) * (x[0] - 1.0) + (x[1] - 2.0) * (x[1] - 2.0); //Non-zero
    return cost;
}
    // Initial guess for the optimization variables
    double x[2] = {0.0, 0.0};
	
    // Create an nlopt optimizer object
    nlopt_opt opt;
    opt = nlopt_create(NLOPT_LD_SLSQP, optimizationDataInput->n); // SLSQP algorithm
    
    // Set the objective function and its parameters
    nlopt_set_min_objective(opt, objective, NULL);
    
    // Set the lower bounds for the optimization variables
    double lb[2] = {optimizationDataInput->x1Lb, optimizationDataInput->x2Lb};
    nlopt_set_lower_bounds(opt, lb);
    
    // Set the upper bounds for the optimization variables
    double ub[2] = {optimizationDataInput->xlUb, optimizationDataInput->x2Ub};
    nlopt_set_upper_bounds(opt, ub);
    
    // Set the termination tolerance
    nlopt_set_ftol_rel(opt, optimizationDataInput->tol);
    
    // Set the maximum number of iterations
    nlopt_set_maxeval(opt, optimizationDataInput->max_iter);
    
    // Optimize the objective function
    nlopt_optimize(opt, x, &optimizationDataInput->min_cost);
    
    // Print the optimized variables and minimum cost
    printf("Optimized variables: x1 = %lf, x2 = %lf\n", x[0], x[1]);
    printf("Minimum cost: %lf\n", optimizationDataInput->min_cost);
		
	//Passing returnvalues back to Modelica
	optimizationDataOutput->x1 = x[0];
	optimizationDataOutput->x2 = x[1];
	optimizationDataOutput->min_cost = optimizationDataInput->min_cost;
	
	//Passing input values back to Modelica
	optimizationDataOutput->xlUb = optimizationDataInput->xlUb;
	optimizationDataOutput->x1Lb = optimizationDataInput->x1Lb;
	optimizationDataOutput->x2Lb = optimizationDataInput->x2Lb;
	optimizationDataOutput->x2Ub = optimizationDataInput->x2Ub;
	optimizationDataOutput->n = optimizationDataInput->n;
	optimizationDataOutput->tol = optimizationDataInput->tol;
	optimizationDataOutput->max_iter = optimizationDataInput->max_iter;
	
    // Destroy the optimizer object
    nlopt_destroy(opt);	
}