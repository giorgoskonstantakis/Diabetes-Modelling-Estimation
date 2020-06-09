function w = add_process_noise(x1,x3,Qk,T)

% In this function , we create the process noise w , which is to be added to 
% the inputs of the model which is to be estimated by Linear Kalman Filter.

% The inputs of the function are  x1,x3 : the time vectors of the time
% moments in which insulin and carbohydrate meal will be consumed ,
% T : the number of glucose concentration samples for one full day 
% ( 1440 + 1 samples , one sample every 5 minutes ) , Qk : the variance of 
% process noise

% Θόρυβος εισόδων ινσουλίνης
noise_insulin_1=sqrt(Qk)*randn(1,1);
noise_insulin_2=sqrt(Qk)*randn(1,1);
noise_insulin_3=sqrt(Qk)*randn(1,1);
noise_insulin_4=sqrt(Qk)*randn(1,1);
noise_insulin_5=sqrt(Qk)*randn(1,1);
y1=[zeros(x1(1,1)-1,1);noise_insulin_1;zeros(x1(1,2)-x1(1,1)-1,1);noise_insulin_2;zeros(x1(1,3)-x1(1,2)-1,1);
    noise_insulin_3;zeros(x1(1,4)-x1(1,3)-1,1);noise_insulin_4;zeros(x1(1,5)-x1(1,4)-1,1);noise_insulin_5;zeros(T-x1(1,5),1)];
y2=[zeros(x1(1,1)+99,1);noise_insulin_1;zeros(x1(1,2)-x1(1,1)-1,1);noise_insulin_2;zeros(x1(1,3)-x1(1,2)-1,1);noise_insulin_3;
    zeros(x1(1,4)-x1(1,3)-1,1);noise_insulin_4;zeros(x1(1,5)-x1(1,4)-1,1);noise_insulin_5;zeros(T-x1(1,5)-100,1)];
y7=[zeros(x1(1,1)+239,1);noise_insulin_1;zeros(x1(1,2)-x1(1,1)-1,1);noise_insulin_2;zeros(x1(1,3)-x1(1,2)-1,1);noise_insulin_3;
    zeros(x1(1,4)-x1(1,3)-1,1);noise_insulin_4;zeros(x1(1,5)-x1(1,4)-1,1);noise_insulin_5;zeros(T-x1(1,5)-240,1)];

% Θόρυβος Διαταραχών γευμάτων
% FIRST MEAL DISTURBANCE
noise_meal_1_1=sqrt(Qk)*randn(1,1);
noise_meal_1_2=sqrt(Qk)*randn(1,1);
for o=1:T
    if(o>=x3(1,1) && o<(x3(1,1)+50))
       y3_1(o,1)=noise_meal_1_1;
       y4_1(o,1)=0;
       y5_1(o,1)=noise_meal_1_2;
       y6_1(o,1)=0;
    elseif(o<x3(1,1))
       y3_1(o,1)=0;
       y4_1(o,1)=0;
       y5_1(o,1)=0;
       y6_1(o,1)=0;
    elseif(o>=(x3(1,1)+50) && o<(x3(1,1)+75))
       y3_1(o,1)=noise_meal_1_1;
       y4_1(o,1)=0;
       y5_1(o,1)=0;
       y6_1(o,1)=noise_meal_1_2;
    elseif(o>=(x3(1,1)+75) && o<(x3(1,1)+100))
       y3_1(o,1)=0;
       y4_1(o,1)=noise_meal_1_1;
       y5_1(o,1)=0;
       y6_1(o,1)=noise_meal_1_2;
    elseif(o>=(x3(1,1)+100) && o<(x3(1,1)+120))
       y3_1(o,1)=0;
       y4_1(o,1)=noise_meal_1_1;
       y5_1(o,1)=0;
       y6_1(o,1)=noise_meal_1_2;
    elseif(o>=(x3(1,1)+120) && o<(x3(1,1)+180))
       y3_1(o,1)=0;
       y4_1(o,1)=noise_meal_1_1;
       y5_1(o,1)=0;
       y6_1(o,1)=0;
    else
       y3_1(o,1)=0;
       y4_1(o,1)=0;
       y5_1(o,1)=0;
       y6_1(o,1)=0;
    end
end

% SECOND MEAL DISTURBANCE 
noise_meal_2_1=sqrt(Qk)*randn(1,1);
noise_meal_2_2=sqrt(Qk)*randn(1,1);
for o=1:T
    if(o>=x3(1,2) && o<(x3(1,2)+50))
       y3_2(o,1)=noise_meal_2_1;
       y4_2(o,1)=0;
       y5_2(o,1)=noise_meal_2_2;
       y6_2(o,1)=0;
    elseif(o<x3(1,2))
       y3_2(o,1)=0;
       y4_2(o,1)=0;
       y5_2(o,1)=0;
       y6_2(o,1)=0;
    elseif(o>=(x3(1,2)+50) && o<(x3(1,2)+75))
       y3_2(o,1)=noise_meal_2_1;
       y4_2(o,1)=0;
       y5_2(o,1)=0;
       y6_2(o,1)=noise_meal_2_2;
    elseif(o>=(x3(1,2)+75) && o<(x3(1,2)+100))
       y3_2(o,1)=0;
       y4_2(o,1)=noise_meal_2_1;
       y5_2(o,1)=0;
       y6_2(o,1)=noise_meal_2_2;
    elseif(o>=(x3(1,2)+100) && o<(x3(1,2)+120))
       y3_2(o,1)=0;
       y4_2(o,1)=noise_meal_2_1;
       y5_2(o,1)=0;
       y6_2(o,1)=noise_meal_2_2;
    elseif(o>=(x3(1,2)+120) && o<(x3(1,2)+180))
       y3_2(o,1)=0;
       y4_2(o,1)=noise_meal_2_1;
       y5_2(o,1)=0;
       y6_2(o,1)=0;
    else
       y3_2(o,1)=0;
       y4_2(o,1)=0;
       y5_2(o,1)=0;
       y6_2(o,1)=0;
    end
end

% THIRD MEAL DISTURBANCE 
noise_meal_3_1=sqrt(Qk)*randn(1,1);
noise_meal_3_2=sqrt(Qk)*randn(1,1);
for o=1:T
    if(o>=x3(1,3) && o<(x3(1,3)+50))
       y3_3(o,1)=noise_meal_3_1;
       y4_3(o,1)=0;
       y5_3(o,1)=noise_meal_3_2;
       y6_3(o,1)=0;
    elseif(o<x3(1,3))
       y3_3(o,1)=0;
       y4_3(o,1)=0;
       y5_3(o,1)=0;
       y6_3(o,1)=0;
    elseif(o>=(x3(1,3)+50) && o<(x3(1,3)+75))
       y3_3(o,1)=noise_meal_3_1;
       y4_3(o,1)=0;
       y5_3(o,1)=0;
       y6_3(o,1)=noise_meal_3_2;
    elseif(o>=(x3(1,3)+75) && o<(x3(1,3)+100))
       y3_3(o,1)=0;
       y4_3(o,1)=noise_meal_3_1;
       y5_3(o,1)=0;
       y6_3(o,1)=noise_meal_3_2;
    elseif(o>=(x3(1,3)+100) && o<(x3(1,3)+120))
       y3_3(o,1)=0;
       y4_3(o,1)=noise_meal_3_1;
       y5_3(o,1)=0;
       y6_3(o,1)=noise_meal_3_2;
    elseif(o>=(x3(1,3)+120) && o<(x3(1,3)+180))
       y3_3(o,1)=0;
       y4_3(o,1)=noise_meal_3_1;
       y5_3(o,1)=0;
       y6_3(o,1)=0;
    else
       y3_3(o,1)=0;
       y4_3(o,1)=0;
       y5_3(o,1)=0;
       y6_3(o,1)=0;
    end
end


% FOURTH MEAL
noise_meal_4_1=sqrt(Qk)*randn(1,1);
noise_meal_4_2=sqrt(Qk)*randn(1,1);
for o=1:T
    if(o>=x3(1,4) && o<(x3(1,4)+50))
       y3_4(o,1)=noise_meal_4_1;
       y4_4(o,1)=0;
       y5_4(o,1)=noise_meal_4_2;
       y6_4(o,1)=0;
    elseif(o<x3(1,4))
       y3_4(o,1)=0;
       y4_4(o,1)=0;
       y5_4(o,1)=0;
       y6_4(o,1)=0;
    elseif(o>=(x3(1,4)+50) && o<(x3(1,4)+75))
       y3_4(o,1)=noise_meal_4_1;
       y4_4(o,1)=0;
       y5_4(o,1)=0;
       y6_4(o,1)=noise_meal_4_2;
    elseif(o>=(x3(1,4)+75) && o<(x3(1,4)+100))
       y3_4(o,1)=0;
       y4_4(o,1)=noise_meal_4_1;
       y5_4(o,1)=0;
       y6_4(o,1)=noise_meal_4_2;
    elseif(o>=(x3(1,4)+100) && o<(x3(1,4)+120))
       y3_4(o,1)=0;
       y4_4(o,1)=noise_meal_4_1;
       y5_4(o,1)=0;
       y6_4(o,1)=noise_meal_4_2;
    elseif(o>=(x3(1,4)+120) && o<(x3(1,4)+180))
       y3_4(o,1)=0;
       y4_4(o,1)=noise_meal_4_1;
       y5_4(o,1)=0;
       y6_4(o,1)=0;
    else
       y3_4(o,1)=0;
       y4_4(o,1)=0;
       y5_4(o,1)=0;
       y6_4(o,1)=0;
    end
end


% FIFTH MEAL
noise_meal_5_1=sqrt(Qk)*randn(1,1);
noise_meal_5_2=sqrt(Qk)*randn(1,1);
for o=1:T
    if(o>=x3(1,5) && o<(x3(1,5)+50))
       y3_5(o,1)=noise_meal_5_1;
       y4_5(o,1)=0;
       y5_5(o,1)=noise_meal_5_2;
       y6_5(o,1)=0;
    elseif(o<x3(1,5))
       y3_5(o,1)=0;
       y4_5(o,1)=0;
       y5_5(o,1)=0;
       y6_5(o,1)=0;
    elseif(o>=(x3(1,5)+50) && o<(x3(1,5)+75))
       y3_5(o,1)=noise_meal_5_1;
       y4_5(o,1)=0;
       y5_5(o,1)=0;
       y6_5(o,1)=noise_meal_5_2;
    elseif(o>=(x3(1,5)+75) && o<(x3(1,5)+100))
       y3_5(o,1)=0;
       y4_5(o,1)=noise_meal_5_1;
       y5_5(o,1)=0;
       y6_5(o,1)=noise_meal_5_2;
    elseif(o>=(x3(1,5)+100) && o<(x3(1,5)+120))
       y3_5(o,1)=0;
       y4_5(o,1)=noise_meal_5_1;
       y5_5(o,1)=0;
       y6_5(o,1)=noise_meal_5_2;
    elseif(o>=(x3(1,5)+120) && o<(x3(1,5)+180))
       y3_5(o,1)=0;
       y4_5(o,1)=noise_meal_5_1;
       y5_5(o,1)=0;
       y6_5(o,1)=0;
    else
       y3_5(o,1)=0;
       y4_5(o,1)=0;
       y5_5(o,1)=0;
       y6_5(o,1)=0;
    end
end

y3 = y3_1 + y3_2 + y3_3 + y3_4 + y3_5 ;
y4 = y4_1 + y4_2 + y4_3 + y4_4 + y4_5 ;
y5 = y5_1 + y5_2 + y5_3 + y5_4 + y5_5 ;
y6 = y6_1 + y6_2 + y6_3 + y6_4 + y6_5 ;

w = [ y3 y4 y5 y6 y1 y2 y7 ];  % Συνολικός θόρυβος εισόδων 

end