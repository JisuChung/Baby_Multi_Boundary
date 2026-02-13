%% [WWW VS sth] ACC (1 Crossing)



a = figure();
% a.Position = [2730 886 560 420];
clearvars WWW_Group MB_Group WWWavg WWWerr MBavg MBerr h p Two_Group SB_Group MB_Group

gi = 1
SB_Group{1} = WWW_Behavior_table.cross1_acc_what(WWW_group_select==gi);
SB_Group{3} = WWW_Behavior_table.cross1_acc_whatwhen(WWW_group_select ==gi);
SB_Group{5} = WWW_Behavior_table.cross1_acc_where(WWW_group_select ==gi);
SB_Group{7} = WWW_Behavior_table.cross1_acc_wherewhen(WWW_group_select ==gi);
SB_Group{9} = WWW_Behavior_table.cross1_acc_whatwhere(WWW_group_select ==gi);
SB_Group{11} = WWW_Behavior_table.cross1_acc_fullem(WWW_group_select ==gi);
% SB_Group{2} = []

% gi = 2
MB_Group{2} = Exp3_Behavior_table.select_acc_what;
MB_Group{4} = Exp3_Behavior_table.select_acc_whatwhen;
MB_Group{6} = Exp3_Behavior_table.select_acc_where;
MB_Group{8} = Exp3_Behavior_table.select_acc_wherewhen;
MB_Group{10} = Exp3_Behavior_table.select_acc_whatwhere;
MB_Group{12} = Exp3_Behavior_table.select_acc_fullem;




% avg & err
[SBavg, SBerr] = jh_mean_err(SB_Group);
[MBavg, MBerr] = jh_mean_err(MB_Group);


% stat ==================================================================

% anova
SB_Group_data = cell2mat(SB_Group');
sb_array = cell2mat(arrayfun(@(x) repmat(x, size(SB_Group{x})), [1 3 5 7 9 11], 'uni', 0)');
[~,tbl,sb_stats] = anova1(SB_Group_data,sb_array,'off');
sb_group_compare = multcompare(sb_stats,"Display","off")


MB_Group_data = cell2mat(MB_Group');
mb_array = cell2mat(arrayfun(@(x) repmat(x, size(MB_Group{x})), [2 4 6 8 10 12], 'uni', 0)');
[~,tbl,mb_stats] = anova1(MB_Group_data,mb_array,'off');
mb_group_compare = multcompare(mb_stats,"Display","off")


for ti = 1:6
    % ttest
    [h(ti), p(ti)] = ttest2(SB_Group{(ti-1)*2+1}, MB_Group{ti*2})
    % ranksum
%     [p(ti), h(ti)] = ranksum(round(SB_Group{(ti-1)*2+1},3), round(MB_Group{ti*2},3))

end

% ======================================================================

% draw bar


sb_fig_bar = jh_bar(SBavg, SBerr);  hold on;
sb_fig_bar.FaceColor = color_palette(2,:);

mb_fig_bar = jh_bar(MBavg, MBerr); hold on;
mb_fig_bar.FaceColor = color_palette(5,:); % .2 .2. 2; .3 .4 .5 ];

% if gi == 1
%     sb_fig_bar.FaceColor = [.4 .5 .7];
%     mb_fig_bar.FaceColor = [.5 .3 .7];
% end


% significance ==========================================================
for bi = 1:6
    ttp = p(bi);
    if ttp < 0.001
        title_groupdif = [ num2str(ttp,3) '***)' ];
        disp = '***';
    elseif ttp < 0.01
        title_groupdif = [ num2str(ttp,3) '**)' ];
        disp = '**';
    elseif ttp < 0.05
        title_groupdif = [ num2str(ttp,3) '*)' ];
        disp = '*';
    elseif ttp < 0.1
        title_groupdif = [ num2str(ttp,3) '+)' ];
        disp = '+';
    else
        title_groupdif = num2str(ttp,3);
        disp = '';
    end
    text((bi-1)*2+1.5, max([MBavg(bi*2), SBavg((bi-1)*2+1) ])+ 0.1, disp, 'FontSize', 10,'fontweight','bold', 'HorizontalAlignment', 'center', 'Color', 'black');

end

% =======================================================================

ylim([0 1.05])


% labels
acc_Labels = {'What'; ''; 'What+When'; ''; 'Where'; '';  'Where+When'; ''; 'What+Where'; '';  'FullEM' };
xticklabels(acc_Labels)
ylabel('Accuracy')

% title
% legend({'Non Boundary', '', 'Boundary'});
legend({'WCDI', '', 'EXP 3 all'}, 'EdgeColor', 'none', 'Location', 'Northeast');
% if gi = 1
%     title(['Accuracy'],'FontWeight','bold')
% else
    title(['1 crossing - Exp 3 VS WCDI'],'FontWeight','bold')

set(gca,'FontName','Arial','FontSize',13,'fontweight','bold','linewidth',2, 'box','off')


% end


%% [cond1 VS cond2] ACC (1 Crossing)


for tpi = 1:3
a = figure();
% a.Position = [2730 886 560 420];
clearvars WWW_Group MB_Group WWWavg WWWerr MBavg MBerr h p Two_Group SB_Group MB_Group

grouping_temp = exp2_age_group;

if tpi == 1
    grouping = ones(size(grouping_temp));
elseif tpi == 2
    grouping = ~grouping_temp;
elseif tpi == 3
    grouping = grouping_temp;
end

SB_Group{1} = Exp2_Behavior_table.select_ABD_acc_what(grouping==1);
SB_Group{3} = Exp2_Behavior_table.select_ABD_acc_whatwhen(grouping==1);
SB_Group{5} = Exp2_Behavior_table.select_ABD_acc_where(grouping==1);
SB_Group{7} = Exp2_Behavior_table.select_ABD_acc_wherewhen(grouping==1);
SB_Group{9} = Exp2_Behavior_table.select_ABD_acc_whatwhere(grouping==1);
SB_Group{11} = Exp2_Behavior_table.select_ABD_acc_fullem(grouping==1);
% SB_Group{2} = []

% gi = 2
MB_Group{2} = Exp2_Behavior_table.select_MBD_acc_what(grouping==1);
MB_Group{4} = Exp2_Behavior_table.select_MBD_acc_whatwhen(grouping==1);
MB_Group{6} = Exp2_Behavior_table.select_MBD_acc_where(grouping==1);
MB_Group{8} = Exp2_Behavior_table.select_MBD_acc_wherewhen(grouping==1);
MB_Group{10} = Exp2_Behavior_table.select_MBD_acc_whatwhere(grouping==1);
MB_Group{12} = Exp2_Behavior_table.select_MBD_acc_fullem(grouping==1);




% avg & err
[SBavg, SBerr] = jh_mean_err(SB_Group);
[MBavg, MBerr] = jh_mean_err(MB_Group);


% stat ==================================================================

% anova
SB_Group_data = cell2mat(SB_Group');
sb_array = cell2mat(arrayfun(@(x) repmat(x, size(SB_Group{x})), [1 3 5 7 9 11], 'uni', 0)');
[~,tbl,sb_stats] = anova1(SB_Group_data,sb_array,'off');
sb_group_compare = multcompare(sb_stats,"Display","off")


MB_Group_data = cell2mat(MB_Group');
mb_array = cell2mat(arrayfun(@(x) repmat(x, size(MB_Group{x})), [2 4 6 8 10 12], 'uni', 0)');
[~,tbl,mb_stats] = anova1(MB_Group_data,mb_array,'off');
mb_group_compare = multcompare(mb_stats,"Display","off")


for ti = 1:6
    % ttest
    [h(ti), p(ti)] = ttest2(SB_Group{(ti-1)*2+1}, MB_Group{ti*2})
    % ranksum
%     [p(ti), h(ti)] = ranksum(round(SB_Group{(ti-1)*2+1},3), round(MB_Group{ti*2},3))

end

% ======================================================================

% draw bar


sb_fig_bar = jh_bar(SBavg, SBerr);  hold on;
sb_fig_bar.FaceColor = light_color_palette(3,:);

mb_fig_bar = jh_bar(MBavg, MBerr); hold on;
mb_fig_bar.FaceColor = light_color_palette(4,:); % .2 .2. 2; .3 .4 .5 ];

% if gi == 1
%     sb_fig_bar.FaceColor = [.4 .5 .7];
%     mb_fig_bar.FaceColor = [.5 .3 .7];
% end


% significance ==========================================================
for bi = 1:6
    ttp = p(bi);
    if ttp < 0.001
        title_groupdif = [ num2str(ttp,3) '***)' ];
        disp = '***';
    elseif ttp < 0.01
        title_groupdif = [ num2str(ttp,3) '**)' ];
        disp = '**';
    elseif ttp < 0.05
        title_groupdif = [ num2str(ttp,3) '*)' ];
        disp = '*';
    elseif ttp < 0.1
        title_groupdif = [ num2str(ttp,3) '+)' ];
        disp = '+';
    else
        title_groupdif = num2str(ttp,3);
        disp = '';
    end
    text((bi-1)*2+1.5, max([MBavg(bi*2), SBavg((bi-1)*2+1) ])+ 0.1, disp, 'FontSize', 10,'fontweight','bold', 'HorizontalAlignment', 'center', 'Color', 'black');

end

% =======================================================================

ylim([0 1.05])


% labels
acc_Labels = {'What'; ''; 'What+When'; ''; 'Where'; '';  'Where+When'; ''; 'What+Where'; '';  'FullEM' };
xticklabels(acc_Labels)
ylabel('Accuracy')

% title
% legend({'Non Boundary', '', 'Boundary'});
legend({'VB', '', 'MB'}, 'EdgeColor', 'none', 'Location', 'Northeast');
% if gi = 1
%     title(['Accuracy'],'FontWeight','bold')
% else
if tpi == 1
    tifm = 'all';
elseif tpi == 2
    tifm = '< 7.5';
else
    tifm = '>= 7.5';
end

    title(['1 crossing - Exp 2 - ' tifm],'FontWeight','bold')

set(gca,'FontName','Arial','FontSize',13,'fontweight','bold','linewidth',2, 'box','off')


end

%% each exp - interference / age


for tpi = 1:3
a = figure();
a.Position = [680 486 296 392];
clearvars WWW_Group MB_Group WWWavg WWWerr MBavg MBerr h p Two_Group SB_Group TB_Group Three_Group avg err


% tpi = 1;

grouping_temp = exp3_age_group;

if tpi == 1
    grouping = ones(size(grouping_temp));
elseif tpi == 2
    grouping = ~grouping_temp;
elseif tpi == 3
    grouping = grouping_temp;
end


SB_Group = [Exp3_Behavior_table.inter_acc_cat1(grouping ==1);];


MB_Group = [Exp3_Behavior_table.inter_acc_cat2(grouping ==1);];

Three_Group = [SB_Group, MB_Group];


[h3, p3] = ttest(SB_Group, MB_Group)


boxplot(Three_Group,'Symbol','', 'BoxStyle','outline');

fig_box = findobj(gca,'Tag','Box');
for j=1:length(fig_box)
    if j == 1
        tj=1;
    elseif j== 2
        tj = 2;
    end
    patch(get(fig_box(j),'XData'),get(fig_box(j),'YData'),light_color_palette(tj,:),'FaceAlpha',0.2);
end

set(fig_box, 'LineWidth', 1.5)

h = findobj(gca, 'Type', 'line');
set(h, 'LineWidth', 1.5, 'Color', [.5 .5 .5])


hold on;

s1 = scatter([ones(size(SB_Group))], SB_Group);
s1.MarkerFaceColor = light_color_palette(2,:);
s1.MarkerFaceAlpha = .2;
s1.MarkerEdgeAlpha = 0;

s2 = scatter(ones(size(MB_Group))*2, MB_Group);
s2.MarkerFaceColor = color_palette(1,:);
s2.MarkerFaceAlpha = .2;
s2.MarkerEdgeAlpha = 0;

plot([1, 2], Three_Group, 'Color', [.7 .7 .7]);


for pp = 3
    ttp = p3;
    xtp = 1.5; xtpg = [1 2];
    ytp = max(nanmean(SB_Group)+0.25);
    if ttp < 0.005
        title_groupdif = [ num2str(ttp,3) '***)' ];
        disp = '***';
    elseif ttp < 0.01
        title_groupdif = [ num2str(ttp,3) '**)' ];
        disp = '**';
    elseif ttp < 0.05
        title_groupdif = [ num2str(ttp,3) '*)' ];
        disp = '*';
    elseif ttp < 0.1
        title_groupdif = [ num2str(ttp,3) '+)' ];
        disp = '+';
    else
        title_groupdif = num2str(ttp,3);
        disp = '';
    end

    text(xtp, ytp, disp, 'FontSize', 13,'fontweight','bold', 'HorizontalAlignment', 'center', 'Color', 'black');

    if ttp < 0.05
        %     plot(xtpg, [ytp-0.03 ytp-0.03], 'Color','black')
    end

end

% =======================================================================

ylim([0 1.2])


% labels
acc_Labels = {'1 Cat'; '2 Cat'; };
xticklabels(acc_Labels)

ylabel('Accuracy')


if tpi == 1
    tifm = 'all';
elseif tpi == 2
    tifm = '< 7.5';
else
    tifm = '>= 7.5';
end


% title
% legend({'Visual Boundary', '', 'Audio + Visual boundary'});
title(['Exp3 age ' tifm],'FontWeight','bold')
set(gca,'FontName','Arial','FontSize',13,'fontweight','bold','linewidth',2, 'box','off')



end


%% all exp


for tpi = 1:3
a = figure();
a.Position = [680 486 296 392];
clearvars WWW_Group MB_Group WWWavg WWWerr MBavg MBerr h p Two_Group SB_Group TB_Group Three_Group avg err


% tpi = 1;

grouping_temp = [www_age_group; exp1_age_group; exp2_age_group; exp3_age_group];

if tpi == 1
    grouping = ones(size(grouping_temp));
elseif tpi == 2
    grouping = ~grouping_temp;
elseif tpi == 3
    grouping = grouping_temp;
end


SB_Group_temp = [WWW_Behavior_table.inter_acc_cat1; Exp1_Behavior_table.inter_acc_cat1; Exp2_Behavior_table.inter_acc_cat1; Exp3_Behavior_table.inter_acc_cat1];
SB_Group = SB_Group_temp(grouping ==1);

MB_Group_temp = [WWW_Behavior_table.inter_acc_cat2; Exp1_Behavior_table.inter_acc_cat2; Exp2_Behavior_table.inter_acc_cat2; Exp3_Behavior_table.inter_acc_cat2];
MB_Group = MB_Group_temp(grouping ==1);

Three_Group = [SB_Group, MB_Group];


[h3, p3] = ttest(SB_Group, MB_Group)


boxplot(Three_Group,'Symbol','', 'BoxStyle','outline');

fig_box = findobj(gca,'Tag','Box');
for j=1:length(fig_box)
    if j == 1
        tj=1;
    elseif j== 2
        tj = 2;
    end
    patch(get(fig_box(j),'XData'),get(fig_box(j),'YData'),light_color_palette(tj,:),'FaceAlpha',0.2);
end

set(fig_box, 'LineWidth', 1.5)

h = findobj(gca, 'Type', 'line');
set(h, 'LineWidth', 1.5, 'Color', [.5 .5 .5])


hold on;

s1 = scatter([ones(size(SB_Group))], SB_Group);
s1.MarkerFaceColor = light_color_palette(2,:);
s1.MarkerFaceAlpha = .2;
s1.MarkerEdgeAlpha = 0;

s2 = scatter(ones(size(MB_Group))*2, MB_Group);
s2.MarkerFaceColor = color_palette(1,:);
s2.MarkerFaceAlpha = .2;
s2.MarkerEdgeAlpha = 0;

plot([1, 2], Three_Group, 'Color', [.7 .7 .7]);


for pp = 3
    ttp = p3;
    xtp = 1.5; xtpg = [1 2];
    ytp = max(nanmean(SB_Group)+0.25);
    if ttp < 0.005
        title_groupdif = [ num2str(ttp,3) '***)' ];
        disp = '***';
    elseif ttp < 0.01
        title_groupdif = [ num2str(ttp,3) '**)' ];
        disp = '**';
    elseif ttp < 0.05
        title_groupdif = [ num2str(ttp,3) '*)' ];
        disp = '*';
    elseif ttp < 0.1
        title_groupdif = [ num2str(ttp,3) '+)' ];
        disp = '+';
    else
        title_groupdif = num2str(ttp,3);
        disp = '';
    end

    text(xtp, ytp, disp, 'FontSize', 13,'fontweight','bold', 'HorizontalAlignment', 'center', 'Color', 'black');

    if ttp < 0.05
        %     plot(xtpg, [ytp-0.03 ytp-0.03], 'Color','black')
    end

end

% =======================================================================

ylim([0 1.2])


% labels
acc_Labels = {'1 Cat'; '2 Cat'; };
xticklabels(acc_Labels)

ylabel('Accuracy')


if tpi == 1
    tifm = 'all';
elseif tpi == 2
    tifm = '< 7.5';
else
    tifm = '>= 7.5';
end


% title
% legend({'Visual Boundary', '', 'Audio + Visual boundary'});
title(['ALL EXP age ' tifm],'FontWeight','bold')
set(gca,'FontName','Arial','FontSize',13,'fontweight','bold','linewidth',2, 'box','off')



end



%%

genderlist = {'남', '여'};
agelist = [5:9];
for age = 1:5
    for gender = 1:2
        www(age,gender) = sum(WWW_Behavior_table.age == agelist(age) & strcmp(WWW_Behavior_table.sex,genderlist{gender}));
        exp1(age,gender) = sum(Exp1_Behavior_table.age == agelist(age) & strcmp(Exp1_Behavior_table.sex,genderlist{gender}));
        exp2(age,gender) = sum(Exp2_Behavior_table.age == agelist(age) & strcmp(Exp2_Behavior_table.sex,genderlist{gender}));
        exp3(age,gender) = sum(Exp3_Behavior_table.age == agelist(age) & strcmp(Exp3_Behavior_table.sex,genderlist{gender}));
    end
end
sum(www)
sum(exp1)
sum(exp2)
sum(exp3)


