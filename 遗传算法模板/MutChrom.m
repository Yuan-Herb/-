%变异处理
%% 用于对每代共100个个体进行变异处理
function chrom_new = MutChrom(chrom, mut, N, N_chrom, chrom_range, t, iter)
for i = 1:N %%N是个体总数，也就是每一代有多少头袋鼠
    for j = 1:N_chrom  %N_chrom是染色体节点数，就是有几条染色体
        mut_rand = rand; %随机生成一个数，代表自然里的基因突变，然后用改值来决定是否产生突变。
        if mut_rand <=mut  %mut代表突变概率，即产生突变的阈值，如果小于0.2的基因突变概率阈值才进行基因突变处理，否者不进行突变处理
            mut_pm = rand; %增加还是减少
            mut_num = rand*(1-t/iter)^2;
            if mut_pm<=0.5
                chrom(i, j)= chrom(i, j)*(1-mut_num);
            else
                chrom(i, j)= chrom(i, j)*(1+mut_num);
            end
            chrom(i, j) = IfOut(chrom(i, j), chrom_range(:, j)); %检验是否越界
        end
    end
end
chrom_new = chrom;%%把变异处理完后的结果存在新矩阵里

end

