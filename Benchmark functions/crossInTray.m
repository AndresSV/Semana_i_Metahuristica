function z = crossInTray(x)

x1 = x(1);
x2 = x(2);

func0 = (sqrt((x1^2)+(x2^2)))/pi;
func1 = (sin(x1)*sin(x2)*exp(abs(100-func0))+1);
func2 = abs(func1)^0.1;

z = -0.0001*func2;

end