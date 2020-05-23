function z = bohachevsky(x)

x1 = x(1);
x2 = x(2);

func1 = x1^2;
func2 = 2*x2^2;
func3 = 0.3*cos(3*pi*x1);
func4 = 0.4*cos(4*pi*x2);

z = func1 + func2 - func3 - func4 + 0.7;

end