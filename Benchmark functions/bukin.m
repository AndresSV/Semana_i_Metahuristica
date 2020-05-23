function z = bukin(x)

x1 = x(1);
x2 = x(2);

func0 = sqrt(abs(x2-(0.01*(x1)^2)));
func1 = 100*func0;
func2 = 0.01*abs(x1+10);

z = func1+func2;

end