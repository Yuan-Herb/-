%交叉处理
function chrom_new = AcrChrom(chrom, acr, N, N_chrom)
for i = 1:N
    acr_rand = rand;%生成一个代表该个体是否产生交叉的概率大小，用于判别是否进行交叉处理
    if acr_rand<acr %如果该个体的交叉概率值大于产生交叉处理的阈值，则对该个体的染色体（两条，因为此案例中有两个自变量）进行交叉处理
        acr_chrom = floor((N-1)*rand+1); %要交叉的染色体
        acr_node = floor((N_chrom-1)*rand+1); %要交叉的节点
        %交叉开始
        temp = chrom(i, acr_node);
        chrom(i, acr_node) = chrom(acr_chrom, acr_node); 
        chrom(acr_chrom, acr_node) = temp;
    end
end
chrom_new = chrom;

end

