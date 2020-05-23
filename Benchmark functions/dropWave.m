function z = dropWave(x)

x1 = x(1);
x2 = x(2);

func0 = (0.5*((x1)^2 + (x2)^2))+2;
func1 = cos(12*sqrt((x1)^2+(x2)^2));

z = -((1+func1)/func0);

end