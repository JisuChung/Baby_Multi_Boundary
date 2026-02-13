% group selection 

age_range = [7,8];
MB_reject.sub_reject = ismember(participant_info.ID, [240706404, 240706504]);
age_group = participant_info.age_yr>=age_range(1) &  participant_info.age_yr<= age_range(2);
www_age_group = www_participant_info.age_yr>=(age_range(1)) &  www_participant_info.age_yr<=(age_range(2)) ;
% age_group = ismember(participant_info.ID, [240709504])
% www_age_group = ismember(www_participant_info.ID, [240113601])
% age_group = participant_info.age_yr<=8 & participant_info.age_yr>=6;
% www_age_group = www_participant_info.age_yr<=8 & www_participant_info.age_yr>=6;



WWW_group_select = www_age_group;
MB_group_select = age_group & ~MB_reject.sub_reject;


Inter_Color = [.3 .7 .3; .6 .6 .6; .6 .8 .6];

em_color = [0.988235294117647	0.623529411764706	0.356862745098039;
0.988235294117647	0.623529411764706	0.356862745098039;
0.356862745098039	0.556862745098039	0.490196078431373;
0.356862745098039	0.556862745098039	0.490196078431373;
0.368627450980392	0.345098039215686	0.372549019607843;
0.282352941176471	0.262745098039216	0.286274509803922];


Inter_Color = [.3 .7 .3; .6 .6 .6; .6 .8 .6];


em_mb_color = [.5 .5 .5; .9 .5 .5];



%% AGE GROUP (before reject)

for ai = 4:9
    www_age_array(ai-3,1) = sum(strcmp(www_participant_info.sex, '남') & (www_participant_info.age_yr == ai));
    www_age_array(ai-3,2) = sum(strcmp(www_participant_info.sex, '여') & (www_participant_info.age_yr == ai));
    www_age_array(ai-3,3) = sum((www_participant_info.age_yr == ai));
    age_array(ai-3,1) = sum(strcmp(participant_info.sex, '남') & (participant_info.age_yr == ai));
    age_array(ai-3,2) = sum(strcmp(participant_info.sex, '여') & (participant_info.age_yr == ai));
    age_array(ai-3,3) = sum((participant_info.age_yr == ai));
end
for fi = 1:3
    www_age_array(7, fi) = sum(www_age_array(1:6,fi));
    age_array(7, fi) = sum(age_array(1:6,fi));
end

www_age_array
age_array
% www_age_table 


%% AGE GROUP (after reject)

for ai = 4:9
    www_age_array(ai-3,1) = sum(strcmp(www_participant_info.sex, '남') & (www_participant_info.age_yr == ai));
    www_age_array(ai-3,2) = sum(strcmp(www_participant_info.sex, '여') & (www_participant_info.age_yr == ai));
    www_age_array(ai-3,3) = sum((www_participant_info.age_yr == ai));
    age_array(ai-3,1) = sum(strcmp(participant_info.sex, '남') & (participant_info.age_yr == ai) & ~MB_reject.sub_reject);
    age_array(ai-3,2) = sum(strcmp(participant_info.sex, '여') & (participant_info.age_yr == ai) & ~MB_reject.sub_reject);
    age_array(ai-3,3) = sum((participant_info.age_yr == ai) & ~MB_reject.sub_reject);
end
for fi = 1:3
    www_age_array(7, fi) = sum(www_age_array(1:6,fi));
    age_array(7, fi) = sum(age_array(1:6,fi));
end

www_age_array
age_array
% www_age_table 

%% AGE HISTOGRAM
histo_group = age_group;
www_histo_group = www_age_group;


a = figure();
a.Position = [1000 918 205 253];
% subplot(2,1,1);
histogram(participant_info.age_yr((strcmp(participant_info.sex, '남') & (histo_group == 1)) == 1,:));hold on;
histogram(participant_info.age_yr((strcmp(participant_info.sex, '여') & (histo_group == 1)) == 1,:)); 
histogram(participant_info.age_yr(histo_group == 1), 'FaceColor','none');
xlim([age_range(1)-0.75 age_range(2)+0.75]);
ylim([0 25]);
title(['Boundary' newline '(n = ' num2str(sum(histo_group == 1)) ')' ] , 'FontSize',13, 'FontWeight','bold');

a = figure();
a.Position = [1000 918 205 253];
% subplot(2,1,1);

histogram(www_participant_info.age_yr((strcmp(www_participant_info.sex, '남') & (www_histo_group == 1)) == 1,:));hold on;
histogram(www_participant_info.age_yr((strcmp(www_participant_info.sex, '여') & (www_histo_group == 1)) == 1,:)); 
histogram(www_participant_info.age_yr(www_histo_group == 1), 'FaceColor','none');
xlim([age_range(1)-0.75 age_range(2)+0.75]);
ylim([0 25]);
title(['Non Boundary' newline '(n = ' num2str(sum(www_histo_group == 1)) ')' ], 'FontSize',13, 'FontWeight','bold');

%% acc www (all)
a = figure();
a.Position = [1053 623 560 420];
clearvars WWW_Group MB_Group WWWavg WWWerr MBavg MBerr h p Two_Group

WWW_Group{1} = WWW_Behavior_table.acc_what(WWW_group_select ==1);
WWW_Group{2} = WWW_Behavior_table.acc_whatwhen(WWW_group_select ==1);
WWW_Group{3} = WWW_Behavior_table.acc_where(WWW_group_select ==1);
WWW_Group{4} = WWW_Behavior_table.acc_wherewhen(WWW_group_select ==1);
WWW_Group{5} = WWW_Behavior_table.acc_whatwhere(WWW_group_select ==1);
WWW_Group{6} = WWW_Behavior_table.acc_fullem(WWW_group_select ==1);


MB_Group{1} = Behavior_table.acc_what(MB_group_select ==1);
MB_Group{2} = Behavior_table.acc_whatwhen(MB_group_select ==1);
MB_Group{3} = Behavior_table.acc_where(MB_group_select ==1);
MB_Group{4} = Behavior_table.acc_wherewhen(MB_group_select ==1);
MB_Group{5} = Behavior_table.acc_whatwhere(MB_group_select ==1);
MB_Group{6} = Behavior_table.acc_fullem(MB_group_select ==1);


% avg & err
[WWWavg, WWWerr] = jh_mean_err(WWW_Group);
[MBavg, MBerr] = jh_mean_err(MB_Group);


% stat ==================================================================

% anova
WWW_Group_data = cell2mat(WWW_Group');
www_array = cell2mat(arrayfun(@(x) repmat(x, size(WWW_Group{x})), 1:6, 'uni', 0)');
[~,tbl,www_stats] = anova1(WWW_Group_data,www_array,'off');
www_group_compare = multcompare(www_stats,"Display","off")


MB_Group_data = cell2mat(MB_Group');
mb_array = cell2mat(arrayfun(@(x) repmat(x, size(MB_Group{x})), 1:6, 'uni', 0)');
[~,tbl,mb_stats] = anova1(MB_Group_data,mb_array,'off');
mb_group_compare = multcompare(mb_stats,"Display","off")


for ti = 1:6
    % ttest
    [h(ti), p(ti)] = ttest2(WWW_Group{ti}, MB_Group{ti})

    % ranksum
%     [p(ti), h(ti)] = ranksum(round(WWW_Group{ti},3), round(MB_Group{ti},3))

end

% =======================================================================

% draw bar
mb_fig_bar = jh_bar(MBavg, MBerr); hold on;
mb_fig_bar.FaceColor = [.9 .5 .5]; % .2 .2. 2; .3 .4 .5 ];

www_fig_bar = jh_bar(WWWavg, WWWerr);  hold on;
www_fig_bar.FaceColor = [.5 .5 .5];

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
    text(bi, MBavg(bi)+ 0.1, disp, 'FontSize', 10,'fontweight','bold', 'HorizontalAlignment', 'center', 'Color', 'black');

end

% =======================================================================

ylim([0 max(MBavg+ 0.2)])


% labels
acc_Labels = {'What'; 'What+When'; 'Where'; 'Where+When'; 'What+Where'; 'FullEM'};
xticklabels(acc_Labels)
ylabel('Accuracy')

% title
% legend({'Boundary', '', 'Non boundary'});
% title(['Accuracy'],'FontWeight','bold')


%% acc www (all) (FOR PARENT)
a = figure();
a.Position = [1053 623 560 420];
clearvars WWW_Group MB_Group WWWavg WWWerr MBavg MBerr h p Two_Group

WWW_Group{1} = WWW_Behavior_table.acc_what(WWW_group_select ==1);
WWW_Group{2} = WWW_Behavior_table.acc_whatwhen(WWW_group_select ==1);
WWW_Group{3} = WWW_Behavior_table.acc_where(WWW_group_select ==1);
WWW_Group{4} = WWW_Behavior_table.acc_wherewhen(WWW_group_select ==1);
WWW_Group{5} = WWW_Behavior_table.acc_whatwhere(WWW_group_select ==1);
WWW_Group{6} = WWW_Behavior_table.acc_fullem(WWW_group_select ==1);


MB_Group{1} = Behavior_table.acc_what(MB_group_select ==1);
% MB_Group{2} = Behavior_table.acc_whatwhen(MB_group_select ==1);
MB_Group{2} = Behavior_table.acc_where(MB_group_select ==1);
% MB_Group{4} = Behavior_table.acc_wherewhen(MB_group_select ==1);
% MB_Group{5} = Behavior_table.acc_whatwhere(MB_group_select ==1);
MB_Group{4} = Behavior_table.acc_fullem(MB_group_select ==1);


% avg & err
[WWWavg, WWWerr] = jh_mean_err(WWW_Group);
[MBavg, MBerr] = jh_mean_err(MB_Group);


% stat ==================================================================

% anova
% WWW_Group_data = cell2mat(WWW_Group');
% www_array = cell2mat(arrayfun(@(x) repmat(x, size(WWW_Group{x})), 1:6, 'uni', 0)');
% [~,tbl,www_stats] = anova1(WWW_Group_data,www_array,'off');
% www_group_compare = multcompare(www_stats,"Display","off")
% 
% 
% MB_Group_data = cell2mat(MB_Group');
% mb_array = cell2mat(arrayfun(@(x) repmat(x, size(MB_Group{x})), 1:6, 'uni', 0)');
% [~,tbl,mb_stats] = anova1(MB_Group_data,mb_array,'off');
% mb_group_compare = multcompare(mb_stats,"Display","off")
% 
% 
% for ti = 1:6
%     % ttest
%     [h(ti), p(ti)] = ttest2(WWW_Group{ti}, MB_Group{ti})
% 
%     % ranksum
% %     [p(ti), h(ti)] = ranksum(round(WWW_Group{ti},3), round(MB_Group{ti},3))
% 
% end

% =======================================================================

% draw bar
mb_fig_bar = jh_bar(MBavg, MBerr); hold on;
mb_fig_bar.FaceColor = [.9 .5 .5]; % .2 .2. 2; .3 .4 .5 ];

% www_fig_bar = jh_bar(WWWavg, WWWerr);  hold on;
% www_fig_bar.FaceColor = [.5 .5 .5];

% significance ==========================================================
% for bi = 1:6
%     ttp = p(bi);
%     if ttp < 0.001
%         title_groupdif = [ num2str(ttp,3) '***)' ];
%         disp = '***';
%     elseif ttp < 0.01
%         title_groupdif = [ num2str(ttp,3) '**)' ];
%         disp = '**';
%     elseif ttp < 0.05
%         title_groupdif = [ num2str(ttp,3) '*)' ];
%         disp = '*';
%     elseif ttp < 0.1
%         title_groupdif = [ num2str(ttp,3) '+)' ];
%         disp = '+';
%     else
%         title_groupdif = num2str(ttp,3);
%         disp = '';
%     end
%     text(bi, MBavg(bi)+ 0.1, disp, 'FontSize', 10,'fontweight','bold', 'HorizontalAlignment', 'center', 'Color', 'black');
% 
% end

% =======================================================================

ylim([0 max(MBavg+ 0.2)])


% labels
acc_Labels = {'What'; 'Where'; ''; 'FullEM'; 'What+Where'; 'FullEM'};
xticklabels(acc_Labels)
ylabel('Accuracy')

% title
% legend({'Boundary', '', 'Non boundary'});
% title(['Accuracy'],'FontWeight','bold')


%% categorized location

a = figure();
a.Position = [1053 623 461 359];
clearvars WWW_Group MB_Group WWWavg WWWerr MBavg MBerr h p Two_Group

WWW_Group = WWW_Behavior_table.acc_location_cat(WWW_group_select ==1);
MB_Group = Behavior_table.acc_location_cat(MB_group_select ==1);

Two_Group = [{WWW_Group}, {MB_Group}];

[avg, err] = jh_mean_err(Two_Group);

[h, p] = ttest2(WWW_Group, MB_Group)

fig_bar = jh_bar(avg, err);  hold on;
fig_bar.FaceColor = [.6 .6 .8];

ttp = p;
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

text(1.5, max(avg+0.1), disp, 'FontSize', 13,'fontweight','bold', 'HorizontalAlignment', 'center', 'Color', 'black');

ylim([0 max(avg+ 0.2)])


% labels
acc_Labels = {'Non boundary'; 'Boundary'};
xticklabels(acc_Labels)
ylabel('Accuracy')


title(['Categorized Location'],'FontWeight','bold')

%% [www mb] categorized location

a = figure();
a.Position = [1053 623 461 359];
clearvars WWW_Group MB_Group WWWavg WWWerr MBavg MBerr h p Two_Group

WWW_Group = WWW_Behavior_table.cross1_acc_location_cat(WWW_group_select ==1);
MB_Group = Behavior_table.select_acc_location_cat(MB_group_select ==1);

Two_Group = [{WWW_Group}, {MB_Group}];

[avg, err] = jh_mean_err(Two_Group);

[h, p] = ttest2(WWW_Group, MB_Group)

fig_bar = jh_bar(avg, err);  hold on;
fig_bar.FaceColor = [.6 .6 .8];

ttp = p;
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

text(1.5, max(avg+0.1), disp, 'FontSize', 13,'fontweight','bold', 'HorizontalAlignment', 'center', 'Color', 'black');

ylim([0 max(avg+ 0.2)])


% labels
acc_Labels = {'Non boundary'; 'Boundary'};
xticklabels(acc_Labels)
ylabel('Accuracy')


title(['Categorized Location'],'FontWeight','bold')





%% [MB] categorized location

a = figure();
a.Position = [1053 623 461 359];
clearvars WWW_Group MB_Group WWWavg WWWerr MBavg MBerr h p Two_Group

WWW_Group = Behavior_table.select_ABD_acc_location_cat(MB_group_select ==1);
MB_Group = Behavior_table.select_MBD_acc_location_cat(MB_group_select ==1);

Two_Group = [{WWW_Group}, {MB_Group}];

[avg, err] = jh_mean_err(Two_Group);

[h, p] = ttest2(WWW_Group, MB_Group)

fig_bar = jh_bar(avg, err);  hold on;
fig_bar.FaceColor = [.6 .6 .8];

ttp = p;
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

text(1.5, max(avg+0.1), disp, 'FontSize', 13,'fontweight','bold', 'HorizontalAlignment', 'center', 'Color', 'black');

ylim([0 max(avg+ 0.2)])


% labels
acc_Labels = {'VISUAL'; 'MULTI'};
xticklabels(acc_Labels)
ylabel('Accuracy')


title(['Categorized Location'],'FontWeight','bold')

%% categorzed (no when)

a = figure();
a.Position = [1053 623 461 359];
clearvars WWW_Group MB_Group WWWavg WWWerr MBavg MBerr h p Two_Group

WWW_Group = WWW_Behavior_table.acc_location_cat_only(WW_group_select ==1);
MB_Group = Behavior_table.acc_location_cat_only(MB_group_select ==1);

Two_Group = [{WWW_Group}, {MB_Group}];

[avg, err] = jh_mean_err(Two_Group);

[h, p] = ttest2(WWW_Group, MB_Group)

fig_bar = jh_bar(avg, err);  hold on;
fig_bar.FaceColor = [.6 .6 .7];

ttp = p;
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

text(1.5, max(avg+0.1), disp, 'FontSize', 13,'fontweight','bold', 'HorizontalAlignment', 'center', 'Color', 'black');

ylim([0 max(avg+ 0.2)])


% labels
acc_Labels = {'Non boundary'; 'Boundary'};
xticklabels(acc_Labels)
ylabel('Accuracy')

title(['Categorized Location (no when)'],'FontWeight','bold')




%% reaction time (right wrong together)

a = figure();
a.Position = [1053 623 560 420];
clearvars WWW_Group MB_Group WWWavg WWWerr MBavg MBerr h p Two_Group


WWW_Group{1} = WWW_Behavior_table.rt_respond(WWW_group_select ==1);
WWW_Group{2} = [];
WWW_Group{3} = WWW_Behavior_table.rt_animal(WWW_group_select ==1);
WWW_Group{4} = WWW_Behavior_table.rt_location(WWW_group_select ==1);


MB_Group{1} = Behavior_table.rt_respond(MB_group_select ==1);
MB_Group{2} = [];
MB_Group{3} = Behavior_table.rt_animal(MB_group_select ==1);
MB_Group{4} = Behavior_table.rt_location(MB_group_select ==1);


% avg & err
[WWWavg, WWWerr] = jh_mean_err(WWW_Group);
[MBavg, MBerr] = jh_mean_err(MB_Group);


% stat ==================================================================

% anova
WWW_Group_data = cell2mat(WWW_Group');
www_array = cell2mat(arrayfun(@(x) repmat(x, size(WWW_Group{x})), [1,3,4], 'uni', 0)');
[~,tbl,www_stats] = anova1(WWW_Group_data,www_array,'off');
www_group_compare = multcompare(www_stats,"Display","off")


MB_Group_data = cell2mat(MB_Group');
mb_array = cell2mat(arrayfun(@(x) repmat(x, size(MB_Group{x})), [1,3,4], 'uni', 0)');
[~,tbl,mb_stats] = anova1(MB_Group_data,mb_array,'off');
mb_group_compare = multcompare(mb_stats,"Display","off")


for ti = 1:4
    if ismember(ti, [1,3,4])
    [h(ti), p(ti)] = ttest2(WWW_Group{ti}, MB_Group{ti})
    end
end

% =======================================================================

% draw bar
www_fig_bar = jh_bar(WWWavg, WWWerr);  hold on;
www_fig_bar.FaceColor = [.6 .6 .6];

mb_fig_bar = jh_bar(MBavg, MBerr); hold on;
mb_fig_bar.FaceColor = [.9 .6 .6]; % .2 .2. 2; .3 .4 .5 ];



% significance ==========================================================
for bi = 1:4
    if ismember(ti, [1,3,4])
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
    text(bi, WWWavg(bi)+ 1, disp, 'FontSize', 10,'fontweight','bold', 'HorizontalAlignment', 'center', 'Color', 'black');
    end
end

% =======================================================================

ylim([0 max(WWWavg+ 2)])


% labels
acc_Labels = {'Respond'; ''; 'What'; 'Where'};
xticklabels(acc_Labels)
ylabel('Reaction Time (sec)')

% title
legend({'Non Boundary', '', 'Boundary'});
% title(['Accuracy'],'FontWeight','bold')


%% reaction time (right trial only)

a = figure();
a.Position = [1053 623 560 420];
clearvars WWW_Group MB_Group WWWavg WWWerr MBavg MBerr h p Two_Group


WWW_Group{1} = WWW_Behavior_table.rt_right_respond(WWW_group_select ==1);
WWW_Group{2} = [];
WWW_Group{3} = WWW_Behavior_table.rt_right_animal(WWW_group_select ==1);
WWW_Group{4} = WWW_Behavior_table.rt_right_location(WWW_group_select ==1);


MB_Group{1} = Behavior_table.rt_right_respond(MB_group_select ==1);
MB_Group{2} = [];
MB_Group{3} = Behavior_table.rt_right_animal(MB_group_select ==1);
MB_Group{4} = Behavior_table.rt_right_location(MB_group_select ==1);


% avg & err
[WWWavg, WWWerr] = jh_mean_err(WWW_Group);
[MBavg, MBerr] = jh_mean_err(MB_Group);


% stat ==================================================================

% anova
WWW_Group_data = cell2mat(WWW_Group');
www_array = cell2mat(arrayfun(@(x) repmat(x, size(WWW_Group{x})), [1,3,4], 'uni', 0)');
[~,tbl,www_stats] = anova1(WWW_Group_data,www_array,'off');
www_group_compare = multcompare(www_stats,"Display","off")


MB_Group_data = cell2mat(MB_Group');
mb_array = cell2mat(arrayfun(@(x) repmat(x, size(MB_Group{x})), [1,3,4], 'uni', 0)');
[~,tbl,mb_stats] = anova1(MB_Group_data,mb_array,'off');
mb_group_compare = multcompare(mb_stats,"Display","off")


for ti = 1:4
    if ismember(ti, [1,3,4])
    [h(ti), p(ti)] = ttest2(WWW_Group{ti}, MB_Group{ti})
    end
end

% =======================================================================

% draw bar
www_fig_bar = jh_bar(WWWavg, WWWerr);  hold on;
www_fig_bar.FaceColor = [.6 .6 .6];

mb_fig_bar = jh_bar(MBavg, MBerr); hold on;
mb_fig_bar.FaceColor = [.9 .6 .6]; % .2 .2. 2; .3 .4 .5 ];



% significance ==========================================================
for bi = 1:4
    if ismember(ti, [1,3,4])
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
    text(bi, WWWavg(bi)+ 1, disp, 'FontSize', 10,'fontweight','bold', 'HorizontalAlignment', 'center', 'Color', 'black');
    end
end

% =======================================================================

ylim([0 max(WWWavg+ 2)])


% labels
acc_Labels = {'Respond'; ''; 'What'; 'Where'};
xticklabels(acc_Labels)
ylabel('Reaction Time (sec)')

% title
legend({'Boundary', '', 'Non boundary'});
% title(['Accuracy'],'FontWeight','bold')


%% [WWW VS MB] (ACC) all trials



a = figure();
a.Position = [2730 886 560 420];
clearvars WWW_Group MB_Group WWWavg WWWerr MBavg MBerr h p Two_Group SB_Group MB_Group

gi = 1
SB_Group{1} = WWW_Behavior_table.acc_what(WWW_group_select==gi);
SB_Group{3} = WWW_Behavior_table.acc_whatwhen(WWW_group_select ==gi);
SB_Group{5} = WWW_Behavior_table.acc_where(WWW_group_select ==gi);
SB_Group{7} = WWW_Behavior_table.acc_wherewhen(WWW_group_select ==gi);
SB_Group{9} = WWW_Behavior_table.acc_whatwhere(WWW_group_select ==gi);
SB_Group{11} = WWW_Behavior_table.acc_fullem(WWW_group_select ==gi);
% SB_Group{2} = []

% gi = 2
MB_Group{2} = Behavior_table.acc_what(MB_group_select ==gi);
MB_Group{4} = Behavior_table.acc_whatwhen(MB_group_select ==gi);
MB_Group{6} = Behavior_table.acc_where(MB_group_select ==gi);
MB_Group{8} = Behavior_table.acc_wherewhen(MB_group_select ==gi);
MB_Group{10} = Behavior_table.acc_whatwhere(MB_group_select ==gi);
MB_Group{12} = Behavior_table.acc_fullem(MB_group_select ==gi);




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
sb_fig_bar.FaceColor = [.5 .5 .5];

mb_fig_bar = jh_bar(MBavg, MBerr); hold on;
mb_fig_bar.FaceColor =[.9 .5 .5]; % .2 .2. 2; .3 .4 .5 ];

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
    text((bi-1)*2+1.5, MBavg(bi*2)+ 0.1, disp, 'FontSize', 10,'fontweight','bold', 'HorizontalAlignment', 'center', 'Color', 'black');

end

% =======================================================================

ylim([0 max(MBavg+ 0.2)])


% labels
acc_Labels = {'What'; ''; 'What+When'; ''; 'Where'; '';  'Where+When'; ''; 'What+Where'; '';  'FullEM' };
xticklabels(acc_Labels)
ylabel('Accuracy')

% title
legend({'Non Boundary', '', 'Boundary'});

% if gi = 1
%     title(['Accuracy'],'FontWeight','bold')
% else
    title(['all trials'],'FontWeight','bold')



% end
%% [MB] (ACC) 0 crossing vs 1,2 crossing 


a = figure();
a.Position = [2780 922 560 420];
clearvars WWW_Group MB_Group WWWavg WWWerr MBavg MBerr h p Two_Group SB_Group 

gi = 1
SB_Group{1} = Behavior_table.cross0_acc_what(MB_group_select ==gi);
% SB_Group{2} = [];
SB_Group{3} = Behavior_table.cross0_acc_where(MB_group_select ==gi);
SB_Group{7} = Behavior_table.cross0_acc_fullem(MB_group_select ==gi);

% gi = 2
MB_Group{2} = Behavior_table.cross1and2_acc_what(MB_group_select ==gi);
% MB_Group{2} = [];
MB_Group{4} = Behavior_table.cross1and2_acc_where(MB_group_select ==gi);
MB_Group{8} = Behavior_table.cross1and2_acc_fullem(MB_group_select ==gi);


% avg & err
[SBavg, SBerr] = jh_mean_err(SB_Group);
[MBavg, MBerr] = jh_mean_err(MB_Group);

for ti = 1:4
    if ismember(ti, [1,2,4])
        SBmed((ti-1)*2+1) = median(SB_Group{(ti-1)*2+1});
        MBmed(ti*2) = median(MB_Group{ti*2});
    end
end


% stat ==================================================================

% anova
SB_Group_data = cell2mat(SB_Group');
sb_array = cell2mat(arrayfun(@(x) repmat(x, size(SB_Group{x})), [1,3,7], 'uni', 0)');
[~,tbl,sb_stats] = anova1(SB_Group_data,sb_array,'off');
sb_group_compare = multcompare(sb_stats,"Display","off")


MB_Group_data = cell2mat(MB_Group');
mb_array = cell2mat(arrayfun(@(x) repmat(x, size(MB_Group{x})), [2,4,8], 'uni', 0)');
[~,tbl,mb_stats] = anova1(MB_Group_data,mb_array,'off');
mb_group_compare = multcompare(mb_stats,"Display","off")


for ti = 1:4
    if ismember(ti, [1,2,4])
        % ttest
        [h(ti), p(ti)] = ttest2(SB_Group{(ti-1)*2+1}, MB_Group{ti*2})
        % ranksum
%         [p(ti), h(ti)] = ranksum(round(SB_Group{(ti-1)*2+1},3), round(MB_Group{ti*2},3))

    end
end

% =======================================================================

% draw bar

% sb_fig_bar = jh_bar(SBavg, SBerr);  hold on;
% sb_fig_bar.FaceColor = [.6 .6 .6];
% 
% mb_fig_bar = jh_bar(MBavg, MBerr); hold on;
% mb_fig_bar.FaceColor = [.9 .6 .6]; % .2 .2. 2; .3 .4 .5 ];


sb_fig_bar = jh_bar(SBavg, SBerr);  hold on;
sb_fig_bar.FaceColor = [.5 .5 .5];

mb_fig_bar = jh_bar(MBavg, MBerr); hold on;
mb_fig_bar.FaceColor =[.9 .5 .5]; % .2 .2. 2; .3 .4 .5 ];


% if gi == 1
%     sb_fig_bar.FaceColor = [.4 .5 .7];
%     mb_fig_bar.FaceColor = [.5 .3 .7];
% end

% significance ==========================================================
for bi = 1:4
    if ismember(ti, [1,2,4])
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
    text((bi-1)*2+1.5, SBavg((bi-1)*2+1)+ 0.1, disp, 'FontSize', 10,'fontweight','bold', 'HorizontalAlignment', 'center', 'Color', 'black');
    end
end

% =======================================================================

% ylim([0 14])%max(MBavg+ 2)])
ylim([0 1.15])

% labels
acc_Labels = {'What'; ''; 'Where'; ''; ''; '';'full EM'};
xticklabels(acc_Labels)
ylabel('Accuracy')

% title
% legend({'Non Boundary', '', 'Boundary'});
title(['cross 0 vs 1&2'],'FontWeight','bold')
%% [MB] (ACC) 0,2 crossing vs 1 crossing 


a = figure();
a.Position = [2780 922 560 420];
clearvars WWW_Group MB_Group WWWavg WWWerr MBavg MBerr h p Two_Group SB_Group 

gi = 1
SB_Group{1} = Behavior_table.cross0and2_acc_what(MB_group_select ==gi);
% SB_Group{2} = [];
SB_Group{3} = Behavior_table.cross0and2_acc_where(MB_group_select ==gi);
SB_Group{7} = Behavior_table.cross0and2_acc_fullem(MB_group_select ==gi);

% gi = 2
MB_Group{2} = Behavior_table.select_acc_what(MB_group_select ==gi);
% MB_Group{2} = [];
MB_Group{4} = Behavior_table.select_acc_where(MB_group_select ==gi);
MB_Group{8} = Behavior_table.select_acc_fullem(MB_group_select ==gi);


% avg & err
[SBavg, SBerr] = jh_mean_err(SB_Group);
[MBavg, MBerr] = jh_mean_err(MB_Group);

for ti = 1:4
    if ismember(ti, [1,2,4])
        SBmed((ti-1)*2+1) = median(SB_Group{(ti-1)*2+1});
        MBmed(ti*2) = median(MB_Group{ti*2});
    end
end


% stat ==================================================================

% anova
SB_Group_data = cell2mat(SB_Group');
sb_array = cell2mat(arrayfun(@(x) repmat(x, size(SB_Group{x})), [1,3,7], 'uni', 0)');
[~,tbl,sb_stats] = anova1(SB_Group_data,sb_array,'off');
sb_group_compare = multcompare(sb_stats,"Display","off")


MB_Group_data = cell2mat(MB_Group');
mb_array = cell2mat(arrayfun(@(x) repmat(x, size(MB_Group{x})), [2,4,8], 'uni', 0)');
[~,tbl,mb_stats] = anova1(MB_Group_data,mb_array,'off');
mb_group_compare = multcompare(mb_stats,"Display","off")


for ti = 1:4
    if ismember(ti, [1,2,4])
        % ttest
        [h(ti), p(ti)] = ttest2(SB_Group{(ti-1)*2+1}, MB_Group{ti*2})
        % ranksum
%         [p(ti), h(ti)] = ranksum(round(SB_Group{(ti-1)*2+1},3), round(MB_Group{ti*2},3))

    end
end

% =======================================================================

% draw bar

% sb_fig_bar = jh_bar(SBavg, SBerr);  hold on;
% sb_fig_bar.FaceColor = [.6 .6 .6];
% 
% mb_fig_bar = jh_bar(MBavg, MBerr); hold on;
% mb_fig_bar.FaceColor = [.9 .6 .6]; % .2 .2. 2; .3 .4 .5 ];


sb_fig_bar = jh_bar(SBavg, SBerr);  hold on;
sb_fig_bar.FaceColor = [.5 .5 .5];

mb_fig_bar = jh_bar(MBavg, MBerr); hold on;
mb_fig_bar.FaceColor =[.9 .5 .5]; % .2 .2. 2; .3 .4 .5 ];


% if gi == 1
%     sb_fig_bar.FaceColor = [.4 .5 .7];
%     mb_fig_bar.FaceColor = [.5 .3 .7];
% end

% significance ==========================================================
for bi = 1:4
    if ismember(ti, [1,2,4])
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
    text((bi-1)*2+1.5, MBavg(bi*2)+ 0.1, disp, 'FontSize', 10,'fontweight','bold', 'HorizontalAlignment', 'center', 'Color', 'black');
    end
end

% =======================================================================

% ylim([0 14])%max(MBavg+ 2)])
ylim([0 1.15])

% labels
acc_Labels = {'What'; ''; 'Where'; ''; ''; '';'full EM'};
xticklabels(acc_Labels)
ylabel('Accuracy')

% title
% legend({'Non Boundary', '', 'Boundary'});
title(['cross 0&2 vs cross 1'],'FontWeight','bold')


%% [WWW VS MB] (ACC) all trials - for meeting (no association) form 1


a = figure();
a.Position = [2780 922 560 420];
clearvars WWW_Group MB_Group WWWavg WWWerr MBavg MBerr h p Two_Group SB_Group 

gi = 1
SB_Group{1} = WWW_Behavior_table.acc_what(WWW_group_select ==gi);
% SB_Group{2} = [];
SB_Group{3} = WWW_Behavior_table.acc_where(WWW_group_select ==gi);
SB_Group{7} = WWW_Behavior_table.acc_fullem(WWW_group_select ==gi);

% gi = 2
MB_Group{2} = Behavior_table.acc_what(MB_group_select ==gi);
% MB_Group{2} = [];
MB_Group{4} = Behavior_table.acc_where(MB_group_select ==gi);
MB_Group{8} = Behavior_table.acc_fullem(MB_group_select ==gi);


% avg & err
[SBavg, SBerr] = jh_mean_err(SB_Group);
[MBavg, MBerr] = jh_mean_err(MB_Group);

for ti = 1:4
    if ismember(ti, [1,2,4])
        SBmed((ti-1)*2+1) = median(SB_Group{(ti-1)*2+1});
        MBmed(ti*2) = median(MB_Group{ti*2});
    end
end


% stat ==================================================================

% anova
SB_Group_data = cell2mat(SB_Group');
sb_array = cell2mat(arrayfun(@(x) repmat(x, size(SB_Group{x})), [1,3,7], 'uni', 0)');
[~,tbl,sb_stats] = anova1(SB_Group_data,sb_array,'off');
sb_group_compare = multcompare(sb_stats,"Display","off")


MB_Group_data = cell2mat(MB_Group');
mb_array = cell2mat(arrayfun(@(x) repmat(x, size(MB_Group{x})), [2,4,8], 'uni', 0)');
[~,tbl,mb_stats] = anova1(MB_Group_data,mb_array,'off');
mb_group_compare = multcompare(mb_stats,"Display","off")


for ti = 1:4
    if ismember(ti, [1,2,4])
        % ttest
        [h(ti), p(ti)] = ttest2(SB_Group{(ti-1)*2+1}, MB_Group{ti*2})
        % ranksum
%         [p(ti), h(ti)] = ranksum(round(SB_Group{(ti-1)*2+1},3), round(MB_Group{ti*2},3))

    end
end

% =======================================================================

% draw bar

% sb_fig_bar = jh_bar(SBavg, SBerr);  hold on;
% sb_fig_bar.FaceColor = [.6 .6 .6];
% 
% mb_fig_bar = jh_bar(MBavg, MBerr); hold on;
% mb_fig_bar.FaceColor = [.9 .6 .6]; % .2 .2. 2; .3 .4 .5 ];


sb_fig_bar = jh_bar(SBavg, SBerr);  hold on;
sb_fig_bar.FaceColor = [.5 .5 .5];

mb_fig_bar = jh_bar(MBavg, MBerr); hold on;
mb_fig_bar.FaceColor =[.9 .5 .5]; % .2 .2. 2; .3 .4 .5 ];


% if gi == 1
%     sb_fig_bar.FaceColor = [.4 .5 .7];
%     mb_fig_bar.FaceColor = [.5 .3 .7];
% end

% significance ==========================================================
for bi = 1:4
    if ismember(ti, [1,2,4])
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
    text((bi-1)*2+1.5, MBavg(bi*2)+ 0.1, disp, 'FontSize', 10,'fontweight','bold', 'HorizontalAlignment', 'center', 'Color', 'black');
    end
end

% =======================================================================

% ylim([0 14])%max(MBavg+ 2)])


% labels
acc_Labels = {'What'; ''; 'Where'; ''; ''; '';'full EM'};
xticklabels(acc_Labels)
ylabel('Accuracy')

% title
legend({'Non Boundary', '', 'Boundary'});
title(['all trial'],'FontWeight','bold')

%% [WWW VS MB] (ACC) all trials - for meeting (no association) form 2



a = figure();
a.Position = [2730 886 359 420];
clearvars WWW_Group MB_Group WWWavg WWWerr MBavg MBerr h p Two_Group SB_Group MB_Group

gi = 1
SB_Group{1} = WWW_Behavior_table.acc_what(WWW_group_select==gi);
SB_Group{3} = WWW_Behavior_table.acc_where(WWW_group_select ==gi);
SB_Group{5} = WWW_Behavior_table.acc_fullem(WWW_group_select ==gi);
% SB_Group{7} = WWW_Behavior_table.acc_wherewhen(WWW_group_select ==gi);
% SB_Group{9} = WWW_Behavior_table.acc_whatwhere(WWW_group_select ==gi);
% SB_Group{11} = WWW_Behavior_table.acc_fullem(WWW_group_select ==gi);
% SB_Group{2} = []

% gi = 2
MB_Group{2} = Behavior_table.acc_what(MB_group_select ==gi);
MB_Group{4} = Behavior_table.acc_where(MB_group_select ==gi);
MB_Group{6} = Behavior_table.acc_fullem(MB_group_select ==gi);
% MB_Group{8} = Behavior_table.acc_wherewhen(MB_group_select ==gi);
% MB_Group{10} = Behavior_table.acc_whatwhere(MB_group_select ==gi);
% MB_Group{12} = Behavior_table.acc_fullem(MB_group_select ==gi);




% avg & err
[SBavg, SBerr] = jh_mean_err(SB_Group);
[MBavg, MBerr] = jh_mean_err(MB_Group);


% stat ==================================================================

% anova
SB_Group_data = cell2mat(SB_Group');
sb_array = cell2mat(arrayfun(@(x) repmat(x, size(SB_Group{x})), [1 3 5 ], 'uni', 0)');
[~,tbl,sb_stats] = anova1(SB_Group_data,sb_array,'off');
sb_group_compare = multcompare(sb_stats,"Display","off")


MB_Group_data = cell2mat(MB_Group');
mb_array = cell2mat(arrayfun(@(x) repmat(x, size(MB_Group{x})), [2 4 6 ], 'uni', 0)');
[~,tbl,mb_stats] = anova1(MB_Group_data,mb_array,'off');
mb_group_compare = multcompare(mb_stats,"Display","off")


for ti = 1:3
    % ttest
    [h(ti), p(ti)] = ttest2(SB_Group{(ti-1)*2+1}, MB_Group{ti*2})
    % ranksum
%     [p(ti), h(ti)] = ranksum(round(SB_Group{(ti-1)*2+1},3), round(MB_Group{ti*2},3))

end

% ======================================================================

% draw bar


sb_fig_bar = jh_bar(SBavg, SBerr);  hold on;
sb_fig_bar.FaceColor = [.5 .5 .5];

mb_fig_bar = jh_bar(MBavg, MBerr); hold on;
mb_fig_bar.FaceColor =[.9 .5 .5]; % .2 .2. 2; .3 .4 .5 ];

% if gi == 1
%     sb_fig_bar.FaceColor = [.4 .5 .7];
%     mb_fig_bar.FaceColor = [.5 .3 .7];
% end


% significance ==========================================================
for bi = 1:3
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
    text((bi-1)*2+1.5, MBavg(bi*2)+ 0.1, disp, 'FontSize', 10,'fontweight','bold', 'HorizontalAlignment', 'center', 'Color', 'black');

end

% =======================================================================

ylim([0 max(MBavg+ 0.2)])


% labels
acc_Labels = {'What'; ''; 'Where'; ''; 'FullEM'; ''; };
xticklabels(acc_Labels)
ylabel('Accuracy')

% title
legend({'Non Boundary', '', 'Boundary'},'Location','southwest');

% if gi = 1
%     title(['Accuracy'],'FontWeight','bold')
% else
    title(['all trials'],'FontWeight','bold')



% end






%% [WWW VS MB] (ACC) 1 Crossing 



a = figure();
a.Position = [2730 886 560 420];
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
MB_Group{2} = Behavior_table.select_acc_what(MB_group_select ==gi);
MB_Group{4} = Behavior_table.select_acc_whatwhen(MB_group_select ==gi);
MB_Group{6} = Behavior_table.select_acc_where(MB_group_select ==gi);
MB_Group{8} = Behavior_table.select_acc_wherewhen(MB_group_select ==gi);
MB_Group{10} = Behavior_table.select_acc_whatwhere(MB_group_select ==gi);
MB_Group{12} = Behavior_table.select_acc_fullem(MB_group_select ==gi);




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
%     [h(ti), p(ti)] = ttest2(SB_Group{(ti-1)*2+1}, MB_Group{ti*2})
    % ranksum
    [p(ti), h(ti)] = ranksum(round(SB_Group{(ti-1)*2+1},3), round(MB_Group{ti*2},3))

end

% ======================================================================

% draw bar


sb_fig_bar = jh_bar(SBavg, SBerr);  hold on;
sb_fig_bar.FaceColor = [.5 .5 .5];

mb_fig_bar = jh_bar(MBavg, MBerr); hold on;
mb_fig_bar.FaceColor =[.9 .5 .5]; % .2 .2. 2; .3 .4 .5 ];

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
    text((bi-1)*2+1.5, MBavg(bi*2)+ 0.1, disp, 'FontSize', 10,'fontweight','bold', 'HorizontalAlignment', 'center', 'Color', 'black');

end

% =======================================================================

ylim([0 max(MBavg+ 0.2)])


% labels
acc_Labels = {'What'; ''; 'What+When'; ''; 'Where'; '';  'Where+When'; ''; 'What+Where'; '';  'FullEM' };
xticklabels(acc_Labels)
ylabel('Accuracy')

% title
legend({'Non Boundary', '', 'Boundary'});

% if gi = 1
%     title(['Accuracy'],'FontWeight','bold')
% else
    title(['1 crossing'],'FontWeight','bold')



% end



%% [WWW VS MB] (ACC) 1 or 2 Crossing




a = figure();
a.Position = [2730 886 560 420];
clearvars WWW_Group MB_Group WWWavg WWWerr MBavg MBerr h p Two_Group SB_Group MB_Group

gi = 1
SB_Group{1} = WWW_Behavior_table.cross1and2_acc_what(WWW_group_select==gi);
SB_Group{3} = WWW_Behavior_table.cross1and2_acc_whatwhen(WWW_group_select ==gi);
SB_Group{5} = WWW_Behavior_table.cross1and2_acc_where(WWW_group_select ==gi);
SB_Group{7} = WWW_Behavior_table.cross1and2_acc_wherewhen(WWW_group_select ==gi);
SB_Group{9} = WWW_Behavior_table.cross1and2_acc_whatwhere(WWW_group_select ==gi);
SB_Group{11} = WWW_Behavior_table.cross1and2_acc_fullem(WWW_group_select ==gi);
% SB_Group{2} = []

% gi = 2
MB_Group{2} = Behavior_table.cross1and2_acc_what(MB_group_select ==gi);
MB_Group{4} = Behavior_table.cross1and2_acc_whatwhen(MB_group_select ==gi);
MB_Group{6} = Behavior_table.cross1and2_acc_where(MB_group_select ==gi);
MB_Group{8} = Behavior_table.cross1and2_acc_wherewhen(MB_group_select ==gi);
MB_Group{10} = Behavior_table.cross1and2_acc_whatwhere(MB_group_select ==gi);
MB_Group{12} = Behavior_table.cross1and2_acc_fullem(MB_group_select ==gi);




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
sb_fig_bar.FaceColor = [.5 .5 .5];

mb_fig_bar = jh_bar(MBavg, MBerr); hold on;
mb_fig_bar.FaceColor =[.9 .5 .5]; % .2 .2. 2; .3 .4 .5 ];

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
    text((bi-1)*2+1.5, MBavg(bi*2)+ 0.1, disp, 'FontSize', 10,'fontweight','bold', 'HorizontalAlignment', 'center', 'Color', 'black');

end

% =======================================================================

ylim([0 max(MBavg+ 0.2)])


% labels
acc_Labels = {'What'; ''; 'What+When'; ''; 'Where'; '';  'Where+When'; ''; 'What+Where'; '';  'FullEM' };
xticklabels(acc_Labels)
ylabel('Accuracy')

% title
legend({'Non Boundary', '', 'Boundary'});

% if gi = 1
%     title(['Accuracy'],'FontWeight','bold')
% else
    title(['1&2 crossing'],'FontWeight','bold')



% end



%% [WWW VS MB] (ACC) 0 Crossing 



a = figure();
a.Position = [2730 886 560 420];
clearvars WWW_Group MB_Group WWWavg WWWerr MBavg MBerr h p Two_Group SB_Group MB_Group

gi = 1
SB_Group{1} = WWW_Behavior_table.cross0_acc_what(WWW_group_select==gi);
SB_Group{3} = WWW_Behavior_table.cross0_acc_whatwhen(WWW_group_select ==gi);
SB_Group{5} = WWW_Behavior_table.cross0_acc_where(WWW_group_select ==gi);
SB_Group{7} = WWW_Behavior_table.cross0_acc_wherewhen(WWW_group_select ==gi);
SB_Group{9} = WWW_Behavior_table.cross0_acc_whatwhere(WWW_group_select ==gi);
SB_Group{11} = WWW_Behavior_table.cross0_acc_fullem(WWW_group_select ==gi);
% SB_Group{2} = []

% gi = 2
MB_Group{2} = Behavior_table.cross0_acc_what(MB_group_select ==gi);
MB_Group{4} = Behavior_table.cross0_acc_whatwhen(MB_group_select ==gi);
MB_Group{6} = Behavior_table.cross0_acc_where(MB_group_select ==gi);
MB_Group{8} = Behavior_table.cross0_acc_wherewhen(MB_group_select ==gi);
MB_Group{10} = Behavior_table.cross0_acc_whatwhere(MB_group_select ==gi);
MB_Group{12} = Behavior_table.cross0_acc_fullem(MB_group_select ==gi);




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
%     [h(ti), p(ti)] = ttest2(SB_Group{(ti-1)*2+1}, MB_Group{ti*2})
    % ranksum
    [p(ti), h(ti)] = ranksum(round(SB_Group{(ti-1)*2+1},3), round(MB_Group{ti*2},3))

end

% ======================================================================

% draw bar


sb_fig_bar = jh_bar(SBavg, SBerr);  hold on;
sb_fig_bar.FaceColor = [.5 .5 .5];

mb_fig_bar = jh_bar(MBavg, MBerr); hold on;
mb_fig_bar.FaceColor =[.9 .5 .5]; % .2 .2. 2; .3 .4 .5 ];

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
    text((bi-1)*2+1.5, MBavg(bi*2)+ 0.1, disp, 'FontSize', 10,'fontweight','bold', 'HorizontalAlignment', 'center', 'Color', 'black');

end

% =======================================================================

ylim([0 max(MBavg+ 0.2)])


% labels
acc_Labels = {'What'; ''; 'What+When'; ''; 'Where'; '';  'Where+When'; ''; 'What+Where'; '';  'FullEM' };
xticklabels(acc_Labels)
ylabel('Accuracy')

% title
legend({'Non Boundary', '', 'Boundary'});

% if gi = 1
%     title(['Accuracy'],'FontWeight','bold')
% else
    title(['0 crossing'],'FontWeight','bold')



% end
%% [WWW VS MB] (ACC) 2 Crossing 



a = figure();
a.Position = [2730 886 560 420];
clearvars WWW_Group MB_Group WWWavg WWWerr MBavg MBerr h p Two_Group SB_Group MB_Group

gi = 1
SB_Group{1} = WWW_Behavior_table.cross2_acc_what(WWW_group_select==gi);
SB_Group{3} = WWW_Behavior_table.cross2_acc_whatwhen(WWW_group_select ==gi);
SB_Group{5} = WWW_Behavior_table.cross2_acc_where(WWW_group_select ==gi);
SB_Group{7} = WWW_Behavior_table.cross2_acc_wherewhen(WWW_group_select ==gi);
SB_Group{9} = WWW_Behavior_table.cross2_acc_whatwhere(WWW_group_select ==gi);
SB_Group{11} = WWW_Behavior_table.cross2_acc_fullem(WWW_group_select ==gi);
% SB_Group{2} = []

% gi = 2
MB_Group{2} = Behavior_table.cross2_acc_what(MB_group_select ==gi);
MB_Group{4} = Behavior_table.cross2_acc_whatwhen(MB_group_select ==gi);
MB_Group{6} = Behavior_table.cross2_acc_where(MB_group_select ==gi);
MB_Group{8} = Behavior_table.cross2_acc_wherewhen(MB_group_select ==gi);
MB_Group{10} = Behavior_table.cross2_acc_whatwhere(MB_group_select ==gi);
MB_Group{12} = Behavior_table.cross2_acc_fullem(MB_group_select ==gi);




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
%     [h(ti), p(ti)] = ttest2(SB_Group{(ti-1)*2+1}, MB_Group{ti*2})
    % ranksum
    [p(ti), h(ti)] = ranksum(round(SB_Group{(ti-1)*2+1},3), round(MB_Group{ti*2},3))

end

% ======================================================================

% draw bar


sb_fig_bar = jh_bar(SBavg, SBerr);  hold on;
sb_fig_bar.FaceColor = [.5 .5 .5];

mb_fig_bar = jh_bar(MBavg, MBerr); hold on;
mb_fig_bar.FaceColor =[.9 .5 .5]; % .2 .2. 2; .3 .4 .5 ];

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
    text((bi-1)*2+1.5, MBavg(bi*2)+ 0.1, disp, 'FontSize', 10,'fontweight','bold', 'HorizontalAlignment', 'center', 'Color', 'black');

end

% =======================================================================

ylim([0 max(MBavg+ 0.2)])


% labels
acc_Labels = {'What'; ''; 'What+When'; ''; 'Where'; '';  'Where+When'; ''; 'What+Where'; '';  'FullEM' };
xticklabels(acc_Labels)
ylabel('Accuracy')

% title
legend({'Non Boundary', '', 'Boundary'});

% if gi = 1
%     title(['Accuracy'],'FontWeight','bold')
% else
    title(['2 crossing'],'FontWeight','bold')



% end


%% [WWW VS MB] (ACC) 0 and 2 Crossing 



a = figure();
a.Position = [2730 886 560 420];
clearvars WWW_Group MB_Group WWWavg WWWerr MBavg MBerr h p Two_Group SB_Group MB_Group

gi = 1
SB_Group{1} = WWW_Behavior_table.cross0and2_acc_what(WWW_group_select==gi);
SB_Group{3} = WWW_Behavior_table.cross0and2_acc_whatwhen(WWW_group_select ==gi);
SB_Group{5} = WWW_Behavior_table.cross0and2_acc_where(WWW_group_select ==gi);
SB_Group{7} = WWW_Behavior_table.cross0and2_acc_wherewhen(WWW_group_select ==gi);
SB_Group{9} = WWW_Behavior_table.cross0and2_acc_whatwhere(WWW_group_select ==gi);
SB_Group{11} = WWW_Behavior_table.cross0and2_acc_fullem(WWW_group_select ==gi);
% SB_Group{2} = []

% gi = 2
MB_Group{2} = Behavior_table.cross0and2_acc_what(MB_group_select ==gi);
MB_Group{4} = Behavior_table.cross0and2_acc_whatwhen(MB_group_select ==gi);
MB_Group{6} = Behavior_table.cross0and2_acc_where(MB_group_select ==gi);
MB_Group{8} = Behavior_table.cross0and2_acc_wherewhen(MB_group_select ==gi);
MB_Group{10} = Behavior_table.cross0and2_acc_whatwhere(MB_group_select ==gi);
MB_Group{12} = Behavior_table.cross0and2_acc_fullem(MB_group_select ==gi);




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
%     [h(ti), p(ti)] = ttest2(SB_Group{(ti-1)*2+1}, MB_Group{ti*2})
    % ranksum
    [p(ti), h(ti)] = ranksum(round(SB_Group{(ti-1)*2+1},3), round(MB_Group{ti*2},3))

end

% ======================================================================

% draw bar


sb_fig_bar = jh_bar(SBavg, SBerr);  hold on;
sb_fig_bar.FaceColor = [.5 .5 .5];

mb_fig_bar = jh_bar(MBavg, MBerr); hold on;
mb_fig_bar.FaceColor =[.9 .5 .5]; % .2 .2. 2; .3 .4 .5 ];

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
    text((bi-1)*2+1.5, MBavg(bi*2)+ 0.1, disp, 'FontSize', 10,'fontweight','bold', 'HorizontalAlignment', 'center', 'Color', 'black');

end

% =======================================================================

ylim([0 max(MBavg+ 0.2)])


% labels
acc_Labels = {'What'; ''; 'What+When'; ''; 'Where'; '';  'Where+When'; ''; 'What+Where'; '';  'FullEM' };
xticklabels(acc_Labels)
ylabel('Accuracy')

% title
legend({'Non Boundary', '', 'Boundary'});

% if gi = 1
%     title(['Accuracy'],'FontWeight','bold')
% else
    title(['0 & 2 crossing'],'FontWeight','bold')



% end

%% [WWW VS MB] (RT) all


a = figure();
a.Position = [2780 922 560 420];
clearvars WWW_Group MB_Group WWWavg WWWerr MBavg MBerr h p Two_Group SB_Group 

gi = 1
SB_Group{1} = WWW_Behavior_table.rt_respond(WWW_group_select ==gi);
% SB_Group{2} = [];
SB_Group{5} = WWW_Behavior_table.rt_animal(WWW_group_select ==gi);
SB_Group{7} = WWW_Behavior_table.rt_location(WWW_group_select ==gi);

% gi = 2
MB_Group{2} = Behavior_table.rt_respond(MB_group_select ==gi);
% MB_Group{2} = [];
MB_Group{6} = Behavior_table.rt_animal(MB_group_select ==gi);
MB_Group{8} = Behavior_table.rt_location(MB_group_select ==gi);


% avg & err
[SBavg, SBerr] = jh_mean_err(SB_Group);
[MBavg, MBerr] = jh_mean_err(MB_Group);

for ti = 1:4
    if ismember(ti, [1,3,4])
        SBmed((ti-1)*2+1) = median(SB_Group{(ti-1)*2+1});
        MBmed(ti*2) = median(MB_Group{ti*2});
    end
end


% stat ==================================================================

% anova
SB_Group_data = cell2mat(SB_Group');
sb_array = cell2mat(arrayfun(@(x) repmat(x, size(SB_Group{x})), [1,5,7], 'uni', 0)');
[~,tbl,sb_stats] = anova1(SB_Group_data,sb_array,'off');
sb_group_compare = multcompare(sb_stats,"Display","off")


MB_Group_data = cell2mat(MB_Group');
mb_array = cell2mat(arrayfun(@(x) repmat(x, size(MB_Group{x})), [2,6,8], 'uni', 0)');
[~,tbl,mb_stats] = anova1(MB_Group_data,mb_array,'off');
mb_group_compare = multcompare(mb_stats,"Display","off")


for ti = 1:4
    if ismember(ti, [1,3,4])
        % ttest
        [h(ti), p(ti)] = ttest2(SB_Group{(ti-1)*2+1}, MB_Group{ti*2})
        % ranksum
%         [p(ti), h(ti)] = ranksum(round(SB_Group{(ti-1)*2+1},3), round(MB_Group{ti*2},3))

    end
end

% =======================================================================

% draw bar

% sb_fig_bar = jh_bar(SBavg, SBerr);  hold on;
% sb_fig_bar.FaceColor = [.6 .6 .6];
% 
% mb_fig_bar = jh_bar(MBavg, MBerr); hold on;
% mb_fig_bar.FaceColor = [.9 .6 .6]; % .2 .2. 2; .3 .4 .5 ];

sb_fig_bar = jh_bar(SBmed, SBerr);  hold on;
sb_fig_bar.FaceColor = [.6 .6 .6];

mb_fig_bar = jh_bar(MBmed, MBerr); hold on;
mb_fig_bar.FaceColor = [.9 .6 .6]; % .2 .2. 2; .3 .4 .5 ];



% if gi == 1
%     sb_fig_bar.FaceColor = [.4 .5 .7];
%     mb_fig_bar.FaceColor = [.5 .3 .7];
% end

% significance ==========================================================
for bi = 1:4
    if ismember(ti, [1,3,4])
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
    text(bi+0.5, SBavg(bi)+ 1, disp, 'FontSize', 10,'fontweight','bold', 'HorizontalAlignment', 'center', 'Color', 'black');
    end
end

% =======================================================================

ylim([0 14])%max(MBavg+ 2)])


% labels
acc_Labels = {'Respond'; '';''; ''; 'What'; ''; 'Where'};
xticklabels(acc_Labels)
ylabel('Reaction Time (sec)')

% title
legend({'Non Boundary', '', 'Boundary'});
title(['all trial'],'FontWeight','bold')


%% [WWW VS MB] (RT) 1 Crossing


a = figure();
a.Position = [2780 922 560 420];
clearvars WWW_Group MB_Group WWWavg WWWerr MBavg MBerr h p Two_Group SB_Group 

gi = 1
SB_Group{1} = WWW_Behavior_table.cross1_rt_respond(WWW_group_select ==gi);
% SB_Group{2} = [];
SB_Group{5} = WWW_Behavior_table.cross1_rt_animal(WWW_group_select ==gi);
SB_Group{7} = WWW_Behavior_table.cross1_rt_location(WWW_group_select ==gi);

% gi = 2
MB_Group{2} = Behavior_table.select_rt_respond(MB_group_select ==gi);
% MB_Group{2} = [];
MB_Group{6} = Behavior_table.select_rt_animal(MB_group_select ==gi);
MB_Group{8} = Behavior_table.select_rt_location(MB_group_select ==gi);


% avg & err
[SBavg, SBerr] = jh_mean_err(SB_Group);
[MBavg, MBerr] = jh_mean_err(MB_Group);


% stat ==================================================================

% anova
SB_Group_data = cell2mat(SB_Group');
sb_array = cell2mat(arrayfun(@(x) repmat(x, size(SB_Group{x})), [1,5,7], 'uni', 0)');
[~,tbl,sb_stats] = anova1(SB_Group_data,sb_array,'off');
sb_group_compare = multcompare(sb_stats,"Display","off")


MB_Group_data = cell2mat(MB_Group');
mb_array = cell2mat(arrayfun(@(x) repmat(x, size(MB_Group{x})), [2,6,8], 'uni', 0)');
[~,tbl,mb_stats] = anova1(MB_Group_data,mb_array,'off');
mb_group_compare = multcompare(mb_stats,"Display","off")


for ti = 1:4
    if ismember(ti, [1,3,4])
        % ttest
        [h(ti), p(ti)] = ttest2(SB_Group{(ti-1)*2+1}, MB_Group{ti*2})
        % ranksum
%         [p(ti), h(ti)] = ranksum(round(SB_Group{(ti-1)*2+1},3), round(MB_Group{ti*2},3))

    end
end

% =======================================================================

% draw bar

sb_fig_bar = jh_bar(SBavg, SBerr);  hold on;
sb_fig_bar.FaceColor = [.6 .6 .6];

mb_fig_bar = jh_bar(MBavg, MBerr); hold on;
mb_fig_bar.FaceColor = [.9 .6 .6]; % .2 .2. 2; .3 .4 .5 ];



% if gi == 1
%     sb_fig_bar.FaceColor = [.4 .5 .7];
%     mb_fig_bar.FaceColor = [.5 .3 .7];
% end

% significance ==========================================================
for bi = 1:4
    if ismember(ti, [1,3,4])
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
    text(bi+0.5, SBavg(bi)+ 1, disp, 'FontSize', 10,'fontweight','bold', 'HorizontalAlignment', 'center', 'Color', 'black');
    end
end

% =======================================================================

ylim([0 14])%max(MBavg+ 2)])


% labels
acc_Labels = {'Respond'; '';''; ''; 'What'; ''; 'Where'};
xticklabels(acc_Labels)
ylabel('Reaction Time (sec)')

% title
legend({'Non Boundary', '', 'Boundary'});
title(['1 crossing'],'FontWeight','bold')



%% [WWW VS MB] (RT) 0 Crossing


a = figure();
a.Position = [2780 922 560 420];
clearvars WWW_Group MB_Group WWWavg WWWerr MBavg MBerr h p Two_Group SB_Group 

gi = 1
SB_Group{1} = rmmissing(WWW_Behavior_table.cross0_rt_respond(WWW_group_select ==gi));
% SB_Group{2} = [];
SB_Group{5} = rmmissing(WWW_Behavior_table.cross0_rt_animal(WWW_group_select ==gi));
SB_Group{7} = rmmissing(WWW_Behavior_table.cross0_rt_location(WWW_group_select ==gi));

% gi = 2
MB_Group{2} = rmmissing(Behavior_table.cross0_rt_respond(MB_group_select ==gi));
% MB_Group{2} = [];
MB_Group{6} = rmmissing(Behavior_table.cross0_rt_animal(MB_group_select ==gi));
MB_Group{8} = rmmissing(Behavior_table.cross0_rt_location(MB_group_select ==gi));


% avg & err
[SBavg, SBerr] = jh_mean_err(SB_Group);
[MBavg, MBerr] = jh_mean_err(MB_Group);



for ti = 1:4
    if ismember(ti, [1,3,4])
        SBmed((ti-1)*2+1) = median(SB_Group{(ti-1)*2+1});
        MBmed(ti*2) = median(MB_Group{ti*2});
    end
end

% stat ==================================================================

% anova
SB_Group_data = cell2mat(SB_Group');
sb_array = cell2mat(arrayfun(@(x) repmat(x, size(SB_Group{x})), [1,5,7], 'uni', 0)');
[~,tbl,sb_stats] = anova1(SB_Group_data,sb_array,'off');
sb_group_compare = multcompare(sb_stats,"Display","off")


MB_Group_data = cell2mat(MB_Group');
mb_array = cell2mat(arrayfun(@(x) repmat(x, size(MB_Group{x})), [2,6,8], 'uni', 0)');
[~,tbl,mb_stats] = anova1(MB_Group_data,mb_array,'off');
mb_group_compare = multcompare(mb_stats,"Display","off")


for ti = 1:4
    if ismember(ti, [1,3,4])
        % ttest
        [h(ti), p(ti)] = ttest2(SB_Group{(ti-1)*2+1}, MB_Group{ti*2})
        % ranksum
%         [p(ti), h(ti)] = ranksum(round(SB_Group{(ti-1)*2+1},3), round(MB_Group{ti*2},3))

    end
end

% =======================================================================

% draw bar

% sb_fig_bar = jh_bar(SBavg, SBerr, SB_Group);  hold on;
% sb_fig_bar.FaceColor = [.6 .6 .6];
% 
% mb_fig_bar = jh_bar(MBavg, MBerr, MB_Group); hold on;
% mb_fig_bar.FaceColor = [.9 .6 .6]; % .2 .2. 2; .3 .4 .5 ];
% 
sb_fig_bar = jh_bar(SBmed, SBerr);  hold on;
sb_fig_bar.FaceColor = [.6 .6 .6];

mb_fig_bar = jh_bar(MBmed, MBerr); hold on;
mb_fig_bar.FaceColor = [.9 .6 .6]; % .2 .2. 2; .3 .4 .5 ];




% if gi == 1
%     sb_fig_bar.FaceColor = [.4 .5 .7];
%     mb_fig_bar.FaceColor = [.5 .3 .7];
% end

% significance ==========================================================
for bi = 1:4
    if ismember(ti, [1,3,4])
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
    text(bi+0.5, SBavg(bi)+ 1, disp, 'FontSize', 10,'fontweight','bold', 'HorizontalAlignment', 'center', 'Color', 'black');
    end
end

% =======================================================================

ylim([0 14])%max(MBavg+ 2)])


% labels
acc_Labels = {'Respond'; '';''; ''; 'What'; ''; 'Where'};
xticklabels(acc_Labels)
ylabel('Reaction Time (sec)')

% title
legend({'Visual', '', 'Audio + Visual'});
title(['0 crossing'],'FontWeight','bold')


%% [WWW VS MB] (RT) 2 Crossing


a = figure();
a.Position = [2780 922 560 420];
clearvars WWW_Group MB_Group WWWavg WWWerr MBavg MBerr h p Two_Group SB_Group 

gi = 1
SB_Group{1} = WWW_Behavior_table.cross2_rt_respond(WWW_group_select ==gi);
% SB_Group{2} = [];
SB_Group{5} = WWW_Behavior_table.cross2_rt_animal(WWW_group_select ==gi);
SB_Group{7} = WWW_Behavior_table.cross2_rt_location(WWW_group_select ==gi);

% gi = 2
MB_Group{2} = Behavior_table.cross2_rt_respond(MB_group_select ==gi);
% MB_Group{2} = [];
MB_Group{6} = Behavior_table.cross2_rt_animal(MB_group_select ==gi);
MB_Group{8} = Behavior_table.cross2_rt_location(MB_group_select ==gi);


% avg & err
[SBavg, SBerr] = jh_mean_err(SB_Group);
[MBavg, MBerr] = jh_mean_err(MB_Group);


% stat ==================================================================

% anova
SB_Group_data = cell2mat(SB_Group');
sb_array = cell2mat(arrayfun(@(x) repmat(x, size(SB_Group{x})), [1,5,7], 'uni', 0)');
[~,tbl,sb_stats] = anova1(SB_Group_data,sb_array,'off');
sb_group_compare = multcompare(sb_stats,"Display","off")


MB_Group_data = cell2mat(MB_Group');
mb_array = cell2mat(arrayfun(@(x) repmat(x, size(MB_Group{x})), [2,6,8], 'uni', 0)');
[~,tbl,mb_stats] = anova1(MB_Group_data,mb_array,'off');
mb_group_compare = multcompare(mb_stats,"Display","off")


for ti = 1:4
    if ismember(ti, [1,3,4])
        % ttest
        [h(ti), p(ti)] = ttest2(SB_Group{(ti-1)*2+1}, MB_Group{ti*2})
        % ranksum
%         [p(ti), h(ti)] = ranksum(round(SB_Group{(ti-1)*2+1},3), round(MB_Group{ti*2},3))

    end
end

% =======================================================================

% draw bar

sb_fig_bar = jh_bar(SBavg, SBerr);  hold on;
sb_fig_bar.FaceColor = [.6 .6 .6];

mb_fig_bar = jh_bar(MBavg, MBerr); hold on;
mb_fig_bar.FaceColor = [.9 .6 .6]; % .2 .2. 2; .3 .4 .5 ];



% if gi == 1
%     sb_fig_bar.FaceColor = [.4 .5 .7];
%     mb_fig_bar.FaceColor = [.5 .3 .7];
% end

% significance ==========================================================
for bi = 1:4
    if ismember(ti, [1,3,4])
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
    text(bi+0.5, SBavg(bi)+ 1, disp, 'FontSize', 10,'fontweight','bold', 'HorizontalAlignment', 'center', 'Color', 'black');
    end
end

% =======================================================================

ylim([0 14])%max(MBavg+ 2)])


% labels
acc_Labels = {'Respond'; '';''; ''; 'What'; ''; 'Where'};
xticklabels(acc_Labels)
ylabel('Reaction Time (sec)')

% title
legend({'Visual', '', 'Audio + Visual'});
title(['2 crossing'],'FontWeight','bold')


%% [WWW VS MB] (RT) 0 and 2 Crossing


a = figure();
a.Position = [2780 922 560 420];
clearvars WWW_Group MB_Group WWWavg WWWerr MBavg MBerr h p Two_Group SB_Group 

gi = 1
SB_Group{1} = WWW_Behavior_table.cross0and2_rt_respond(WWW_group_select ==gi);
% SB_Group{2} = [];
SB_Group{5} = WWW_Behavior_table.cross0and2_rt_animal(WWW_group_select ==gi);
SB_Group{7} = WWW_Behavior_table.cross0and2_rt_location(WWW_group_select ==gi);

% gi = 2
MB_Group{2} = Behavior_table.cross0and2_rt_respond(MB_group_select ==gi);
% MB_Group{2} = [];
MB_Group{6} = Behavior_table.cross0and2_rt_animal(MB_group_select ==gi);
MB_Group{8} = Behavior_table.cross0and2_rt_location(MB_group_select ==gi);


% avg & err
[SBavg, SBerr] = jh_mean_err(SB_Group);
[MBavg, MBerr] = jh_mean_err(MB_Group);


% stat ==================================================================

% anova
SB_Group_data = cell2mat(SB_Group');
sb_array = cell2mat(arrayfun(@(x) repmat(x, size(SB_Group{x})), [1,5,7], 'uni', 0)');
[~,tbl,sb_stats] = anova1(SB_Group_data,sb_array,'off');
sb_group_compare = multcompare(sb_stats,"Display","off")


MB_Group_data = cell2mat(MB_Group');
mb_array = cell2mat(arrayfun(@(x) repmat(x, size(MB_Group{x})), [2,6,8], 'uni', 0)');
[~,tbl,mb_stats] = anova1(MB_Group_data,mb_array,'off');
mb_group_compare = multcompare(mb_stats,"Display","off")


for ti = 1:4
    if ismember(ti, [1,3,4])
        % ttest
        [h(ti), p(ti)] = ttest2(SB_Group{(ti-1)*2+1}, MB_Group{ti*2})
        % ranksum
%         [p(ti), h(ti)] = ranksum(round(SB_Group{(ti-1)*2+1},3), round(MB_Group{ti*2},3))

    end
end

% =======================================================================

% draw bar

sb_fig_bar = jh_bar(SBavg, SBerr);  hold on;
sb_fig_bar.FaceColor = [.6 .6 .6];

mb_fig_bar = jh_bar(MBavg, MBerr); hold on;
mb_fig_bar.FaceColor = [.9 .6 .6]; % .2 .2. 2; .3 .4 .5 ];



% if gi == 1
%     sb_fig_bar.FaceColor = [.4 .5 .7];
%     mb_fig_bar.FaceColor = [.5 .3 .7];
% end

% significance ==========================================================
for bi = 1:4
    if ismember(ti, [1,3,4])
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
    text(bi+0.5, SBavg(bi)+ 1, disp, 'FontSize', 10,'fontweight','bold', 'HorizontalAlignment', 'center', 'Color', 'black');
    end
end

% =======================================================================

ylim([0 14])%max(MBavg+ 2)])


% labels
acc_Labels = {'Respond'; '';''; ''; 'What'; ''; 'Where'};
xticklabels(acc_Labels)
ylabel('Reaction Time (sec)')

% title
legend({'Visual', '', 'Audio + Visual'});
title(['0 and 2 crossing'],'FontWeight','bold')

%% [WWW VS MB] (RT) 1 and 2 Crossing


a = figure();
a.Position = [2780 922 560 420];
clearvars WWW_Group MB_Group WWWavg WWWerr MBavg MBerr h p Two_Group SB_Group MBavg SBavg SBmed MBmed

gi = 1
SB_Group{1} = WWW_Behavior_table.cross1and2_rt_respond(WWW_group_select ==gi);
% SB_Group{2} = [];
SB_Group{5} = WWW_Behavior_table.cross1and2_rt_animal(WWW_group_select ==gi);
SB_Group{7} = WWW_Behavior_table.cross1and2_rt_location(WWW_group_select ==gi);

% gi = 2
MB_Group{2} = Behavior_table.cross1and2_rt_respond(MB_group_select ==gi);
% MB_Group{2} = [];
MB_Group{6} = Behavior_table.cross1and2_rt_animal(MB_group_select ==gi);
MB_Group{8} = Behavior_table.cross1and2_rt_location(MB_group_select ==gi);


% avg & err
[SBavg, SBerr] = jh_mean_err(SB_Group);
[MBavg, MBerr] = jh_mean_err(MB_Group);


for ti = 1:4
    if ismember(ti, [1,3,4])
        SBmed((ti-1)*2+1) = median(SB_Group{(ti-1)*2+1});
        MBmed(ti*2) = median(MB_Group{ti*2});
    end
end

% stat ==================================================================

% anova
SB_Group_data = cell2mat(SB_Group');
sb_array = cell2mat(arrayfun(@(x) repmat(x, size(SB_Group{x})), [1,5,7], 'uni', 0)');
[~,tbl,sb_stats] = anova1(SB_Group_data,sb_array,'off');
sb_group_compare = multcompare(sb_stats,"Display","off")


MB_Group_data = cell2mat(MB_Group');
mb_array = cell2mat(arrayfun(@(x) repmat(x, size(MB_Group{x})), [2,6,8], 'uni', 0)');
[~,tbl,mb_stats] = anova1(MB_Group_data,mb_array,'off');
mb_group_compare = multcompare(mb_stats,"Display","off")


for ti = 1:4
    if ismember(ti, [1,3,4])
        % ttest
        [h(ti), p(ti)] = ttest2(SB_Group{(ti-1)*2+1}, MB_Group{ti*2})
        % ranksum
%         [p(ti), h(ti)] = ranksum(round(SB_Group{(ti-1)*2+1},3), round(MB_Group{ti*2},3))

    end
end

% =======================================================================

% draw bar
% 
% sb_fig_bar = jh_bar(SBavg, SBerr);  hold on;
% sb_fig_bar.FaceColor = [.6 .6 .6];
% 
% mb_fig_bar = jh_bar(MBavg, MBerr); hold on;
% mb_fig_bar.FaceColor = [.9 .6 .6]; % .2 .2. 2; .3 .4 .5 ];


sb_fig_bar = jh_bar(SBmed, SBerr);  hold on;
sb_fig_bar.FaceColor = [.6 .6 .6];

mb_fig_bar = jh_bar(MBmed, MBerr); hold on;
mb_fig_bar.FaceColor = [.9 .6 .6]; % .2 .2. 2; .3 .4 .5 ];


% if gi == 1
%     sb_fig_bar.FaceColor = [.4 .5 .7];
%     mb_fig_bar.FaceColor = [.5 .3 .7];
% end

% significance ==========================================================
for bi = 1:4
    if ismember(ti, [1,3,4])
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
    text(bi+0.5, SBavg(bi)+ 1, disp, 'FontSize', 10,'fontweight','bold', 'HorizontalAlignment', 'center', 'Color', 'black');
    end
end

% =======================================================================

ylim([0 14])%max(MBavg+ 2)])


% labels
acc_Labels = {'Respond'; '';''; ''; 'What'; ''; 'Where'};
xticklabels(acc_Labels)
ylabel('Reaction Time (sec)')

% title
legend({'Visual', '', 'Audio + Visual'});
title(['1 and 2 crossing'],'FontWeight','bold')


%% [WWW VS MB] Location chunking

a = figure();
a.Position = [2655 612 337 420];
clearvars WWW_Group MB_Group WWWavg WWWerr MBavg MBerr h p Two_Group SB_Group

SB_Group{1} = [WWW_Behavior_table.loc_chunking(WWW_group_select ==1);];


MB_Group{2} = [Behavior_table.loc_chunking(MB_group_select ==1);];


% avg & err
[SBavg, SBerr] = jh_mean_err(SB_Group);
[MBavg, MBerr] = jh_mean_err(MB_Group);


for ti = 1:1
    % ttest
    [h(ti), p(ti)] = ttest2(SB_Group{(ti-1)*2+1}, MB_Group{ti*2})
    % ranksum
%     [p(ti), h(ti)] = signrank(round(SB_Group{(ti-1)*2+1},3), round(MB_Group{ti*2},3))
end


sb_fig_bar = jh_bar(SBavg, SBerr);  hold on;
sb_fig_bar.FaceColor = [.6 .6 .6];

mb_fig_bar = jh_bar(MBavg, MBerr); hold on;
mb_fig_bar.FaceColor = [.9 .6 .4]; % .2 .2. 2; .3 .4 .5 ];

% significance ==========================================================
for bi = 1:1
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
    text((bi-1)*2+1.5, MBavg(bi*2)+ 0.1, disp, 'FontSize', 10,'fontweight','bold', 'HorizontalAlignment', 'center', 'Color', 'black');

end

% =======================================================================

ylim([0 1.15])


% labels
acc_Labels = {'Non boundary'; ''; 'Boundary';};
xticklabels(acc_Labels)
ylabel('location chunking')


% title
% legend({'Visual Boundary', '', 'Audio + Visual boundary'});
title(['Location Chunking'],'FontWeight','bold')



%% [Interference] (cat 1 2)

a = figure();
a.Position = [2655 612 337 420];
clearvars WWW_Group MB_Group WWWavg WWWerr MBavg MBerr h p Two_Group SB_Group

SB_Group{1} = [Behavior_table.inter_acc_cat1(MB_group_select ==1); WWW_Behavior_table.inter_acc_cat1(WWW_group_select ==1)];


MB_Group{2} = [Behavior_table.inter_acc_cat2(MB_group_select ==1); WWW_Behavior_table.inter_acc_cat2(WWW_group_select ==1)];


% avg & err
[SBavg, SBerr] = jh_mean_err(SB_Group);
[MBavg, MBerr] = jh_mean_err(MB_Group);


for ti = 1:1
    % ttest
    [h(ti), p(ti)] = ttest(SB_Group{(ti-1)*2+1}, MB_Group{ti*2})
    % ranksum
%     [p(ti), h(ti)] = signrank(round(SB_Group{(ti-1)*2+1},3), round(MB_Group{ti*2},3))
end


sb_fig_bar = jh_bar(SBavg, SBerr);  hold on;
sb_fig_bar.FaceColor = [.6 .6 .6];

mb_fig_bar = jh_bar(MBavg, MBerr); hold on;
mb_fig_bar.FaceColor = [.5 .9 .5]; % .2 .2. 2; .3 .4 .5 ];

% significance ==========================================================
for bi = 1:1
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
    text((bi-1)*2+1.5, MBavg(bi*2)+ 0.1, disp, 'FontSize', 10,'fontweight','bold', 'HorizontalAlignment', 'center', 'Color', 'black');

end

% =======================================================================

ylim([0 1.15])


% labels
acc_Labels = {'1 Category'; '2 Category';};
xticklabels(acc_Labels)
ylabel('Accuracy')


% title
% legend({'Visual Boundary', '', 'Audio + Visual boundary'});
title(['Accuracy'],'FontWeight','bold')

%% [Interference]  (www & MB) (all cat1 cat2)


a = figure();
a.Position = [2655 612 337 420];
clearvars WWW_Group MB_Group WWWavg WWWerr MBavg MBerr h p Two_Group SB_Group TB_Group


TB_Group{1} = [Behavior_table.inter_acc(MB_group_select ==1); WWW_Behavior_table.inter_acc(WWW_group_select ==1)];


SB_Group{3} = [Behavior_table.inter_acc_cat1(MB_group_select ==1); WWW_Behavior_table.inter_acc_cat1(WWW_group_select ==1)];


MB_Group{4} = [Behavior_table.inter_acc_cat2(MB_group_select ==1); WWW_Behavior_table.inter_acc_cat2(WWW_group_select ==1)];


% avg & err
[TBavg, TBerr] = jh_mean_err(TB_Group);
[SBavg, SBerr] = jh_mean_err(SB_Group);
[MBavg, MBerr] = jh_mean_err(MB_Group);


for ti = 2:2
    % ttest
    [h(ti), p(ti)] = ttest(SB_Group{(ti-1)*2+1}, MB_Group{ti*2})
    % ranksum
%     [p(ti), h(ti)] = signrank(round(SB_Group{(ti-1)*2+1},3), round(MB_Group{ti*2},3))
end

tb_fig_bar = jh_bar(TBavg, TBerr); hold on;
tb_fig_bar.FaceColor = [.3 .7 .3]; % .2 .2. 2; .3 .4 .5 ];


sb_fig_bar = jh_bar(SBavg, SBerr);  hold on;
sb_fig_bar.FaceColor = [.6 .6 .6];

mb_fig_bar = jh_bar(MBavg, MBerr); hold on;
mb_fig_bar.FaceColor = [.6 .8 .6]; % .2 .2. 2; .3 .4 .5 ];

% significance ==========================================================
for bi = 2:2
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
    text((bi-1)*2+1.5, MBavg(bi*2)+ 0.05, disp, 'FontSize', 10,'fontweight','bold', 'HorizontalAlignment', 'center', 'Color', 'black');

end

% =======================================================================

ylim([0.5 1])


% labels
acc_Labels = {'all'; ''; '1 Category'; '2 Category';};
xticklabels(acc_Labels)

ylabel('Accuracy')


% title
% legend({'Visual Boundary', '', 'Audio + Visual boundary'});
title(['mb+www age ' num2str(age_range(1)) '-' num2str(age_range(2))],'FontWeight','bold')




%% [Interference]  (only MB)


a = figure();
a.Position = [2655 612 337 420];
clearvars WWW_Group MB_Group WWWavg WWWerr MBavg MBerr h p Two_Group SB_Group


TB_Group{1} = [Behavior_table.inter_acc(MB_group_select ==1)];


SB_Group{3} = [Behavior_table.inter_acc_cat1(MB_group_select ==1)];


MB_Group{4} = [Behavior_table.inter_acc_cat2(MB_group_select ==1)];


% avg & err
[TBavg, TBerr] = jh_mean_err(TB_Group);
[SBavg, SBerr] = jh_mean_err(SB_Group);
[MBavg, MBerr] = jh_mean_err(MB_Group);


for ti = 2:2
    % ttest
    [h(ti), p(ti)] = ttest(SB_Group{(ti-1)*2+1}, MB_Group{ti*2})
    % ranksum
%     [p(ti), h(ti)] = signrank(round(SB_Group{(ti-1)*2+1},3), round(MB_Group{ti*2},3))
end

tb_fig_bar = jh_bar(TBavg, TBerr); hold on;
tb_fig_bar.FaceColor = [.3 .7 .3]; % .2 .2. 2; .3 .4 .5 ];


sb_fig_bar = jh_bar(SBavg, SBerr);  hold on;
sb_fig_bar.FaceColor = [.6 .6 .6];

mb_fig_bar = jh_bar(MBavg, MBerr); hold on;
mb_fig_bar.FaceColor = [.6 .8 .6]; % .2 .2. 2; .3 .4 .5 ];

% significance ==========================================================
for bi = 2:2
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
    text((bi-1)*2+1.5, MBavg(bi*2)+ 0.05, disp, 'FontSize', 10,'fontweight','bold', 'HorizontalAlignment', 'center', 'Color', 'black');

end

% =======================================================================

ylim([0.5 1])


% labels
acc_Labels = {'all'; ''; '1 Category'; '2 Category';};
xticklabels(acc_Labels)

ylabel('Accuracy')


% title
% legend({'Visual Boundary', '', 'Audio + Visual boundary'});
title(['mb age ' num2str(age_range(1)) '-' num2str(age_range(2))],'FontWeight','bold')



%% [Interference] (ONLY WWW)

a = figure();
a.Position = [2655 612 337 420];
clearvars WWW_Group MB_Group WWWavg WWWerr MBavg MBerr h p Two_Group SB_Group


TB_Group{1} = [WWW_Behavior_table.inter_acc(WWW_group_select ==1)];


SB_Group{3} = [WWW_Behavior_table.inter_acc_cat1(WWW_group_select ==1)];


MB_Group{4} = [WWW_Behavior_table.inter_acc_cat2(WWW_group_select ==1)];


% avg & err
[TBavg, TBerr] = jh_mean_err(TB_Group);
[SBavg, SBerr] = jh_mean_err(SB_Group);
[MBavg, MBerr] = jh_mean_err(MB_Group);


for ti = 2:2
    % ttest
    [h(ti), p(ti)] = ttest(SB_Group{(ti-1)*2+1}, MB_Group{ti*2})
    % ranksum
%     [p(ti), h(ti)] = signrank(round(SB_Group{(ti-1)*2+1},3), round(MB_Group{ti*2},3))
end

tb_fig_bar = jh_bar(TBavg, TBerr); hold on;
tb_fig_bar.FaceColor = [.3 .7 .3]; % .2 .2. 2; .3 .4 .5 ];


sb_fig_bar = jh_bar(SBavg, SBerr);  hold on;
sb_fig_bar.FaceColor = [.6 .6 .6];

mb_fig_bar = jh_bar(MBavg, MBerr); hold on;
mb_fig_bar.FaceColor = [.6 .8 .6]; % .2 .2. 2; .3 .4 .5 ];

% significance ==========================================================
for bi = 2:2
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
    text((bi-1)*2+1.5, MBavg(bi*2)+ 0.05, disp, 'FontSize', 10,'fontweight','bold', 'HorizontalAlignment', 'center', 'Color', 'black');

end

% =======================================================================

ylim([0.5 1])


% labels
acc_Labels = {'all'; ''; '1 Category'; '2 Category';};
xticklabels(acc_Labels)

ylabel('Accuracy')


% title
% legend({'Visual Boundary', '', 'Audio + Visual boundary'});
title(['www age ' num2str(age_range(1)) '-' num2str(age_range(2))],'FontWeight','bold')



% for parent 
% 
% this_baby = [0.833333333333333, 0.708333333333333,	0.958333333333333];
% scatter([1,3,4],this_baby, 20, [.3 .3 .8])

%% only boundary -> [ single boundary & multiple boundary ] ==============

% MB_group_select = ones(size(age_group)); % select all sub
% MB_group_select = age_group;
% age_group = ones(size(participant_info.age_yr));

% age_group = ismember(participant_info.ID, [240709403])
% age_group = participant_info.age_yr<=9 & participant_info.age_yr>=6 ;%& ~ismember(participant_info.ID, [240709404, 240709504]);

% MB_group_select = age_group;


%% [MB] (ACC) 0,2 crossing vs 1 crossing (ABD & MBD)


a = figure();
a.Position = [2780 922 560 420];
clearvars WWW_Group MB_Group WWWavg WWWerr MBavg MBerr h p Two_Group SB_Group 

gi = 1
SB_Group{1} = Behavior_table.cross0and2_ABD_acc_what(MB_group_select ==gi);
% SB_Group{2} = [];
SB_Group{3} = Behavior_table.cross0and2_ABD_acc_where(MB_group_select ==gi);
SB_Group{7} = Behavior_table.cross0and2_ABD_acc_fullem(MB_group_select ==gi);

% gi = 2
MB_Group{2} = Behavior_table.select_ABD_acc_what(MB_group_select ==gi);
% MB_Group{2} = [];
MB_Group{4} = Behavior_table.select_ABD_acc_where(MB_group_select ==gi);
MB_Group{8} = Behavior_table.select_ABD_acc_fullem(MB_group_select ==gi);


% avg & err
[SBavg, SBerr] = jh_mean_err(SB_Group);
[MBavg, MBerr] = jh_mean_err(MB_Group);

for ti = 1:4
    if ismember(ti, [1,2,4])
        SBmed((ti-1)*2+1) = median(SB_Group{(ti-1)*2+1});
        MBmed(ti*2) = median(MB_Group{ti*2});
    end
end


% stat ==================================================================

% anova
SB_Group_data = cell2mat(SB_Group');
sb_array = cell2mat(arrayfun(@(x) repmat(x, size(SB_Group{x})), [1,3,7], 'uni', 0)');
[~,tbl,sb_stats] = anova1(SB_Group_data,sb_array,'off');
sb_group_compare = multcompare(sb_stats,"Display","off")


MB_Group_data = cell2mat(MB_Group');
mb_array = cell2mat(arrayfun(@(x) repmat(x, size(MB_Group{x})), [2,4,8], 'uni', 0)');
[~,tbl,mb_stats] = anova1(MB_Group_data,mb_array,'off');
mb_group_compare = multcompare(mb_stats,"Display","off")


for ti = 1:4
    if ismember(ti, [1,2,4])
        % ttest
        [h(ti), p(ti)] = ttest2(SB_Group{(ti-1)*2+1}, MB_Group{ti*2})
        % ranksum
%         [p(ti), h(ti)] = ranksum(round(SB_Group{(ti-1)*2+1},3), round(MB_Group{ti*2},3))

    end
end

% =======================================================================

% draw bar

% sb_fig_bar = jh_bar(SBavg, SBerr);  hold on;
% sb_fig_bar.FaceColor = [.6 .6 .6];
% 
% mb_fig_bar = jh_bar(MBavg, MBerr); hold on;
% mb_fig_bar.FaceColor = [.9 .6 .6]; % .2 .2. 2; .3 .4 .5 ];


sb_fig_bar = jh_bar(SBavg, SBerr);  hold on;
sb_fig_bar.FaceColor = [.5 .5 .5];

mb_fig_bar = jh_bar(MBavg, MBerr); hold on;
mb_fig_bar.FaceColor =[.5 .5 .9]; % .2 .2. 2; .3 .4 .5 ];


% if gi == 1
%     sb_fig_bar.FaceColor = [.4 .5 .7];
%     mb_fig_bar.FaceColor = [.5 .3 .7];
% end

% significance ==========================================================
for bi = 1:4
    if ismember(ti, [1,2,4])
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
    text((bi-1)*2+1.5, MBavg(bi*2)+ 0.1, disp, 'FontSize', 10,'fontweight','bold', 'HorizontalAlignment', 'center', 'Color', 'black');
    end
end

% =======================================================================

% ylim([0 14])%max(MBavg+ 2)])
ylim([0 1.15])

% labels
acc_Labels = {'What'; ''; 'Where'; ''; ''; '';'full EM'};
xticklabels(acc_Labels)
ylabel('Accuracy')

% title
% legend({'Non Boundary', '', 'Boundary'});
title(['Audio boundary ) cross 0&2 vs cross 1'],'FontWeight','bold')

% [MB] (ACC) 0,2 crossing vs 1 crossing (MBD)


a = figure();
a.Position = [2780 922 560 420];
clearvars WWW_Group MB_Group WWWavg WWWerr MBavg MBerr h p Two_Group SB_Group 

gi = 1
SB_Group{1} = Behavior_table.cross0and2_MBD_acc_what(MB_group_select ==gi);
% SB_Group{2} = [];
SB_Group{3} = Behavior_table.cross0and2_MBD_acc_where(MB_group_select ==gi);
SB_Group{7} = Behavior_table.cross0and2_MBD_acc_fullem(MB_group_select ==gi);

% gi = 2
MB_Group{2} = Behavior_table.select_MBD_acc_what(MB_group_select ==gi);
% MB_Group{2} = [];
MB_Group{4} = Behavior_table.select_MBD_acc_where(MB_group_select ==gi);
MB_Group{8} = Behavior_table.select_MBD_acc_fullem(MB_group_select ==gi);


% avg & err
[SBavg, SBerr] = jh_mean_err(SB_Group);
[MBavg, MBerr] = jh_mean_err(MB_Group);

for ti = 1:4
    if ismember(ti, [1,2,4])
        SBmed((ti-1)*2+1) = median(SB_Group{(ti-1)*2+1});
        MBmed(ti*2) = median(MB_Group{ti*2});
    end
end


% stat ==================================================================

% anova
SB_Group_data = cell2mat(SB_Group');
sb_array = cell2mat(arrayfun(@(x) repmat(x, size(SB_Group{x})), [1,3,7], 'uni', 0)');
[~,tbl,sb_stats] = anova1(SB_Group_data,sb_array,'off');
sb_group_compare = multcompare(sb_stats,"Display","off")


MB_Group_data = cell2mat(MB_Group');
mb_array = cell2mat(arrayfun(@(x) repmat(x, size(MB_Group{x})), [2,4,8], 'uni', 0)');
[~,tbl,mb_stats] = anova1(MB_Group_data,mb_array,'off');
mb_group_compare = multcompare(mb_stats,"Display","off")


for ti = 1:4
    if ismember(ti, [1,2,4])
        % ttest
        [h(ti), p(ti)] = ttest2(SB_Group{(ti-1)*2+1}, MB_Group{ti*2})
        % ranksum
%         [p(ti), h(ti)] = ranksum(round(SB_Group{(ti-1)*2+1},3), round(MB_Group{ti*2},3))

    end
end

% =======================================================================

% draw bar

% sb_fig_bar = jh_bar(SBavg, SBerr);  hold on;
% sb_fig_bar.FaceColor = [.6 .6 .6];
% 
% mb_fig_bar = jh_bar(MBavg, MBerr); hold on;
% mb_fig_bar.FaceColor = [.9 .6 .6]; % .2 .2. 2; .3 .4 .5 ];


sb_fig_bar = jh_bar(SBavg, SBerr);  hold on;
sb_fig_bar.FaceColor = [.5 .5 .5];

mb_fig_bar = jh_bar(MBavg, MBerr); hold on;
mb_fig_bar.FaceColor =[.8 .5 .9]; % .2 .2. 2; .3 .4 .5 ];


% if gi == 1
%     sb_fig_bar.FaceColor = [.4 .5 .7];
%     mb_fig_bar.FaceColor = [.5 .3 .7];
% end

% significance ==========================================================
for bi = 1:4
    if ismember(ti, [1,2,4])
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
    text((bi-1)*2+1.5, MBavg(bi*2)+ 0.1, disp, 'FontSize', 10,'fontweight','bold', 'HorizontalAlignment', 'center', 'Color', 'black');
    end
end

% =======================================================================

% ylim([0 14])%max(MBavg+ 2)])
ylim([0 1.15])

% labels
acc_Labels = {'What'; ''; 'Where'; ''; ''; '';'full EM'};
xticklabels(acc_Labels)
ylabel('Accuracy')

% title
% legend({'Non Boundary', '', 'Boundary'});
title(['MULTI boundary ) cross 0&2 vs cross 1'],'FontWeight','bold')



%% Single boundary / multiple boundary www




a = figure();
a.Position = [2730 886 560 420];
clearvars WWW_Group MB_Group WWWavg WWWerr MBavg MBerr h p Two_Group SB_Group MB_Group

SB_Group{1} = Behavior_table.all_ABD_acc_what(MB_group_select==1);
SB_Group{3} = Behavior_table.all_ABD_acc_whatwhen(MB_group_select ==1);
SB_Group{5} = Behavior_table.all_ABD_acc_where(MB_group_select ==1);
SB_Group{7} = Behavior_table.all_ABD_acc_wherewhen(MB_group_select ==1);
SB_Group{9} = Behavior_table.all_ABD_acc_whatwhere(MB_group_select ==1);
SB_Group{11} = Behavior_table.all_ABD_acc_fullem(MB_group_select ==1);
% SB_Group{2} = []

MB_Group{2} = Behavior_table.all_MBD_acc_what(MB_group_select ==1);
MB_Group{4} = Behavior_table.all_MBD_acc_whatwhen(MB_group_select ==1);
MB_Group{6} = Behavior_table.all_MBD_acc_where(MB_group_select ==1);
MB_Group{8} = Behavior_table.all_MBD_acc_wherewhen(MB_group_select ==1);
MB_Group{10} = Behavior_table.all_MBD_acc_whatwhere(MB_group_select ==1);
MB_Group{12} = Behavior_table.all_MBD_acc_fullem(MB_group_select ==1);




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
%     [h(ti), p(ti)] = ttest(SB_Group{(ti-1)*2+1}, MB_Group{ti*2})
    % ranksum
    [p(ti), h(ti)] = signrank(round(SB_Group{(ti-1)*2+1},3), round(MB_Group{ti*2},3))

end

% =======================================================================

% draw bar


sb_fig_bar = jh_bar(SBavg, SBerr);  hold on;
sb_fig_bar.FaceColor = [.6 .7 .9];

mb_fig_bar = jh_bar(MBavg, MBerr); hold on;
mb_fig_bar.FaceColor = [.7 .5 .9]; % .2 .2. 2; .3 .4 .5 ];

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
    text((bi-1)*2+1.5, MBavg(bi*2)+ 0.1, disp, 'FontSize', 10,'fontweight','bold', 'HorizontalAlignment', 'center', 'Color', 'black');

end

% =======================================================================

ylim([0 max(MBavg+ 0.2)])


% labels
acc_Labels = {'What'; ''; 'What+When'; ''; 'Where'; '';  'Where+When'; ''; 'What+Where'; '';  'FullEM' };
xticklabels(acc_Labels)
ylabel('Accuracy')

% title
legend({'Visual Boundary', '', 'Audio + Visual boundary'});
% title(['Accuracy'],'FontWeight','bold')


%% Single boundary / multiple boundary www (no association & parent report)




a = figure();
a.Position = [2730 886 560 420];
clearvars WWW_Group MB_Group WWWavg WWWerr MBavg MBerr h p Two_Group SB_Group MB_Group

SB_Group{1} = Behavior_table.all_ABD_acc_what(MB_group_select==1);
SB_Group{3} = Behavior_table.all_ABD_acc_where(MB_group_select ==1);
% SB_Group{5} = Behavior_table.all_ABD_acc_where(MB_group_select ==1);
SB_Group{7} = Behavior_table.all_ABD_acc_fullem(MB_group_select ==1);
% SB_Group{9} = Behavior_table.all_ABD_acc_whatwhere(MB_group_select ==1);
% SB_Group{11} = Behavior_table.all_ABD_acc_fullem(MB_group_select ==1);
% SB_Group{2} = []

MB_Group{2} = Behavior_table.all_MBD_acc_what(MB_group_select ==1);
MB_Group{4} = Behavior_table.all_MBD_acc_where(MB_group_select ==1);
% MB_Group{6} = Behavior_table.all_MBD_acc_where(MB_group_select ==1);
MB_Group{8} = Behavior_table.all_MBD_acc_fullem(MB_group_select ==1);
% MB_Group{10} = Behavior_table.all_MBD_acc_whatwhere(MB_group_select ==1);
% MB_Group{12} = Behavior_table.all_MBD_acc_fullem(MB_group_select ==1);




% avg & err
[SBavg, SBerr] = jh_mean_err(SB_Group);
[MBavg, MBerr] = jh_mean_err(MB_Group);


% stat ==================================================================

% anova
% SB_Group_data = cell2mat(SB_Group');
% sb_array = cell2mat(arrayfun(@(x) repmat(x, size(SB_Group{x})), [1 3 5 7 9 11], 'uni', 0)');
% [~,tbl,sb_stats] = anova1(SB_Group_data,sb_array,'off');
% sb_group_compare = multcompare(sb_stats,"Display","off")
% 
% 
% MB_Group_data = cell2mat(MB_Group');
% mb_array = cell2mat(arrayfun(@(x) repmat(x, size(MB_Group{x})), [2 4 6 8 10 12], 'uni', 0)');
% [~,tbl,mb_stats] = anova1(MB_Group_data,mb_array,'off');
% mb_group_compare = multcompare(mb_stats,"Display","off")

% 
% for ti = 1:6
%     % ttest
% %     [h(ti), p(ti)] = ttest(SB_Group{(ti-1)*2+1}, MB_Group{ti*2})
%     % ranksum
%     [p(ti), h(ti)] = signrank(round(SB_Group{(ti-1)*2+1},3), round(MB_Group{ti*2},3))
% 
% end

% =======================================================================

% draw bar


sb_fig_bar = jh_bar(SBavg);  hold on;
sb_fig_bar.FaceColor = [.6 .7 .9];

mb_fig_bar = jh_bar(MBavg); hold on;
mb_fig_bar.FaceColor = [.7 .5 .9]; % .2 .2. 2; .3 .4 .5 ];

% significance ==========================================================
% for bi = 1:6
%     ttp = p(bi);
%     if ttp < 0.001
%         title_groupdif = [ num2str(ttp,3) '***)' ];
%         disp = '***';
%     elseif ttp < 0.01
%         title_groupdif = [ num2str(ttp,3) '**)' ];
%         disp = '**';
%     elseif ttp < 0.05
%         title_groupdif = [ num2str(ttp,3) '*)' ];
%         disp = '*';
%     elseif ttp < 0.1
%         title_groupdif = [ num2str(ttp,3) '+)' ];
%         disp = '+';
%     else
%         title_groupdif = num2str(ttp,3);
%         disp = '';
%     end
%     text((bi-1)*2+1.5, MBavg(bi*2)+ 0.2, disp, 'FontSize', 10,'fontweight','bold', 'HorizontalAlignment', 'center', 'Color', 'black');
% 
% end

% =======================================================================

ylim([0 max(MBavg+ 0.2)])


% labels
acc_Labels = {'What'; ''; 'Where'; ''; '' ;'FullEM';};
xticklabels(acc_Labels)
ylabel('Accuracy')

% title
legend({'Visual Boundary', 'Audio + Visual boundary'});
% title(['Accuracy'],'FontWeight','bold')




%% Single boundary / multiple boundary categorized location

a = figure();
a.Position = [1053 623 461 359];
clearvars WWW_Group MB_Group WWWavg WWWerr MBavg MBerr h p Two_Group SB_Group

SB_Group = Behavior_table.all_ABD_acc_location_cat(MB_group_select ==1);
MB_Group = Behavior_table.all_MBD_acc_location_cat(MB_group_select ==1);

Two_Group = [{SB_Group}, {MB_Group}];

[avg, err] = jh_mean_err(Two_Group);

% ttest
[h, p] = ttest(SB_Group, MB_Group)
% ranksum
% [p, h] = ranksum(SB_Group, MB_Group)


fig_bar = jh_bar(avg, err);  hold on;
fig_bar.FaceColor = [.6 .6 .8];

ttp = p;
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

text(1.5, max(avg+0.1), disp, 'FontSize', 13,'fontweight','bold', 'HorizontalAlignment', 'center', 'Color', 'black');

ylim([0 max(avg+ 0.2)])


% labels
acc_Labels = {'Visual'; 'Audio + Visual'};
xticklabels(acc_Labels)
title(['Categorized Location'],'FontWeight','bold')

% 
% % title
% legend({'Visual Boundary', '', 'Audio + Visual boundary'});




%% Single boundary / multiple boundary RT



a = figure();
a.Position = [1053 623 560 420];
clearvars WWW_Group MB_Group WWWavg WWWerr MBavg MBerr h p Two_Group SB_Group 


SB_Group{1} = Behavior_table.all_ABD_rt_respond(MB_group_select ==1);
% SB_Group{2} = [];
SB_Group{5} = Behavior_table.all_ABD_rt_animal(MB_group_select ==1);
SB_Group{7} = Behavior_table.all_ABD_rt_location(MB_group_select ==1);


MB_Group{2} = Behavior_table.all_MBD_rt_respond(MB_group_select ==1);
% MB_Group{2} = [];
MB_Group{6} = Behavior_table.all_MBD_rt_animal(MB_group_select ==1);
MB_Group{8} = Behavior_table.all_MBD_rt_location(MB_group_select ==1);


% avg & err
[SBavg, SBerr] = jh_mean_err(SB_Group);
[MBavg, MBerr] = jh_mean_err(MB_Group);


% stat ==================================================================

% anova
SB_Group_data = cell2mat(SB_Group');
sb_array = cell2mat(arrayfun(@(x) repmat(x, size(SB_Group{x})), [1,5,7], 'uni', 0)');
[~,tbl,sb_stats] = anova1(SB_Group_data,sb_array,'off');
sb_group_compare = multcompare(sb_stats,"Display","off")


MB_Group_data = cell2mat(MB_Group');
mb_array = cell2mat(arrayfun(@(x) repmat(x, size(MB_Group{x})), [2,6,8], 'uni', 0)');
[~,tbl,mb_stats] = anova1(MB_Group_data,mb_array,'off');
mb_group_compare = multcompare(mb_stats,"Display","off")


for ti = 1:4
    if ismember(ti, [1,3,4])
        
        % ttest
%         [h(ti), p(ti)] = ttest(SB_Group{(ti-1)*2+1}, MB_Group{ti*2})
        % ranksum
        [p(ti), h(ti)] = signrank(round(SB_Group{(ti-1)*2+1}), round(MB_Group{ti*2}))

    end
end

% =======================================================================

% draw bar
sb_fig_bar = jh_bar(SBavg, SBerr);  hold on;
sb_fig_bar.FaceColor = [.6 .7 .9];

mb_fig_bar = jh_bar(MBavg, MBerr); hold on;
mb_fig_bar.FaceColor = [.7 .5 .9]; % .2 .2. 2; .3 .4 .5 ];


% significance ==========================================================
for bi = 1:4
    if ismember(ti, [1,3,4])
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
    text(bi+0.5, SBavg(bi)+ 1, disp, 'FontSize', 10,'fontweight','bold', 'HorizontalAlignment', 'center', 'Color', 'black');
    end
end

% =======================================================================

ylim([0 max(SBavg+ 2)])


% labels
acc_Labels = {'Respond'; '';''; ''; 'What'; ''; 'Where'};
xticklabels(acc_Labels)
ylabel('Reaction Time (sec)')

% title
legend({'Visual', '', 'Audio + Visual'});
% title(['Accuracy'],'FontWeight','bold')


%% Single boundary / multiple boundary RT (Right trial only)


a = figure();
a.Position = [1053 623 560 420];
clearvars WWW_Group MB_Group WWWavg WWWerr MBavg MBerr h p Two_Group SB_Group 


SB_Group{1} = Behavior_table.all_ABD_rt_right_respond(MB_group_select ==1);
% SB_Group{2} = [];
SB_Group{5} = Behavior_table.all_ABD_rt_right_animal(MB_group_select ==1);
SB_Group{7} = Behavior_table.all_ABD_rt_right_location(MB_group_select ==1);


MB_Group{2} = Behavior_table.all_MBD_rt_right_respond(MB_group_select ==1);
% MB_Group{2} = [];
MB_Group{6} = Behavior_table.all_MBD_rt_right_animal(MB_group_select ==1);
MB_Group{8} = Behavior_table.all_MBD_rt_right_location(MB_group_select ==1);


% avg & err
[SBavg, SBerr] = jh_mean_err(SB_Group);
[MBavg, MBerr] = jh_mean_err(MB_Group);


% stat ==================================================================

% anova
SB_Group_data = cell2mat(SB_Group');
sb_array = cell2mat(arrayfun(@(x) repmat(x, size(SB_Group{x})), [1,5,7], 'uni', 0)');
[~,tbl,sb_stats] = anova1(SB_Group_data,sb_array,'off');
sb_group_compare = multcompare(sb_stats,"Display","off")


MB_Group_data = cell2mat(MB_Group');
mb_array = cell2mat(arrayfun(@(x) repmat(x, size(MB_Group{x})), [2,6,8], 'uni', 0)');
[~,tbl,mb_stats] = anova1(MB_Group_data,mb_array,'off');
mb_group_compare = multcompare(mb_stats,"Display","off")


for ti = 1:4
    if ismember(ti, [1,3,4])
        
        % ttest
        [h(ti), p(ti)] = ttest(SB_Group{(ti-1)*2+1}, MB_Group{ti*2})
        % ranksum
%         [p(ti), h(ti)] = signrank(round(SB_Group{(ti-1)*2+1}), round(MB_Group{ti*2}))

    end
end

% =======================================================================

% draw bar
sb_fig_bar = jh_bar(SBavg, SBerr);  hold on;
sb_fig_bar.FaceColor = [.6 .7 .9];

mb_fig_bar = jh_bar(MBavg, MBerr); hold on;
mb_fig_bar.FaceColor = [.7 .5 .9]; % .2 .2. 2; .3 .4 .5 ];


% significance ==========================================================
for bi = 1:4
    if ismember(ti, [1,3,4])
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
    text(bi+0.5, SBavg(bi)+ 1, disp, 'FontSize', 10,'fontweight','bold', 'HorizontalAlignment', 'center', 'Color', 'black');
    end
end

% =======================================================================

ylim([0 max(SBavg+ 2)])


% labels
acc_Labels = {'Respond'; '';''; ''; 'What'; ''; 'Where'};
xticklabels(acc_Labels)
ylabel('Reaction Time (sec)')

% title
legend({'Visual', '', 'Audio + Visual'});
% title(['Accuracy'],'FontWeight','bold')





%% only boundary crossing 1 trials 

%% Single boundary / multiple boundary  (selected trials = cross 1)


a = figure();
a.Position = [1053 623 560 420];
clearvars WWW_Group MB_Group WWWavg WWWerr MBavg MBerr h p Two_Group SB_Group

SB_Group{1} = Behavior_table.select_ABD_acc_what(MB_group_select ==1);
SB_Group{3} = Behavior_table.select_ABD_acc_whatwhen(MB_group_select ==1);
SB_Group{5} = Behavior_table.select_ABD_acc_where(MB_group_select ==1);
SB_Group{7} = Behavior_table.select_ABD_acc_wherewhen(MB_group_select ==1);
SB_Group{9} = Behavior_table.select_ABD_acc_whatwhere(MB_group_select ==1);
SB_Group{11} = Behavior_table.select_ABD_acc_fullem(MB_group_select ==1);
% SB_Group{2} = []

MB_Group{2} = Behavior_table.select_MBD_acc_what(MB_group_select ==1);
MB_Group{4} = Behavior_table.select_MBD_acc_whatwhen(MB_group_select ==1);
MB_Group{6} = Behavior_table.select_MBD_acc_where(MB_group_select ==1);
MB_Group{8} = Behavior_table.select_MBD_acc_wherewhen(MB_group_select ==1);
MB_Group{10} = Behavior_table.select_MBD_acc_whatwhere(MB_group_select ==1);
MB_Group{12} = Behavior_table.select_MBD_acc_fullem(MB_group_select ==1);




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
%     [h(ti), p(ti)] = ttest(SB_Grosup{(ti-1)*2+1}, MB_Group{ti*2})
    % ranksum
    [p(ti), h(ti)] = signrank(round(SB_Group{(ti-1)*2+1},3), round(MB_Group{ti*2},3))
end

% =======================================================================

% draw bar


sb_fig_bar = jh_bar(SBavg, SBerr);  hold on;
sb_fig_bar.FaceColor = [.6 .7 .9];

mb_fig_bar = jh_bar(MBavg, MBerr); hold on;
mb_fig_bar.FaceColor = [.7 .5 .9]; % .2 .2. 2; .3 .4 .5 ];

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
    text((bi-1)*2+1.5, SBavg((bi-1)*2+1)+ 0.1, disp, 'FontSize', 10,'fontweight','bold', 'HorizontalAlignment', 'center', 'Color', 'black');

end

% =======================================================================

ylim([0 max(MBavg+ 0.2)])


% labels
acc_Labels = {'What'; ''; 'What+When'; ''; 'Where'; '';  'Where+When'; ''; 'What+Where'; '';  'FullEM' };
xticklabels(acc_Labels)
ylabel('Accuracy')


% title
legend({'Visual Boundary', '', 'Audio + Visual boundary'});
% title(['Accuracy'],'FontWeight','bold')



%% Single boundary / multiple boundary  (across within)


a = figure();
a.Position = [1053 623 560 420];
clearvars WWW_Group MB_Group WWWavg WWWerr MBavg MBerr h p Two_Group SB_Group

SB_Group{1} = Behavior_table.all_ABD_across_acc(MB_group_select ==1);
SB_Group{3} = Behavior_table.all_ABD_within_acc(MB_group_select ==1);

% SB_Group{2} = []

MB_Group{2} = Behavior_table.all_MBD_across_acc(MB_group_select ==1);
MB_Group{4} = Behavior_table.all_MBD_within_acc(MB_group_select ==1);





% avg & err
[SBavg, SBerr] = jh_mean_err(SB_Group);
[MBavg, MBerr] = jh_mean_err(MB_Group);


% stat ==================================================================

% anova
SB_Group_data = cell2mat(SB_Group');
sb_array = cell2mat(arrayfun(@(x) repmat(x, size(SB_Group{x})), [1 3], 'uni', 0)');
[~,tbl,sb_stats] = anova1(SB_Group_data,sb_array,'off');
sb_group_compare = multcompare(sb_stats,"Display","off")


MB_Group_data = cell2mat(MB_Group');
mb_array = cell2mat(arrayfun(@(x) repmat(x, size(MB_Group{x})), [2 4], 'uni', 0)');
[~,tbl,mb_stats] = anova1(MB_Group_data,mb_array,'off');
mb_group_compare = multcompare(mb_stats,"Display","off")


for ti = 1:2
    % ttest
    [h(ti), p(ti)] = ttest(SB_Group{(ti-1)*2+1}, MB_Group{ti*2})
    % ranksum
%     [p(ti), h(ti)] = signrank(round(SB_Group{(ti-1)*2+1},3), round(MB_Group{ti*2},3))
end

% =======================================================================

% draw bar


sb_fig_bar = jh_bar(SBavg, SBerr);  hold on;
sb_fig_bar.FaceColor = [.6 .7 .9];

mb_fig_bar = jh_bar(MBavg, MBerr); hold on;
mb_fig_bar.FaceColor = [.7 .5 .9]; % .2 .2. 2; .3 .4 .5 ];

% significance ==========================================================
for bi = 1:2
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
    text((bi-1)*2+1.5, MBavg(bi*2)+ 0.2, disp, 'FontSize', 10,'fontweight','bold', 'HorizontalAlignment', 'center', 'Color', 'black');

end

% =======================================================================

ylim([0 max(MBavg+ 0.2)])


% labels
acc_Labels = {'Across'; ''; 'Within'; ''; 'Where'; '';  'Where+When'; ''; 'What+Where'; '';  'FullEM' };
xticklabels(acc_Labels)
ylabel('Accuracy')


% title
legend({'Visual Boundary', '', 'Audio + Visual boundary'});
% title(['Accuracy'],'FontWeight','bold')

%% Single boundary / multiple boundary  (across within) (for parent)


a = figure();
a.Position = [1053 623 560 420];
clearvars WWW_Group MB_Group WWWavg WWWerr MBavg MBerr h p Two_Group SB_Group

SB_Group{1} = Behavior_table.all_ABD_across_acc(MB_group_select ==1);
SB_Group{2} = Behavior_table.all_ABD_within_acc(MB_group_select ==1);

% SB_Group{2} = []

MB_Group{3} = Behavior_table.all_MBD_across_acc(MB_group_select ==1);
MB_Group{4} = Behavior_table.all_MBD_within_acc(MB_group_select ==1);





% avg & err
[SBavg, SBerr] = jh_mean_err(SB_Group);
[MBavg, MBerr] = jh_mean_err(MB_Group);


% stat ==================================================================

% anova
% SB_Group_data = cell2mat(SB_Group');
% sb_array = cell2mat(arrayfun(@(x) repmat(x, size(SB_Group{x})), [1 3], 'uni', 0)');
% [~,tbl,sb_stats] = anova1(SB_Group_data,sb_array,'off');
% sb_group_compare = multcompare(sb_stats,"Display","off")
% 
% 
% MB_Group_data = cell2mat(MB_Group');
% mb_array = cell2mat(arrayfun(@(x) repmat(x, size(MB_Group{x})), [2 4], 'uni', 0)');
% [~,tbl,mb_stats] = anova1(MB_Group_data,mb_array,'off');
% mb_group_compare = multcompare(mb_stats,"Display","off")


% for ti = 1:2
%     % ttest
%     [h(ti), p(ti)] = ttest(SB_Group{(ti-1)*2+1}, MB_Group{ti*2})
%     % ranksum
% %     [p(ti), h(ti)] = signrank(round(SB_Group{(ti-1)*2+1},3), round(MB_Group{ti*2},3))
% end

% =======================================================================

% draw bar


sb_fig_bar = jh_bar(SBavg);  hold on;
sb_fig_bar.FaceColor = [.6 .7 .9];

mb_fig_bar = jh_bar(MBavg); hold on;
mb_fig_bar.FaceColor = [.7 .5 .9]; % .2 .2. 2; .3 .4 .5 ];

% % significance ==========================================================
% for bi = 1:2
%     ttp = p(bi);
%     if ttp < 0.001
%         title_groupdif = [ num2str(ttp,3) '***)' ];
%         disp = '***';
%     elseif ttp < 0.01
%         title_groupdif = [ num2str(ttp,3) '**)' ];
%         disp = '**';
%     elseif ttp < 0.05
%         title_groupdif = [ num2str(ttp,3) '*)' ];
%         disp = '*';
%     elseif ttp < 0.1
%         title_groupdif = [ num2str(ttp,3) '+)' ];
%         disp = '+';
%     else
%         title_groupdif = num2str(ttp,3);
%         disp = '';
%     end
%     text((bi-1)*2+1.5, MBavg(bi*2)+ 0.2, disp, 'FontSize', 10,'fontweight','bold', 'HorizontalAlignment', 'center', 'Color', 'black');
% 
% end

% =======================================================================

% ylim([0 max(MBavg+ 0.2)])

ylim([0 1.15])


% labels
acc_Labels = {'Across'; 'Within'; 'Across'; 'Within' };
xticklabels(acc_Labels)
ylabel('Accuracy')


% title
legend({'Visual Boundary', 'Audio + Visual boundary'});
% title(['Accuracy'],'FontWeight','bold')



%% [crossing 0 / 1 / 2] Single boundary / multiple boundary acc (for meeting format)

for gi = 1:3
a = figure();
a.Position = [1053 623 560 420];
clearvars WWW_Group MB_Group WWWavg WWWerr MBavg MBerr h p Two_Group SB_Group

if gi == 1
SB_Group{1} = rmmissing(Behavior_table.cross0_ABD_acc_what(MB_group_select ==1));
% SB_Group{3} = rmmissing(Behavior_table.cross0_ABD_acc_whatwhen(MB_group_select ==1));
SB_Group{3} = rmmissing(Behavior_table.cross0_ABD_acc_where(MB_group_select ==1));
% SB_Group{7} = rmmissing(Behavior_table.cross0_ABD_acc_wherewhen(MB_group_select ==1));
% SB_Group{9} = rmmissing(Behavior_table.cross0_ABD_acc_whatwhere(MB_group_select ==1));
SB_Group{7} = rmmissing(Behavior_table.cross0_ABD_acc_fullem(MB_group_select ==1));
% SB_Group{2} = []

MB_Group{2} = rmmissing(Behavior_table.cross0_MBD_acc_what(MB_group_select ==1));
% MB_Group{4} = rmmissing(Behavior_table.cross0_MBD_acc_whatwhen(MB_group_select ==1));
MB_Group{4} = rmmissing(Behavior_table.cross0_MBD_acc_where(MB_group_select ==1));
% MB_Group{8} = rmmissing(Behavior_table.cross0_MBD_acc_wherewhen(MB_group_select ==1));
% MB_Group{10} = rmmissing(Behavior_table.cross0_MBD_acc_whatwhere(MB_group_select ==1));
MB_Group{8} = rmmissing(Behavior_table.cross0_MBD_acc_fullem(MB_group_select ==1));


elseif gi == 2
SB_Group{1} = rmmissing(Behavior_table.select_ABD_acc_what(MB_group_select ==1));
% SB_Group{3} = rmmissing(Behavior_table.cross0_ABD_acc_whatwhen(MB_group_select ==1));
SB_Group{3} = rmmissing(Behavior_table.select_ABD_acc_where(MB_group_select ==1));
% SB_Group{7} = rmmissing(Behavior_table.cross0_ABD_acc_wherewhen(MB_group_select ==1));
% SB_Group{9} = rmmissing(Behavior_table.cross0_ABD_acc_whatwhere(MB_group_select ==1));
SB_Group{7} = rmmissing(Behavior_table.select_ABD_acc_fullem(MB_group_select ==1));
% SB_Group{2} = []

MB_Group{2} = rmmissing(Behavior_table.select_MBD_acc_what(MB_group_select ==1));
% MB_Group{4} = rmmissing(Behavior_table.cross0_MBD_acc_whatwhen(MB_group_select ==1));
MB_Group{4} = rmmissing(Behavior_table.select_MBD_acc_where(MB_group_select ==1));
% MB_Group{8} = rmmissing(Behavior_table.cross0_MBD_acc_wherewhen(MB_group_select ==1));
% MB_Group{10} = rmmissing(Behavior_table.cross0_MBD_acc_whatwhere(MB_group_select ==1));
MB_Group{8} = rmmissing(Behavior_table.select_MBD_acc_fullem(MB_group_select ==1));


elseif gi == 3

SB_Group{1} = rmmissing(Behavior_table.cross2_ABD_acc_what(MB_group_select ==1));
% SB_Group{3} = rmmissing(Behavior_table.cross0_ABD_acc_whatwhen(MB_group_select ==1));
SB_Group{3} = rmmissing(Behavior_table.cross2_ABD_acc_where(MB_group_select ==1));
% SB_Group{7} = rmmissing(Behavior_table.cross0_ABD_acc_wherewhen(MB_group_select ==1));
% SB_Group{9} = rmmissing(Behavior_table.cross0_ABD_acc_whatwhere(MB_group_select ==1));
SB_Group{7} = rmmissing(Behavior_table.cross2_ABD_acc_fullem(MB_group_select ==1));
% SB_Group{2} = []

MB_Group{2} = rmmissing(Behavior_table.cross2_MBD_acc_what(MB_group_select ==1));
% MB_Group{4} = rmmissing(Behavior_table.cross0_MBD_acc_whatwhen(MB_group_select ==1));
MB_Group{4} = rmmissing(Behavior_table.cross2_MBD_acc_where(MB_group_select ==1));
% MB_Group{8} = rmmissing(Behavior_table.cross0_MBD_acc_wherewhen(MB_group_select ==1));
% MB_Group{10} = rmmissing(Behavior_table.cross0_MBD_acc_whatwhere(MB_group_select ==1));
MB_Group{8} = rmmissing(Behavior_table.cross2_MBD_acc_fullem(MB_group_select ==1));

end



% avg & err
[SBavg, SBerr] = jh_mean_err(SB_Group);
[MBavg, MBerr] = jh_mean_err(MB_Group);


% stat ==================================================================

% anova
SB_Group_data = cell2mat(SB_Group');
sb_array = cell2mat(arrayfun(@(x) repmat(x, size(SB_Group{x})), [1 3 7 ], 'uni', 0)');
[~,tbl,sb_stats] = anova1(SB_Group_data,sb_array,'off');
% sb_group_compare = multcompare(sb_stats,"Display","off")


MB_Group_data = cell2mat(MB_Group');
mb_array = cell2mat(arrayfun(@(x) repmat(x, size(MB_Group{x})), [2 4 8 ], 'uni', 0)');
[~,tbl,mb_stats] = anova1(MB_Group_data,mb_array,'off');
% mb_group_compare = multcompare(mb_stats,"Display","off")


for ti = 1:4
    if ti ~= 3
    % ttest
        [h(ti), p(ti)] = ttest2(SB_Group{(ti-1)*2+1}, MB_Group{ti*2})
    % ranksum
%     [p(ti), h(ti)] = ranksum(round(SB_Group{(ti-1)*2+1},3), round(MB_Group{ti*2},3))
    end
end

% =======================================================================

% draw bar


sb_fig_bar = jh_bar(SBavg, SBerr);  hold on;
sb_fig_bar.FaceColor = [.6 .7 .9];

mb_fig_bar = jh_bar(MBavg, MBerr); hold on;
mb_fig_bar.FaceColor = [.7 .5 .9]; % .2 .2. 2; .3 .4 .5 ];

% significance ==========================================================
for bi = 1:4
    if bi ~= 3
    ttp = p(bi)
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
    text((bi-1)*2+1.5, SBavg((bi-1)*2+1)+ 0.15, disp, 'FontSize', 10,'fontweight','bold', 'HorizontalAlignment', 'center', 'Color', 'black');
    end
end

% =======================================================================

ylim([0 max(MBavg+ 0.4)])


% labels
acc_Labels = {'What'; ''; 'What+When'; ''; 'Where'; '';  'Where+When'; ''; 'What+Where'; '';  'FullEM' };
xticklabels(acc_Labels)
ylabel('Accuracy')


% title
legend({'Visual Boundary', '', 'Audio + Visual boundary'});
% title(['Accuracy'],'FontWeight','bold')

if gi == 1
    title(['cross 0'],'FontWeight','bold')
elseif gi == 2
    title(['cross 1'],'FontWeight','bold')
elseif gi == 3
      title(['cross 2'],'FontWeight','bold')
end


end

%% [crossing 0] Single boundary / multiple boundary acc


a = figure();
a.Position = [1053 623 560 420];
clearvars WWW_Group MB_Group WWWavg WWWerr MBavg MBerr h p Two_Group SB_Group

SB_Group{1} = rmmissing(Behavior_table.cross0_ABD_acc_what(MB_group_select ==1));
SB_Group{3} = rmmissing(Behavior_table.cross0_ABD_acc_whatwhen(MB_group_select ==1));
SB_Group{5} = rmmissing(Behavior_table.cross0_ABD_acc_where(MB_group_select ==1));
SB_Group{7} = rmmissing(Behavior_table.cross0_ABD_acc_wherewhen(MB_group_select ==1));
SB_Group{9} = rmmissing(Behavior_table.cross0_ABD_acc_whatwhere(MB_group_select ==1));
SB_Group{11} = rmmissing(Behavior_table.cross0_ABD_acc_fullem(MB_group_select ==1));
% SB_Group{2} = []

MB_Group{2} = rmmissing(Behavior_table.cross0_MBD_acc_what(MB_group_select ==1));
MB_Group{4} = rmmissing(Behavior_table.cross0_MBD_acc_whatwhen(MB_group_select ==1));
MB_Group{6} = rmmissing(Behavior_table.cross0_MBD_acc_where(MB_group_select ==1));
MB_Group{8} = rmmissing(Behavior_table.cross0_MBD_acc_wherewhen(MB_group_select ==1));
MB_Group{10} = rmmissing(Behavior_table.cross0_MBD_acc_whatwhere(MB_group_select ==1));
MB_Group{12} = rmmissing(Behavior_table.cross0_MBD_acc_fullem(MB_group_select ==1));




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

% =======================================================================

% draw bar


sb_fig_bar = jh_bar(SBavg, SBerr);  hold on;
sb_fig_bar.FaceColor = [.6 .7 .9];

mb_fig_bar = jh_bar(MBavg, MBerr); hold on;
mb_fig_bar.FaceColor = [.7 .5 .9]; % .2 .2. 2; .3 .4 .5 ];

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
    text((bi-1)*2+1.5, MBavg(bi*2)+ 0.1, disp, 'FontSize', 10,'fontweight','bold', 'HorizontalAlignment', 'center', 'Color', 'black');

end

% =======================================================================

ylim([0 max(MBavg+ 0.4)])


% labels
acc_Labels = {'What'; ''; 'What+When'; ''; 'Where'; '';  'Where+When'; ''; 'What+Where'; '';  'FullEM' };
xticklabels(acc_Labels)
ylabel('Accuracy')


% title
legend({'Visual Boundary', '', 'Audio + Visual boundary'});
% title(['Accuracy'],'FontWeight','bold')

%% [crossing 2] Single boundary / multiple boundary acc


a = figure();
a.Position = [1053 623 560 420];
clearvars WWW_Group MB_Group WWWavg WWWerr MBavg MBerr h p Two_Group SB_Group

SB_Group{1} = rmmissing(Behavior_table.cross2_ABD_acc_what(MB_group_select ==1));
SB_Group{3} = rmmissing(Behavior_table.cross2_ABD_acc_whatwhen(MB_group_select ==1));
SB_Group{5} = rmmissing(Behavior_table.cross2_ABD_acc_where(MB_group_select ==1));
SB_Group{7} = rmmissing(Behavior_table.cross2_ABD_acc_wherewhen(MB_group_select ==1));
SB_Group{9} = rmmissing(Behavior_table.cross2_ABD_acc_whatwhere(MB_group_select ==1));
SB_Group{11} = rmmissing(Behavior_table.cross2_ABD_acc_fullem(MB_group_select ==1));
% SB_Group{2} = []

MB_Group{2} = rmmissing(Behavior_table.cross2_MBD_acc_what(MB_group_select ==1));
MB_Group{4} = rmmissing(Behavior_table.cross2_MBD_acc_whatwhen(MB_group_select ==1));
MB_Group{6} = rmmissing(Behavior_table.cross2_MBD_acc_where(MB_group_select ==1));
MB_Group{8} = rmmissing(Behavior_table.cross2_MBD_acc_wherewhen(MB_group_select ==1));
MB_Group{10} = rmmissing(Behavior_table.cross2_MBD_acc_whatwhere(MB_group_select ==1));
MB_Group{12} = rmmissing(Behavior_table.cross2_MBD_acc_fullem(MB_group_select ==1));



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

% =======================================================================

% draw bar


sb_fig_bar = jh_bar(SBavg, SBerr);  hold on;
sb_fig_bar.FaceColor = [.6 .7 .9];

mb_fig_bar = jh_bar(MBavg, MBerr); hold on;
mb_fig_bar.FaceColor = [.7 .5 .9]; % .2 .2. 2; .3 .4 .5 ];

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
    text((bi-1)*2+1.5, MBavg(bi*2)+ 0.1, disp, 'FontSize', 10,'fontweight','bold', 'HorizontalAlignment', 'center', 'Color', 'black');

end

% =======================================================================

ylim([0 max(MBavg+ 0.2)])


% labels
acc_Labels = {'What'; ''; 'What+When'; ''; 'Where'; '';  'Where+When'; ''; 'What+Where'; '';  'FullEM' };
xticklabels(acc_Labels)
ylabel('Accuracy')


% title
legend({'Visual Boundary', '', 'Audio + Visual boundary'});
% title(['Accuracy'],'FontWeight','bold')

%% [crossing 0 and 2] Single boundary / multiple boundary acc


a = figure();
a.Position = [1053 623 560 420];
clearvars WWW_Group MB_Group WWWavg WWWerr MBavg MBerr h p Two_Group SB_Group

SB_Group{1} = rmmissing(Behavior_table.cross0and2_ABD_acc_what(MB_group_select ==1));
SB_Group{3} = rmmissing(Behavior_table.cross0and2_ABD_acc_whatwhen(MB_group_select ==1));
SB_Group{5} = rmmissing(Behavior_table.cross0and2_ABD_acc_where(MB_group_select ==1));
SB_Group{7} = rmmissing(Behavior_table.cross0and2_ABD_acc_wherewhen(MB_group_select ==1));
SB_Group{9} = rmmissing(Behavior_table.cross0and2_ABD_acc_whatwhere(MB_group_select ==1));
SB_Group{11} = rmmissing(Behavior_table.cross0and2_ABD_acc_fullem(MB_group_select ==1));
% SB_Group{2} = []

MB_Group{2} = rmmissing(Behavior_table.cross0and2_MBD_acc_what(MB_group_select ==1));
MB_Group{4} = rmmissing(Behavior_table.cross0and2_MBD_acc_whatwhen(MB_group_select ==1));
MB_Group{6} = rmmissing(Behavior_table.cross0and2_MBD_acc_where(MB_group_select ==1));
MB_Group{8} = rmmissing(Behavior_table.cross0and2_MBD_acc_wherewhen(MB_group_select ==1));
MB_Group{10} = rmmissing(Behavior_table.cross0and2_MBD_acc_whatwhere(MB_group_select ==1));
MB_Group{12} = rmmissing(Behavior_table.cross0and2_MBD_acc_fullem(MB_group_select ==1));




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
%     [h(ti), p(ti)] = ttest2(SB_Group{(ti-1)*2+1}, MB_Group{ti*2})
    % ranksum
    [p(ti), h(ti)] = ranksum(round(SB_Group{(ti-1)*2+1},3), round(MB_Group{ti*2},3))
end

% =======================================================================

% draw bar


sb_fig_bar = jh_bar(SBavg, SBerr);  hold on;
sb_fig_bar.FaceColor = [.6 .7 .9];

mb_fig_bar = jh_bar(MBavg, MBerr); hold on;
mb_fig_bar.FaceColor = [.7 .5 .9]; % .2 .2. 2; .3 .4 .5 ];

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
    text((bi-1)*2+1.5, MBavg(bi*2)+ 0.1, disp, 'FontSize', 10,'fontweight','bold', 'HorizontalAlignment', 'center', 'Color', 'black');

end

    % =======================================================================

ylim([0 max(MBavg+ 0.4)])


% labels
acc_Labels = {'What'; ''; 'What+When'; ''; 'Where'; '';  'Where+When'; ''; 'What+Where'; '';  'FullEM' };
xticklabels(acc_Labels)
ylabel('Accuracy')


% title
legend({'Visual Boundary', '', 'Audio + Visual boundary'});
% title(['Accuracy'],'FontWeight','bold')

%% [crossing 1 and 2] Single boundary / multiple boundary acc


a = figure();
a.Position = [1053 623 560 420];
clearvars WWW_Group MB_Group WWWavg WWWerr MBavg MBerr h p Two_Group SB_Group

SB_Group{1} = rmmissing(Behavior_table.cross1and2_ABD_acc_what(MB_group_select ==1));
SB_Group{3} = rmmissing(Behavior_table.cross1and2_ABD_acc_whatwhen(MB_group_select ==1));
SB_Group{5} = rmmissing(Behavior_table.cross1and2_ABD_acc_where(MB_group_select ==1));
SB_Group{7} = rmmissing(Behavior_table.cross1and2_ABD_acc_wherewhen(MB_group_select ==1));
SB_Group{9} = rmmissing(Behavior_table.cross1and2_ABD_acc_whatwhere(MB_group_select ==1));
SB_Group{11} = rmmissing(Behavior_table.cross1and2_ABD_acc_fullem(MB_group_select ==1));
% SB_Group{2} = []

MB_Group{2} = rmmissing(Behavior_table.cross1and2_MBD_acc_what(MB_group_select ==1));
MB_Group{4} = rmmissing(Behavior_table.cross1and2_MBD_acc_whatwhen(MB_group_select ==1));
MB_Group{6} = rmmissing(Behavior_table.cross1and2_MBD_acc_where(MB_group_select ==1));
MB_Group{8} = rmmissing(Behavior_table.cross1and2_MBD_acc_wherewhen(MB_group_select ==1));
MB_Group{10} = rmmissing(Behavior_table.cross1and2_MBD_acc_whatwhere(MB_group_select ==1));
MB_Group{12} = rmmissing(Behavior_table.cross1and2_MBD_acc_fullem(MB_group_select ==1));




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
%     [h(ti), p(ti)] = ttest2(SB_Group{(ti-1)*2+1}, MB_Group{ti*2})
    % ranksum
    [p(ti), h(ti)] = ranksum(round(SB_Group{(ti-1)*2+1},3), round(MB_Group{ti*2},3))
end

% =======================================================================

% draw bar


sb_fig_bar = jh_bar(SBavg, SBerr);  hold on;
sb_fig_bar.FaceColor = [.6 .7 .9];

mb_fig_bar = jh_bar(MBavg, MBerr); hold on;
mb_fig_bar.FaceColor = [.7 .5 .9]; % .2 .2. 2; .3 .4 .5 ];

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
    text((bi-1)*2+1.5, MBavg(bi*2)+ 0.1, disp, 'FontSize', 10,'fontweight','bold', 'HorizontalAlignment', 'center', 'Color', 'black');

end

    % =======================================================================

ylim([0 max(MBavg+ 0.4)])


% labels
acc_Labels = {'What'; ''; 'What+When'; ''; 'Where'; '';  'Where+When'; ''; 'What+Where'; '';  'FullEM' };
xticklabels(acc_Labels)
ylabel('Accuracy')


% title
legend({'Visual Boundary', '', 'Audio + Visual boundary'});
% title(['Accuracy'],'FontWeight','bold')



%% [crossing 1 vs crossing 0 2 ] single boundary and multiple boundary comparision



for gi = 1:2

a = figure();
a.Position = [2730 886 560 420];
clearvars WWW_Group MB_Group WWWavg WWWerr MBavg MBerr h p Two_Group SB_Group MB_Group

if gi == 1
SB_Group{1} = rmmissing(Behavior_table.select_ABD_acc_what(MB_group_select ==1));
SB_Group{3} = rmmissing(Behavior_table.select_ABD_acc_whatwhen(MB_group_select ==1));
SB_Group{5} = rmmissing(Behavior_table.select_ABD_acc_where(MB_group_select ==1));
SB_Group{7} = rmmissing(Behavior_table.select_ABD_acc_wherewhen(MB_group_select ==1));
SB_Group{9} = rmmissing(Behavior_table.select_ABD_acc_whatwhere(MB_group_select ==1));
SB_Group{11} = rmmissing(Behavior_table.select_ABD_acc_fullem(MB_group_select ==1));


MB_Group{2} = rmmissing(Behavior_table.cross0and2_ABD_acc_what(MB_group_select ==1));
MB_Group{4} = rmmissing(Behavior_table.cross0and2_ABD_acc_whatwhen(MB_group_select ==1));
MB_Group{6} = rmmissing(Behavior_table.cross0and2_ABD_acc_where(MB_group_select ==1));
MB_Group{8} = rmmissing(Behavior_table.cross0and2_ABD_acc_wherewhen(MB_group_select ==1));
MB_Group{10} = rmmissing(Behavior_table.cross0and2_ABD_acc_whatwhere(MB_group_select ==1));
MB_Group{12} = rmmissing(Behavior_table.cross0and2_ABD_acc_fullem(MB_group_select ==1));


% SB_Group{2} = []

elseif gi == 2

SB_Group{1} = rmmissing(Behavior_table.select_MBD_acc_what(MB_group_select ==1));
SB_Group{3} = rmmissing(Behavior_table.select_MBD_acc_whatwhen(MB_group_select ==1));
SB_Group{5} = rmmissing(Behavior_table.select_MBD_acc_where(MB_group_select ==1));
SB_Group{7} = rmmissing(Behavior_table.select_MBD_acc_wherewhen(MB_group_select ==1));
SB_Group{9} = rmmissing(Behavior_table.select_MBD_acc_whatwhere(MB_group_select ==1));
SB_Group{11} = rmmissing(Behavior_table.select_MBD_acc_fullem(MB_group_select ==1));


MB_Group{2} = rmmissing(Behavior_table.cross0and2_MBD_acc_what(MB_group_select ==1));
MB_Group{4} = rmmissing(Behavior_table.cross0and2_MBD_acc_whatwhen(MB_group_select ==1));
MB_Group{6} = rmmissing(Behavior_table.cross0and2_MBD_acc_where(MB_group_select ==1));
MB_Group{8} = rmmissing(Behavior_table.cross0and2_MBD_acc_wherewhen(MB_group_select ==1));
MB_Group{10} = rmmissing(Behavior_table.cross0and2_MBD_acc_whatwhere(MB_group_select ==1));
MB_Group{12} = rmmissing(Behavior_table.cross0and2_MBD_acc_fullem(MB_group_select ==1));
end



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
sb_fig_bar.FaceColor = [.6 .7 .9];

mb_fig_bar = jh_bar(MBavg, MBerr); hold on;
mb_fig_bar.FaceColor = [.4 .5 .7]; % .2 .2. 2; .3 .4 .5 ];

if gi == 1
    sb_fig_bar.FaceColor = [.6 .7 .9];
    mb_fig_bar.FaceColor = [.4 .5 .7];

elseif gi == 2
    sb_fig_bar.FaceColor = [.7 .5 .9];
    mb_fig_bar.FaceColor = [.5 .4 .7];
end


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
    text((bi-1)*2+1.5, SBavg((bi-1)*2+1)+ 0.1, disp, 'FontSize', 10,'fontweight','bold', 'HorizontalAlignment', 'center', 'Color', 'black');

end

% =======================================================================

% ylim([0 max(MBavg+ 0.2)])

ylim([0 1.15])

% labels
acc_Labels = {'What'; ''; 'What+When'; ''; 'Where'; '';  'Where+When'; ''; 'What+Where'; '';  'FullEM' };
xticklabels(acc_Labels)
ylabel('Accuracy')

% title
legend({'1 crossing', '', '0 or 2 crossing'});

if gi == 1
    title(['Visual Boundary'],'FontWeight','bold')
else
    title(['Audio + Visual Boundary'],'FontWeight','bold')

end

end

%% [crossing 0 vs crossing 1 vs crossing 2 ] single boundary and multiple boundary comparision



for gi = 1:2

a = figure();
a.Position = [2730 886 560 420];
clearvars WWW_Group MB_Group WWWavg WWWerr MBavg MBerr h p Two_Group SB_Group MB_Group

if gi == 1
SB_Group{1} = rmmissing(Behavior_table.select_ABD_acc_what(MB_group_select ==1));
SB_Group{4} = rmmissing(Behavior_table.select_ABD_acc_whatwhen(MB_group_select ==1));
SB_Group{7} = rmmissing(Behavior_table.select_ABD_acc_where(MB_group_select ==1));
SB_Group{10} = rmmissing(Behavior_table.select_ABD_acc_wherewhen(MB_group_select ==1));
SB_Group{13} = rmmissing(Behavior_table.select_ABD_acc_whatwhere(MB_group_select ==1));
SB_Group{16} = rmmissing(Behavior_table.select_ABD_acc_fullem(MB_group_select ==1));


MB_Group{2} = rmmissing(Behavior_table.cross0_ABD_acc_what(MB_group_select ==1));
MB_Group{5} = rmmissing(Behavior_table.cross0_ABD_acc_whatwhen(MB_group_select ==1));
MB_Group{8} = rmmissing(Behavior_table.cross0_ABD_acc_where(MB_group_select ==1));
MB_Group{11} = rmmissing(Behavior_table.cross0_ABD_acc_wherewhen(MB_group_select ==1));
MB_Group{14} = rmmissing(Behavior_table.cross0_ABD_acc_whatwhere(MB_group_select ==1));
MB_Group{17} = rmmissing(Behavior_table.cross0_ABD_acc_fullem(MB_group_select ==1));

OB_Group{3} = rmmissing(Behavior_table.cross2_ABD_acc_what(MB_group_select ==1));
OB_Group{6} = rmmissing(Behavior_table.cross2_ABD_acc_whatwhen(MB_group_select ==1));
OB_Group{9} = rmmissing(Behavior_table.cross2_ABD_acc_where(MB_group_select ==1));
OB_Group{12} = rmmissing(Behavior_table.cross2_ABD_acc_wherewhen(MB_group_select ==1));
OB_Group{15} = rmmissing(Behavior_table.cross2_ABD_acc_whatwhere(MB_group_select ==1));
OB_Group{18} = rmmissing(Behavior_table.cross2_ABD_acc_fullem(MB_group_select ==1));


% SB_Group{2} = []

elseif gi == 2

SB_Group{1} = rmmissing(Behavior_table.select_MBD_acc_what(MB_group_select ==1));
SB_Group{4} = rmmissing(Behavior_table.select_MBD_acc_whatwhen(MB_group_select ==1));
SB_Group{7} = rmmissing(Behavior_table.select_MBD_acc_where(MB_group_select ==1));
SB_Group{10} = rmmissing(Behavior_table.select_MBD_acc_wherewhen(MB_group_select ==1));
SB_Group{13} = rmmissing(Behavior_table.select_MBD_acc_whatwhere(MB_group_select ==1));
SB_Group{16} = rmmissing(Behavior_table.select_MBD_acc_fullem(MB_group_select ==1));


MB_Group{2} = rmmissing(Behavior_table.cross0_MBD_acc_what(MB_group_select ==1));
MB_Group{5} = rmmissing(Behavior_table.cross0_MBD_acc_whatwhen(MB_group_select ==1));
MB_Group{8} = rmmissing(Behavior_table.cross0_MBD_acc_where(MB_group_select ==1));
MB_Group{11} = rmmissing(Behavior_table.cross0_MBD_acc_wherewhen(MB_group_select ==1));
MB_Group{14} = rmmissing(Behavior_table.cross0_MBD_acc_whatwhere(MB_group_select ==1));
MB_Group{17} = rmmissing(Behavior_table.cross0_MBD_acc_fullem(MB_group_select ==1));

OB_Group{3} = rmmissing(Behavior_table.cross2_MBD_acc_what(MB_group_select ==1));
OB_Group{6} = rmmissing(Behavior_table.cross2_MBD_acc_whatwhen(MB_group_select ==1));
OB_Group{9} = rmmissing(Behavior_table.cross2_MBD_acc_where(MB_group_select ==1));
OB_Group{12} = rmmissing(Behavior_table.cross2_MBD_acc_wherewhen(MB_group_select ==1));
OB_Group{15} = rmmissing(Behavior_table.cross2_MBD_acc_whatwhere(MB_group_select ==1));
OB_Group{18} = rmmissing(Behavior_table.cross2_MBD_acc_fullem(MB_group_select ==1));


end



% avg & err
[SBavg, SBerr] = jh_mean_err(SB_Group);
[MBavg, MBerr] = jh_mean_err(MB_Group);
[OBavg, OBerr] = jh_mean_err(OB_Group);

% stat ==================================================================

% anova
SB_Group_data = cell2mat(SB_Group');
sb_array = cell2mat(arrayfun(@(x) repmat(x, size(SB_Group{x})), [1 4 7 10 13 16], 'uni', 0)');
[~,tbl,sb_stats] = anova1(SB_Group_data,sb_array,'off');
sb_group_compare = multcompare(sb_stats,"Display","off")


MB_Group_data = cell2mat(MB_Group');
mb_array = cell2mat(arrayfun(@(x) repmat(x, size(MB_Group{x})), [2 5 8 11 14 17], 'uni', 0)');
[~,tbl,mb_stats] = anova1(MB_Group_data,mb_array,'off');
mb_group_compare = multcompare(mb_stats,"Display","off")


OB_Group_data = cell2mat(OB_Group');
ob_array = cell2mat(arrayfun(@(x) repmat(x, size(OB_Group{x})), [3 6 9 12 15 18], 'uni', 0)');
[~,tbl,ob_stats] = anova1(OB_Group_data,ob_array,'off');
ob_group_compare = multcompare(ob_stats,"Display","off")



% for ti = 1:6
    % ttest
%     [h(ti), p(ti)] = ttest2(SB_Group{(ti-1)*2+1}, MB_Group{ti*2})
    % ranksum
%     [p(ti), h(ti)] = ranksum(round(SB_Group{(ti-1)*2+1},3), round(MB_Group{ti*2},3))

% end

% ======================================================================

% draw bar


sb_fig_bar = jh_bar(SBavg, SBerr);  hold on;
sb_fig_bar.FaceColor = [.6 .7 .9];

mb_fig_bar = jh_bar(MBavg, MBerr); hold on;
mb_fig_bar.FaceColor = [.4 .5 .7]; % .2 .2. 2; .3 .4 .5 ];

ob_fig_bar = jh_bar(OBavg, OBerr); hold on;
ob_fig_bar.FaceColor = [.4 .5 .7]; % .2 .2. 2; .3 .4 .5 ];


if gi == 1
    sb_fig_bar.FaceColor = [.6 .7 .9];
    mb_fig_bar.FaceColor = [.4 .5 .7];
    ob_fig_bar.FaceColor = [.2 .3 .5];


elseif gi == 2
    sb_fig_bar.FaceColor = [.7 .5 .9];
    mb_fig_bar.FaceColor = [.5 .4 .7];
    ob_fig_bar.FaceColor = [.3 .2 .5];
end


% significance ==========================================================
% for bi = 1:6
%     ttp = p(bi);
%     if ttp < 0.001
%         title_groupdif = [ num2str(ttp,3) '***)' ];
%         disp = '***';
%     elseif ttp < 0.01
%         title_groupdif = [ num2str(ttp,3) '**)' ];
%         disp = '**';
%     elseif ttp < 0.05
%         title_groupdif = [ num2str(ttp,3) '*)' ];
%         disp = '*';
%     elseif ttp < 0.1
%         title_groupdif = [ num2str(ttp,3) '+)' ];
%         disp = '+';
%     else
%         title_groupdif = num2str(ttp,3);
%         disp = '';
%     end
%     text((bi-1)*2+1.5, SBavg((bi-1)*2+1)+ 0.1, disp, 'FontSize', 10,'fontweight','bold', 'HorizontalAlignment', 'center', 'Color', 'black');
% 
% end

% =======================================================================

% ylim([0 max(MBavg+ 0.2)])

ylim([0 1.15])

% labels
acc_Labels = {'What';  'What+When';  'Where';   'Where+When';  'What+Where';   'FullEM' };
xticks([2 5 8 11 14 17])
xticklabels(acc_Labels)
% xlabel('What  What+When  Where  Where+When  What+Where  FullEM')
ylabel('Accuracy')

% title
legend({'1 crossing', '', '0 crossing', '', '2 crossing' });

if gi == 1
    title(['Visual Boundary'],'FontWeight','bold')
else
    title(['Audio + Visual Boundary'],'FontWeight','bold')

end

end

%% [crossing 0 vs crossing 1 vs crossing 2 ] single boundary and multiple boundary comparision  for report (only what where full)



for gi = 1:3
gi
a = figure();
a.Position = [2730 886 560 420];
clearvars WWW_Group MB_Group WWWavg WWWerr MBavg MBerr h p Two_Group SB_Group MB_Group OBavg SBavg OB_Group

if gi == 1
SB_Group{1} = rmmissing(Behavior_table.select_ABD_acc_what(MB_group_select ==1));
% SB_Group{4} = rmmissing(Behavior_table.select_ABD_acc_whatwhen(MB_group_select ==1));
SB_Group{4} = rmmissing(Behavior_table.select_ABD_acc_where(MB_group_select ==1));
% SB_Group{10} = rmmissing(Behavior_table.select_ABD_acc_wherewhen(MB_group_select ==1));
% SB_Group{13} = rmmissing(Behavior_table.select_ABD_acc_whatwhere(MB_group_select ==1));
SB_Group{10} = rmmissing(Behavior_table.select_ABD_acc_fullem(MB_group_select ==1));


MB_Group{2} = rmmissing(Behavior_table.cross0_ABD_acc_what(MB_group_select ==1));
% MB_Group{5} = rmmissing(Behavior_table.cross0_ABD_acc_whatwhen(MB_group_select ==1));
MB_Group{5} = rmmissing(Behavior_table.cross0_ABD_acc_where(MB_group_select ==1));
% MB_Group{11} = rmmissing(Behavior_table.cross0_ABD_acc_wherewhen(MB_group_select ==1));
% MB_Group{14} = rmmissing(Behavior_table.cross0_ABD_acc_whatwhere(MB_group_select ==1));
MB_Group{11} = rmmissing(Behavior_table.cross0_ABD_acc_fullem(MB_group_select ==1));

OB_Group{3} = rmmissing(Behavior_table.cross2_ABD_acc_what(MB_group_select ==1));
% OB_Group{6} = rmmissing(Behavior_table.cross2_ABD_acc_whatwhen(MB_group_select ==1));
OB_Group{6} = rmmissing(Behavior_table.cross2_ABD_acc_where(MB_group_select ==1));
% OB_Group{12} = rmmissing(Behavior_table.cross2_ABD_acc_wherewhen(MB_group_select ==1));
% OB_Group{15} = rmmissing(Behavior_table.cross2_ABD_acc_whatwhere(MB_group_select ==1));
OB_Group{12} = rmmissing(Behavior_table.cross2_ABD_acc_fullem(MB_group_select ==1));


% SB_Group{2} = []

elseif gi == 2

SB_Group{1} = rmmissing(Behavior_table.select_MBD_acc_what(MB_group_select ==1));
% SB_Group{4} = rmmissing(Behavior_table.select_MBD_acc_whatwhen(MB_group_select ==1));
SB_Group{4} = rmmissing(Behavior_table.select_MBD_acc_where(MB_group_select ==1));
% SB_Group{10} = rmmissing(Behavior_table.select_MBD_acc_wherewhen(MB_group_select ==1));
% SB_Group{13} = rmmissing(Behavior_table.select_MBD_acc_whatwhere(MB_group_select ==1));
SB_Group{10} = rmmissing(Behavior_table.select_MBD_acc_fullem(MB_group_select ==1));


MB_Group{2} = rmmissing(Behavior_table.cross0_MBD_acc_what(MB_group_select ==1));
% MB_Group{5} = rmmissing(Behavior_table.cross0_MBD_acc_whatwhen(MB_group_select ==1));
MB_Group{5} = rmmissing(Behavior_table.cross0_MBD_acc_where(MB_group_select ==1));
% MB_Group{11} = rmmissing(Behavior_table.cross0_MBD_acc_wherewhen(MB_group_select ==1));
% MB_Group{14} = rmmissing(Behavior_table.cross0_MBD_acc_whatwhere(MB_group_select ==1));
MB_Group{11} = rmmissing(Behavior_table.cross0_MBD_acc_fullem(MB_group_select ==1));

OB_Group{3} = rmmissing(Behavior_table.cross2_MBD_acc_what(MB_group_select ==1));
% OB_Group{6} = rmmissing(Behavior_table.cross2_MBD_acc_whatwhen(MB_group_select ==1));
OB_Group{6} = rmmissing(Behavior_table.cross2_MBD_acc_where(MB_group_select ==1));
% OB_Group{12} = rmmissing(Behavior_table.cross2_MBD_acc_wherewhen(MB_group_select ==1));
% OB_Group{15} = rmmissing(Behavior_table.cross2_MBD_acc_whatwhere(MB_group_select ==1));
OB_Group{12} = rmmissing(Behavior_table.cross2_MBD_acc_fullem(MB_group_select ==1));

elseif gi == 3

SB_Group{1} = rmmissing(Behavior_table.select_acc_what(MB_group_select ==1));
% SB_Group{4} = rmmissing(Behavior_table.select_MBD_acc_whatwhen(MB_group_select ==1));
SB_Group{4} = rmmissing(Behavior_table.select_acc_where(MB_group_select ==1));
% SB_Group{10} = rmmissing(Behavior_table.select_MBD_acc_wherewhen(MB_group_select ==1));
% SB_Group{13} = rmmissing(Behavior_table.select_MBD_acc_whatwhere(MB_group_select ==1));
SB_Group{10} = rmmissing(Behavior_table.select_acc_fullem(MB_group_select ==1));


MB_Group{2} = rmmissing(Behavior_table.cross0_acc_what(MB_group_select ==1));
% MB_Group{5} = rmmissing(Behavior_table.cross0_MBD_acc_whatwhen(MB_group_select ==1));
MB_Group{5} = rmmissing(Behavior_table.cross0_acc_where(MB_group_select ==1));
% MB_Group{11} = rmmissing(Behavior_table.cross0_MBD_acc_wherewhen(MB_group_select ==1));
% MB_Group{14} = rmmissing(Behavior_table.cross0_MBD_acc_whatwhere(MB_group_select ==1));
MB_Group{11} = rmmissing(Behavior_table.cross0_acc_fullem(MB_group_select ==1));

OB_Group{3} = rmmissing(Behavior_table.cross2_acc_what(MB_group_select ==1));
% OB_Group{6} = rmmissing(Behavior_table.cross2_MBD_acc_whatwhen(MB_group_select ==1));
OB_Group{6} = rmmissing(Behavior_table.cross2_acc_where(MB_group_select ==1));
% OB_Group{12} = rmmissing(Behavior_table.cross2_MBD_acc_wherewhen(MB_group_select ==1));
% OB_Group{15} = rmmissing(Behavior_table.cross2_MBD_acc_whatwhere(MB_group_select ==1));
OB_Group{12} = rmmissing(Behavior_table.cross2_acc_fullem(MB_group_select ==1));

end



% avg & err
[SBavg, SBerr] = jh_mean_err(SB_Group);
[MBavg, MBerr] = jh_mean_err(MB_Group);
[OBavg, OBerr] = jh_mean_err(OB_Group);

% stat ==================================================================

% % anova
% SB_Group_data = cell2mat(SB_Group');
% sb_array = cell2mat(arrayfun(@(x) repmat(x, size(SB_Group{x})), [1 4 10 ], 'uni', 0)');
% [~,tbl,sb_stats] = anova1(SB_Group_data,sb_array,'off');
% sb_group_compare = multcompare(sb_stats,"Display","off")
% tbl{2,6}


% MB_Group_data = cell2mat(MB_Group');
% mb_array = cell2mat(arrayfun(@(x) repmat(x, size(MB_Group{x})), [2 5 11], 'uni', 0)');
% [~,tbl,mb_stats] = anova1(MB_Group_data,mb_array,'off');
% mb_group_compare = multcompare(mb_stats,"Display","off")
% tbl{2,6}

% OB_Group_data = cell2mat(OB_Group');
% ob_array = cell2mat(arrayfun(@(x) repmat(x, size(OB_Group{x})), [3 6 12], 'uni', 0)');
% [~,tbl,ob_stats] = anova1(OB_Group_data,ob_array,'off');
% ob_group_compare = multcompare(ob_stats,"Display","off")
% % tbl{2,6}

what_group = [SB_Group{1}; MB_Group{2}; OB_Group{3}];
what_array = [ones(size(SB_Group{1}))*1; ones(size(MB_Group{2}))*2; ones(size(OB_Group{3}))*3;];
[~,what_tbl,what_stats] = anova1(what_group,what_array,'off');
what_group_compare = multcompare(what_stats,"Display","off")
what_tbl{2,6}

where_group = [SB_Group{4}; MB_Group{5}; OB_Group{6}];
where_array = [ones(size(SB_Group{4}))*4; ones(size(MB_Group{5}))*5; ones(size(OB_Group{6}))*6;];
[~,where_tbl,where_stats] = anova1(where_group,where_array,'off');
where_group_compare = multcompare(where_stats,"Display","off")
where_tbl{2,6}

full_group = [SB_Group{10}; MB_Group{11}; OB_Group{12}];
full_array = [ones(size(SB_Group{10}))*10; ones(size(MB_Group{11}))*11; ones(size(OB_Group{12}))*12;];
[~,full_tbl,full_stats] = anova1(full_group,full_array,'off');
full_group_compare = multcompare(full_stats,"Display","off")
full_tbl{2,6}




% for ti = 1:6
    % ttest
%     [h(ti), p(ti)] = ttest2(SB_Group{(ti-1)*2+1}, MB_Group{ti*2})
    % ranksum
%     [p(ti), h(ti)] = ranksum(round(SB_Group{(ti-1)*2+1},3), round(MB_Group{ti*2},3))

% end

% ======================================================================

% draw bar


sb_fig_bar = jh_bar(SBavg, SBerr);  hold on;
sb_fig_bar.FaceColor = [.6 .7 .9];

mb_fig_bar = jh_bar(MBavg, MBerr); hold on;
mb_fig_bar.FaceColor = [.4 .5 .7]; % .2 .2. 2; .3 .4 .5 ];

ob_fig_bar = jh_bar(OBavg, OBerr); hold on;
ob_fig_bar.FaceColor = [.4 .5 .7]; % .2 .2. 2; .3 .4 .5 ];


if gi == 1
    sb_fig_bar.FaceColor = [.6 .7 .9];
    mb_fig_bar.FaceColor = [.4 .5 .7];
    ob_fig_bar.FaceColor = [.2 .3 .5];


elseif gi == 2
    sb_fig_bar.FaceColor = [.7 .5 .9];
    mb_fig_bar.FaceColor = [.5 .4 .7];
    ob_fig_bar.FaceColor = [.3 .2 .5];

elseif gi == 3
    sb_fig_bar.FaceColor = [.9 .5 .6];
    mb_fig_bar.FaceColor = [.7 .4 .5];
    ob_fig_bar.FaceColor = [.5 .2 .3];

end


if what_tbl{2,6} < 0.05
    a = 1
    plot([1 3], [1.1 1.1], 'Color','black')
end

if where_tbl{2,6} < 0.05
    a = 1
    plot([4 6], [1.1 1.1], 'Color','black')
end

if full_tbl{2,6} < 0.05
    a = 1
    plot([10 12], [0.7 0.7], 'Color','black')
end


% significance ==========================================================
% for bi = 1:6
%     ttp = p(bi);
%     if ttp < 0.001
%         title_groupdif = [ num2str(ttp,3) '***)' ];
%         disp = '***';
%     elseif ttp < 0.01
%         title_groupdif = [ num2str(ttp,3) '**)' ];
%         disp = '**';
%     elseif ttp < 0.05
%         title_groupdif = [ num2str(ttp,3) '*)' ];
%         disp = '*';
%     elseif ttp < 0.1
%         title_groupdif = [ num2str(ttp,3) '+)' ];
%         disp = '+';
%     else
%         title_groupdif = num2str(ttp,3);
%         disp = '';
%     end
%     text((bi-1)*2+1.5, SBavg((bi-1)*2+1)+ 0.1, disp, 'FontSize', 10,'fontweight','bold', 'HorizontalAlignment', 'center', 'Color', 'black');
% 
% end

% =======================================================================

% ylim([0 max(MBavg+ 0.2)])

ylim([0 1.15])

% labels
acc_Labels = {'What';  'Where';  '';  'FullEM' };
xticks([2 5 8 11 14 17])
xticklabels(acc_Labels)
% xlabel('What  What+When  Where  Where+When  What+Where  FullEM')
ylabel('Accuracy')

% title
legend({'1 crossing', '', '0 crossing', '', '2 crossing' });

if gi == 1
    title(['Visual Boundary'],'FontWeight','bold')
elseif gi == 2
    title(['Audio + Visual Boundary'],'FontWeight','bold')
elseif gi == 3
    title(['all'],'FontWeight','bold')
end


end


%% Single boundary / multiple boundary categorized location

a = figure();
a.Position = [1053 623 461 359];
clearvars WWW_Group MB_Group WWWavg WWWerr MBavg MBerr h p Two_Group SB_Group

SB_Group = Behavior_table.select_ABD_acc_location_cat(MB_group_select ==1);
MB_Group = Behavior_table.select_MBD_acc_location_cat(MB_group_select ==1);

Two_Group = [{SB_Group}, {MB_Group}];

[avg, err] = jh_mean_err(Two_Group);

[h, p] = ttest(SB_Group, MB_Group)

fig_bar = jh_bar(avg, err);  hold on;
fig_bar.FaceColor = [.6 .6 .8];

ttp = p;
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

text(1.5, max(avg+0.1), disp, 'FontSize', 13,'fontweight','bold', 'HorizontalAlignment', 'center', 'Color', 'black');

ylim([0 max(avg+ 0.2)])


% labels
acc_Labels = {'Visual'; 'Audio + Visual'};
xticklabels(acc_Labels)
title(['Categorized Location'],'FontWeight','bold')

% 
% % title
% legend({'Visual Boundary', '', 'Audio + Visual boundary'});

%% Single boundary / multiple boundary RT



a = figure();
a.Position = [1053 623 560 420];
clearvars WWW_Group MB_Group WWWavg WWWerr MBavg MBerr h p Two_Group SB_Group 


SB_Group{1} = Behavior_table.select_ABD_rt_respond(MB_group_select ==1);
% SB_Group{2} = [];
SB_Group{5} = Behavior_table.select_ABD_rt_animal(MB_group_select ==1);
SB_Group{7} = Behavior_table.select_ABD_rt_location(MB_group_select ==1);


MB_Group{2} = Behavior_table.select_MBD_rt_respond(MB_group_select ==1);
% MB_Group{2} = [];
MB_Group{6} = Behavior_table.select_MBD_rt_animal(MB_group_select ==1);
MB_Group{8} = Behavior_table.select_MBD_rt_location(MB_group_select ==1);


% avg & err
[SBavg, SBerr] = jh_mean_err(SB_Group);
[MBavg, MBerr] = jh_mean_err(MB_Group);


% stat ==================================================================

% anova
SB_Group_data = cell2mat(SB_Group');
sb_array = cell2mat(arrayfun(@(x) repmat(x, size(SB_Group{x})), [1,5,7], 'uni', 0)');
[~,tbl,sb_stats] = anova1(SB_Group_data,sb_array,'off');
sb_group_compare = multcompare(sb_stats,"Display","off")


MB_Group_data = cell2mat(MB_Group');
mb_array = cell2mat(arrayfun(@(x) repmat(x, size(MB_Group{x})), [2,6,8], 'uni', 0)');
[~,tbl,mb_stats] = anova1(MB_Group_data,mb_array,'off');
mb_group_compare = multcompare(mb_stats,"Display","off")


for ti = 1:4
    if ismember(ti, [1,3,4])
        % ttest
%         [h(ti), p(ti)] = ttest(SB_Group{(ti-1)*2+1}, MB_Group{ti*2})
        % ranksum
        [p(ti), h(ti)] = signrank(round(SB_Group{(ti-1)*2+1},3), round(MB_Group{ti*2},3))

    end
end

% =======================================================================

% draw bar
sb_fig_bar = jh_bar(SBavg, SBerr);  hold on;
sb_fig_bar.FaceColor = [.6 .7 .9];

mb_fig_bar = jh_bar(MBavg, MBerr); hold on;
mb_fig_bar.FaceColor = [.7 .5 .9]; % .2 .2. 2; .3 .4 .5 ];


% significance ==========================================================
for bi = 1:4
    if ismember(ti, [1,3,4])
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
    text(bi+0.5, SBavg(bi)+ 1, disp, 'FontSize', 10,'fontweight','bold', 'HorizontalAlignment', 'center', 'Color', 'black');
    end
end

% =======================================================================

ylim([0 max(SBavg+ 2)])


% labels
acc_Labels = {'Respond'; '';''; ''; 'What'; ''; 'Where'};
xticklabels(acc_Labels)
ylabel('Reaction Time (sec)')

% title
legend({'Visual', '', 'Audio + Visual'});
% title(['Accuracy'],'FontWeight','bold')


%% Single boundary / multiple boundary RT (Right trial only)



a = figure();
a.Position = [1053 623 560 420];
clearvars WWW_Group MB_Group WWWavg WWWerr MBavg MBerr h p Two_Group SB_Group 


SB_Group{1} = Behavior_table.select_ABD_rt_right_respond(MB_group_select ==1);
% SB_Group{2} = [];
SB_Group{5} = Behavior_table.select_ABD_rt_right_animal(MB_group_select ==1);
SB_Group{7} = Behavior_table.select_ABD_rt_right_location(MB_group_select ==1);


MB_Group{2} = Behavior_table.select_MBD_rt_right_respond(MB_group_select ==1);
% MB_Group{2} = [];
MB_Group{6} = Behavior_table.select_MBD_rt_right_animal(MB_group_select ==1);
MB_Group{8} = Behavior_table.select_MBD_rt_right_location(MB_group_select ==1);


% avg & err
[SBavg, SBerr] = jh_mean_err(SB_Group);
[MBavg, MBerr] = jh_mean_err(MB_Group);


% stat ==================================================================

% anova
SB_Group_data = cell2mat(SB_Group');
sb_array = cell2mat(arrayfun(@(x) repmat(x, size(SB_Group{x})), [1,5,7], 'uni', 0)');
[~,tbl,sb_stats] = anova1(SB_Group_data,sb_array,'off');
sb_group_compare = multcompare(sb_stats,"Display","off")


MB_Group_data = cell2mat(MB_Group');
mb_array = cell2mat(arrayfun(@(x) repmat(x, size(MB_Group{x})), [2,6,8], 'uni', 0)');
[~,tbl,mb_stats] = anova1(MB_Group_data,mb_array,'off');
mb_group_compare = multcompare(mb_stats,"Display","off")


for ti = 1:4
    if ismember(ti, [1,3,4])
        % ttest
        [h(ti), p(ti)] = ttest(SB_Group{(ti-1)*2+1}, MB_Group{ti*2})
        % ranksum
%         [p(ti), h(ti)] = signrank(round(SB_Group{(ti-1)*2+1},3), round(MB_Group{ti*2},3))

    end
end

% =======================================================================

% draw bar
sb_fig_bar = jh_bar(SBavg, SBerr);  hold on;
sb_fig_bar.FaceColor = [.6 .7 .9];

mb_fig_bar = jh_bar(MBavg, MBerr); hold on;
mb_fig_bar.FaceColor = [.7 .5 .9]; % .2 .2. 2; .3 .4 .5 ];


% significance ==========================================================
for bi = 1:4
    if ismember(ti, [1,3,4])
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
    text(bi+0.5, SBavg(bi)+ 1, disp, 'FontSize', 10,'fontweight','bold', 'HorizontalAlignment', 'center', 'Color', 'black');
    end
end

% =======================================================================

ylim([0 max(SBavg+ 2)])


% labels
acc_Labels = {'Respond'; '';''; ''; 'What'; ''; 'Where'};
xticklabels(acc_Labels)
ylabel('Reaction Time (sec)')

% title
legend({'Visual', '', 'Audio + Visual'});
% title(['Accuracy'],'FontWeight','bold')


%% [mb] abd mbd full em difference (cross 0 cross 1)

a = figure();
a.Position = [1053 623 293 359];
clearvars WWW_Group MB_Group WWWavg WWWerr MBavg MBerr h p Two_Group

WWW_Group = Behavior_table.cross0_ABD_acc_fullem(MB_group_select ==1);
MB_Group = Behavior_table.cross0_MBD_acc_fullem(MB_group_select ==1);

Two_Group = [{WWW_Group}, {MB_Group}];

MB_Group2{2} = MB_Group

[avg, err] = jh_mean_err(Two_Group);
[avg1, err1]= jh_mean_err({WWW_Group});
[avg2, err2]= jh_mean_err(MB_Group2);

[h, p] = ttest2(WWW_Group, MB_Group)


% fig_bar = jh_bar(avg, err);  hold on;
% fig_bar.FaceColor = [.6 .6 .8];

fig_bar1 = jh_bar(avg1, err1);  hold on;
fig_bar1.FaceColor = [.6 .7 .9];
fig_bar2 = jh_bar(avg2, err2);  hold on;
fig_bar2.FaceColor = [.7 .5 .9];


ttp = p;
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

text(1.5, max(avg+0.1), disp, 'FontSize', 13,'fontweight','bold', 'HorizontalAlignment', 'center', 'Color', 'black');

ylim([0 1])


% labels
acc_Labels = {'Visual'; 'Multi'};
xticklabels(acc_Labels)
ylabel('Accuracy')


title(['Cross 0'],'FontWeight','bold')

%% [MB] visual vs audio+visual Location chunking

a = figure();
a.Position = [2655 612 337 420];
clearvars WWW_Group MB_Group WWWavg WWWerr MBavg MBerr h p Two_Group SB_Group

SB_Group{1} = [Behavior_table.ABD_loc_chunking(MB_group_select ==1);];


MB_Group{2} = [Behavior_table.MBD_loc_chunking(MB_group_select ==1);];


% avg & err
[SBavg, SBerr] = jh_mean_err(SB_Group);
[MBavg, MBerr] = jh_mean_err(MB_Group);


for ti = 1:1
    % ttest
    [h(ti), p(ti)] = ttest2(SB_Group{(ti-1)*2+1}, MB_Group{ti*2})
    % ranksum
%     [p(ti), h(ti)] = signrank(round(SB_Group{(ti-1)*2+1},3), round(MB_Group{ti*2},3))
end


sb_fig_bar = jh_bar(SBavg, SBerr);  hold on;
sb_fig_bar.FaceColor = [.6 .6 .6];

mb_fig_bar = jh_bar(MBavg, MBerr); hold on;
mb_fig_bar.FaceColor = [.9 .8 .4]; % .2 .2. 2; .3 .4 .5 ];

% significance ==========================================================
for bi = 1:1
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
    text((bi-1)*2+1.5, MBavg(bi*2)+ 0.1, disp, 'FontSize', 10,'fontweight','bold', 'HorizontalAlignment', 'center', 'Color', 'black');

end

% =======================================================================

ylim([0 1.15])


% labels
acc_Labels = {'visual'; ''; 'Audio+visual';};
xticklabels(acc_Labels)
ylabel('location chunking')


% title
% legend({'Visual Boundary', '', 'Audio + Visual boundary'});
title(['all trials'],'FontWeight','bold')



%% [MB] visual vs audio+visual Location chunking (for parent report)

a = figure();
a.Position = [2655 612 337 420];
clearvars WWW_Group MB_Group WWWavg WWWerr MBavg MBerr h p Two_Group SB_Group

SB_Group{1} = [Behavior_table.ABD_loc_chunking(MB_group_select ==1);];


MB_Group{2} = [Behavior_table.MBD_loc_chunking(MB_group_select ==1);];


% avg & err
[SBavg, SBerr] = jh_mean_err(SB_Group);
[MBavg, MBerr] = jh_mean_err(MB_Group);


for ti = 1:1
    % ttest
    [h(ti), p(ti)] = ttest2(SB_Group{(ti-1)*2+1}, MB_Group{ti*2})
    % ranksum
%     [p(ti), h(ti)] = signrank(round(SB_Group{(ti-1)*2+1},3), round(MB_Group{ti*2},3))
end


sb_fig_bar = jh_bar(SBavg);  hold on;
sb_fig_bar.FaceColor = [.6 .6 .6];

mb_fig_bar = jh_bar(MBavg); hold on;
mb_fig_bar.FaceColor = [.9 .8 .4]; % .2 .2. 2; .3 .4 .5 ];

% significance ==========================================================
% for bi = 1:1
%     ttp = p(bi);
%     if ttp < 0.001
%         title_groupdif = [ num2str(ttp,3) '***)' ];
%         disp = '***';
%     elseif ttp < 0.01
%         title_groupdif = [ num2str(ttp,3) '**)' ];
%         disp = '**';
%     elseif ttp < 0.05
%         title_groupdif = [ num2str(ttp,3) '*)' ];
%         disp = '*';
%     elseif ttp < 0.1
%         title_groupdif = [ num2str(ttp,3) '+)' ];
%         disp = '+';
%     else
%         title_groupdif = num2str(ttp,3);
%         disp = '';
%     end
%     text((bi-1)*2+1.5, MBavg(bi*2)+ 0.1, disp, 'FontSize', 10,'fontweight','bold', 'HorizontalAlignment', 'center', 'Color', 'black');
% 
% end

% =======================================================================

ylim([0 1.15])


% labels
acc_Labels = {'visual'; ''; 'Audio+visual';};
xticklabels(acc_Labels)
ylabel('location chunking')


% title
% legend({'Visual Boundary', '', 'Audio + Visual boundary'});
title(['all trials'],'FontWeight','bold')

%% [MB] visual vs audio+visual Location chunking ( 1 crossing)

a = figure();
a.Position = [2655 612 337 420];
clearvars WWW_Group MB_Group WWWavg WWWerr MBavg MBerr h p Two_Group SB_Group

SB_Group{1} = [Behavior_table.select_ABD_loc_chunking(MB_group_select ==1);];
SB_Group{2} = [];


MB_Group{2} = [Behavior_table.select_MBD_loc_chunking(MB_group_select ==1);];


% avg & err
[SBavg, SBerr] = jh_mean_err(SB_Group);
[MBavg, MBerr] = jh_mean_err(MB_Group);


for ti = 1:1
    % ttest
    [h(ti), p(ti)] = ttest2(SB_Group{(ti-1)*2+1}, MB_Group{ti*2})
    % ranksum
%     [p(ti), h(ti)] = signrank(round(SB_Group{(ti-1)*2+1},3), round(MB_Group{ti*2},3))
end


sb_fig_bar = jh_bar(SBavg, SBerr);  hold on;
sb_fig_bar.FaceColor = [.6 .6 .6];

mb_fig_bar = jh_bar(MBavg, MBerr); hold on;
mb_fig_bar.FaceColor = [.9 .8 .4]; % .2 .2. 2; .3 .4 .5 ];

% significance ==========================================================
for bi = 1:1
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
    text((bi-1)*2+1.5, MBavg(bi*2)+ 0.1, disp, 'FontSize', 10,'fontweight','bold', 'HorizontalAlignment', 'center', 'Color', 'black');

end

% =======================================================================

ylim([0 1.15])


% labels
acc_Labels = {'visual'; 'Audio+visual';};
xticklabels(acc_Labels)
ylabel('location chunking')


% title
% legend({'Visual Boundary', '', 'Audio + Visual boundary'});
title(['1 crossing'],'FontWeight','bold')



%% [ Boundary user & Non user ] =========================================

MB_group_orig = MB_group_select;

MB_bnd_user_group = (MB_group_orig & Behavior_table.inter_bnd_user) * 2 + (MB_group_orig & ~Behavior_table.inter_bnd_user);
% boundary user 2 non-user 1 / 
WWW_group_orig = WWW_group_select;

WWW_bnd_user_group = (WWW_group_orig & WWW_Behavior_table.inter_bnd_user) * 2 + (WWW_group_orig & ~WWW_Behavior_table.inter_bnd_user);




%% Demographical Difference


% Behavior_table.inter_bnd_user : 1 - user / 0 - non-user
% histo_group = Behavior_table.inter_bnd_user;
histo_group = MB_bnd_user_group;


% www_histo_group = www_age_group;


a = figure();
a.Position = [2650 925 354 253];
subplot(1,2,1);
% histogram(participant_info.age_yr((strcmp(participant_info.sex, '남') & (histo_group == 1)) == 1,:));hold on;
% histogram(participant_info.age_yr((strcmp(participant_info.sex, '여') & (histo_group == 1)) == 1,:)); 
histogram(participant_info.age_yr(histo_group == 2), 'FaceColor','none');
xlim([4.5 9.5]);
ylim([0 8]);
title(['Boundary User' newline '(n = ' num2str(sum(histo_group == 2)) ')' ] , 'FontSize',13, 'FontWeight','bold');
subplot(1,2,2);
histogram(participant_info.age_yr(histo_group == 1), 'FaceColor','none');
xlim([4.5 9.5]);
ylim([0 8]);
title(['Boundary Non-User' newline '(n = ' num2str(sum(histo_group == 1)) ')' ] , 'FontSize',13, 'FontWeight','bold');


% histo_group = WWW_Behavior_table.inter_bnd_user;
histo_group = WWW_bnd_user_group
% www_histo_group = www_age_group;


a = figure();
a.Position = [2650 925 354 253];
subplot(1,2,1);
% histogram(participant_info.age_yr((strcmp(participant_info.sex, '남') & (histo_group == 1)) == 1,:));hold on;
% histogram(participant_info.age_yr((strcmp(participant_info.sex, '여') & (histo_group == 1)) == 1,:)); 
histogram(www_participant_info.age_yr(histo_group == 2), 'FaceColor','none');
xlim([4.5 9.5]);
ylim([0 18]);
title(['Boundary User' newline '(n = ' num2str(sum(histo_group == 2)) ')' ] , 'FontSize',13, 'FontWeight','bold');
subplot(1,2,2);
histogram(www_participant_info.age_yr(histo_group == 1), 'FaceColor','none');
xlim([4.5 9.5]);
ylim([0 18]);
title(['Boundary Non-User' newline '(n = ' num2str(sum(histo_group == 1)) ')' ] , 'FontSize',13, 'FontWeight','bold');


%% all trials ver) accuracy - each condition & each group

for gi = 1:2

a = figure();
a.Position = [2730 886 560 420];
clearvars WWW_Group MB_Group WWWavg WWWerr MBavg MBerr h p Two_Group SB_Group MB_Group

SB_Group{1} = Behavior_table.all_ABD_acc_what(MB_bnd_user_group==gi);
SB_Group{3} = Behavior_table.all_ABD_acc_whatwhen(MB_bnd_user_group ==gi);
SB_Group{5} = Behavior_table.all_ABD_acc_where(MB_bnd_user_group ==gi);
SB_Group{7} = Behavior_table.all_ABD_acc_wherewhen(MB_bnd_user_group ==gi);
SB_Group{9} = Behavior_table.all_ABD_acc_whatwhere(MB_bnd_user_group ==gi);
SB_Group{11} = Behavior_table.all_ABD_acc_fullem(MB_bnd_user_group ==gi);
% SB_Group{2} = []

MB_Group{2} = Behavior_table.all_MBD_acc_what(MB_bnd_user_group ==gi);
MB_Group{4} = Behavior_table.all_MBD_acc_whatwhen(MB_bnd_user_group ==gi);
MB_Group{6} = Behavior_table.all_MBD_acc_where(MB_bnd_user_group ==gi);
MB_Group{8} = Behavior_table.all_MBD_acc_wherewhen(MB_bnd_user_group ==gi);
MB_Group{10} = Behavior_table.all_MBD_acc_whatwhere(MB_bnd_user_group ==gi);
MB_Group{12} = Behavior_table.all_MBD_acc_fullem(MB_bnd_user_group ==gi);




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
    [h(ti), p(ti)] = ttest(SB_Group{(ti-1)*2+1}, MB_Group{ti*2})
    % ranksum
%     [p(ti), h(ti)] = signrank(round(SB_Group{(ti-1)*2+1},3), round(MB_Group{ti*2},3))

end

% =======================================================================

% draw bar


sb_fig_bar = jh_bar(SBavg, SBerr);  hold on;
sb_fig_bar.FaceColor = [.6 .7 .9];

mb_fig_bar = jh_bar(MBavg, MBerr); hold on;
mb_fig_bar.FaceColor = [.7 .5 .9]; % .2 .2. 2; .3 .4 .5 ];

if gi == 1
    sb_fig_bar.FaceColor = [.4 .5 .7];
    mb_fig_bar.FaceColor = [.5 .3 .7];
end


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
    text((bi-1)*2+1.5, MBavg(bi*2)+ 0.2, disp, 'FontSize', 10,'fontweight','bold', 'HorizontalAlignment', 'center', 'Color', 'black');

end

% =======================================================================

ylim([0 max(MBavg+ 0.2)])


% labels
acc_Labels = {'What'; ''; 'What+When'; ''; 'Where'; '';  'Where+When'; ''; 'What+Where'; '';  'FullEM' };
xticklabels(acc_Labels)
ylabel('Accuracy')

% title
legend({'Visual Boundary', '', 'Audio + Visual boundary'});

% if gi = 1
%     title(['Accuracy'],'FontWeight','bold')
% else
%     title(['Accuracy'],'FontWeight','bold')



end

%% all trial ver) accuracy group difference


% for gi = 1:2

a = figure();
a.Position = [2730 886 560 420];
clearvars WWW_Group MB_Group WWWavg WWWerr MBavg MBerr h p Two_Group SB_Group MB_Group

gi = 1
SB_Group{1} = Behavior_table.acc_what(MB_bnd_user_group==gi);
SB_Group{3} = Behavior_table.acc_whatwhen(MB_bnd_user_group ==gi);
SB_Group{5} = Behavior_table.acc_where(MB_bnd_user_group ==gi);
SB_Group{7} = Behavior_table.acc_wherewhen(MB_bnd_user_group ==gi);
SB_Group{9} = Behavior_table.acc_whatwhere(MB_bnd_user_group ==gi);
SB_Group{11} = Behavior_table.acc_fullem(MB_bnd_user_group ==gi);
% SB_Group{2} = []

gi = 2
MB_Group{2} = Behavior_table.acc_what(MB_bnd_user_group ==gi);
MB_Group{4} = Behavior_table.acc_whatwhen(MB_bnd_user_group ==gi);
MB_Group{6} = Behavior_table.acc_where(MB_bnd_user_group ==gi);
MB_Group{8} = Behavior_table.acc_wherewhen(MB_bnd_user_group ==gi);
MB_Group{10} = Behavior_table.acc_whatwhere(MB_bnd_user_group ==gi);
MB_Group{12} = Behavior_table.acc_fullem(MB_bnd_user_group ==gi);




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
sb_fig_bar.FaceColor = [.6 .7 .9];

mb_fig_bar = jh_bar(MBavg, MBerr); hold on;
mb_fig_bar.FaceColor = [.4 .5 .7]; % .2 .2. 2; .3 .4 .5 ];

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
    text((bi-1)*2+1.5, MBavg(bi*2)+ 0.2, disp, 'FontSize', 10,'fontweight','bold', 'HorizontalAlignment', 'center', 'Color', 'black');

end

% =======================================================================

ylim([0 max(MBavg+ 0.2)])


% labels
acc_Labels = {'What'; ''; 'What+When'; ''; 'Where'; '';  'Where+When'; ''; 'What+Where'; '';  'FullEM' };
xticklabels(acc_Labels)
ylabel('Accuracy')

% title
legend({'Boundary Non-User', '', 'Boundary User'});

% if gi = 1
%     title(['Accuracy'],'FontWeight','bold')
% else
%     title(['Accuracy'],'FontWeight','bold')



% end

%% [www] all trial ver) accuracy group difference



% for gi = 1:2

a = figure();
a.Position = [2730 886 560 420];
clearvars WWW_Group MB_Group WWWavg WWWerr MBavg MBerr h p Two_Group SB_Group MB_Group

gi = 1
SB_Group{1} = WWW_Behavior_table.acc_what(WWW_bnd_user_group==gi);
SB_Group{3} = WWW_Behavior_table.acc_whatwhen(WWW_bnd_user_group ==gi);
SB_Group{5} = WWW_Behavior_table.acc_where(WWW_bnd_user_group ==gi);
SB_Group{7} = WWW_Behavior_table.acc_wherewhen(WWW_bnd_user_group ==gi);
SB_Group{9} = WWW_Behavior_table.acc_whatwhere(WWW_bnd_user_group ==gi);
SB_Group{11} = WWW_Behavior_table.acc_fullem(WWW_bnd_user_group ==gi);
% SB_Group{2} = []

gi = 2
MB_Group{2} = WWW_Behavior_table.acc_what(WWW_bnd_user_group ==gi);
MB_Group{4} = WWW_Behavior_table.acc_whatwhen(WWW_bnd_user_group ==gi);
MB_Group{6} = WWW_Behavior_table.acc_where(WWW_bnd_user_group ==gi);
MB_Group{8} = WWW_Behavior_table.acc_wherewhen(WWW_bnd_user_group ==gi);
MB_Group{10} = WWW_Behavior_table.acc_whatwhere(WWW_bnd_user_group ==gi);
MB_Group{12} = WWW_Behavior_table.acc_fullem(WWW_bnd_user_group ==gi);




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
%     [h(ti), p(ti)] = ttest2(SB_Group{(ti-1)*2+1}, MB_Group{ti*2})
    % ranksum
    [p(ti), h(ti)] = ranksum(round(SB_Group{(ti-1)*2+1},3), round(MB_Group{ti*2},3))

end

% ======================================================================

% draw bar


sb_fig_bar = jh_bar(SBavg, SBerr);  hold on;
sb_fig_bar.FaceColor = [.6 .7 .9];

mb_fig_bar = jh_bar(MBavg, MBerr); hold on;
mb_fig_bar.FaceColor = [.4 .5 .7]; % .2 .2. 2; .3 .4 .5 ];

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
    text((bi-1)*2+1.5, MBavg(bi*2)+ 0.2, disp, 'FontSize', 10,'fontweight','bold', 'HorizontalAlignment', 'center', 'Color', 'black');

end

% =======================================================================

ylim([0 max(MBavg+ 0.2)])


% labels
acc_Labels = {'What'; ''; 'What+When'; ''; 'Where'; '';  'Where+When'; ''; 'What+Where'; '';  'FullEM' };
xticklabels(acc_Labels)
ylabel('Accuracy')

% title
legend({'Boundary Non-User', '', 'Boundary User'});

% if gi = 1
%     title(['Accuracy'],'FontWeight','bold')
% else
%     title(['Accuracy'],'FontWeight','bold')



% end

%% [www] 1 crossing ver) accuracy group difference



% for gi = 1:2

a = figure();
a.Position = [2730 886 560 420];
clearvars WWW_Group MB_Group WWWavg WWWerr MBavg MBerr h p Two_Group SB_Group MB_Group

gi = 1
SB_Group{1} = WWW_Behavior_table.cross1_acc_what(WWW_bnd_user_group==gi);
SB_Group{3} = WWW_Behavior_table.cross1_acc_whatwhen(WWW_bnd_user_group ==gi);
SB_Group{5} = WWW_Behavior_table.cross1_acc_where(WWW_bnd_user_group ==gi);
SB_Group{7} = WWW_Behavior_table.cross1_acc_wherewhen(WWW_bnd_user_group ==gi);
SB_Group{9} = WWW_Behavior_table.cross1_acc_whatwhere(WWW_bnd_user_group ==gi);
SB_Group{11} = WWW_Behavior_table.cross1_acc_fullem(WWW_bnd_user_group ==gi);
% SB_Group{2} = []

gi = 2
MB_Group{2} = WWW_Behavior_table.cross1_acc_what(WWW_bnd_user_group ==gi);
MB_Group{4} = WWW_Behavior_table.cross1_acc_whatwhen(WWW_bnd_user_group ==gi);
MB_Group{6} = WWW_Behavior_table.cross1_acc_where(WWW_bnd_user_group ==gi);
MB_Group{8} = WWW_Behavior_table.cross1_acc_wherewhen(WWW_bnd_user_group ==gi);
MB_Group{10} = WWW_Behavior_table.cross1_acc_whatwhere(WWW_bnd_user_group ==gi);
MB_Group{12} = WWW_Behavior_table.cross1_acc_fullem(WWW_bnd_user_group ==gi);




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
%     [h(ti), p(ti)] = ttest2(SB_Group{(ti-1)*2+1}, MB_Group{ti*2})
    % ranksum
    [p(ti), h(ti)] = ranksum(round(SB_Group{(ti-1)*2+1},3), round(MB_Group{ti*2},3))

end

% ======================================================================

% draw bar


sb_fig_bar = jh_bar(SBavg, SBerr);  hold on;
sb_fig_bar.FaceColor = [.6 .7 .9];

mb_fig_bar = jh_bar(MBavg, MBerr); hold on;
mb_fig_bar.FaceColor = [.4 .5 .7]; % .2 .2. 2; .3 .4 .5 ];

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
    text((bi-1)*2+1.5, MBavg(bi*2)+ 0.2, disp, 'FontSize', 10,'fontweight','bold', 'HorizontalAlignment', 'center', 'Color', 'black');

end

% =======================================================================

ylim([0 max(MBavg+ 0.2)])


% labels
acc_Labels = {'What'; ''; 'What+When'; ''; 'Where'; '';  'Where+When'; ''; 'What+Where'; '';  'FullEM' };
xticklabels(acc_Labels)
ylabel('Accuracy')

% title
legend({'Boundary Non-User', '', 'Boundary User'});

% if gi = 1
%     title(['Accuracy'],'FontWeight','bold')
% else
%     title(['Accuracy'],'FontWeight','bold')



% end

%% all trials ver) right & wrong ver) RT - each condition & each group

for gi = 1:2

a = figure();
a.Position = [2780 922 560 420];
clearvars WWW_Group MB_Group WWWavg WWWerr MBavg MBerr h p Two_Group SB_Group 


SB_Group{1} = Behavior_table.all_ABD_rt_respond(MB_bnd_user_group ==gi);
% SB_Group{2} = [];
SB_Group{5} = Behavior_table.all_ABD_rt_animal(MB_bnd_user_group ==gi);
SB_Group{7} = Behavior_table.all_ABD_rt_location(MB_bnd_user_group ==gi);


MB_Group{2} = Behavior_table.all_MBD_rt_respond(MB_bnd_user_group ==gi);
% MB_Group{2} = [];
MB_Group{6} = Behavior_table.all_MBD_rt_animal(MB_bnd_user_group ==gi);
MB_Group{8} = Behavior_table.all_MBD_rt_location(MB_bnd_user_group ==gi);


% avg & err
[SBavg, SBerr] = jh_mean_err(SB_Group);
[MBavg, MBerr] = jh_mean_err(MB_Group);


% stat ==================================================================

% anova
SB_Group_data = cell2mat(SB_Group');
sb_array = cell2mat(arrayfun(@(x) repmat(x, size(SB_Group{x})), [1,5,7], 'uni', 0)');
[~,tbl,sb_stats] = anova1(SB_Group_data,sb_array,'off');
sb_group_compare = multcompare(sb_stats,"Display","off")


MB_Group_data = cell2mat(MB_Group');
mb_array = cell2mat(arrayfun(@(x) repmat(x, size(MB_Group{x})), [2,6,8], 'uni', 0)');
[~,tbl,mb_stats] = anova1(MB_Group_data,mb_array,'off');
mb_group_compare = multcompare(mb_stats,"Display","off")


for ti = 1:4
    if ismember(ti, [1,3,4])
        % ttest
%         [h(ti), p(ti)] = ttest(SB_Group{(ti-1)*2+1}, MB_Group{ti*2})
        % ranksum
        [p(ti), h(ti)] = signrank(round(SB_Group{(ti-1)*2+1},3), round(MB_Group{ti*2},3))

    end
end

% =======================================================================

% draw bar
sb_fig_bar = jh_bar(SBavg, SBerr);  hold on;
sb_fig_bar.FaceColor = [.6 .7 .9];

mb_fig_bar = jh_bar(MBavg, MBerr); hold on;
mb_fig_bar.FaceColor = [.7 .5 .9]; % .2 .2. 2; .3 .4 .5 ];
if gi == 1
    sb_fig_bar.FaceColor = [.4 .5 .7];
    mb_fig_bar.FaceColor = [.5 .3 .7];
end

% significance ==========================================================
for bi = 1:4
    if ismember(ti, [1,3,4])
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
    text(bi+0.5, SBavg(bi)+ 1, disp, 'FontSize', 10,'fontweight','bold', 'HorizontalAlignment', 'center', 'Color', 'black');
    end
end

% =======================================================================

ylim([0 14])%max(MBavg+ 2)])


% labels
acc_Labels = {'Respond'; '';''; ''; 'What'; ''; 'Where'};
xticklabels(acc_Labels)
ylabel('Reaction Time (sec)')

% title
legend({'Visual', '', 'Audio + Visual'});
% title(['Accuracy'],'FontWeight','bold')

end

%% all trials ver) right & wrong ver) RT - group difference



a = figure();
a.Position = [2780 922 560 420];
clearvars WWW_Group MB_Group WWWavg WWWerr MBavg MBerr h p Two_Group SB_Group 

gi = 1
SB_Group{1} = Behavior_table.rt_respond(MB_bnd_user_group ==gi);
% SB_Group{2} = [];
SB_Group{5} = Behavior_table.rt_animal(MB_bnd_user_group ==gi);
SB_Group{7} = Behavior_table.rt_location(MB_bnd_user_group ==gi);

gi = 2
MB_Group{2} = Behavior_table.rt_respond(MB_bnd_user_group ==gi);
% MB_Group{2} = [];
MB_Group{6} = Behavior_table.rt_animal(MB_bnd_user_group ==gi);
MB_Group{8} = Behavior_table.rt_location(MB_bnd_user_group ==gi);


% avg & err
[SBavg, SBerr] = jh_mean_err(SB_Group);
[MBavg, MBerr] = jh_mean_err(MB_Group);


% stat ==================================================================

% anova
SB_Group_data = cell2mat(SB_Group');
sb_array = cell2mat(arrayfun(@(x) repmat(x, size(SB_Group{x})), [1,5,7], 'uni', 0)');
[~,tbl,sb_stats] = anova1(SB_Group_data,sb_array,'off');
sb_group_compare = multcompare(sb_stats,"Display","off")


MB_Group_data = cell2mat(MB_Group');
mb_array = cell2mat(arrayfun(@(x) repmat(x, size(MB_Group{x})), [2,6,8], 'uni', 0)');
[~,tbl,mb_stats] = anova1(MB_Group_data,mb_array,'off');
mb_group_compare = multcompare(mb_stats,"Display","off")


for ti = 1:4
    if ismember(ti, [1,3,4])
        % ttest
        [h(ti), p(ti)] = ttest2(SB_Group{(ti-1)*2+1}, MB_Group{ti*2})
        % ranksum
%         [p(ti), h(ti)] = ranksum(round(SB_Group{(ti-1)*2+1},3), round(MB_Group{ti*2},3))

    end
end

% =======================================================================

% draw bar

sb_fig_bar = jh_bar(SBavg, SBerr);  hold on;
sb_fig_bar.FaceColor = [.6 .7 .9];

mb_fig_bar = jh_bar(MBavg, MBerr); hold on;
mb_fig_bar.FaceColor = [.4 .5 .7]; % .2 .2. 2; .3 .4 .5 ];

% significance ==========================================================
for bi = 1:4
    if ismember(ti, [1,3,4])
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
    text(bi+0.5, SBavg(bi)+ 1, disp, 'FontSize', 10,'fontweight','bold', 'HorizontalAlignment', 'center', 'Color', 'black');
    end
end

% =======================================================================

ylim([0 14])%max(MBavg+ 2)])


% labels
acc_Labels = {'Respond'; '';''; ''; 'What'; ''; 'Where'};
xticklabels(acc_Labels)
ylabel('Reaction Time (sec)')

% title
legend({'Visual', '', 'Audio + Visual'});
% title(['Accuracy'],'FontWeight','bold')


%% single boundary crossing trials ver) accuracy - each condition & each group

for gi = 1:2

a = figure();
a.Position = [2730 886 560 420];
clearvars WWW_Group MB_Group WWWavg WWWerr MBavg MBerr h p Two_Group SB_Group MB_Group

SB_Group{1} = Behavior_table.select_ABD_acc_what(MB_bnd_user_group==gi);
SB_Group{3} = Behavior_table.select_ABD_acc_whatwhen(MB_bnd_user_group ==gi);
SB_Group{5} = Behavior_table.select_ABD_acc_where(MB_bnd_user_group ==gi);
SB_Group{7} = Behavior_table.select_ABD_acc_wherewhen(MB_bnd_user_group ==gi);
SB_Group{9} = Behavior_table.select_ABD_acc_whatwhere(MB_bnd_user_group ==gi);
SB_Group{11} = Behavior_table.select_ABD_acc_fullem(MB_bnd_user_group ==gi);
% SB_Group{2} = []

MB_Group{2} = Behavior_table.select_MBD_acc_what(MB_bnd_user_group ==gi);
MB_Group{4} = Behavior_table.select_MBD_acc_whatwhen(MB_bnd_user_group ==gi);
MB_Group{6} = Behavior_table.select_MBD_acc_where(MB_bnd_user_group ==gi);
MB_Group{8} = Behavior_table.select_MBD_acc_wherewhen(MB_bnd_user_group ==gi);
MB_Group{10} = Behavior_table.select_MBD_acc_whatwhere(MB_bnd_user_group ==gi);
MB_Group{12} = Behavior_table.select_MBD_acc_fullem(MB_bnd_user_group ==gi);




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
%     [h(ti), p(ti)] = ttest(SB_Group{(ti-1)*2+1}, MB_Group{ti*2})
    % ranksum
    [p(ti), h(ti)] = signrank(round(SB_Group{(ti-1)*2+1},3), round(MB_Group{ti*2},3))

end

% =======================================================================

% draw bar


sb_fig_bar = jh_bar(SBavg, SBerr);  hold on;
sb_fig_bar.FaceColor = [.6 .7 .9];

mb_fig_bar = jh_bar(MBavg, MBerr); hold on;
mb_fig_bar.FaceColor = [.7 .5 .9]; % .2 .2. 2; .3 .4 .5 ];

if gi == 1
    sb_fig_bar.FaceColor = [.4 .5 .7];
    mb_fig_bar.FaceColor = [.5 .3 .7];
end


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
    text((bi-1)*2+1.5, MBavg(bi*2)+ 0.3, disp, 'FontSize', 10,'fontweight','bold', 'HorizontalAlignment', 'center', 'Color', 'black');

end

% =======================================================================

ylim([0 max(MBavg+ 0.2)])


% labels
acc_Labels = {'What'; ''; 'What+When'; ''; 'Where'; '';  'Where+When'; ''; 'What+Where'; '';  'FullEM' };
xticklabels(acc_Labels)
ylabel('Accuracy')

% title
legend({'Visual Boundary', '', 'Audio + Visual boundary'});

% if gi = 1
%     title(['Accuracy'],'FontWeight','bold')
% else
%     title(['Accuracy'],'FontWeight','bold')



end

%% single boundary crossing trials ver) accuracy group difference


% for gi = 1:2

a = figure();
a.Position = [2730 886 560 420];
clearvars WWW_Group MB_Group WWWavg WWWerr MBavg MBerr h p Two_Group SB_Group MB_Group

gi = 1
SB_Group{1} = Behavior_table.select_acc_what(MB_bnd_user_group==gi);
SB_Group{3} = Behavior_table.select_acc_whatwhen(MB_bnd_user_group ==gi);
SB_Group{5} = Behavior_table.select_acc_where(MB_bnd_user_group ==gi);
SB_Group{7} = Behavior_table.select_acc_wherewhen(MB_bnd_user_group ==gi);
SB_Group{9} = Behavior_table.select_acc_whatwhere(MB_bnd_user_group ==gi);
SB_Group{11} = Behavior_table.select_acc_fullem(MB_bnd_user_group ==gi);
% SB_Group{2} = []

gi = 2
MB_Group{2} = Behavior_table.select_acc_what(MB_bnd_user_group ==gi);
MB_Group{4} = Behavior_table.select_acc_whatwhen(MB_bnd_user_group ==gi);
MB_Group{6} = Behavior_table.select_acc_where(MB_bnd_user_group ==gi);
MB_Group{8} = Behavior_table.select_acc_wherewhen(MB_bnd_user_group ==gi);
MB_Group{10} = Behavior_table.select_acc_whatwhere(MB_bnd_user_group ==gi);
MB_Group{12} = Behavior_table.select_acc_fullem(MB_bnd_user_group ==gi);




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
%     [h(ti), p(ti)] = ttest2(SB_Group{(ti-1)*2+1}, MB_Group{ti*2})
    % ranksum
    [p(ti), h(ti)] = ranksum(round(SB_Group{(ti-1)*2+1},3), round(MB_Group{ti*2},3))

end

% ======================================================================

% draw bar


sb_fig_bar = jh_bar(SBavg, SBerr);  hold on;
sb_fig_bar.FaceColor = [.6 .7 .9];

mb_fig_bar = jh_bar(MBavg, MBerr); hold on;
mb_fig_bar.FaceColor = [.4 .5 .7]; % .2 .2. 2; .3 .4 .5 ];

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
    text((bi-1)*2+1.5, MBavg(bi*2)+ 0.2, disp, 'FontSize', 10,'fontweight','bold', 'HorizontalAlignment', 'center', 'Color', 'black');

end

% =======================================================================

ylim([0 max(MBavg+ 0.2)])


% labels
acc_Labels = {'What'; ''; 'What+When'; ''; 'Where'; '';  'Where+When'; ''; 'What+Where'; '';  'FullEM' };
xticklabels(acc_Labels)
ylabel('Accuracy')

% title
legend({'Boundary Non-User', '', 'Boundary User'});

% if gi = 1
%     title(['Accuracy'],'FontWeight','bold')
% else
%     title(['Accuracy'],'FontWeight','bold')



% end


%% single boundary conditon - right & wrong ver) RT - each condition & each group

for gi = 1:2

a = figure();
a.Position = [2780 922 560 420];
clearvars WWW_Group MB_Group WWWavg WWWerr MBavg MBerr h p Two_Group SB_Group 


SB_Group{1} = Behavior_table.select_ABD_rt_respond(MB_bnd_user_group ==gi);
% SB_Group{2} = [];
SB_Group{5} = Behavior_table.select_ABD_rt_animal(MB_bnd_user_group ==gi);
SB_Group{7} = Behavior_table.select_ABD_rt_location(MB_bnd_user_group ==gi);


MB_Group{2} = Behavior_table.select_MBD_rt_respond(MB_bnd_user_group ==gi);
% MB_Group{2} = [];
MB_Group{6} = Behavior_table.select_MBD_rt_animal(MB_bnd_user_group ==gi);
MB_Group{8} = Behavior_table.select_MBD_rt_location(MB_bnd_user_group ==gi);


% avg & err
[SBavg, SBerr] = jh_mean_err(SB_Group);
[MBavg, MBerr] = jh_mean_err(MB_Group);


% stat ==================================================================

% anova
SB_Group_data = cell2mat(SB_Group');
sb_array = cell2mat(arrayfun(@(x) repmat(x, size(SB_Group{x})), [1,5,7], 'uni', 0)');
[~,tbl,sb_stats] = anova1(SB_Group_data,sb_array,'off');
sb_group_compare = multcompare(sb_stats,"Display","off")


MB_Group_data = cell2mat(MB_Group');
mb_array = cell2mat(arrayfun(@(x) repmat(x, size(MB_Group{x})), [2,6,8], 'uni', 0)');
[~,tbl,mb_stats] = anova1(MB_Group_data,mb_array,'off');
mb_group_compare = multcompare(mb_stats,"Display","off")


for ti = 1:4
    if ismember(ti, [1,3,4])
        % ttest
        [h(ti), p(ti)] = ttest(SB_Group{(ti-1)*2+1}, MB_Group{ti*2})
        % ranksum
%         [p(ti), h(ti)] = signrank(round(SB_Group{(ti-1)*2+1},3), round(MB_Group{ti*2},3))

    end
end

% =======================================================================

% draw bar
sb_fig_bar = jh_bar(SBavg, SBerr);  hold on;
sb_fig_bar.FaceColor = [.6 .7 .9];

mb_fig_bar = jh_bar(MBavg, MBerr); hold on;
mb_fig_bar.FaceColor = [.7 .5 .9]; % .2 .2. 2; .3 .4 .5 ];
if gi == 1
    sb_fig_bar.FaceColor = [.4 .5 .7];
    mb_fig_bar.FaceColor = [.5 .3 .7];
end

% significance ==========================================================
for bi = 1:4
    if ismember(ti, [1,3,4])
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
    text(bi+0.5, SBavg(bi)+ 1, disp, 'FontSize', 10,'fontweight','bold', 'HorizontalAlignment', 'center', 'Color', 'black');
    end
end

% =======================================================================

ylim([0 14])%max(MBavg+ 2)])


% labels
acc_Labels = {'Respond'; '';''; ''; 'What'; ''; 'Where'};
xticklabels(acc_Labels)
ylabel('Reaction Time (sec)')

% title
legend({'Visual', '', 'Audio + Visual'});
% title(['Accuracy'],'FontWeight','bold')

end




%% single boundary conditon - right & wrong ver) RT - group difference

% for gi = 1:2

a = figure();
a.Position = [2780 922 560 420];
clearvars WWW_Group MB_Group WWWavg WWWerr MBavg MBerr h p Two_Group SB_Group 

gi = 1
SB_Group{1} = Behavior_table.select_rt_respond(MB_bnd_user_group ==gi);
% SB_Group{2} = [];
SB_Group{5} = Behavior_table.select_rt_animal(MB_bnd_user_group ==gi);
SB_Group{7} = Behavior_table.select_rt_location(MB_bnd_user_group ==gi);

gi = 2
MB_Group{2} = Behavior_table.select_rt_respond(MB_bnd_user_group ==gi);
% MB_Group{2} = [];
MB_Group{6} = Behavior_table.select_rt_animal(MB_bnd_user_group ==gi);
MB_Group{8} = Behavior_table.select_rt_location(MB_bnd_user_group ==gi);


% avg & err
[SBavg, SBerr] = jh_mean_err(SB_Group);
[MBavg, MBerr] = jh_mean_err(MB_Group);


% stat ==================================================================

% anova
SB_Group_data = cell2mat(SB_Group');
sb_array = cell2mat(arrayfun(@(x) repmat(x, size(SB_Group{x})), [1,5,7], 'uni', 0)');
[~,tbl,sb_stats] = anova1(SB_Group_data,sb_array,'off');
sb_group_compare = multcompare(sb_stats,"Display","off")


MB_Group_data = cell2mat(MB_Group');
mb_array = cell2mat(arrayfun(@(x) repmat(x, size(MB_Group{x})), [2,6,8], 'uni', 0)');
[~,tbl,mb_stats] = anova1(MB_Group_data,mb_array,'off');
mb_group_compare = multcompare(mb_stats,"Display","off")


for ti = 1:4
    if ismember(ti, [1,3,4])
        % ttest
%         [h(ti), p(ti)] = ttest2(SB_Group{(ti-1)*2+1}, MB_Group{ti*2})
        % ranksum
        [p(ti), h(ti)] = ranksum(round(SB_Group{(ti-1)*2+1},3), round(MB_Group{ti*2},3))

    end
end

% =======================================================================

% draw bar

sb_fig_bar = jh_bar(SBavg, SBerr);  hold on;
sb_fig_bar.FaceColor = [.6 .7 .9];

mb_fig_bar = jh_bar(MBavg, MBerr); hold on;
mb_fig_bar.FaceColor = [.4 .5 .7]; % .2 .2. 2; .3 .4 .5 ];

% if gi == 1
%     sb_fig_bar.FaceColor = [.4 .5 .7];
%     mb_fig_bar.FaceColor = [.5 .3 .7];
% end

% significance ==========================================================
for bi = 1:4
    if ismember(ti, [1,3,4])
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
    text(bi+0.5, SBavg(bi)+ 1, disp, 'FontSize', 10,'fontweight','bold', 'HorizontalAlignment', 'center', 'Color', 'black');
    end
end

% =======================================================================

ylim([0 14])%max(MBavg+ 2)])


% labels
acc_Labels = {'Respond'; '';''; ''; 'What'; ''; 'Where'};
xticklabels(acc_Labels)
ylabel('Reaction Time (sec)')

% title
legend({'Visual', '', 'Audio + Visual'});
% title(['Accuracy'],'FontWeight','bold')

% end

%% [WWW]  right & wrong ver) RT - group difference



% for gi = 1:2

a = figure();
a.Position = [2780 922 560 420];
clearvars WWW_Group MB_Group WWWavg WWWerr MBavg MBerr h p Two_Group SB_Group 

gi = 1
SB_Group{1} = WWW_Behavior_table.rt_respond(WWW_bnd_user_group ==gi);
% SB_Group{2} = [];
SB_Group{5} = WWW_Behavior_table.rt_animal(WWW_bnd_user_group ==gi);
SB_Group{7} = WWW_Behavior_table.rt_location(WWW_bnd_user_group ==gi);

gi = 2
MB_Group{2} = WWW_Behavior_table.rt_respond(WWW_bnd_user_group ==gi);
% MB_Group{2} = [];
MB_Group{6} = WWW_Behavior_table.rt_animal(WWW_bnd_user_group ==gi);
MB_Group{8} = WWW_Behavior_table.rt_location(WWW_bnd_user_group ==gi);


% avg & err
[SBavg, SBerr] = jh_mean_err(SB_Group);
[MBavg, MBerr] = jh_mean_err(MB_Group);


% stat ==================================================================

% anova
SB_Group_data = cell2mat(SB_Group');
sb_array = cell2mat(arrayfun(@(x) repmat(x, size(SB_Group{x})), [1,5,7], 'uni', 0)');
[~,tbl,sb_stats] = anova1(SB_Group_data,sb_array,'off');
sb_group_compare = multcompare(sb_stats,"Display","off")


MB_Group_data = cell2mat(MB_Group');
mb_array = cell2mat(arrayfun(@(x) repmat(x, size(MB_Group{x})), [2,6,8], 'uni', 0)');
[~,tbl,mb_stats] = anova1(MB_Group_data,mb_array,'off');
mb_group_compare = multcompare(mb_stats,"Display","off")


for ti = 1:4
    if ismember(ti, [1,3,4])
        % ttest
%         [h(ti), p(ti)] = ttest2(SB_Group{(ti-1)*2+1}, MB_Group{ti*2})
        % ranksum
        [p(ti), h(ti)] = ranksum(round(SB_Group{(ti-1)*2+1},3), round(MB_Group{ti*2},3))

    end
end

% =======================================================================

% draw bar

sb_fig_bar = jh_bar(SBavg, SBerr);  hold on;
sb_fig_bar.FaceColor = [.6 .7 .9];

mb_fig_bar = jh_bar(MBavg, MBerr); hold on;
mb_fig_bar.FaceColor = [.4 .5 .7]; % .2 .2. 2; .3 .4 .5 ];

% if gi == 1
%     sb_fig_bar.FaceColor = [.4 .5 .7];
%     mb_fig_bar.FaceColor = [.5 .3 .7];
% end

% significance ==========================================================
for bi = 1:4
    if ismember(ti, [1,3,4])
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
    text(bi+0.5, SBavg(bi)+ 1, disp, 'FontSize', 10,'fontweight','bold', 'HorizontalAlignment', 'center', 'Color', 'black');
    end
end

% =======================================================================

ylim([0 14])%max(MBavg+ 2)])


% labels
acc_Labels = {'Respond'; '';''; ''; 'What'; ''; 'Where'};
xticklabels(acc_Labels)
ylabel('Reaction Time (sec)')

% title
legend({'Visual', '', 'Audio + Visual'});
% title(['Accuracy'],'FontWeight','bold')

% end

%% [WWW]  right trial only ver) RT - group difference



% for gi = 1:2

a = figure();
a.Position = [2780 922 560 420];
clearvars WWW_Group MB_Group WWWavg WWWerr MBavg MBerr h p Two_Group SB_Group 

gi = 1
SB_Group{1} = WWW_Behavior_table.rt_right_respond(WWW_bnd_user_group ==gi);
% SB_Group{2} = [];
SB_Group{5} = WWW_Behavior_table.rt_right_animal(WWW_bnd_user_group ==gi);
SB_Group{7} = WWW_Behavior_table.rt_right_location(WWW_bnd_user_group ==gi);

gi = 2
MB_Group{2} = WWW_Behavior_table.rt_right_respond(WWW_bnd_user_group ==gi);
% MB_Group{2} = [];
MB_Group{6} = WWW_Behavior_table.rt_right_animal(WWW_bnd_user_group ==gi);
MB_Group{8} = WWW_Behavior_table.rt_right_location(WWW_bnd_user_group ==gi);


% avg & err
[SBavg, SBerr] = jh_mean_err(SB_Group);
[MBavg, MBerr] = jh_mean_err(MB_Group);


% stat ==================================================================

% anova
SB_Group_data = cell2mat(SB_Group');
sb_array = cell2mat(arrayfun(@(x) repmat(x, size(SB_Group{x})), [1,5,7], 'uni', 0)');
[~,tbl,sb_stats] = anova1(SB_Group_data,sb_array,'off');
sb_group_compare = multcompare(sb_stats,"Display","off")


MB_Group_data = cell2mat(MB_Group');
mb_array = cell2mat(arrayfun(@(x) repmat(x, size(MB_Group{x})), [2,6,8], 'uni', 0)');
[~,tbl,mb_stats] = anova1(MB_Group_data,mb_array,'off');
mb_group_compare = multcompare(mb_stats,"Display","off")


for ti = 1:4
    if ismember(ti, [1,3,4])
        % ttest
        [h(ti), p(ti)] = ttest2(SB_Group{(ti-1)*2+1}, MB_Group{ti*2})
        % ranksum
%         [p(ti), h(ti)] = ranksum(round(SB_Group{(ti-1)*2+1},3), round(MB_Group{ti*2},3))

    end
end

% =======================================================================

% draw bar

sb_fig_bar = jh_bar(SBavg, SBerr);  hold on;
sb_fig_bar.FaceColor = [.6 .7 .9];

mb_fig_bar = jh_bar(MBavg, MBerr); hold on;
mb_fig_bar.FaceColor = [.4 .5 .7]; % .2 .2. 2; .3 .4 .5 ];

% if gi == 1
%     sb_fig_bar.FaceColor = [.4 .5 .7];
%     mb_fig_bar.FaceColor = [.5 .3 .7];
% end

% significance ==========================================================
for bi = 1:4
    if ismember(ti, [1,3,4])
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
    text(bi+0.5, SBavg(bi)+ 1, disp, 'FontSize', 10,'fontweight','bold', 'HorizontalAlignment', 'center', 'Color', 'black');
    end
end

% =======================================================================

ylim([0 14])%max(MBavg+ 2)])


% labels
acc_Labels = {'Respond'; '';''; ''; 'What'; ''; 'Where'};
xticklabels(acc_Labels)
ylabel('Reaction Time (sec)')

% title
legend({'Visual', '', 'Audio + Visual'});
% title(['Accuracy'],'FontWeight','bold')

% end


%% [crossing 0] accuracy - each condition & each group

for gi = 1:2

a = figure();
a.Position = [2730 886 560 420];
clearvars WWW_Group MB_Group WWWavg WWWerr MBavg MBerr h p Two_Group SB_Group MB_Group

SB_Group{1} = Behavior_table.cross0_ABD_acc_what(MB_bnd_user_group==gi);
SB_Group{3} = Behavior_table.cross0_ABD_acc_whatwhen(MB_bnd_user_group ==gi);
SB_Group{5} = Behavior_table.cross0_ABD_acc_where(MB_bnd_user_group ==gi);
SB_Group{7} = Behavior_table.cross0_ABD_acc_wherewhen(MB_bnd_user_group ==gi);
SB_Group{9} = Behavior_table.cross0_ABD_acc_whatwhere(MB_bnd_user_group ==gi);
SB_Group{11} = Behavior_table.cross0_ABD_acc_fullem(MB_bnd_user_group ==gi);
% SB_Group{2} = []

MB_Group{2} = Behavior_table.cross0_MBD_acc_what(MB_bnd_user_group ==gi);
MB_Group{4} = Behavior_table.cross0_MBD_acc_whatwhen(MB_bnd_user_group ==gi);
MB_Group{6} = Behavior_table.cross0_MBD_acc_where(MB_bnd_user_group ==gi);
MB_Group{8} = Behavior_table.cross0_MBD_acc_wherewhen(MB_bnd_user_group ==gi);
MB_Group{10} = Behavior_table.cross0_MBD_acc_whatwhere(MB_bnd_user_group ==gi);
MB_Group{12} = Behavior_table.cross0_MBD_acc_fullem(MB_bnd_user_group ==gi);




% avg & err
[SBavg, SBerr] = jh_mean_err(SB_Group);
[MBavg, MBerr] = jh_mean_err(MB_Group);


% stat ==================================================================

% anova
SB_Group_data = cell2mat(SB_Group');
sb_array = cell2mat(arrayfun(@(x) repmat(x, size(SB_Group{x})), [1 3 5 7 9 11], 'uni', 0)');
[~,tbl,sb_stats] = anova1(SB_Group_data,sb_array,'off');
% sb_group_compare = multcompare(sb_stats,"Display","off")


MB_Group_data = cell2mat(MB_Group');
mb_array = cell2mat(arrayfun(@(x) repmat(x, size(MB_Group{x})), [2 4 6 8 10 12], 'uni', 0)');
[~,tbl,mb_stats] = anova1(MB_Group_data,mb_array,'off');
% mb_group_compare = multcompare(mb_stats,"Display","off")


for ti = 1:6
    % ttest
%     [h(ti), p(ti)] = ttest(SB_Group{(ti-1)*2+1}, MB_Group{ti*2})
    % ranksum
    [p(ti), h(ti)] = signrank(round(SB_Group{(ti-1)*2+1},3), round(MB_Group{ti*2},3))

end

% =======================================================================

% draw bar


sb_fig_bar = jh_bar(SBavg, SBerr);  hold on;
sb_fig_bar.FaceColor = [.6 .7 .9];

mb_fig_bar = jh_bar(MBavg, MBerr); hold on;
mb_fig_bar.FaceColor = [.7 .5 .9]; % .2 .2. 2; .3 .4 .5 ];

if gi == 1
    sb_fig_bar.FaceColor = [.4 .5 .7];
    mb_fig_bar.FaceColor = [.5 .3 .7];
end


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
    text((bi-1)*2+1.5, MBavg(bi*2)+ 0.3, disp, 'FontSize', 10,'fontweight','bold', 'HorizontalAlignment', 'center', 'Color', 'black');

end

% =======================================================================

ylim([0 max(MBavg+ 0.2)])


% labels
acc_Labels = {'What'; ''; 'What+When'; ''; 'Where'; '';  'Where+When'; ''; 'What+Where'; '';  'FullEM' };
xticklabels(acc_Labels)
ylabel('Accuracy')

% title
legend({'Visual Boundary', '', 'Audio + Visual boundary'});

% if gi = 1
%     title(['Accuracy'],'FontWeight','bold')
% else
%     title(['Accuracy'],'FontWeight','bold')



end

%% [crossing 2] accuracy - each condition & each group

for gi = 1:2

a = figure();
a.Position = [2730 886 560 420];
clearvars WWW_Group MB_Group WWWavg WWWerr MBavg MBerr h p Two_Group SB_Group MB_Group

SB_Group{1} = Behavior_table.cross2_ABD_acc_what(MB_bnd_user_group==gi);
SB_Group{3} = Behavior_table.cross2_ABD_acc_whatwhen(MB_bnd_user_group ==gi);
SB_Group{5} = Behavior_table.cross2_ABD_acc_where(MB_bnd_user_group ==gi);
SB_Group{7} = Behavior_table.cross2_ABD_acc_wherewhen(MB_bnd_user_group ==gi);
SB_Group{9} = Behavior_table.cross2_ABD_acc_whatwhere(MB_bnd_user_group ==gi);
SB_Group{11} = Behavior_table.cross2_ABD_acc_fullem(MB_bnd_user_group ==gi);
% SB_Group{2} = []

MB_Group{2} = Behavior_table.cross2_MBD_acc_what(MB_bnd_user_group ==gi);
MB_Group{4} = Behavior_table.cross2_MBD_acc_whatwhen(MB_bnd_user_group ==gi);
MB_Group{6} = Behavior_table.cross2_MBD_acc_where(MB_bnd_user_group ==gi);
MB_Group{8} = Behavior_table.cross2_MBD_acc_wherewhen(MB_bnd_user_group ==gi);
MB_Group{10} = Behavior_table.cross2_MBD_acc_whatwhere(MB_bnd_user_group ==gi);
MB_Group{12} = Behavior_table.cross2_MBD_acc_fullem(MB_bnd_user_group ==gi);




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
%     [h(ti), p(ti)] = ttest(SB_Group{(ti-1)*2+1}, MB_Group{ti*2})
    % ranksum
    [p(ti), h(ti)] = signrank(round(SB_Group{(ti-1)*2+1},3), round(MB_Group{ti*2},3))

end

% =======================================================================

% draw bar


sb_fig_bar = jh_bar(SBavg, SBerr);  hold on;
sb_fig_bar.FaceColor = [.6 .7 .9];

mb_fig_bar = jh_bar(MBavg, MBerr); hold on;
mb_fig_bar.FaceColor = [.7 .5 .9]; % .2 .2. 2; .3 .4 .5 ];

if gi == 1
    sb_fig_bar.FaceColor = [.4 .5 .7];
    mb_fig_bar.FaceColor = [.5 .3 .7];
end


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
    text((bi-1)*2+1.5, MBavg(bi*2)+ 0.3, disp, 'FontSize', 10,'fontweight','bold', 'HorizontalAlignment', 'center', 'Color', 'black');

end

% =======================================================================

ylim([0 max(MBavg+ 0.2)])


% labels
acc_Labels = {'What'; ''; 'What+When'; ''; 'Where'; '';  'Where+When'; ''; 'What+Where'; '';  'FullEM' };
xticklabels(acc_Labels)
ylabel('Accuracy')

% title
legend({'Visual Boundary', '', 'Audio + Visual boundary'});

% if gi = 1
%     title(['Accuracy'],'FontWeight','bold')
% else
%     title(['Accuracy'],'FontWeight','bold')



end


%% Interference Age Curve (www)



plot_age_range = 5:9;
selected_data1 = age_curve.www_inter_acc_cat1(plot_age_range)
selected_data2 = age_curve.www_inter_acc_cat2(plot_age_range)
selected_data3 = age_curve.www_inter_acc(plot_age_range)

a = figure();

line1 = plot(plot_age_range, selected_data1, '-o', 'LineWidth', 2, 'Color', Inter_Color(2, :));
hold on
line2 = plot(plot_age_range, selected_data2, '-o', 'LineWidth', 2, 'Color', Inter_Color(1, :));


xlim([4.7 9.3])
ylim([.6 1])



legend_h = legend({' Category 1', ' Category 2'}, 'EdgeColor', 'none', 'Location', 'Southeast')
xticks(plot_age_range)
yticks([.5 .6 .7 .8 .9 1])

set(gca,'FontName','Arial','FontSize',14,'fontweight','bold','linewidth',2, 'box','off')
hold off


%%

task_Color.default = [0.9 0.6 1];

% MB_corr_selected = {'ACC'; 'DDD'};

% Behavior_table.inter_bnd_use_index
% caculate correlation
% [r,p] = corr(reshape(xData,[],1),reshape(yData,[],1), varargin{:});
% remove nan
signum = 0;
figure();
inter_sig_list = zeros(length(Behavior_table.Properties.VariableNames),1);
for ffi = 6:length( Behavior_table.Properties.VariableNames)
    if ~contains(Behavior_table.Properties.VariableNames{ffi}, 'rt') && ~contains(Behavior_table.Properties.VariableNames{ffi}, 'inter')
%     if ~ismember(ffi, [10])
    xData = Behavior_table.inter_bnd_use_index;
    yData = Behavior_table.(Behavior_table.Properties.VariableNames{ffi});

    if islogical(yData)
        yData = double(yData);
    end
    xData = reshape(xData,[],1);
    yData = reshape(yData,[],1);
    ind_remove = isnan(xData) | isnan(yData);
    xData(ind_remove) = [];
    yData(ind_remove) = [];

    [r,p] = corr(reshape(xData,[],1),reshape(yData,[],1));
    
    if p<0.05
        Behavior_table.Properties.VariableNames{ffi}
        inter_sig_list(ffi,1) = 1;
%         figure();
        signum = signum + 1;
        subplot(4,4,signum)
        [r, p] = func_corr(xData, yData, task_Color.default, 'on');
        t = title([ Behavior_table.Properties.VariableNames{ffi} newline 'r = ' num2str(r) ' p = ' num2str(p)]);
        set(t,'Interpreter','none');
        

    elseif p<0.1
        inter_sig_list(ffi,1) = 2;
        signum = signum + 1;
        subplot(4,4,signum)

%         figure();
        [r, p] = func_corr(xData, yData, task_Color.default, 'on');
        t = title([ Behavior_table.Properties.VariableNames{ffi} newline 'r = ' num2str(r) ' p = ' num2str(p)]);
        set(t,'Interpreter','none');


    end
    end

end
sgtitle(['Intertrial Category 2 ACC - Category 1 ACC'])

%%
condition ={'select_ABD_wrong_cat'};

plot_age_range = 6:8;
age_group = participant_info.age_yr>=plot_age_range(1) &  participant_info.age_yr<= plot_age_range(end);
MB_group_select = age_group & ~MB_reject.sub_reject;


a = figure();
a.Position = [1000 1015 284 323];
    xData = Behavior_table.inter_bnd_use_index(MB_group_select);
    yData = Behavior_table.(condition{1})(MB_group_select);
    if islogical(yData)
        yData = double(yData);
    end
    xData = reshape(xData,[],1);
    yData = reshape(yData,[],1);
    ind_remove = isnan(xData) | isnan(yData);
    xData(ind_remove) = [];
    yData(ind_remove) = [];

%     [r,p] = corr(reshape(xData,[],1),reshape(yData,[],1));
        [r, p] = func_corr(xData, yData, task_Color.default, 'on');
        t = title([ condition{1} newline 'r = ' num2str(r) ' p = ' num2str(p) newline ]);
        set(t,'Interpreter','none');


%%

condition ={'select_ABD_acc_location_cat'};
condition2 ={'inter_'};


plot_age_range = 6:8;
age_group = participant_info.age_yr>=plot_age_range(1) &  participant_info.age_yr<= plot_age_range(end);
MB_group_select = age_group & ~MB_reject.sub_reject;


a = figure();
a.Position = [1000 1015 284 323];
    xData = Behavior_table.(condition{1})(MB_group_select);
    yData = Behavior_table.(condition2{1})(MB_group_select);
    if islogical(yData)
        yData = double(yData);
    end
    xData = reshape(xData,[],1);
    yData = reshape(yData,[],1);
    ind_remove = isnan(xData) | isnan(yData);
    xData(ind_remove) = [];
    yData(ind_remove) = [];

%     [r,p] = corr(reshape(xData,[],1),reshape(yData,[],1));
        [r, p] = func_corr(xData, yData, task_Color.default, 'on');
        t = title([ condition{1} '&' condition2{1} newline 'r = ' num2str(r) ' p = ' num2str(p) newline ]);
        set(t,'Interpreter','none');

        
%% for to do 

%% reaction time each trial (나중에 할 것)

a = figure();
a.Position = [1053 623 560 420];
clearvars WWW_Group MB_Group WWWavg WWWerr MBavg MBerr h p Two_Group


t1_Group{1} = WWW_Behavior_table.rt_respond(WW_group_select ==1);
t1_Group{2} = WWW_Behavior_table.rt_animal;
t1_Group{3} = WWW_Behavior_table.rt_location;


t1_Group{1} = WWW_Behavior_table.rt_respond;
t1_Group{2} = WWW_Behavior_table.rt_animal;
t1_Group{3} = WWW_Behavior_table.rt_location;

t1_Group{1} = WWW_Behavior_table.rt_respond;
t1_Group{2} = WWW_Behavior_table.rt_animal;
t1_Group{3} = WWW_Behavior_table.rt_location;


% avg & err
[WWWavg, WWWerr] = jh_mean_err(WWW_Group);
[MBavg, MBerr] = jh_mean_err(MB_Group);


% stat ==================================================================

% anova
WWW_Group_data = cell2mat(WWW_Group');
www_array = cell2mat(arrayfun(@(x) repmat(x, size(WWW_Group{x})), [1,3,4], 'uni', 0)');
[~,tbl,www_stats] = anova1(WWW_Group_data,www_array,'off');
www_group_compare = multcompare(www_stats,"Display","off")


MB_Group_data = cell2mat(MB_Group');
mb_array = cell2mat(arrayfun(@(x) repmat(x, size(MB_Group{x})), [1,3,4], 'uni', 0)');
[~,tbl,mb_stats] = anova1(MB_Group_data,mb_array,'off');
mb_group_compare = multcompare(mb_stats,"Display","off")


for ti = 1:4
    if ismember(ti, [1,3,4])
    [h(ti), p(ti)] = ttest2(WWW_Group{ti}, MB_Group{ti})
    end
end

% =======================================================================

% draw bar
www_fig_bar = jh_bar(WWWavg, WWWerr);  hold on;
www_fig_bar.FaceColor = [.6 .6 .6];

mb_fig_bar = jh_bar(MBavg, MBerr); hold on;
mb_fig_bar.FaceColor = [.9 .6 .6]; % .2 .2. 2; .3 .4 .5 ];



% significance ==========================================================
for bi = 1:4
    if ismember(ti, [1,3,4])
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
    text(bi, WWWavg(bi)+ 1, disp, 'FontSize', 10,'fontweight','bold', 'HorizontalAlignment', 'center', 'Color', 'black');
    end
end

% =======================================================================

ylim([0 max(WWWavg+ 2)])


% labels
acc_Labels = {'Respond'; ''; 'What'; 'Where'};
xticklabels(acc_Labels)

% title
legend({'Boundary', '', 'Non boundary'});
% title(['Accuracy'],'FontWeight','bold')

