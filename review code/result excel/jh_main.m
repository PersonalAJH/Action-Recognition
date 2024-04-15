a = readtable("test.xlsx");
data = table2cell(a(:,1:2));
% table2matrix
table2matrix_ver2
Re1 = make_heat(Re);
% heatmap(Re1,'FontSize',30);