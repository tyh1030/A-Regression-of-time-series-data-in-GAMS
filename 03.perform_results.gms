Sets
  t 'Years';
Parameters
  y(t) 
  x1(t)
  x2(t)
  ;
* Declare variables
VARIABLES
    beta0   "Intercept"
    beta1    "Slope1"
    beta2    "Slope2"
    residuals(t) "Residuals"
    SEE      "Sum of Squared Errors";

* Declare equations
EQUATIONS
    define_residuals(t) "Residual definition"
    objective "Objective function of SEE";

* Define equations
define_residuals(t).. 
    residuals(t) =E= y(t) - (beta0 + beta1 * x1(t)+ beta2 * x2(t));

objective..
    SEE =E= SUM((t), residuals(t)**2);

*-------------------------------------------------------------------------------
** will set up the syntax of importing data as below
** run 01.load_data.gms and check the ./gdx/xxxx_data_import.gdx
** if the data in gdx file is fine to you, binding the data
*-------------------------------------------------------------------------------
$gdxIn "./gdx/test_data_import.gdx"
$load t=Time y=Outcome x1=Variable01 x2=Variable02
$gdxIn
display t,y,x1,x2;
*-------------------------------------------------------------------------------


* Model and solve
MODEL regression /all/;
* Initial guesses for variables
beta0.L = 1;
beta1.L = 1;
beta2.L = 1;
SEE.L = 1;

SOLVE regression USING NLP MINIMIZING SEE;

* Display results
DISPLAY beta0.L, beta1.L, beta2.L,SEE.L;

* write result data to a GDX file
execute_unload "./gdx/test_data_result.gdx", t,y,x1,x2,beta0,beta1,beta2,residuals,SEE;


