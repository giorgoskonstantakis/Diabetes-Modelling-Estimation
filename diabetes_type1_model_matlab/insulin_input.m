function [y1,y2,y3] = insulin_input(x1,x2,T)

% In this function we create the insulin dose . As insulin analog is used
% the Humalog Kwik-Pen analog . The 3 outputs y1,y2,y3 are combined to
% represent the functionality of insulin's dose .

% The inputs of the function are x1 : vector of time moments in which an
% insulin dose is injected on the subject , x2 : the amount of insulin
% units which are going to be used in each injection , T : the number of glucose
% concentration samples for one full day ( 1440 + 1 samples , one sample every
% 5 minutes ) . The insulin dose is given in insulin units , where in
% Humalog Kwik Pen analog  we have 100units/ml , and 3ml(3.5mg/ml)


y1=[zeros(x1(1,1)-1,1);x2(1,1);zeros(x1(1,2)-x1(1,1)-1,1);x2(1,2);zeros(x1(1,3)-x1(1,2)-1,1);x2(1,3);
    zeros(x1(1,4)-x1(1,3)-1,1);x2(1,4);zeros(x1(1,5)-x1(1,4)-1,1);x2(1,5);zeros(T-x1(1,5),1)];
y2=[zeros(x1(1,1)+99,1);x2(1,1);zeros(x1(1,2)-x1(1,1)-1,1);x2(1,2);zeros(x1(1,3)-x1(1,2)-1,1);x2(1,3);
    zeros(x1(1,4)-x1(1,3)-1,1);x2(1,4);zeros(x1(1,5)-x1(1,4)-1,1);x2(1,5);zeros(T-x1(1,5)-100,1)];
y3=[zeros(x1(1,1)+239,1);x2(1,1);zeros(x1(1,2)-x1(1,1)-1,1);x2(1,2);zeros(x1(1,3)-x1(1,2)-1,1);x2(1,3);
    zeros(x1(1,4)-x1(1,3)-1,1);x2(1,4);zeros(x1(1,5)-x1(1,4)-1,1);x2(1,5);zeros(T-x1(1,5)-240,1)];
end