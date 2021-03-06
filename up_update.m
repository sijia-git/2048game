function data = up_update(data )
    %向上更新按钮
    %每列不为0的数据从上到下依次遍历，若当前点与下一点取值相等，则该点取值*2，下一点赋值为0    
    for i=1:4       
        a=data(:,i);%提取每一列数据      
        a(find(a==0))=[]; %删除每一列中所有为0的点
        a(length(a)+1:4)=0; %并在最后补0，保证维度不变
        for j=1:3
            %遍历该列中每一个点，如果下一个点与该点取值相等，
            %该点取值×2，下一个点赋0
            if a(j)==a(j+1)
                a(j)=2*a(j);
                a(j+1)=0;
            end
        end
        %删除每一列中所有为0的点，
        %并在最后补0，保证维度不变
        %并把更新后的列，重新赋给data
        a(find(a==0))=[];
        a(length(a)+1:4)=0;
        data(:,i)=a;
    end
end


