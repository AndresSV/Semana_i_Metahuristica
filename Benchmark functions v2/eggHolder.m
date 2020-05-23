function z = eggHolder(x)

x1 = x(1);
x2 = x(2);

func0 = x1*sin(sqrt(abs(x1-(x2+47))));
func1 = (x2+47)*sin(sqrt(abs(x2+(x1/2)+47)));

z = -func1-func0;

end