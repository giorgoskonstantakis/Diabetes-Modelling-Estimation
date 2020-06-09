%% 
clc; clear all;
%% 24-HOUR SIMULATION FOR DIABETIC SUBJECT WITH 3 MEAL DISTURBANCES AND 3 INSULIN INJECTIONS

% Below , set the initial glucose concentration , the time moments of meal
% intake and insulin injection and the quantities
siz=1441; % Number of samples for full day
Time=[100 400 700 900 1100 ]; % Time of meals and insulin
% 4 meal and insulin simulation : [ 420 660 900 1440 ]  7am , 11am  , 3pm  , 8pm 
% 5 meal and insulin simulation : [ 420 600 840 1020 1200 ]  7am , 10am , 5pm , 10pm 
% 3 meal and insulin simulation : [ 420 780 1140 ]  7am , 1pm , 7pm
% 2 meal and insulin simulation : [ 600 1080 ]  10am , 6pm
CARBS=[1 2 5 6 5]; % number of meal units ( unit =15gr )
INS=[1 3 3 7 5]; % number of ins units ( unit = units of insulin ) 1ml=100units
initial_glucose=150; % number of initial blood glucose concentration ( unit = mg/dl )

[INS_1,INS_2,INS_3]=insulin_input(Time,INS,siz);
[CARBS_1_1,CARBS_1_2,CARBS_2_1,CARBS_2_2]=carbs_inputs(Time,CARBS,siz);

% Inputs
u = [CARBS_1_1 CARBS_1_2 CARBS_2_1 CARBS_2_2 INS_1 INS_2 INS_3 ];

% Insulin-Glucose Model 
Ts=60;
order=6;

A=[1 30 30 -30 0 0 ;
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

x0=[initial_glucose;0;0;0;0;0];

sys_total=idss(A,B,C,D,K,x0,Ts);

[y,~,x]=lsim(sys_total,u,0:Ts:86400,x0);

% Process Noise Variance 
Qk=0.05;

% Addition of process noise in the system
w = add_process_noise(Time,Time,Qk,siz);

[y_process_noise,~,x_process_noise]=lsim(sys_total,u+w,0:Ts:86400,x0);

% this plot represents the model without-noise(blue line) simulation
% ,and the model with-process_noise(red line) simulation

plot(0:(1/60):24,y_process_noise,'r',0:(1/60):24,y,'b','MarkerSize',10,'LineWidth',1.5);
title('System and Model Response')
xlabel('time ( hours )'), ylabel('Blood Glucose Concentration ( mg/dl )')
legend('real system','model')
xlim([0 24])

%% Model response plot
% Model plot alone
plot(0:(1/60):24,y,'b','MarkerSize',10,'LineWidth',1.5);
title('Model Response')
xlabel('time ( hours )'), ylabel('Blood Glucose Concentration ( mg/dl )')
xlim([0 24])
%% CONSTRUCT REAL AND MODEL DATA FOR THE KALMAN FILTER ESTIMATION

samples=289; % real samples' number ( sampling every 5 minutes )
amp=50; % Observation Noise Variance

% Processing the values , and extract the values as we have 5 min sampling
% rate 
y_meas_real=zeros(samples,1);
noise=sqrt(amp)*randn(samples,1);
y_meas_real(1,1)=y_process_noise(1,1);
for w=1:siz
    if(mod(w,5)==0)
        y_meas_real(w/5+1,1)=y_process_noise(w,1);
    end
end
y_model_sampled=[y(1,1);zeros(samples-1,1)];
for j=1:siz
    if(mod(j,5)==0)
        y_model_sampled(j/5+1,1)=y(j,1);
    end
end


y_meas_real=y_meas_real+noise;
y_meas_real=y_meas_real';
t=(0:5:1440)';
ti=(0:1:1440)';
y_meas=interp1(t,y_meas_real,ti); 
y_meas_real=y_meas_real';

% Initialization of Kalman's matrices
P= amp;
x=[initial_glucose;zeros(5,1)];
y_filter=zeros(samples,1);
errcov=zeros(samples,1);
X=zeros(6,samples);


%% plot y_measured and y_model

% plot the real glucose values ( as we made them with observation noise)
% and the  values without noise
plot(0:(1/12):24,y_meas_real,'r',0:(1/12):24,y_model_sampled,'b','MarkerSize',10,'LineWidth',1);
title('System and Model Response')
xlabel('time ( hours )'), ylabel('Blood Glucose Concentration ( mg/dl )')
legend('real system','model')
xlim([0 24])


%% LINEAR KALMAN FILTER
% Kalman Filter's Implementation
% Kalman Filter's algorithm , which is checking glucose every five minutes
Rk=amp;

for z=1:samples
        X(:,z)=x;    
        Kgain = P*C'/(C*P*C'+Rk);
        x = x + Kgain*(y_meas_real(z)-C*x); 
        P = (eye(6)-Kgain*C)*P*(eye(6)-Kgain*C)'+Kgain*Rk*Kgain'; 
        y_filter(z) = C*x;
        errcov(z) = C*P*C';
        x = A*x ; 
        P = A*P*A'+Qk;
end

plot(0:(1/12):24,y_model_sampled,'r',0:(1/12):24,y_filter,'b-',0:(1/12):24,y_meas_real,'g','MarkerSize',2,'LineWidth',1.5)
title('System Response vs Linear Kalman Filter Response (Basic System)')
xlabel('time ( hours )'), ylabel('Blood Glucose Concentration ( mg/dl )')
legend('model','estimation','system')
xlim([0 24])

%% Euclidean distances
distances=zeros(samples,1);
for i=1:samples
    distances(i,1)=y_meas_real(i,1)-y_filter(i,1);
end
k1=max(abs(distances));
k2=min(abs(distances));
%% RESULTS

% εδώ υπολογίζονται οι μετρικές NRMSE,MSE και NMSE
% Οι NRMSE και MSE παίρνουν τιμή από -Inf εώς 1
% με χειρότερη απόδοση στο -Inf και καλύτερη στο 1
% στην τιμή 0 μία απλή γραμμή χρησιμοποιείται για το fit
% Η MSE δείχνει το μέσο τετραγωνικό σφάλμα του φίλτρου και του μοντέλου
% ως προς τις μετρήσεις και παίρνει τιμές >0

% Norm Root Mean Square Error
NRMSE_model=goodnessOfFit(y_model_sampled,y_meas_real,'NRMSE');
NRMSE_kalman_filter=goodnessOfFit(y_filter,y_meas_real,'NRMSE');
NRMSE=[NRMSE_model NRMSE_kalman_filter] % norm root mean square error ( model vs observations )

% Mean Square Error
MSE_model=goodnessOfFit(y_model_sampled,y_meas_real,'MSE');
MSE_kalman_filter=goodnessOfFit(y_filter,y_meas_real,'MSE');
MSE=[MSE_model MSE_kalman_filter] % mean square error ( model vs observations )

% Norm Mean Square Error
NMSE_model=goodnessOfFit(y_model_sampled,y_meas_real,'NMSE');
NMSE_kalman_filter=goodnessOfFit(y_filter,y_meas_real,'NMSE');
NMSE=[NMSE_model NMSE_kalman_filter]; % norm mean square error

% NRMSE is the most reliable from the three
