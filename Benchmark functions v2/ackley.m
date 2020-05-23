function z = ackley(x)
a=20;
b=0.2;
c=2*pi;
d=6;
sum1=0;
sum2=0;

    for i=1:d
        sum1 =(x(i))^2 + sum1;
        sum2 = cos(c*x(i)) + sum2;
    end
    coef1 = sqrt(sum1/d)*(-b);
    coef2 = sum/d;
    
    z = -a*exp(coef1) - exp(coef2) + a + exp(1);
end

