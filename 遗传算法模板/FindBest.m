%选择淘汰

function chrom_best = FindBest(chrom, fitness, N_chrom)%求解最大值
chrom_best = zeros(1, N_chrom+1);
[maxNum, maxCorr] = max(fitness);%因为所有个体对应的适应度大小都被存放在fitness矩阵中
chrom_best(1:N_chrom) =chrom(maxCorr, :);
chrom_best(end) = maxNum;
end

% function chrom_best = FindBest(chrom, fitness, N_chrom)%求解最小值
% chrom_best = zeros(1, N_chrom+1);
% [minNum, minCorr] = min(fitness); % 这里用 min 代替 max
% chrom_best(1:N_chrom) = chrom(minCorr, :);
% chrom_best(end) = minNum;
% end


