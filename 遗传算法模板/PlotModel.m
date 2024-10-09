%绘制结果
function PlotModel(chrom)
x = chrom(1);
y = chrom(2);
z = chrom(3);
figure(2)
scatter3(x, y, z, 'ko')
hold on
%创建网格数据：生成 X 和 Y 数据网格，这里 X 和 Y 的范围是从 -10 到 10，步长为 0.1。meshgrid 函数生成了一个二维网格，用于绘制网格曲面。
[X, Y] = meshgrid(-10:0.1:10);
%计算网格高度：基于网格数据 X 和 Y，计算 Z 的值。Z 的值由 sin(X) + cos(Y) + 0.1 * X + 0.1 * Y 确定，表示一个函数的值，通常用于生成三维曲面图。
Z =sin(X)+cos(Y)+0.1*X+0.1*Y;
%绘制网格曲面：在三维空间中绘制由 X、Y 和 Z 数据定义的网格曲面。这个网格曲面展示了 Z 随 X 和 Y 变化的情况。
mesh(X, Y, Z)

end

