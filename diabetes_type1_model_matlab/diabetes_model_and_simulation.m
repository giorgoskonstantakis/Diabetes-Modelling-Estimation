%% Representing the model for diabetes type 1

% Here we present the glucose_insulin model for a diabetic type-1 subject .
% As we can see , the model is in state-space form of order 6 . It has one
% output and seven inputs . The model is representing a day in a diabetic's
% life , with all the ups and downs of blood glucose concentration , due to
% the meal disturbances and the insulin injections.

% The model's output represents of course the blood glucose concentration
% which is measured in mg/dl .

% About the inputs , originally they are three , the insulin dose and the
% carbohydrate meal which is separated in 2 different inputs , each one
% representing a different time activeness of meal( in the simulation , you
% just set values for insulin and carbohydrates , and the system
% automatically "break" the meal in two parts. Despite that the true inputs
% are three , we use 7 , which are used combined to represent the original
% inputs , in order to avoid the non-linearities which original inputs
% have. We use Humalog Kwik-Pen as the model's insulin analog ,
% which has 4 hours of effectiveness .

% About the states of the system , it is consisted by 6 states which are
% the follow :
% x1(k) : blood glucose concentration ( mg/dl )
% x2(k) : meal disturbance's 1 (2 hour activeness) ( 15gr )
% x3(k) : meal disturbance's 2 (3 hour activeness) ( 15gr )
% x4(k) : insulin's activeness (4-hour activeness) ( U/ml )
% x5(k) , x6(k) : these states are used to help the represenation of
% insulin 4-hour activeness , in order to be able to use the model for
% other purposes , such as for the development of a controller ( U/ml )

% Discrete time state space model
Ts=60; % sampling rate
order=6; % order

% These parameters show the action of insulin and carbohydrates in blood
% glucose concentration . We change their values to show differences
% between different subjects with type-1 diabetes . ( k1,k2 : meal's
% parameter ( >0 ) , k3 : insulin parameter ( <0 ) )
k1 = 30 ; % ( mg/(15*gr*dl) )
k2 = 30 ; % ( mg/(15*gr*dl) )
k3 = -30 ; % ( (100*mg) / U )

% The model's matrices
A=[1 k1 k2 k3 0 0 ;
   0 1 0 0 0 0 ;
   0 0 1 0 0 0;
   0 0 0 1 0.0000825 -0.00005892857;
   0 0 0 0 1 0;
   0 0 0 0 0 1];

B=[0 0 0 0 0 0 0;
   0.00014814815 -0.0001058201 0 0 0 0 0;
   0 0 0.000335 -0.00023928571 0 0 0;
   0 0 0 0 0 0 0;
   0 0 0 0 1 -1 0;
   0 0 0 0 0 1 -1];

C=[1 0 0 0 0 0];

D=[0 0 0 0 0 0 0];

K=zeros(order,1);

%% Simulation of the model

% Initializing and creating the inputs
% Now , you are able to choose values for the carbohydrates and for the
% insulin dose , in order to simulate the system for 24 hours. 
% Be careful , we set CARBS *15gr , so for example if you want to simulate
% a meal 60gr carbohydrates , set CARBS = 60gr/15gr = 4 . Also , insulin is
% measured in units , in a way that 1 ml insulin has 100 units .

siz=1441; % Number of samples for full day

% We must set an initial blood glucose to begin our simulation 
%  empirically , choose values >30-40 && <600
initial_glucose = 100 ; 
x0=[initial_glucose;0;0;0;0;0];

% Below , you set the values for time and quantity of injection of insulin
% and consuming of carbohydrate
Time_for_meal=[100 400 700 900 1100 ]; % Time moments of meals and insulin
Time_for_insulin=[100 400 700 900 1100 ]; % Time moments of meals and insulin
CARBS=[1 3 5 0 4]; % number of meal units
INS=[1 3 5 0 4]; % number of ins units

% As we can see above , the model offers to us the chance to simulate up to
% 5 meals and 5 insulin injections a day. But we can also simulate less,
% for example :
% Time_for_meal=[1 50 500 800 1100 ]; 
%Time_for_insulin=[1 50 500 500 1100 ]; 
%CARBS=[0 0 5 6 5]; 
%INS=[0 0 3 7 5]; 
% Above , we simulate 3 meals and 3 injections of insulin throughout the
% day.

% Making the system
system_diabetes=idss(A,B,C,D,K,x0,Ts);

% Here we call the specific functions to create system's inputs
[INS_1,INS_2,INS_3]=insulin_input(Time_for_meal,INS,siz);
[CARBS_1_1,CARBS_1_2,CARBS_2_1,CARBS_2_2]=carbs_inputs(Time_for_insulin,CARBS,siz);
u = [CARBS_1_1 CARBS_1_2 CARBS_2_1 CARBS_2_2 INS_1 INS_2 INS_3 ];

% LINEAR SIMULATION OF DIABETES MODEL
[y,~,x]=lsim(system_diabetes,u,0:Ts:86400,x0);


%% Plot the values of model

% Model plot alone
plot(0:(1/60):24,y,'b','MarkerSize',10,'LineWidth',1.5);
title('Model Response')
xlabel('time ( hours )'), ylabel('Blood Glucose Concentration ( mg/dl )')
xlim([0 24])

