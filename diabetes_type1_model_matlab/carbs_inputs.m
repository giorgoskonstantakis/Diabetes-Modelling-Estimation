function [y3,y4,y5,y6] = carbs_inputs(x3,x4,T)

% In this function we construct the carbohydrates' meal , which is
% separated in two different pieces , one piece with fast carbohydrate absorb
% and one with medium carbohydrate absorb. These two meals are represented
% by the 4 outputs of the function y3,y4,y5,y6 , two values for each meal
% because they are needed for the state space representation of the full
% system . Also , carbohydrates are given in x(15gr) units , for example ,
% if we want to represent a 60 gr carbohydrates meal , we are going to set
% the value equal to 60gr/15g = 4 .

% The inputs of the function are x3 : vector with the time moments of
% consuming a meal  , x4 : vector with the quantity of carbohydrates that
% are to be consumed every time moment , T : the number of glucose
% concentration samples for one full day ( 1440 + 1 samples , one sample every
% 5 minutes )


% FIRST MEAL DISTURBANCE
for o=1:T
    if(o>=x3(1,1) && o<(x3(1,1)+50))
       y3_1(o,1)=x4(1,1)/2;
       y4_1(o,1)=0;
       y5_1(o,1)=x4(1,1)/2;
       y6_1(o,1)=0;
    elseif(o<x3(1,1))
       y3_1(o,1)=0;
       y4_1(o,1)=0;
       y5_1(o,1)=0;
       y6_1(o,1)=0;
    elseif(o>=(x3(1,1)+50) && o<(x3(1,1)+75))
       y3_1(o,1)=x4(1,1)/2;
       y4_1(o,1)=0;
       y5_1(o,1)=0;
       y6_1(o,1)=x4(1,1)/2;
    elseif(o>=(x3(1,1)+75) && o<(x3(1,1)+100))
       y3_1(o,1)=0;
       y4_1(o,1)=x4(1,1)/2;
       y5_1(o,1)=0;
       y6_1(o,1)=x4(1,1)/2;
    elseif(o>=(x3(1,1)+100) && o<(x3(1,1)+120))
       y3_1(o,1)=0;
       y4_1(o,1)=x4(1,1)/2;
       y5_1(o,1)=0;
       y6_1(o,1)=x4(1,1)/2;
    elseif(o>=(x3(1,1)+120) && o<(x3(1,1)+180))
       y3_1(o,1)=0;
       y4_1(o,1)=x4(1,1)/2;
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
for o=1:T
    if(o>=x3(1,2) && o<(x3(1,2)+50))
       y3_2(o,1)=x4(1,2)/2;
       y4_2(o,1)=0;
       y5_2(o,1)=x4(1,2)/2;
       y6_2(o,1)=0;
    elseif(o<x3(1,2))
       y3_2(o,1)=0;
       y4_2(o,1)=0;
       y5_2(o,1)=0;
       y6_2(o,1)=0;
    elseif(o>=(x3(1,2)+50) && o<(x3(1,2)+75))
       y3_2(o,1)=x4(1,2)/2;
       y4_2(o,1)=0;
       y5_2(o,1)=0;
       y6_2(o,1)=x4(1,2)/2;
    elseif(o>=(x3(1,2)+75) && o<(x3(1,2)+100))
       y3_2(o,1)=0;
       y4_2(o,1)=x4(1,2)/2;
       y5_2(o,1)=0;
       y6_2(o,1)=x4(1,2)/2;
    elseif(o>=(x3(1,2)+100) && o<(x3(1,2)+120))
       y3_2(o,1)=0;
       y4_2(o,1)=x4(1,2)/2;
       y5_2(o,1)=0;
       y6_2(o,1)=x4(1,2)/2;
    elseif(o>=(x3(1,2)+120) && o<(x3(1,2)+180))
       y3_2(o,1)=0;
       y4_2(o,1)=x4(1,2)/2;
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
for o=1:T
    if(o>=x3(1,3) && o<(x3(1,3)+50))
       y3_3(o,1)=x4(1,3)/2;
       y4_3(o,1)=0;
       y5_3(o,1)=x4(1,3)/2;
       y6_3(o,1)=0;
    elseif(o<x3(1,3))
       y3_3(o,1)=0;
       y4_3(o,1)=0;
       y5_3(o,1)=0;
       y6_3(o,1)=0;
    elseif(o>=(x3(1,3)+50) && o<(x3(1,3)+75))
       y3_3(o,1)=x4(1,3)/2;
       y4_3(o,1)=0;
       y5_3(o,1)=0;
       y6_3(o,1)=x4(1,3)/2;
    elseif(o>=(x3(1,3)+75) && o<(x3(1,3)+100))
       y3_3(o,1)=0;
       y4_3(o,1)=x4(1,3)/2;
       y5_3(o,1)=0;
       y6_3(o,1)=x4(1,3)/2;
    elseif(o>=(x3(1,3)+100) && o<(x3(1,3)+120))
       y3_3(o,1)=0;
       y4_3(o,1)=x4(1,3)/2;
       y5_3(o,1)=0;
       y6_3(o,1)=x4(1,3)/2;
    elseif(o>=(x3(1,3)+120) && o<(x3(1,3)+180))
       y3_3(o,1)=0;
       y4_3(o,1)=x4(1,3)/2;
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
for o=1:T
    if(o>=x3(1,4) && o<(x3(1,4)+50))
       y3_4(o,1)=x4(1,4)/2;
       y4_4(o,1)=0;
       y5_4(o,1)=x4(1,4)/2;
       y6_4(o,1)=0;
    elseif(o<x3(1,4))
       y3_4(o,1)=0;
       y4_4(o,1)=0;
       y5_4(o,1)=0;
       y6_4(o,1)=0;
    elseif(o>=(x3(1,4)+50) && o<(x3(1,4)+75))
       y3_4(o,1)=x4(1,4)/2;
       y4_4(o,1)=0;
       y5_4(o,1)=0;
       y6_4(o,1)=x4(1,4)/2;
    elseif(o>=(x3(1,4)+75) && o<(x3(1,4)+100))
       y3_4(o,1)=0;
       y4_4(o,1)=x4(1,4)/2;
       y5_4(o,1)=0;
       y6_4(o,1)=x4(1,4)/2;
    elseif(o>=(x3(1,4)+100) && o<(x3(1,4)+120))
       y3_4(o,1)=0;
       y4_4(o,1)=x4(1,4)/2;
       y5_4(o,1)=0;
       y6_4(o,1)=x4(1,4)/2;
    elseif(o>=(x3(1,4)+120) && o<(x3(1,4)+180))
       y3_4(o,1)=0;
       y4_4(o,1)=x4(1,4)/2;
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
for o=1:T
    if(o>=x3(1,5) && o<(x3(1,5)+50))
       y3_5(o,1)=x4(1,5)/2;
       y4_5(o,1)=0;
       y5_5(o,1)=x4(1,5)/2;
       y6_5(o,1)=0;
    elseif(o<x3(1,5))
       y3_5(o,1)=0;
       y4_5(o,1)=0;
       y5_5(o,1)=0;
       y6_5(o,1)=0;
    elseif(o>=(x3(1,5)+50) && o<(x3(1,5)+75))
       y3_5(o,1)=x4(1,5)/2;
       y4_5(o,1)=0;
       y5_5(o,1)=0;
       y6_5(o,1)=x4(1,5)/2;
    elseif(o>=(x3(1,5)+75) && o<(x3(1,5)+100))
       y3_5(o,1)=0;
       y4_5(o,1)=x4(1,5)/2;
       y5_5(o,1)=0;
       y6_5(o,1)=x4(1,5)/2;
    elseif(o>=(x3(1,5)+100) && o<(x3(1,5)+120))
       y3_5(o,1)=0;
       y4_5(o,1)=x4(1,5)/2;
       y5_5(o,1)=0;
       y6_5(o,1)=x4(1,5)/2;
    elseif(o>=(x3(1,5)+120) && o<(x3(1,5)+180))
       y3_5(o,1)=0;
       y4_5(o,1)=x4(1,5)/2;
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

end