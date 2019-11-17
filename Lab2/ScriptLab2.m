
x = linspace(0,2*pi,10);

P=eye(2);
J=[0,0;0,-1];
 A=[0,1;-1,0];
tiledlayout(2,1);
 nexttile;
for i=1:10
    WPC(1)=sin(x(i));
    WPC(2)=cos(x(i)); 
    a = sim('ModelLab2');
    plot(a.x(:,1),a.x(:,2));
    grid;
    hold on;    
end
nexttile;
for i=1:10
    r=max(abs(sin(x(i))),abs(cos(x(i))));
   WPC(1)=sin(x(i))/r;
    WPC(2)=cos(x(i))/r; 
    a = sim('ModelLab2');
    plot(a.x(:,1),a.x(:,2));
    grid;
    hold on;    
end



