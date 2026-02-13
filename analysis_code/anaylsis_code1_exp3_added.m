clear all;

% cd D:\DCNL\DEvl\Multi\Museum_data
% cd "C:\Users\su119\OneDrive\바탕 화면\DCNL\boundary\Museum_data"
cd('C:\Users\su119\OneDrive\바탕 화면\DCNL\boundary\Museum_data')

www_path = 'WWW\';

Exp1_data_path = 'Exp1_Multi_boundary\';
Exp2_ctrl_path = 'Exp2_Multi_boundary_Control\';
Exp3_chunk_path = 'Exp3_Multi_boundary_Chunking\';



www_year_dir = dir(fullfile(www_path, '20*'));
www_year_num = length(www_year_dir);

Exp1_data_year_dir = dir(fullfile(Exp1_data_path, '2*'));
Exp1_data_year_num = length(Exp1_data_year_dir);

Exp2_ctrl_year_dir = dir(fullfile(Exp2_ctrl_path, '2*'));
Exp2_ctrl_year_num = length(Exp2_ctrl_year_dir);

Exp3_chunk_year_dir = dir(fullfile(Exp3_chunk_path, '2*'));
Exp3_chunk_year_num = length(Exp3_chunk_year_dir);



www_participant_info = readtable([www_path 'www_participant data.xlsx']);

Exp1_participant_info = readtable([Exp1_data_path 'Exp1_participant_data.xlsx']);
Exp2_participant_info = readtable([Exp2_ctrl_path 'Exp2_control_participant_data.xlsx']);
Exp3_participant_info = readtable([Exp3_chunk_path 'Exp3_Chunk_participant_data.xlsx']);
% Exp3_participant_info.Properties.VariableNames = {'Task','ID','expdate','exptime','subjectkey','pre/onsite','name_child','name_parent','phone','sex','birthdate','age_mo','age_yr','age_yrfrac','experimenter','computer', 'button','etc','reject','trial_reject','run_reject','em_pass','inter_pass','pass/pending/fail','headphone','pointing','reason_pass/fail','subjectkey_v2','note_1','note_2','Q1','Q2- ani, loc strategy','Q3- ani, loc easy','Q4-ani, OX'};
selected_feature = [{'Task'} {'ID'}, {'pre_onsite'}, {'sex'}, {'birthdate'}, {'age_mo'}, {'age_yr'}, {'age_yrfrac'}, {'experimenter'}, {'computer'}, {'button'}, {'etc'},];

% these have to be added...!
% {'reject'}, {'trial_reject'}, {'run_reject'}, {'em_pass'}, {'inter_pass'}, {'pass_pending_fail'}];

for fi = 1:2
    Boundary_subject.(selected_feature{fi}) = [Exp1_participant_info.(selected_feature{fi}); Exp2_participant_info.(selected_feature{fi}); Exp3_participant_info.(selected_feature{fi});];
end

Boundary_subject = struct2table(Boundary_subject);

for fi = 3:length(selected_feature)
    Boundary_subject.(selected_feature{fi}) = [Exp1_participant_info.(selected_feature{fi}); Exp2_participant_info.(selected_feature{fi}); Exp3_participant_info.(selected_feature{fi});];
end



%% data

% multi boundary data
loc = 0;
for yi = 1:Exp1_data_year_num
    clearvars data_dir exclude_prac data_selec
    data_dir = dir(fullfile(Exp1_data_path, Exp1_data_year_dir(yi).name, '\*.mat'));
    exclude_prac = ~contains({data_dir.name}, 'practice') & ~contains({data_dir.name}, 'boundary1_') & ~contains({data_dir.name}, 'run')  & ~contains({data_dir.name}, '1_1')  & ~contains({data_dir.name}, '4_7') & ~contains({data_dir.name}, '4_8')  & ~contains({data_dir.name}, '3_6');
    data_selec = data_dir(exclude_prac);
    for di = 1:length(data_selec)
        clearvars Data
        sbjid_temp = str2double(regexp( data_selec(di).name, '\d+', 'match'));
        sbjid = sbjid_temp(1)*1000 + sbjid_temp(2);
        load([Exp1_data_path Exp1_data_year_dir(yi).name '\' data_selec(di).name])
        if yi == 1 & di == 1
            loc = 1;
        else
            loc = loc + 1;
        end
        Exp1_sbj_data(loc,1) = sbjid;
        Exp1_All_Data(loc,1).id = sbjid;
        Exp1_All_Data(loc,1).Data = Data;
    end
end

% www data

loc = 0;
for yi = 1:www_year_num
    clearvars data_dir exclude_prac data_selec
    data_dir = dir(fullfile(www_path, www_year_dir(yi).name, '\*.mat'));
    exclude_prac = ~contains({data_dir.name}, 'practice') & ~contains({data_dir.name}, '_monster_') ;
    data_selec = data_dir(exclude_prac);
    for di = 1:length(data_selec)
        clearvars Data
        sbjid_temp = str2double(regexp( data_selec(di).name, '\d+', 'match'));
        sbjid = sbjid_temp(1)*1000 + sbjid_temp(2);
        load([www_path www_year_dir(yi).name '\' data_selec(di).name])
        if yi == 1 & di == 1
            loc = 1;
        else
            loc = loc + 1;
        end
        www_sbj_data(loc,1) = sbjid;
        WWW_Data(loc,1).id = sbjid;
        WWW_Data(loc,1).Data = Data;
    end
end


% Exp2_ multi boundary data continuous
loc = 0;
for yi = 1:Exp2_ctrl_year_num
    clearvars data_dir exclude_prac data_selec
    data_dir = dir(fullfile(Exp2_ctrl_path, Exp2_ctrl_year_dir(yi).name, '\*boundary.mat'));
    exclude_prac = ~contains({data_dir.name}, 'practice') & ~contains({data_dir.name}, 'boundary1_') & ~contains({data_dir.name}, 'run')  & ~contains({data_dir.name}, '1_1');
    data_selec = data_dir(exclude_prac);
    for di = 1:length(data_selec)
        clearvars Data
        sbjid_temp = str2double(regexp( data_selec(di).name, '\d+', 'match'));
        sbjid = sbjid_temp(1)*1000 + sbjid_temp(2);
        load([Exp2_ctrl_path Exp2_ctrl_year_dir(yi).name '\' data_selec(di).name])
        if yi == 1 & di == 1
            loc = 1;
        else
            loc = loc + 1;
        end
        Exp2_sbj_data(loc,1) = sbjid;
        Exp2_All_Data(loc,1).id = sbjid;
        Exp2_All_Data(loc,1).Data = Data;
    end
end


% Exp3 - multi_chunking_data 
loc = 0;
for yi = 1:Exp3_chunk_year_num
    clearvars data_dir exclude_prac data_selec
    data_dir = dir(fullfile(Exp3_chunk_path, Exp3_chunk_year_dir(yi).name, '\*Chunking.mat'));
    exclude_prac = ~contains({data_dir.name}, 'practice') & ~contains({data_dir.name}, 'boundary1_') & ~contains({data_dir.name}, 'run')  & ~contains({data_dir.name}, 'boundary_1_' ) & ~contains({data_dir.name}, 'boundary_4_' )  & ~contains({data_dir.name}, 'boundary_3_5') & ~contains({data_dir.name}, 'Chunking_2' );
    data_selec = data_dir(exclude_prac);
    for di = 1:length(data_selec)
        clearvars Data
        sbjid_temp = str2double(regexp( data_selec(di).name, '\d+', 'match'));
        sbjid = sbjid_temp(1)*1000 + sbjid_temp(2);
        load([Exp3_chunk_path Exp3_chunk_year_dir(yi).name '\' data_selec(di).name])
        if yi == 1 & di == 1
            loc = 1;
        else
            loc = loc + 1;
        end
        Exp3_sbj_data(loc,1) = sbjid;
        Exp3_All_Data(loc,1).id = sbjid;
        Exp3_All_Data(loc,1).Data = Data;
    end
end





%%
% figure()
% subplot(2,1,1);
% histogram(participant_info.age_yr, 'FaceColor','none');
% xlim([4.5 9.5]);
% ylim([0 13]);
% title('all subject');
%
% subplot(2,1,2);
% histogram(participant_info.age_yr(strcmp(participant_info.sex, '여'),:)); hold on;
% histogram(participant_info.age_yr(strcmp(participant_info.sex, '남'),:));
% xlim([4.5 9.5]);
% ylim([0 13]);
%
%
%
%
% figure()
%
% subplot(2,1,1);
% histogram(participant_info.age_yrfrac,10,  'FaceColor','none');
% xlim([5 10]);
% ylim([0 7]);
%
% title('all subject');
%
% subplot(2,1,2);
% histogram(participant_info.age_yrfrac(strcmp(participant_info.sex, '여'),:),10); hold on;
% histogram(participant_info.age_yrfrac(strcmp(participant_info.sex, '남'),:),10);
% xlim([5 10]);
% ylim([0 7]);



% figure()
% subplot(2,1,1);
% histogram(www_participant_info.age_yr, 'FaceColor','none');
% xlim([4.5 9.5]);
% ylim([0 25]);
% title('all subject');
%
% subplot(2,1,2);
% histogram(www_participant_info.age_yr(strcmp(www_participant_info.sex, '여'),:)); hold on;
% histogram(www_participant_info.age_yr(strcmp(www_participant_info.sex, '남'),:));
% xlim([4.5 9.5]);
% ylim([0 20]);
%
%
%
%
% figure()
%
% subplot(2,1,1);
% histogram(www_participant_info.age_yrfrac,10,  'FaceColor','none');
% xlim([5 10]);
% % ylim([0 7]);
%
% title('all subject');
%
% subplot(2,1,2);
% histogram(www_participant_info.age_yrfrac(strcmp(www_participant_info.sex, '여'),:),10); hold on;
% histogram(www_participant_info.age_yrfrac(strcmp(www_participant_info.sex, '남'),:),10);
% xlim([5 10]);
% ylim([0 7]);

%
%
%
% figure()
% % subplot(2,1,1);
% histogram(participant_info.age_yr(strcmp(participant_info.sex, '남'),:));hold on;
% histogram(participant_info.age_yr(strcmp(participant_info.sex, '여'),:));
% histogram(participant_info.age_yr, 'FaceColor','none');
% xlim([4.5 9.5]);
% % ylim([0 13]);
% title('Multi Boundary');
%
% figure()
% % subplot(2,1,1);
%
% histogram(www_participant_info.age_yr(strcmp(www_participant_info.sex, '남'),:));hold on;
% histogram(www_participant_info.age_yr(strcmp(www_participant_info.sex, '여'),:));
% histogram(www_participant_info.age_yr, 'FaceColor','none');
% xlim([4.5 9.5]);
% % ylim([0 13]);
% title('No Boundary');




%%
selected_condition1 = [1, 4]; selected_condition2 = [3, 6];
boundary_condition = cellstr(['1  1  2'; '1  2  1';'2  1  1'; '2  2  1'; '2  1  2'; '1  2  2'; '1  1  1'; '2  2  2']);

crossing_0 = [7, 8]; crossing_1 = [1, 3, 4, 6]; crossing_2 = [2, 5];

setnum = [1,3; 4,6; 7,9; 10,12; 13,15; 16,18; 19,21; 22,24;];


for ti = 1:length(Exp1_sbj_data)
    Exp1_Trial_Data(ti).main = Exp1_All_Data(ti).Data.trial.retrieval;
    Exp1_Trial_Data(ti).inter = Exp1_All_Data(ti).Data.trial.interRet;
    Exp1_Trial_Data(ti).info = Exp1_All_Data(ti).Data.trial.trialinfo;
    Exp1_Trial_Data(ti).main_trial.run = [1; 1; 2; 2; 3; 3; 4; 4];
    Exp1_Trial_Data(ti).main_trial.trial = [1:1:8]';
    
end

for ti = 1:length(Exp2_sbj_data)
    Exp2_Trial_Data(ti).main = Exp2_All_Data(ti).Data.trial.retrieval;
    Exp2_Trial_Data(ti).inter = Exp2_All_Data(ti).Data.trial.interRet;
    Exp2_Trial_Data(ti).info = Exp2_All_Data(ti).Data.trial.trialinfo;
    Exp2_Trial_Data(ti).main_trial.run = [1; 1; 2; 2; 3; 3; 4; 4];
    Exp2_Trial_Data(ti).main_trial.trial = [1:1:8]';
    
end


for ti = 1:length(Exp3_sbj_data)
    Exp3_Trial_Data(ti).main = Exp3_All_Data(ti).Data.trial.retrieval;
    Exp3_Trial_Data(ti).inter = Exp3_All_Data(ti).Data.trial.interRet;
    Exp3_Trial_Data(ti).info = Exp3_All_Data(ti).Data.trial.trialinfo;
    Exp3_Trial_Data(ti).main_trial.run = [1; 1; 2; 2; 3; 3; 4; 4];
    Exp3_Trial_Data(ti).main_trial.trial = [1:1:8]';
    
end





for tti = 1:length(www_sbj_data)
    WWW_Trial_Data(tti).main = WWW_Data(tti).Data.trial.retrieval;
    WWW_Trial_Data(tti).inter = WWW_Data(tti).Data.trial.interRet;
    WWW_Trial_Data(tti).info = WWW_Data(tti).Data.trial.trialinfo;
    WWW_Trial_Data(tti).main_trial.run = [1; 1; 2; 2; 3; 3; 4; 4];
    WWW_Trial_Data(tti).main_trial.trial = [1:1:8]';    
end


main_var = fieldnames(Exp1_Trial_Data(1).main);
inter_var = fieldnames(Exp1_Trial_Data(1).inter);

for si = 1:length(Exp1_sbj_data)
    Exp1_Trial_Data(si).main = struct2table(Exp1_Trial_Data(si).main);
    Exp1_Trial_Data(si).inter = struct2table(Exp1_Trial_Data(si).inter);
    Exp1_Trial_Data(si).main_trial = struct2table(Exp1_Trial_Data(si).main_trial);
    temp_table = struct2table(Exp1_All_Data(si).Data.time);
    react_start = temp_table.time(contains(temp_table.label, 'select start'),:);
    react_end = temp_table.time(contains(temp_table.label, 'select end'),:);
    react_time = react_end - react_start;

    Exp1_Trial_Data(si).main.respondRT = react_time;
    
    Exp1_Trial_Data(si).main.animalRT = Exp1_Trial_Data(si).main.animalT - react_start;
    Exp1_Trial_Data(si).main.locationRT = react_end - Exp1_Trial_Data(si).main.animalT;


    Exp1_Trial_Data(si).main.respondRT_log = log(Exp1_Trial_Data(si).main.respondRT);
    Exp1_Trial_Data(si).main.animalRT_log = log(Exp1_Trial_Data(si).main.animalRT);
    Exp1_Trial_Data(si).main.locationRT_log = log(Exp1_Trial_Data(si).main.locationRT);



    Exp1_Trial_Data(si).main.locationEnc_cat(Exp1_Trial_Data(si).main.locationEnc > 3) = 2;
    Exp1_Trial_Data(si).main.locationEnc_cat(Exp1_Trial_Data(si).main.locationEnc <= 3) = 1;
    Exp1_Trial_Data(si).main.location_cat(Exp1_Trial_Data(si).main.location > 3) = 2;
    Exp1_Trial_Data(si).main.location_cat(Exp1_Trial_Data(si).main.location <= 3) = 1;

    Exp1_Trial_Data(si).main.location_catAcc =  (Exp1_Trial_Data(si).main.locationEnc_cat == Exp1_Trial_Data(si).main.location_cat);
    
    % yj method ( 1 location cat / 2 detail right / 0 really wrong)
    Exp1_Trial_Data(si).main.categorical_Acc = Exp1_Trial_Data(si).main.location_catAcc + Exp1_Trial_Data(si).main.locationAcc;

    for ti = 1:height(Exp1_Trial_Data(si).main)/3
        loc_temp = find(Exp1_Trial_Data(si).main.trial==ti); loc1 = min(loc_temp); loc2 = max(loc_temp);
        Exp1_Trial_Data(si).main.context(loc1:loc2,1) = Exp1_Trial_Data(si).info.context(ti);
        Exp1_Trial_Data(si).main.boundary(loc1:loc2,1) = Exp1_Trial_Data(si).info.condition(ti);

        % boundary condition
        Loc_cat = num2str(Exp1_Trial_Data(si).main.locationEnc_cat(Exp1_Trial_Data(si).main.trial == ti,:)');
        Exp1_Trial_Data(si).main.boundary_cat(loc1:loc2,1) = find(strcmp(Loc_cat, boundary_condition));

        % what / where
        what_enc = Exp1_Trial_Data(si).main.animalEnc(Exp1_Trial_Data(si).main.trial==ti);
        what_res = Exp1_Trial_Data(si).main.animal(Exp1_Trial_Data(si).main.trial==ti);
        Exp1_Trial_Data(si).main.what(loc1:loc2,1) = ismember(what_res, what_enc);
        where_enc = Exp1_Trial_Data(si).main.locationEnc(Exp1_Trial_Data(si).main.trial==ti);
        where_res = Exp1_Trial_Data(si).main.location(Exp1_Trial_Data(si).main.trial==ti);
        Exp1_Trial_Data(si).main.where(loc1:loc2,1) = ismember(where_res, where_enc);
        what_where_enc = what_enc*10+where_enc;
        what_where_res = what_res*10+where_res;
        Exp1_Trial_Data(si).main.whatwhere(loc1:loc2,1) = ismember(what_where_res, what_where_enc);
        Exp1_Trial_Data(si).main.wherewhen(loc1:loc2,1) = Exp1_Trial_Data(si).main.locationAcc(loc1:loc2,1);
        Exp1_Trial_Data(si).main.whatwhen(loc1:loc2,1) = Exp1_Trial_Data(si).main.animalAcc(loc1:loc2,1);
        Exp1_Trial_Data(si).main.fullem(loc1:loc2,1) = Exp1_Trial_Data(si).main.locationAcc(loc1:loc2,1) & Exp1_Trial_Data(si).main.animalAcc(loc1:loc2,1);

        Exp1_Trial_Data(si).main.boundary_cat_okay = ismember(Exp1_Trial_Data(si).main.boundary_cat,selected_condition1) + ismember(Exp1_Trial_Data(si).main.boundary_cat,selected_condition2)*2;
        Exp1_Trial_Data(si).main.boundary_crossing = ismember(Exp1_Trial_Data(si).main.boundary_cat,crossing_1) + ismember(Exp1_Trial_Data(si).main.boundary_cat,crossing_2)*2;

        CATwhere_enc = Exp1_Trial_Data(si).main.locationEnc_cat(Exp1_Trial_Data(si).main.trial==ti);
        CATwhere_res = Exp1_Trial_Data(si).main.location_cat(Exp1_Trial_Data(si).main.trial==ti);
        Exp1_Trial_Data(si).main.location_catAcc_where(loc1:loc2,1) = ismember(CATwhere_res, CATwhere_enc);
 
        Exp1_Trial_Data(si).main.location_catAcc_wherewhen(loc1:loc2,1) = Exp1_Trial_Data(si).main.location_catAcc(loc1:loc2,1);
        what_CATwhere_enc = what_enc*10+CATwhere_enc;
        what_CATwhere_res = what_res*10+CATwhere_res;
        Exp1_Trial_Data(si).main.location_catAcc_whatwhere(loc1:loc2,1) = ismember(what_CATwhere_res, what_CATwhere_enc);
        Exp1_Trial_Data(si).main.location_catAcc_fullem(loc1:loc2,1) = Exp1_Trial_Data(si).main.location_catAcc(loc1:loc2,1) & Exp1_Trial_Data(si).main.animalAcc(loc1:loc2,1);


        loc_cat_enc = Exp1_Trial_Data(si).main.locationEnc_cat(Exp1_Trial_Data(si).main.trial==ti);
        loc_cat_res = Exp1_Trial_Data(si).main.location_cat(Exp1_Trial_Data(si).main.trial==ti);
        Exp1_Trial_Data(si).main.location_catWhere(loc1:loc2,1) = ismember(loc_cat_res, loc_cat_enc);


        Exp1_Trial_Data(si).main_trial.boundary_cat(ti) = Exp1_Trial_Data(si).main.boundary_cat(3*ti);
        Exp1_Trial_Data(si).main_trial.context(ti) = Exp1_Trial_Data(si).main.context(3*ti);
        Exp1_Trial_Data(si).main_trial.boundary(ti) = Exp1_Trial_Data(si).main.boundary(3*ti);

        Exp1_Trial_Data(si).main_trial.boundary_1cross_run = ismember(Exp1_Trial_Data(si).main_trial.boundary_cat,selected_condition1) + ismember(Exp1_Trial_Data(si).main_trial.boundary_cat,selected_condition2)*2;
    
        Exp1_Trial_Data(si).main_trial.across_acc(ti) = NaN;
        Exp1_Trial_Data(si).main_trial.within_acc(ti) = NaN;



        if ~ismember(Exp1_Trial_Data(si).main.boundary_cat(3*ti), [7, 8])
            Exp1_Trial_Data(si).main_trial.across_acc(ti) = all(Exp1_Trial_Data(si).main.location_catAcc((ti-1)*3+1:(ti-1)*3+3,1)==1);
            
            temp_ans = Exp1_Trial_Data(si).main.locationEnc((ti-1)*3+1:(ti-1)*3+3,1);
            temp_res = Exp1_Trial_Data(si).main.location((ti-1)*3+1:(ti-1)*3+3,1);
            temp_cat = Exp1_Trial_Data(si).main.location_cat((ti-1)*3+1:(ti-1)*3+3,1);
            
            
            for lefi = 1:2
                if sum(temp_cat == lefi) == 2
                    seli = lefi;
                    sel_loc = find(temp_cat == lefi);
                end
            end
            sel_ans = temp_ans(sel_loc);
            sel_res = temp_res(sel_loc);
            
            
            Exp1_Trial_Data(si).main_trial.within_acc(ti) = all(sel_ans == sel_res);


            



        end
    


    end

    Exp1_Trial_Data(si).main_trial.boundary_cat_okay = ismember(Exp1_Trial_Data(si).main_trial.boundary_cat,selected_condition1) + ismember(Exp1_Trial_Data(si).main_trial.boundary_cat,selected_condition2)*2;



    for vi = 10:13
        if vi == 13
            Exp1_Trial_Data(si).inter.(inter_var{vi})(Exp1_Trial_Data(si).inter.RT == 99 | isnan(Exp1_Trial_Data(si).inter.RT),1) = 0;
        else
            Exp1_Trial_Data(si).inter.(inter_var{vi})(Exp1_Trial_Data(si).inter.RT == 99 | isnan(Exp1_Trial_Data(si).inter.RT),1) = NaN;
        end
    end

end


for si = 1:length(www_sbj_data)
    clearvars temp_table react_start react_end react_time
    WWW_Trial_Data(si).main = struct2table(WWW_Trial_Data(si).main);
    WWW_Trial_Data(si).inter = struct2table(WWW_Trial_Data(si).inter);
    WWW_Trial_Data(si).main_trial = struct2table(WWW_Trial_Data(si).main_trial);
    temp_table = struct2table(WWW_Data(si).Data.time);
    trial_num = (WWW_Trial_Data(si).main.trial-1)*3 + WWW_Trial_Data(si).main.order;
    %     react_start = NaN(size(trial_num)); react_end = NaN(size(trial_num));  react_time = NaN(size(trial_num));

    react_start = temp_table.time(contains(temp_table.label, 'select start'),:);
    react_end = temp_table.time(contains(temp_table.label, 'select end'),:);
    react_time = react_end - react_start;

    WWW_Trial_Data(si).main.respondRT = react_time;
    WWW_Trial_Data(si).main.animalRT = WWW_Trial_Data(si).main.animalT - react_start;
    WWW_Trial_Data(si).main.locationRT = react_end - WWW_Trial_Data(si).main.animalT;

    WWW_Trial_Data(si).main.respondRT_log = log(WWW_Trial_Data(si).main.respondRT);
    WWW_Trial_Data(si).main.animalRT_log = log(WWW_Trial_Data(si).main.animalRT);
    WWW_Trial_Data(si).main.locationRT_log = log(WWW_Trial_Data(si).main.locationRT);
    


    WWW_Trial_Data(si).main.locationEnc_cat(WWW_Trial_Data(si).main.locationEnc > 3) = 2;
    WWW_Trial_Data(si).main.locationEnc_cat(WWW_Trial_Data(si).main.locationEnc <= 3) = 1;
    WWW_Trial_Data(si).main.location_cat(WWW_Trial_Data(si).main.location > 3) = 2;
    WWW_Trial_Data(si).main.location_cat(WWW_Trial_Data(si).main.location <= 3) = 1;

    WWW_Trial_Data(si).main.location_catAcc =  (WWW_Trial_Data(si).main.locationEnc_cat == WWW_Trial_Data(si).main.location_cat);

    % yj method ( 1 location cat right / 2 really right / 0 really wrong)
    WWW_Trial_Data(si).main.categorical_Acc = WWW_Trial_Data(si).main.location_catAcc + WWW_Trial_Data(si).main.locationAcc;


    empty_trial = [];
    for zi = 1:8
        if isempty(WWW_Trial_Data(si).main.locationEnc_cat(WWW_Trial_Data(si).main.trial == zi,:))
            empty_trial(end+1,1) = zi;
        end
    end

    if height(WWW_Trial_Data(si).main)~=24
        WWW_Trial_Data(si).main_trial.boundary_cat(1:24) = NaN;
        WWW_Trial_Data(si).main_trial.context(1:24) = NaN;
    end


    %     if isempty(empty_trial)
    for ti = 1:8
        loc_temp = find(WWW_Trial_Data(si).main.trial==ti); loc1 = min(loc_temp); loc2 = max(loc_temp);
        WWW_Trial_Data(si).main.context(loc1:loc2,1) = WWW_Trial_Data(si).info.context(ti);

        % boundary condition
        Loc_cat = num2str(WWW_Trial_Data(si).main.locationEnc_cat(WWW_Trial_Data(si).main.trial == ti,:)');
        WWW_Trial_Data(si).main.boundary_cat(loc1:loc2,1) = find(strcmp(Loc_cat, boundary_condition));


        % what / where
        what_enc = WWW_Trial_Data(si).main.animalEnc(WWW_Trial_Data(si).main.trial==ti);
        what_res = WWW_Trial_Data(si).main.animal(WWW_Trial_Data(si).main.trial==ti);
        WWW_Trial_Data(si).main.what(loc1:loc2,1) = ismember(what_res, what_enc);
        where_enc = WWW_Trial_Data(si).main.locationEnc(WWW_Trial_Data(si).main.trial==ti);
        where_res = WWW_Trial_Data(si).main.location(WWW_Trial_Data(si).main.trial==ti);
        WWW_Trial_Data(si).main.where(loc1:loc2,1) = ismember(where_res, where_enc);
        what_where_enc = what_enc*10+where_enc;
        what_where_res = what_res*10+where_res;
        WWW_Trial_Data(si).main.whatwhere(loc1:loc2,1) = ismember(what_where_res, what_where_enc);
        WWW_Trial_Data(si).main.wherewhen(loc1:loc2,1) = WWW_Trial_Data(si).main.locationAcc(loc1:loc2,1);
        WWW_Trial_Data(si).main.whatwhen(loc1:loc2,1) = WWW_Trial_Data(si).main.animalAcc(loc1:loc2,1);
        WWW_Trial_Data(si).main.fullem(loc1:loc2,1) = WWW_Trial_Data(si).main.animalAcc(loc1:loc2,1) & WWW_Trial_Data(si).main.locationAcc(loc1:loc2,1);


        WWW_Trial_Data(si).main.boundary_cat_okay = ismember(WWW_Trial_Data(si).main.boundary_cat,selected_condition1) + ismember(WWW_Trial_Data(si).main.boundary_cat,selected_condition2)*2;
        WWW_Trial_Data(si).main.boundary_crossing = ismember(WWW_Trial_Data(si).main.boundary_cat,crossing_1) + ismember(WWW_Trial_Data(si).main.boundary_cat,crossing_2)*2;


        CATwhere_enc = WWW_Trial_Data(si).main.locationEnc_cat(WWW_Trial_Data(si).main.trial==ti);
        CATwhere_res = WWW_Trial_Data(si).main.location_cat(WWW_Trial_Data(si).main.trial==ti);
        WWW_Trial_Data(si).main.location_catAcc_where(loc1:loc2,1) = ismember(CATwhere_res, CATwhere_enc);

        WWW_Trial_Data(si).main.location_catAcc_wherewhen(loc1:loc2,1) = WWW_Trial_Data(si).main.location_catAcc(loc1:loc2,1);
        what_CATwhere_enc = what_enc*10+CATwhere_enc;
        what_CATwhere_res = what_res*10+CATwhere_res;
        WWW_Trial_Data(si).main.location_catAcc_whatwhere(loc1:loc2,1) = ismember(what_CATwhere_res, what_CATwhere_enc);
        WWW_Trial_Data(si).main.location_catAcc_fullem(loc1:loc2,1) = WWW_Trial_Data(si).main.location_catAcc(loc1:loc2,1) & WWW_Trial_Data(si).main.animalAcc(loc1:loc2,1);




        loc_cat_enc = WWW_Trial_Data(si).main.locationEnc_cat(WWW_Trial_Data(si).main.trial==ti);
        loc_cat_res = WWW_Trial_Data(si).main.location_cat(WWW_Trial_Data(si).main.trial==ti);
        WWW_Trial_Data(si).main.location_catWhere(loc1:loc2,1) = ismember(loc_cat_res, loc_cat_enc);



        if ti <= height(WWW_Trial_Data(si).main)/3

            WWW_Trial_Data(si).main_trial.boundary_cat(ti) = WWW_Trial_Data(si).main.boundary_cat(3*ti);

            WWW_Trial_Data(si).main_trial.context(ti) = WWW_Trial_Data(si).main.context(3*ti);
            %         WWW_Trial_Data(si).main_trial.boundary(ti) = WWW_Trial_Data(si).main.boundary(3*ti);
            WWW_Trial_Data(si).main_trial.boundary_crossing(ti) = WWW_Trial_Data(si).main.boundary_crossing(3*ti);

            WWW_Trial_Data(si).main_trial.boundary_1cross_run = ismember(WWW_Trial_Data(si).main_trial.boundary_cat,selected_condition1) + ismember(WWW_Trial_Data(si).main_trial.boundary_cat,selected_condition2)*2;

            WWW_Trial_Data(si).main_trial.across_acc(ti) = NaN;
            WWW_Trial_Data(si).main_trial.within_acc(ti) = NaN;



        if ~ismember(WWW_Trial_Data(si).main.boundary_cat(3*ti), [7, 8])
            WWW_Trial_Data(si).main_trial.across_acc(ti) = all(WWW_Trial_Data(si).main.location_catAcc((ti-1)*3+1:(ti-1)*3+3,1)==1);
            
            temp_ans = WWW_Trial_Data(si).main.locationEnc((ti-1)*3+1:(ti-1)*3+3,1);
            temp_res = WWW_Trial_Data(si).main.location((ti-1)*3+1:(ti-1)*3+3,1);
            temp_cat = WWW_Trial_Data(si).main.location_cat((ti-1)*3+1:(ti-1)*3+3,1);
            
            
            for lefi = 1:2
                if sum(temp_cat == lefi) == 2
                    seli = lefi;
                    sel_loc = find(temp_cat == lefi);
                end
            end
            sel_ans = temp_ans(sel_loc);
            sel_res = temp_res(sel_loc);
            
            
            WWW_Trial_Data(si).main_trial.within_acc(ti) = all(sel_ans == sel_res);


            



        end

        end



    end
    WWW_Trial_Data(si).main_trial.boundary_cat_okay = ismember(WWW_Trial_Data(si).main_trial.boundary_cat,selected_condition1) + ismember(WWW_Trial_Data(si).main_trial.boundary_cat,selected_condition2)*2;


    %     else
    % 일단 급한대로 nan 처리 나중에 수정 필요
    %         WWW_Trial_Data(si).main.context = nan(size(WWW_Trial_Data(si).main.run))
    %         WWW_Trial_Data(si).main.boundary_cat = nan(size(WWW_Trial_Data(si).main.run))
    %     end


    for vi = 10:13
        if vi == 13
            WWW_Trial_Data(si).inter.(inter_var{vi})(WWW_Trial_Data(si).inter.RT == 99 | isnan(WWW_Trial_Data(si).inter.RT),1) = 0;
        else
            WWW_Trial_Data(si).inter.(inter_var{vi})(WWW_Trial_Data(si).inter.RT == 99 | isnan(WWW_Trial_Data(si).inter.RT),1) = NaN;
        end
    end

end




for si = 1:length(Exp2_sbj_data)
    Exp2_Trial_Data(si).main = struct2table(Exp2_Trial_Data(si).main);
    Exp2_Trial_Data(si).inter = struct2table(Exp2_Trial_Data(si).inter);
    Exp2_Trial_Data(si).main_trial = struct2table(Exp2_Trial_Data(si).main_trial);
    temp_table = struct2table(Exp2_All_Data(si).Data.time);
    react_start = temp_table.time(contains(temp_table.label, 'select start'),:);
    react_end = temp_table.time(contains(temp_table.label, 'select end'),:);
    react_time = react_end - react_start;

    Exp2_Trial_Data(si).main.respondRT = react_time;
    
    Exp2_Trial_Data(si).main.animalRT = Exp2_Trial_Data(si).main.animalT - react_start;
    Exp2_Trial_Data(si).main.locationRT = react_end - Exp2_Trial_Data(si).main.animalT;


    Exp2_Trial_Data(si).main.respondRT_log = log(Exp2_Trial_Data(si).main.respondRT);
    Exp2_Trial_Data(si).main.animalRT_log = log(Exp2_Trial_Data(si).main.animalRT);
    Exp2_Trial_Data(si).main.locationRT_log = log(Exp2_Trial_Data(si).main.locationRT);



    Exp2_Trial_Data(si).main.locationEnc_cat(Exp2_Trial_Data(si).main.locationEnc > 3) = 2;
    Exp2_Trial_Data(si).main.locationEnc_cat(Exp2_Trial_Data(si).main.locationEnc <= 3) = 1;
    Exp2_Trial_Data(si).main.location_cat(Exp2_Trial_Data(si).main.location > 3) = 2;
    Exp2_Trial_Data(si).main.location_cat(Exp2_Trial_Data(si).main.location <= 3) = 1;

    Exp2_Trial_Data(si).main.location_catAcc =  (Exp2_Trial_Data(si).main.locationEnc_cat == Exp2_Trial_Data(si).main.location_cat);
    
    % yj method ( 1 location cat / 2 detail right / 0 really wrong)
    Exp2_Trial_Data(si).main.categorical_Acc = Exp2_Trial_Data(si).main.location_catAcc + Exp2_Trial_Data(si).main.locationAcc;
    
    for ti = 1:height(Exp2_Trial_Data(si).main)/3
        loc_temp = find(Exp2_Trial_Data(si).main.trial==ti); loc1 = min(loc_temp); loc2 = max(loc_temp);
        Exp2_Trial_Data(si).main.context(loc1:loc2,1) = Exp2_Trial_Data(si).info.context(ti);
        Exp2_Trial_Data(si).main.boundary(loc1:loc2,1) = Exp2_Trial_Data(si).info.condition(ti);

        % boundary condition
        Loc_cat = num2str(Exp2_Trial_Data(si).main.locationEnc_cat(Exp2_Trial_Data(si).main.trial == ti,:)');
        Exp2_Trial_Data(si).main.boundary_cat(loc1:loc2,1) = find(strcmp(Loc_cat, boundary_condition));

        % what / where
        what_enc = Exp2_Trial_Data(si).main.animalEnc(Exp2_Trial_Data(si).main.trial==ti);
        what_res = Exp2_Trial_Data(si).main.animal(Exp2_Trial_Data(si).main.trial==ti);
        Exp2_Trial_Data(si).main.what(loc1:loc2,1) = ismember(what_res, what_enc);
        where_enc = Exp2_Trial_Data(si).main.locationEnc(Exp2_Trial_Data(si).main.trial==ti);
        where_res = Exp2_Trial_Data(si).main.location(Exp2_Trial_Data(si).main.trial==ti);
        Exp2_Trial_Data(si).main.where(loc1:loc2,1) = ismember(where_res, where_enc);
        what_where_enc = what_enc*10+where_enc;
        what_where_res = what_res*10+where_res;
        Exp2_Trial_Data(si).main.whatwhere(loc1:loc2,1) = ismember(what_where_res, what_where_enc);
        Exp2_Trial_Data(si).main.wherewhen(loc1:loc2,1) = Exp2_Trial_Data(si).main.locationAcc(loc1:loc2,1);
        Exp2_Trial_Data(si).main.whatwhen(loc1:loc2,1) = Exp2_Trial_Data(si).main.animalAcc(loc1:loc2,1);
        Exp2_Trial_Data(si).main.fullem(loc1:loc2,1) = Exp2_Trial_Data(si).main.locationAcc(loc1:loc2,1) & Exp2_Trial_Data(si).main.animalAcc(loc1:loc2,1);

        Exp2_Trial_Data(si).main.boundary_cat_okay = ismember(Exp2_Trial_Data(si).main.boundary_cat,selected_condition1) + ismember(Exp2_Trial_Data(si).main.boundary_cat,selected_condition2)*2;
        Exp2_Trial_Data(si).main.boundary_crossing = ismember(Exp2_Trial_Data(si).main.boundary_cat,crossing_1) + ismember(Exp2_Trial_Data(si).main.boundary_cat,crossing_2)*2;


        loc_cat_enc = Exp2_Trial_Data(si).main.locationEnc_cat(Exp2_Trial_Data(si).main.trial==ti);
        loc_cat_res = Exp2_Trial_Data(si).main.location_cat(Exp2_Trial_Data(si).main.trial==ti);
        Exp2_Trial_Data(si).main.location_catWhere(loc1:loc2,1) = ismember(loc_cat_res, loc_cat_enc);


        Exp2_Trial_Data(si).main_trial.boundary_cat(ti) = Exp2_Trial_Data(si).main.boundary_cat(3*ti);
        Exp2_Trial_Data(si).main_trial.context(ti) = Exp2_Trial_Data(si).main.context(3*ti);
        Exp2_Trial_Data(si).main_trial.boundary(ti) = Exp2_Trial_Data(si).main.boundary(3*ti);

        Exp2_Trial_Data(si).main_trial.boundary_1cross_run = ismember(Exp2_Trial_Data(si).main_trial.boundary_cat,selected_condition1) + ismember(Exp2_Trial_Data(si).main_trial.boundary_cat,selected_condition2)*2;
    
        Exp2_Trial_Data(si).main_trial.across_acc(ti) = NaN;
        Exp2_Trial_Data(si).main_trial.within_acc(ti) = NaN;



        if ~ismember(Exp2_Trial_Data(si).main.boundary_cat(3*ti), [7, 8])
            Exp2_Trial_Data(si).main_trial.across_acc(ti) = all(Exp2_Trial_Data(si).main.location_catAcc((ti-1)*3+1:(ti-1)*3+3,1)==1);
            
            temp_ans = Exp2_Trial_Data(si).main.locationEnc((ti-1)*3+1:(ti-1)*3+3,1);
            temp_res = Exp2_Trial_Data(si).main.location((ti-1)*3+1:(ti-1)*3+3,1);
            temp_cat = Exp2_Trial_Data(si).main.location_cat((ti-1)*3+1:(ti-1)*3+3,1);
            
            
            for lefi = 1:2
                if sum(temp_cat == lefi) == 2
                    seli = lefi;
                    sel_loc = find(temp_cat == lefi);
                end
            end
            sel_ans = temp_ans(sel_loc);
            sel_res = temp_res(sel_loc);
            
            
            Exp2_Trial_Data(si).main_trial.within_acc(ti) = all(sel_ans == sel_res);


            



        end
    
    end


    for vi = 10:13
        if vi == 13
            Exp2_Trial_Data(si).inter.(inter_var{vi})(Exp2_Trial_Data(si).inter.RT == 99 | isnan(Exp2_Trial_Data(si).inter.RT),1) = 0;
        else
            Exp2_Trial_Data(si).inter.(inter_var{vi})(Exp2_Trial_Data(si).inter.RT == 99 | isnan(Exp2_Trial_Data(si).inter.RT),1) = NaN;
        end
    end

end



for si = 1:length(Exp3_sbj_data)
    Exp3_Trial_Data(si).main = struct2table(Exp3_Trial_Data(si).main);
    Exp3_Trial_Data(si).inter = struct2table(Exp3_Trial_Data(si).inter);
    Exp3_Trial_Data(si).main_trial = struct2table(Exp3_Trial_Data(si).main_trial);
    temp_table = struct2table(Exp3_All_Data(si).Data.time);
    react_start = temp_table.time(contains(temp_table.label, 'select start'),:);
    react_end = temp_table.time(contains(temp_table.label, 'select end'),:);
    react_time = react_end - react_start;

    Exp3_Trial_Data(si).main.respondRT = react_time;
    
    Exp3_Trial_Data(si).main.animalRT = Exp3_Trial_Data(si).main.animalT - react_start;
    Exp3_Trial_Data(si).main.locationRT = react_end - Exp3_Trial_Data(si).main.animalT;


    Exp3_Trial_Data(si).main.respondRT_log = log(Exp3_Trial_Data(si).main.respondRT);
    Exp3_Trial_Data(si).main.animalRT_log = log(Exp3_Trial_Data(si).main.animalRT);
    Exp3_Trial_Data(si).main.locationRT_log = log(Exp3_Trial_Data(si).main.locationRT);



    Exp3_Trial_Data(si).main.locationEnc_cat(Exp3_Trial_Data(si).main.locationEnc > 3) = 2;
    Exp3_Trial_Data(si).main.locationEnc_cat(Exp3_Trial_Data(si).main.locationEnc <= 3) = 1;
    Exp3_Trial_Data(si).main.location_cat(Exp3_Trial_Data(si).main.location > 3) = 2;
    Exp3_Trial_Data(si).main.location_cat(Exp3_Trial_Data(si).main.location <= 3) = 1;

    Exp3_Trial_Data(si).main.location_catAcc =  (Exp3_Trial_Data(si).main.locationEnc_cat == Exp3_Trial_Data(si).main.location_cat);
    
    % yj method ( 1 location cat / 2 detail right / 0 really wrong)
    Exp3_Trial_Data(si).main.categorical_Acc = Exp3_Trial_Data(si).main.location_catAcc + Exp3_Trial_Data(si).main.locationAcc;
    
    for ti = 1:height(Exp3_Trial_Data(si).main)/3
        loc_temp = find(Exp3_Trial_Data(si).main.trial==ti); loc1 = min(loc_temp); loc2 = max(loc_temp);
        Exp3_Trial_Data(si).main.context(loc1:loc2,1) = Exp3_Trial_Data(si).info.context(ti);
        Exp3_Trial_Data(si).main.chunking(loc1:loc2,1) = Exp3_Trial_Data(si).info.condition(ti);
        Exp3_Trial_Data(si).main.boundary(loc1:loc2,1) = ~Exp3_Trial_Data(si).main.chunking(loc1:loc2,1);
        % boundary condition
        Loc_cat = num2str(Exp3_Trial_Data(si).main.locationEnc_cat(Exp3_Trial_Data(si).main.trial == ti,:)');
        Exp3_Trial_Data(si).main.boundary_cat(loc1:loc2,1) = find(strcmp(Loc_cat, boundary_condition));

        % what / where
        what_enc = Exp3_Trial_Data(si).main.animalEnc(Exp3_Trial_Data(si).main.trial==ti);
        what_res = Exp3_Trial_Data(si).main.animal(Exp3_Trial_Data(si).main.trial==ti);
        Exp3_Trial_Data(si).main.what(loc1:loc2,1) = ismember(what_res, what_enc);
        where_enc = Exp3_Trial_Data(si).main.locationEnc(Exp3_Trial_Data(si).main.trial==ti);
        where_res = Exp3_Trial_Data(si).main.location(Exp3_Trial_Data(si).main.trial==ti);
        Exp3_Trial_Data(si).main.where(loc1:loc2,1) = ismember(where_res, where_enc);
        what_where_enc = what_enc*10+where_enc;
        what_where_res = what_res*10+where_res;
        Exp3_Trial_Data(si).main.whatwhere(loc1:loc2,1) = ismember(what_where_res, what_where_enc);
        Exp3_Trial_Data(si).main.wherewhen(loc1:loc2,1) = Exp3_Trial_Data(si).main.locationAcc(loc1:loc2,1);
        Exp3_Trial_Data(si).main.whatwhen(loc1:loc2,1) = Exp3_Trial_Data(si).main.animalAcc(loc1:loc2,1);
        Exp3_Trial_Data(si).main.fullem(loc1:loc2,1) = Exp3_Trial_Data(si).main.locationAcc(loc1:loc2,1) & Exp3_Trial_Data(si).main.animalAcc(loc1:loc2,1);

        Exp3_Trial_Data(si).main.boundary_cat_okay = ismember(Exp3_Trial_Data(si).main.boundary_cat,selected_condition1) + ismember(Exp3_Trial_Data(si).main.boundary_cat,selected_condition2)*2;
        Exp3_Trial_Data(si).main.boundary_crossing = ismember(Exp3_Trial_Data(si).main.boundary_cat,crossing_1) + ismember(Exp3_Trial_Data(si).main.boundary_cat,crossing_2)*2;


        loc_cat_enc = Exp3_Trial_Data(si).main.locationEnc_cat(Exp3_Trial_Data(si).main.trial==ti);
        loc_cat_res = Exp3_Trial_Data(si).main.location_cat(Exp3_Trial_Data(si).main.trial==ti);
        Exp3_Trial_Data(si).main.location_catWhere(loc1:loc2,1) = ismember(loc_cat_res, loc_cat_enc);


        Exp3_Trial_Data(si).main_trial.boundary_cat(ti) = Exp3_Trial_Data(si).main.boundary_cat(3*ti);
        Exp3_Trial_Data(si).main_trial.context(ti) = Exp3_Trial_Data(si).main.context(3*ti);
        Exp3_Trial_Data(si).main_trial.boundary(ti) = Exp3_Trial_Data(si).main.boundary(3*ti);

        Exp3_Trial_Data(si).main_trial.boundary_1cross_run = ismember(Exp3_Trial_Data(si).main_trial.boundary_cat,selected_condition1) + ismember(Exp3_Trial_Data(si).main_trial.boundary_cat,selected_condition2)*2;
    
        Exp3_Trial_Data(si).main_trial.across_acc(ti) = NaN;
        Exp3_Trial_Data(si).main_trial.within_acc(ti) = NaN;



        if ~ismember(Exp3_Trial_Data(si).main.boundary_cat(3*ti), [7, 8])
            Exp3_Trial_Data(si).main_trial.across_acc(ti) = all(Exp3_Trial_Data(si).main.location_catAcc((ti-1)*3+1:(ti-1)*3+3,1)==1);
            
            temp_ans = Exp3_Trial_Data(si).main.locationEnc((ti-1)*3+1:(ti-1)*3+3,1);
            temp_res = Exp3_Trial_Data(si).main.location((ti-1)*3+1:(ti-1)*3+3,1);
            temp_cat = Exp3_Trial_Data(si).main.location_cat((ti-1)*3+1:(ti-1)*3+3,1);
            
            
            for lefi = 1:2
                if sum(temp_cat == lefi) == 2
                    seli = lefi;
                    sel_loc = find(temp_cat == lefi);
                end
            end
            sel_ans = temp_ans(sel_loc);
            sel_res = temp_res(sel_loc);
            
            
            Exp3_Trial_Data(si).main_trial.within_acc(ti) = all(sel_ans == sel_res);


            



        end
    
    end


    for vi = 10:13
        if vi == 13
            Exp3_Trial_Data(si).inter.(inter_var{vi})(Exp3_Trial_Data(si).inter.RT == 99 | isnan(Exp3_Trial_Data(si).inter.RT),1) = 0;
        else
            Exp3_Trial_Data(si).inter.(inter_var{vi})(Exp3_Trial_Data(si).inter.RT == 99 | isnan(Exp3_Trial_Data(si).inter.RT),1) = NaN;
        end
    end

end



%% Behavior features

Exp1_Behavior_table.ID = Exp1_sbj_data;
Exp1_Behavior_table = struct2table(Exp1_Behavior_table);
Exp1_Behavior_table.group = ones(size(Exp1_Behavior_table.ID));
Exp1_Behavior_table.sex = Exp1_participant_info.sex;
Exp1_Behavior_table.age = Exp1_participant_info.age_yr;
Exp1_Behavior_table.age_detail = Exp1_participant_info.age_yrfrac;
Exp1_Behavior_table.group = ones(size(Exp1_Behavior_table.ID));


WWW_Behavior_table.ID = www_sbj_data;
WWW_Behavior_table.group = zeros(size(WWW_Behavior_table.ID));
WWW_Behavior_table = struct2table(WWW_Behavior_table);
WWW_Behavior_table.sex = www_participant_info.sex;
WWW_Behavior_table.age = www_participant_info.age_yr;
WWW_Behavior_table.age_detail = www_participant_info.age_yrfrac;


Exp2_Behavior_table.ID = Exp2_sbj_data;
Exp2_Behavior_table = struct2table(Exp2_Behavior_table);
Exp2_Behavior_table.group = ones(size(Exp2_Behavior_table.ID));
Exp2_Behavior_table.sex = Exp2_participant_info.sex;
Exp2_Behavior_table.age = Exp2_participant_info.age_yr;
Exp2_Behavior_table.age_detail = Exp2_participant_info.age_yrfrac;
Exp2_Behavior_table.group = ones(size(Exp2_Behavior_table.ID));



Exp3_Behavior_table.ID = Exp3_sbj_data;
Exp3_Behavior_table = struct2table(Exp3_Behavior_table);
Exp3_Behavior_table.group = ones(size(Exp3_Behavior_table.ID));
Exp3_Behavior_table.sex = Exp3_participant_info.sex;
Exp3_Behavior_table.age = Exp3_participant_info.age_yr;
Exp3_Behavior_table.age_detail = Exp3_participant_info.age_yrfrac;
Exp3_Behavior_table.group = ones(size(Exp3_Behavior_table.ID));



% for si = 1:length(www_sbj_data)
% 
% 
% end



for si = 1:length(Exp1_sbj_data)
    Exp1_Behavior_table.set(si) = Exp1_All_Data(si).Data.trial.trialinfo.set;


    if length(Exp1_All_Data(si).Data.trial.trialinfo.bgm_B1) == 20
        Exp1_Behavior_table.Bgm_B1(si) = Exp1_All_Data(si).Data.trial.trialinfo.bgm_B1(end);
    elseif length(Exp1_All_Data(si).Data.trial.trialinfo.bgm_B1) == 21
        Exp1_Behavior_table.Bgm_B1(si) = Exp1_All_Data(si).Data.trial.trialinfo.bgm_B1(end-1);
    end


    if length(Exp1_All_Data(si).Data.trial.trialinfo.bgm_B2) == 20
        Exp1_Behavior_table.Bgm_B2(si) = Exp1_All_Data(si).Data.trial.trialinfo.bgm_B2(end);
    elseif length(Exp1_All_Data(si).Data.trial.trialinfo.bgm_B2) == 21
        Exp1_Behavior_table.Bgm_B2(si) = Exp1_All_Data(si).Data.trial.trialinfo.bgm_B2(end-1);
    end


    if length(Exp1_All_Data(si).Data.trial.trialinfo.bgm_NB) == 20
        Exp1_Behavior_table.Bgm_NB(si) = Exp1_All_Data(si).Data.trial.trialinfo.bgm_NB(end);
    elseif length(Exp1_All_Data(si).Data.trial.trialinfo.bgm_NB) == 21
        Exp1_Behavior_table.Bgm_NB(si) = Exp1_All_Data(si).Data.trial.trialinfo.bgm_NB(end-1);
    end

end


for si = 1:length(Exp2_sbj_data)
    Exp2_Behavior_table.set(si) = Exp2_All_Data(si).Data.trial.trialinfo.set;
    Exp2_Behavior_table.Bgm_B1(si) = Exp2_All_Data(si).Data.trial.trialinfo.bgm_B1(end);
    Exp2_Behavior_table.Bgm_B2(si) = Exp2_All_Data(si).Data.trial.trialinfo.bgm_B2(end);
    Exp2_Behavior_table.Bgm_NB(si) = Exp2_All_Data(si).Data.trial.trialinfo.bgm_NB(end);

end



for si = 1:length(Exp3_sbj_data)
    Exp3_Behavior_table.set(si) = Exp3_All_Data(si).Data.trial.trialinfo.set;
    Exp3_Behavior_table.chunk_context(si) = Exp3_All_Data(si).Data.sbj.chunkContext;
    Exp3_Behavior_table.Bgm_chunk_B1_1(si) = Exp3_All_Data(si).Data.trial.trialinfo.bgm_chunk_B1_1(end);
    Exp3_Behavior_table.Bgm_chunk_B1_2(si) = Exp3_All_Data(si).Data.trial.trialinfo.bgm_chunk_B1_2(end);
    Exp3_Behavior_table.Bgm_chunk_B2(si) = Exp3_All_Data(si).Data.trial.trialinfo.bgm_chunk_B2(end);
    
    Exp3_Behavior_table.Bgm_B1(si) = Exp3_All_Data(si).Data.trial.trialinfo.bgm_B1(end);
    Exp3_Behavior_table.Bgm_B2(si) = Exp3_All_Data(si).Data.trial.trialinfo.bgm_B2(end);
end





Behavior_table_GROUP2 = Exp1_Behavior_table;
Behavior_table_GROUP2.group = ones(size(Exp1_Behavior_table.ID))*2;
Behavior_table_GROUP3 = Exp1_Behavior_table;
Behavior_table_GROUP3.group = ones(size(Exp1_Behavior_table.ID))*3;

for si = 1:length(Exp1_sbj_data)
    Exp1_Behavior_table.cross0(si) = sum(Exp1_Trial_Data(si).main.boundary_crossing == 0);
    Exp1_Behavior_table.cross1(si) = sum(Exp1_Trial_Data(si).main.boundary_crossing == 1);
    Exp1_Behavior_table.cross2(si) = sum(Exp1_Trial_Data(si).main.boundary_crossing == 2);
    Exp1_Behavior_table.cross0_ABD(si) = sum(Exp1_Trial_Data(si).main.boundary_crossing == 0 & Exp1_Trial_Data(si).main.boundary == 0);
    Exp1_Behavior_table.cross1_ABD(si) = sum(Exp1_Trial_Data(si).main.boundary_crossing == 1 & Exp1_Trial_Data(si).main.boundary == 0);
    Exp1_Behavior_table.cross2_ABD(si) = sum(Exp1_Trial_Data(si).main.boundary_crossing == 2 & Exp1_Trial_Data(si).main.boundary == 0);
    Exp1_Behavior_table.cross0_MBD(si) = sum(Exp1_Trial_Data(si).main.boundary_crossing == 0 & Exp1_Trial_Data(si).main.boundary == 1);
    Exp1_Behavior_table.cross1_MBD(si) = sum(Exp1_Trial_Data(si).main.boundary_crossing == 1 & Exp1_Trial_Data(si).main.boundary == 1);
    Exp1_Behavior_table.cross2_MBD(si) = sum(Exp1_Trial_Data(si).main.boundary_crossing == 2 & Exp1_Trial_Data(si).main.boundary == 1);    
    % inter trial accuracy
    Exp1_Behavior_table.inter_acc(si) = nanmean(Exp1_Trial_Data(si).inter.correct);
    Exp1_Behavior_table.inter_acc_cat1(si) = nanmean(Exp1_Trial_Data(si).inter.correct(Exp1_Trial_Data(si).inter.condition == 1));
    Exp1_Behavior_table.inter_acc_cat2(si) = nanmean(Exp1_Trial_Data(si).inter.correct(Exp1_Trial_Data(si).inter.condition == 2));
    Exp1_Behavior_table.inter_bnd_use_index(si) = Exp1_Behavior_table.inter_acc_cat2(si) - Exp1_Behavior_table.inter_acc_cat1(si);
    Exp1_Behavior_table.inter_bnd_user(si) = Exp1_Behavior_table.inter_acc_cat1(si) < Exp1_Behavior_table.inter_acc_cat2(si);

    % yj method ( 1 location cat / 2 detail right / 0 really wrong)
%     WWW_Trial_Data(si).main.categorical_Acc = WWW_Trial_Data(si).main.location_catAcc + WWW_Trial_Data(si).main.locationAcc;
    
    if sum(Exp1_Trial_Data(si).main.categorical_Acc == 1) + sum(Exp1_Trial_Data(si).main.categorical_Acc == 0) ~= 0
        Exp1_Behavior_table.loc_chunking(si) = sum(Exp1_Trial_Data(si).main.categorical_Acc == 1) / (sum(Exp1_Trial_Data(si).main.categorical_Acc == 1) + sum(Exp1_Trial_Data(si).main.categorical_Acc == 0));
    else
        Exp1_Behavior_table.loc_chunking(si) = NaN;
    end

    Exp1_Behavior_table.all_wrong_cat(si) = nanmean(Exp1_Trial_Data(si).main.location_catAcc(Exp1_Trial_Data(si).main.where == 0));


    % accuracy
    Exp1_Behavior_table.across_acc(si) = nanmean(Exp1_Trial_Data(si).main_trial.across_acc);
    Exp1_Behavior_table.within_acc(si) = nanmean(Exp1_Trial_Data(si).main_trial.within_acc);

    Exp1_Behavior_table.acc_what(si) = nanmean(Exp1_Trial_Data(si).main.what);
    Exp1_Behavior_table.acc_whatwhen(si) = nanmean(Exp1_Trial_Data(si).main.whatwhen);
    Exp1_Behavior_table.acc_where(si) = nanmean(Exp1_Trial_Data(si).main.where);
    Exp1_Behavior_table.acc_wherewhen(si) = nanmean(Exp1_Trial_Data(si).main.wherewhen);
    Exp1_Behavior_table.acc_whatwhere(si) = nanmean(Exp1_Trial_Data(si).main.whatwhere);
    Exp1_Behavior_table.acc_fullem(si) = nanmean(Exp1_Trial_Data(si).main.fullem);

    Exp1_Behavior_table.acc_loc_cat_where(si) = nanmean(Exp1_Trial_Data(si).main.location_catAcc_where);
    Exp1_Behavior_table.acc_loc_cat_wherewhen(si) = nanmean(Exp1_Trial_Data(si).main.location_catAcc_wherewhen);
    Exp1_Behavior_table.acc_loc_cat_whatwhere(si) = nanmean(Exp1_Trial_Data(si).main.location_catAcc_whatwhere);
    Exp1_Behavior_table.acc_loc_cat_fullem(si) = nanmean(Exp1_Trial_Data(si).main.location_catAcc_fullem);

    Exp1_Behavior_table.acc_wrong_loc_cat_where(si) = nanmean(Exp1_Trial_Data(si).main.location_catAcc_where(Exp1_Trial_Data(si).main.where == 0));
    Exp1_Behavior_table.acc_wrong_loc_cat_wherewhen(si) = nanmean(Exp1_Trial_Data(si).main.location_catAcc_wherewhen(Exp1_Trial_Data(si).main.where == 0));
    Exp1_Behavior_table.acc_wrong_loc_cat_whatwhere(si) = nanmean(Exp1_Trial_Data(si).main.location_catAcc_whatwhere(Exp1_Trial_Data(si).main.where == 0));
    Exp1_Behavior_table.acc_wrong_loc_cat_fullem(si) = nanmean(Exp1_Trial_Data(si).main.location_catAcc_fullem(Exp1_Trial_Data(si).main.where == 0));




    % accuracy - location categorically divided
    Exp1_Behavior_table.acc_location_cat(si) = nanmean(Exp1_Trial_Data(si).main.location_catAcc);
    Exp1_Behavior_table.acc_location_cat_only(si) = nanmean(Exp1_Trial_Data(si).main.location_catWhere);


    % reaction time (right or wrong whole)
    Exp1_Behavior_table.rt_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT);
    Exp1_Behavior_table.rt_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT);
    Exp1_Behavior_table.rt_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT);

    Exp1_Behavior_table.log_rt_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT_log);
    Exp1_Behavior_table.log_rt_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT_log);
    Exp1_Behavior_table.log_rt_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT_log);



    %reaction time (right only)
    Exp1_Behavior_table.rt_right_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT(Exp1_Trial_Data(si).main.fullem == 1));
    Exp1_Behavior_table.rt_right_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT(Exp1_Trial_Data(si).main.animalAcc == 1));
    Exp1_Behavior_table.rt_right_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT(Exp1_Trial_Data(si).main.locationAcc == 1));

    Exp1_Behavior_table.log_rt_right_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT_log(Exp1_Trial_Data(si).main.fullem == 1));
    Exp1_Behavior_table.log_rt_right_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT_log(Exp1_Trial_Data(si).main.animalAcc == 1));
    Exp1_Behavior_table.log_rt_right_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT_log(Exp1_Trial_Data(si).main.locationAcc == 1));



    % each trial (right & wrong)
    Exp1_Behavior_table.rt_trial1_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT(Exp1_Trial_Data(si).main.order == 1));
    Exp1_Behavior_table.rt_trial1_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT(Exp1_Trial_Data(si).main.order == 1));
    Exp1_Behavior_table.rt_trial1_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT(Exp1_Trial_Data(si).main.order == 1));

    Exp1_Behavior_table.rt_trial2_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT(Exp1_Trial_Data(si).main.order == 2));
    Exp1_Behavior_table.rt_trial2_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT(Exp1_Trial_Data(si).main.order == 2));
    Exp1_Behavior_table.rt_trial2_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT(Exp1_Trial_Data(si).main.order == 2));

    Exp1_Behavior_table.rt_trial3_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT(Exp1_Trial_Data(si).main.order == 3));
    Exp1_Behavior_table.rt_trial3_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT(Exp1_Trial_Data(si).main.order == 3));
    Exp1_Behavior_table.rt_trial3_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT(Exp1_Trial_Data(si).main.order == 3));


    Exp1_Behavior_table.log_rt_trial1_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT_log(Exp1_Trial_Data(si).main.order == 1));
    Exp1_Behavior_table.log_rt_trial1_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT_log(Exp1_Trial_Data(si).main.order == 1));
    Exp1_Behavior_table.log_rt_trial1_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT_log(Exp1_Trial_Data(si).main.order == 1));

    Exp1_Behavior_table.log_rt_trial2_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT_log(Exp1_Trial_Data(si).main.order == 2));
    Exp1_Behavior_table.log_rt_trial2_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT_log(Exp1_Trial_Data(si).main.order == 2));
    Exp1_Behavior_table.log_rt_trial2_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT_log(Exp1_Trial_Data(si).main.order == 2));

    Exp1_Behavior_table.log_rt_trial3_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT_log(Exp1_Trial_Data(si).main.order == 3));
    Exp1_Behavior_table.log_rt_trial3_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT_log(Exp1_Trial_Data(si).main.order == 3));
    Exp1_Behavior_table.log_rt_trial3_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT_log(Exp1_Trial_Data(si).main.order == 3));

    Exp1_Behavior_table.log_rt_right_trial1_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT_log(Exp1_Trial_Data(si).main.order == 1  & Exp1_Trial_Data(si).main.fullem == 1));
    Exp1_Behavior_table.log_rt_right_trial1_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT_log(Exp1_Trial_Data(si).main.order == 1 & Exp1_Trial_Data(si).main.animalAcc == 1));
    Exp1_Behavior_table.log_rt_right_trial1_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT_log(Exp1_Trial_Data(si).main.order == 1  & Exp1_Trial_Data(si).main.locationAcc == 1));

    Exp1_Behavior_table.log_rt_right_trial2_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT_log(Exp1_Trial_Data(si).main.order == 2 & Exp1_Trial_Data(si).main.fullem == 1));
    Exp1_Behavior_table.log_rt_right_trial2_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT_log(Exp1_Trial_Data(si).main.order == 2 & Exp1_Trial_Data(si).main.animalAcc == 1));
    Exp1_Behavior_table.log_rt_right_trial2_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT_log(Exp1_Trial_Data(si).main.order == 2 & Exp1_Trial_Data(si).main.locationAcc == 1));

    Exp1_Behavior_table.log_rt_right_trial3_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT_log(Exp1_Trial_Data(si).main.order == 3 & Exp1_Trial_Data(si).main.fullem == 1));
    Exp1_Behavior_table.log_rt_right_trial3_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT_log(Exp1_Trial_Data(si).main.order == 3 & Exp1_Trial_Data(si).main.animalAcc == 1));
    Exp1_Behavior_table.log_rt_right_trial3_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT_log(Exp1_Trial_Data(si).main.order == 3 & Exp1_Trial_Data(si).main.locationAcc == 1));




    % a signle boundary only
    Exp1_Behavior_table.all_ABD_across_acc(si) = nanmean(Exp1_Trial_Data(si).main_trial.across_acc(Exp1_Trial_Data(si).main_trial.boundary == 0,:));
    Exp1_Behavior_table.all_ABD_within_acc(si) = nanmean(Exp1_Trial_Data(si).main_trial.within_acc(Exp1_Trial_Data(si).main_trial.boundary == 0,:));
    Exp1_Behavior_table.all_ABD_acc_what(si) = nanmean(Exp1_Trial_Data(si).main.what(Exp1_Trial_Data(si).main.boundary == 0,:));
    Exp1_Behavior_table.all_ABD_acc_whatwhen(si) = nanmean(Exp1_Trial_Data(si).main.whatwhen(Exp1_Trial_Data(si).main.boundary == 0,:));
    Exp1_Behavior_table.all_ABD_acc_where(si) = nanmean(Exp1_Trial_Data(si).main.where(Exp1_Trial_Data(si).main.boundary == 0,:));
    Exp1_Behavior_table.all_ABD_acc_wherewhen(si) = nanmean(Exp1_Trial_Data(si).main.wherewhen(Exp1_Trial_Data(si).main.boundary == 0,:));
    Exp1_Behavior_table.all_ABD_acc_whatwhere(si) = nanmean(Exp1_Trial_Data(si).main.whatwhere(Exp1_Trial_Data(si).main.boundary == 0,:));
    Exp1_Behavior_table.all_ABD_acc_fullem(si) = nanmean(Exp1_Trial_Data(si).main.fullem(Exp1_Trial_Data(si).main.boundary == 0,:));
    Exp1_Behavior_table.all_ABD_acc_location_cat(si) = nanmean(Exp1_Trial_Data(si).main.location_catAcc(Exp1_Trial_Data(si).main.boundary == 0,:));



    Exp1_Behavior_table.all_ABD_acc_loc_cat_where(si) = nanmean(Exp1_Trial_Data(si).main.location_catAcc_where(Exp1_Trial_Data(si).main.boundary == 0,:));
    Exp1_Behavior_table.all_ABD_acc_loc_cat_wherewhen(si) = nanmean(Exp1_Trial_Data(si).main.location_catAcc_wherewhen(Exp1_Trial_Data(si).main.boundary == 0,:));
    Exp1_Behavior_table.all_ABD_acc_loc_cat_whatwhere(si) = nanmean(Exp1_Trial_Data(si).main.location_catAcc_whatwhere(Exp1_Trial_Data(si).main.boundary == 0,:));
    Exp1_Behavior_table.all_ABD_acc_loc_cat_fullem(si) = nanmean(Exp1_Trial_Data(si).main.location_catAcc_fullem(Exp1_Trial_Data(si).main.boundary == 0,:));

    Exp1_Behavior_table.all_ABD_acc_wrong_loc_cat_where(si) = nanmean(Exp1_Trial_Data(si).main.location_catAcc_where(Exp1_Trial_Data(si).main.where == 0 & Exp1_Trial_Data(si).main.boundary == 0,:));
    Exp1_Behavior_table.all_ABD_acc_wrong_loc_cat_wherewhen(si) = nanmean(Exp1_Trial_Data(si).main.location_catAcc_wherewhen(Exp1_Trial_Data(si).main.where == 0 & Exp1_Trial_Data(si).main.boundary == 0,:));
    Exp1_Behavior_table.all_ABD_acc_wrong_loc_cat_whatwhere(si) = nanmean(Exp1_Trial_Data(si).main.location_catAcc_whatwhere(Exp1_Trial_Data(si).main.where == 0 & Exp1_Trial_Data(si).main.boundary == 0,:));
    Exp1_Behavior_table.all_ABD_acc_wrong_loc_cat_fullem(si) = nanmean(Exp1_Trial_Data(si).main.location_catAcc_fullem(Exp1_Trial_Data(si).main.where == 0 & Exp1_Trial_Data(si).main.boundary == 0,:));



    if sum(Exp1_Trial_Data(si).main.categorical_Acc(Exp1_Trial_Data(si).main.boundary == 0,:) == 1) + sum(Exp1_Trial_Data(si).main.categorical_Acc(Exp1_Trial_Data(si).main.boundary == 0,:) == 0) ~= 0
        Exp1_Behavior_table.ABD_loc_chunking(si) = sum(Exp1_Trial_Data(si).main.categorical_Acc(Exp1_Trial_Data(si).main.boundary == 0,:) == 1) / (sum(Exp1_Trial_Data(si).main.categorical_Acc(Exp1_Trial_Data(si).main.boundary == 0,:) == 1) + sum(Exp1_Trial_Data(si).main.categorical_Acc(Exp1_Trial_Data(si).main.boundary == 0,:) == 0));
    else
        Exp1_Behavior_table.ABD_loc_chunking(si) = NaN;
    end

    Exp1_Behavior_table.all_ABD_wrong_cat(si) = nanmean(Exp1_Trial_Data(si).main.location_catAcc(Exp1_Trial_Data(si).main.where == 0 & Exp1_Trial_Data(si).main.boundary == 0,:));    



    Exp1_Behavior_table.all_ABD_rt_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT(Exp1_Trial_Data(si).main.boundary == 0,:));
    Exp1_Behavior_table.all_ABD_rt_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT(Exp1_Trial_Data(si).main.boundary == 0,:));
    Exp1_Behavior_table.all_ABD_rt_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT(Exp1_Trial_Data(si).main.boundary == 0,:));


    Exp1_Behavior_table.all_ABD_log_rt_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT_log(Exp1_Trial_Data(si).main.boundary == 0,:));
    Exp1_Behavior_table.all_ABD_log_rt_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT_log(Exp1_Trial_Data(si).main.boundary == 0,:));
    Exp1_Behavior_table.all_ABD_log_rt_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT_log(Exp1_Trial_Data(si).main.boundary == 0,:));


    % right trials rt only
    Exp1_Behavior_table.all_ABD_rt_right_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT(((Exp1_Trial_Data(si).main.boundary == 0) & (Exp1_Trial_Data(si).main.fullem == 1)) == 1,:));
    Exp1_Behavior_table.all_ABD_rt_right_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT(((Exp1_Trial_Data(si).main.boundary == 0) & (Exp1_Trial_Data(si).main.animalAcc == 1)) == 1,:));
    Exp1_Behavior_table.all_ABD_rt_right_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT(((Exp1_Trial_Data(si).main.boundary == 0) & (Exp1_Trial_Data(si).main.locationAcc == 1)) == 1,:));


    Exp1_Behavior_table.all_ABD_log_rt_right_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT_log(((Exp1_Trial_Data(si).main.boundary == 0) & (Exp1_Trial_Data(si).main.fullem == 1)) == 1,:));
    Exp1_Behavior_table.all_ABD_log_rt_right_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT_log(((Exp1_Trial_Data(si).main.boundary == 0) & (Exp1_Trial_Data(si).main.animalAcc == 1)) == 1,:));
    Exp1_Behavior_table.all_ABD_log_rt_right_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT_log(((Exp1_Trial_Data(si).main.boundary == 0) & (Exp1_Trial_Data(si).main.locationAcc == 1)) == 1,:));




    Exp1_Behavior_table.all_ABD_log_rt_trial1_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT_log(Exp1_Trial_Data(si).main.order == 1 & Exp1_Trial_Data(si).main.boundary == 0));
    Exp1_Behavior_table.all_ABD_log_rt_trial1_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT_log(Exp1_Trial_Data(si).main.order == 1 & Exp1_Trial_Data(si).main.boundary == 0));
    Exp1_Behavior_table.all_ABD_log_rt_trial1_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT_log(Exp1_Trial_Data(si).main.order == 1 & Exp1_Trial_Data(si).main.boundary == 0));

    Exp1_Behavior_table.all_ABD_log_rt_trial2_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT_log(Exp1_Trial_Data(si).main.order == 2 & Exp1_Trial_Data(si).main.boundary == 0));
    Exp1_Behavior_table.all_ABD_log_rt_trial2_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT_log(Exp1_Trial_Data(si).main.order == 2 & Exp1_Trial_Data(si).main.boundary == 0));
    Exp1_Behavior_table.all_ABD_log_rt_trial2_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT_log(Exp1_Trial_Data(si).main.order == 2 & Exp1_Trial_Data(si).main.boundary == 0));

    Exp1_Behavior_table.all_ABD_log_rt_trial3_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT_log(Exp1_Trial_Data(si).main.order == 3 & Exp1_Trial_Data(si).main.boundary == 0));
    Exp1_Behavior_table.all_ABD_log_rt_trial3_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT_log(Exp1_Trial_Data(si).main.order == 3 & Exp1_Trial_Data(si).main.boundary == 0));
    Exp1_Behavior_table.all_ABD_log_rt_trial3_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT_log(Exp1_Trial_Data(si).main.order == 3 & Exp1_Trial_Data(si).main.boundary == 0));

    Exp1_Behavior_table.all_ABD_log_rt_right_trial1_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT_log(Exp1_Trial_Data(si).main.order == 1  & Exp1_Trial_Data(si).main.fullem == 1 & Exp1_Trial_Data(si).main.boundary == 0));
    Exp1_Behavior_table.all_ABD_log_rt_right_trial1_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT_log(Exp1_Trial_Data(si).main.order == 1 & Exp1_Trial_Data(si).main.animalAcc == 1 & Exp1_Trial_Data(si).main.boundary == 0));
    Exp1_Behavior_table.all_ABD_log_rt_right_trial1_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT_log(Exp1_Trial_Data(si).main.order == 1  & Exp1_Trial_Data(si).main.locationAcc == 1 & Exp1_Trial_Data(si).main.boundary == 0));

    Exp1_Behavior_table.all_ABD_log_rt_right_trial2_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT_log(Exp1_Trial_Data(si).main.order == 2 & Exp1_Trial_Data(si).main.fullem == 1 & Exp1_Trial_Data(si).main.boundary == 0));
    Exp1_Behavior_table.all_ABD_log_rt_right_trial2_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT_log(Exp1_Trial_Data(si).main.order == 2 & Exp1_Trial_Data(si).main.animalAcc == 1 & Exp1_Trial_Data(si).main.boundary == 0));
    Exp1_Behavior_table.all_ABD_log_rt_right_trial2_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT_log(Exp1_Trial_Data(si).main.order == 2 & Exp1_Trial_Data(si).main.locationAcc == 1 & Exp1_Trial_Data(si).main.boundary == 0));

    Exp1_Behavior_table.all_ABD_log_rt_right_trial3_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT_log(Exp1_Trial_Data(si).main.order == 3 & Exp1_Trial_Data(si).main.fullem == 1 & Exp1_Trial_Data(si).main.boundary == 0));
    Exp1_Behavior_table.all_ABD_log_rt_right_trial3_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT_log(Exp1_Trial_Data(si).main.order == 3 & Exp1_Trial_Data(si).main.animalAcc == 1 & Exp1_Trial_Data(si).main.boundary == 0));
    Exp1_Behavior_table.all_ABD_log_rt_right_trial3_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT_log(Exp1_Trial_Data(si).main.order == 3 & Exp1_Trial_Data(si).main.locationAcc == 1 & Exp1_Trial_Data(si).main.boundary == 0));



    % multiple boundary
    Exp1_Behavior_table.all_MBD_across_acc(si) = nanmean(Exp1_Trial_Data(si).main_trial.across_acc(Exp1_Trial_Data(si).main_trial.boundary == 1,:))    
    Exp1_Behavior_table.all_MBD_within_acc(si) = nanmean(Exp1_Trial_Data(si).main_trial.within_acc(Exp1_Trial_Data(si).main_trial.boundary == 1,:))        
    Exp1_Behavior_table.all_MBD_acc_what(si) = nanmean(Exp1_Trial_Data(si).main.what(Exp1_Trial_Data(si).main.boundary == 1,:));
    Exp1_Behavior_table.all_MBD_acc_whatwhen(si) = nanmean(Exp1_Trial_Data(si).main.whatwhen(Exp1_Trial_Data(si).main.boundary == 1,:));
    Exp1_Behavior_table.all_MBD_acc_where(si) = nanmean(Exp1_Trial_Data(si).main.where(Exp1_Trial_Data(si).main.boundary == 1,:));
    Exp1_Behavior_table.all_MBD_acc_wherewhen(si) = nanmean(Exp1_Trial_Data(si).main.wherewhen(Exp1_Trial_Data(si).main.boundary == 1,:));
    Exp1_Behavior_table.all_MBD_acc_whatwhere(si) = nanmean(Exp1_Trial_Data(si).main.whatwhere(Exp1_Trial_Data(si).main.boundary == 1,:));
    Exp1_Behavior_table.all_MBD_acc_fullem(si) = nanmean(Exp1_Trial_Data(si).main.fullem(Exp1_Trial_Data(si).main.boundary == 1,:));
    Exp1_Behavior_table.all_MBD_acc_location_cat(si) = nanmean(Exp1_Trial_Data(si).main.location_catAcc(Exp1_Trial_Data(si).main.boundary == 1,:));



    Exp1_Behavior_table.all_MBD_acc_loc_cat_where(si) = nanmean(Exp1_Trial_Data(si).main.location_catAcc_where(Exp1_Trial_Data(si).main.boundary == 1,:));
    Exp1_Behavior_table.all_MBD_acc_loc_cat_wherewhen(si) = nanmean(Exp1_Trial_Data(si).main.location_catAcc_wherewhen(Exp1_Trial_Data(si).main.boundary == 1,:));
    Exp1_Behavior_table.all_MBD_acc_loc_cat_whatwhere(si) = nanmean(Exp1_Trial_Data(si).main.location_catAcc_whatwhere(Exp1_Trial_Data(si).main.boundary == 1,:));
    Exp1_Behavior_table.all_MBD_acc_loc_cat_fullem(si) = nanmean(Exp1_Trial_Data(si).main.location_catAcc_fullem(Exp1_Trial_Data(si).main.boundary == 1,:));

    Exp1_Behavior_table.all_MBD_acc_wrong_loc_cat_where(si) = nanmean(Exp1_Trial_Data(si).main.location_catAcc_where(Exp1_Trial_Data(si).main.where == 0 & Exp1_Trial_Data(si).main.boundary == 1,:));
    Exp1_Behavior_table.all_MBD_acc_wrong_loc_cat_wherewhen(si) = nanmean(Exp1_Trial_Data(si).main.location_catAcc_wherewhen(Exp1_Trial_Data(si).main.where == 0 & Exp1_Trial_Data(si).main.boundary == 1,:));
    Exp1_Behavior_table.all_MBD_acc_wrong_loc_cat_whatwhere(si) = nanmean(Exp1_Trial_Data(si).main.location_catAcc_whatwhere(Exp1_Trial_Data(si).main.where == 0 & Exp1_Trial_Data(si).main.boundary == 1,:));
    Exp1_Behavior_table.all_MBD_acc_wrong_loc_cat_fullem(si) = nanmean(Exp1_Trial_Data(si).main.location_catAcc_fullem(Exp1_Trial_Data(si).main.where == 0 & Exp1_Trial_Data(si).main.boundary == 1,:));




    Exp1_Behavior_table.all_MBD_rt_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT(Exp1_Trial_Data(si).main.boundary == 1,:));
    Exp1_Behavior_table.all_MBD_rt_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT(Exp1_Trial_Data(si).main.boundary == 1,:));
    Exp1_Behavior_table.all_MBD_rt_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT(Exp1_Trial_Data(si).main.boundary == 1,:));


    Exp1_Behavior_table.all_MBD_log_rt_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT_log(Exp1_Trial_Data(si).main.boundary == 1,:));
    Exp1_Behavior_table.all_MBD_log_rt_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT_log(Exp1_Trial_Data(si).main.boundary == 1,:));
    Exp1_Behavior_table.all_MBD_log_rt_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT_log(Exp1_Trial_Data(si).main.boundary == 1,:));




    if sum(Exp1_Trial_Data(si).main.categorical_Acc(Exp1_Trial_Data(si).main.boundary == 1,:) == 1) + sum(Exp1_Trial_Data(si).main.categorical_Acc(Exp1_Trial_Data(si).main.boundary == 1,:) == 0) ~= 0
        Exp1_Behavior_table.MBD_loc_chunking(si) = sum(Exp1_Trial_Data(si).main.categorical_Acc(Exp1_Trial_Data(si).main.boundary == 1,:) == 1) / (sum(Exp1_Trial_Data(si).main.categorical_Acc(Exp1_Trial_Data(si).main.boundary == 1,:) == 1) + sum(Exp1_Trial_Data(si).main.categorical_Acc(Exp1_Trial_Data(si).main.boundary == 1,:) == 0));
    else
        Exp1_Behavior_table.MBD_loc_chunking(si) = NaN;
    end

    Exp1_Behavior_table.all_MBD_wrong_cat(si) = nanmean(Exp1_Trial_Data(si).main.location_catAcc(Exp1_Trial_Data(si).main.where == 0 & Exp1_Trial_Data(si).main.boundary == 1,:));    



    % right trials rt only
    Exp1_Behavior_table.all_MBD_rt_right_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT(((Exp1_Trial_Data(si).main.boundary == 1) & (Exp1_Trial_Data(si).main.fullem == 1)) == 1,:));
    Exp1_Behavior_table.all_MBD_rt_right_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT(((Exp1_Trial_Data(si).main.boundary == 1) & (Exp1_Trial_Data(si).main.animalAcc == 1)) == 1,:));
    Exp1_Behavior_table.all_MBD_rt_right_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT(((Exp1_Trial_Data(si).main.boundary == 1) & (Exp1_Trial_Data(si).main.locationAcc == 1)) == 1,:));

    Exp1_Behavior_table.all_MBD_log_rt_right_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT_log(((Exp1_Trial_Data(si).main.boundary == 1) & (Exp1_Trial_Data(si).main.fullem == 1)) == 1,:));
    Exp1_Behavior_table.all_MBD_log_rt_right_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT_log(((Exp1_Trial_Data(si).main.boundary == 1) & (Exp1_Trial_Data(si).main.animalAcc == 1)) == 1,:));
    Exp1_Behavior_table.all_MBD_log_rt_right_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT_log(((Exp1_Trial_Data(si).main.boundary == 1) & (Exp1_Trial_Data(si).main.locationAcc == 1)) == 1,:));


    Exp1_Behavior_table.all_MBD_log_rt_trial1_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT_log(Exp1_Trial_Data(si).main.order == 1 & Exp1_Trial_Data(si).main.boundary == 1));
    Exp1_Behavior_table.all_MBD_log_rt_trial1_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT_log(Exp1_Trial_Data(si).main.order == 1 & Exp1_Trial_Data(si).main.boundary == 1));
    Exp1_Behavior_table.all_MBD_log_rt_trial1_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT_log(Exp1_Trial_Data(si).main.order == 1 & Exp1_Trial_Data(si).main.boundary == 1));

    Exp1_Behavior_table.all_MBD_log_rt_trial2_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT_log(Exp1_Trial_Data(si).main.order == 2 & Exp1_Trial_Data(si).main.boundary == 1));
    Exp1_Behavior_table.all_MBD_log_rt_trial2_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT_log(Exp1_Trial_Data(si).main.order == 2 & Exp1_Trial_Data(si).main.boundary == 1));
    Exp1_Behavior_table.all_MBD_log_rt_trial2_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT_log(Exp1_Trial_Data(si).main.order == 2 & Exp1_Trial_Data(si).main.boundary == 1));

    Exp1_Behavior_table.all_MBD_log_rt_trial3_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT_log(Exp1_Trial_Data(si).main.order == 3 & Exp1_Trial_Data(si).main.boundary == 1));
    Exp1_Behavior_table.all_MBD_log_rt_trial3_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT_log(Exp1_Trial_Data(si).main.order == 3 & Exp1_Trial_Data(si).main.boundary == 1));
    Exp1_Behavior_table.all_MBD_log_rt_trial3_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT_log(Exp1_Trial_Data(si).main.order == 3 & Exp1_Trial_Data(si).main.boundary == 1));

    Exp1_Behavior_table.all_MBD_log_rt_right_trial1_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT_log(Exp1_Trial_Data(si).main.order == 1  & Exp1_Trial_Data(si).main.fullem == 1 & Exp1_Trial_Data(si).main.boundary == 1));
    Exp1_Behavior_table.all_MBD_log_rt_right_trial1_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT_log(Exp1_Trial_Data(si).main.order == 1 & Exp1_Trial_Data(si).main.animalAcc == 1 & Exp1_Trial_Data(si).main.boundary == 1));
    Exp1_Behavior_table.all_MBD_log_rt_right_trial1_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT_log(Exp1_Trial_Data(si).main.order == 1  & Exp1_Trial_Data(si).main.locationAcc == 1 & Exp1_Trial_Data(si).main.boundary == 1));

    Exp1_Behavior_table.all_MBD_log_rt_right_trial2_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT_log(Exp1_Trial_Data(si).main.order == 2 & Exp1_Trial_Data(si).main.fullem == 1 & Exp1_Trial_Data(si).main.boundary == 1));
    Exp1_Behavior_table.all_MBD_log_rt_right_trial2_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT_log(Exp1_Trial_Data(si).main.order == 2 & Exp1_Trial_Data(si).main.animalAcc == 1 & Exp1_Trial_Data(si).main.boundary == 1));
    Exp1_Behavior_table.all_MBD_log_rt_right_trial2_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT_log(Exp1_Trial_Data(si).main.order == 2 & Exp1_Trial_Data(si).main.locationAcc == 1 & Exp1_Trial_Data(si).main.boundary == 1));

    Exp1_Behavior_table.all_MBD_log_rt_right_trial3_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT_log(Exp1_Trial_Data(si).main.order == 3 & Exp1_Trial_Data(si).main.fullem == 1 & Exp1_Trial_Data(si).main.boundary == 1));
    Exp1_Behavior_table.all_MBD_log_rt_right_trial3_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT_log(Exp1_Trial_Data(si).main.order == 3 & Exp1_Trial_Data(si).main.animalAcc == 1 & Exp1_Trial_Data(si).main.boundary == 1));
    Exp1_Behavior_table.all_MBD_log_rt_right_trial3_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT_log(Exp1_Trial_Data(si).main.order == 3 & Exp1_Trial_Data(si).main.locationAcc == 1 & Exp1_Trial_Data(si).main.boundary == 1));

  

    %selected (boundary crossing 1) - no right rt yet
    Exp1_Behavior_table.select_across_acc(si) = nanmean(Exp1_Trial_Data(si).main_trial.across_acc(Exp1_Trial_Data(si).main_trial.boundary_cat_okay > 0 ,:));    
    Exp1_Behavior_table.select_within_acc(si) = nanmean(Exp1_Trial_Data(si).main_trial.within_acc(Exp1_Trial_Data(si).main_trial.boundary_cat_okay > 0 ,:))   

    Exp1_Behavior_table.select_acc_what(si) = nanmean(Exp1_Trial_Data(si).main.what(Exp1_Trial_Data(si).main.boundary_cat_okay > 0 ,:));
    Exp1_Behavior_table.select_acc_whatwhen(si) = nanmean(Exp1_Trial_Data(si).main.whatwhen(Exp1_Trial_Data(si).main.boundary_cat_okay > 0 ,:));
    Exp1_Behavior_table.select_acc_where(si) = nanmean(Exp1_Trial_Data(si).main.where(Exp1_Trial_Data(si).main.boundary_cat_okay > 0 ,:));
    Exp1_Behavior_table.select_acc_wherewhen(si) = nanmean(Exp1_Trial_Data(si).main.wherewhen(Exp1_Trial_Data(si).main.boundary_cat_okay > 0 ,:));
    Exp1_Behavior_table.select_acc_whatwhere(si) = nanmean(Exp1_Trial_Data(si).main.whatwhere(Exp1_Trial_Data(si).main.boundary_cat_okay > 0 ,:));
    Exp1_Behavior_table.select_acc_fullem(si) = nanmean(Exp1_Trial_Data(si).main.fullem(Exp1_Trial_Data(si).main.boundary_cat_okay > 0 ,:));


    Exp1_Behavior_table.select_acc_loc_cat_where(si) = nanmean(Exp1_Trial_Data(si).main.location_catAcc_where(Exp1_Trial_Data(si).main.boundary_cat_okay > 0 ,:));
    Exp1_Behavior_table.select_acc_loc_cat_wherewhen(si) = nanmean(Exp1_Trial_Data(si).main.location_catAcc_wherewhen(Exp1_Trial_Data(si).main.boundary_cat_okay > 0 ,:));
    Exp1_Behavior_table.select_acc_loc_cat_whatwhere(si) = nanmean(Exp1_Trial_Data(si).main.location_catAcc_whatwhere(Exp1_Trial_Data(si).main.boundary_cat_okay > 0 ,:));
    Exp1_Behavior_table.select_acc_loc_cat_fullem(si) = nanmean(Exp1_Trial_Data(si).main.location_catAcc_fullem(Exp1_Trial_Data(si).main.boundary_cat_okay > 0 ,:));



    Exp1_Behavior_table.select_acc_wrong_loc_cat_where(si) = nanmean(Exp1_Trial_Data(si).main.location_catAcc_where(Exp1_Trial_Data(si).main.where == 0 & Exp1_Trial_Data(si).main.boundary_cat_okay > 0 ,:));
    Exp1_Behavior_table.select_acc_wrong_loc_cat_wherewhen(si) = nanmean(Exp1_Trial_Data(si).main.location_catAcc_wherewhen(Exp1_Trial_Data(si).main.where == 0 & Exp1_Trial_Data(si).main.boundary_cat_okay > 0 ,:));
    Exp1_Behavior_table.select_acc_wrong_loc_cat_whatwhere(si) = nanmean(Exp1_Trial_Data(si).main.location_catAcc_whatwhere(Exp1_Trial_Data(si).main.where == 0 & Exp1_Trial_Data(si).main.boundary_cat_okay > 0 ,:));
    Exp1_Behavior_table.select_acc_wrong_loc_cat_fullem(si) = nanmean(Exp1_Trial_Data(si).main.location_catAcc_fullem(Exp1_Trial_Data(si).main.where == 0 & Exp1_Trial_Data(si).main.boundary_cat_okay > 0 ,:));



    Exp1_Behavior_table.select_acc_location_cat(si) = nanmean(Exp1_Trial_Data(si).main.location_catAcc(Exp1_Trial_Data(si).main.boundary_cat_okay > 0 ,:));

    if sum(Exp1_Trial_Data(si).main.categorical_Acc(Exp1_Trial_Data(si).main.boundary_cat_okay > 0,:) == 1) + sum(Exp1_Trial_Data(si).main.categorical_Acc( Exp1_Trial_Data(si).main.boundary_cat_okay > 0,:) == 0) ~= 0
        Exp1_Behavior_table.select_loc_chunking(si) = sum(Exp1_Trial_Data(si).main.categorical_Acc(Exp1_Trial_Data(si).main.boundary_cat_okay > 0,:) == 1) / (sum(Exp1_Trial_Data(si).main.categorical_Acc(Exp1_Trial_Data(si).main.boundary_cat_okay > 0,:) == 1) + sum(Exp1_Trial_Data(si).main.categorical_Acc(Exp1_Trial_Data(si).main.boundary_cat_okay > 0,:) == 0));
    else
        Exp1_Behavior_table.select_loc_chunking(si) = NaN;
    end

    Exp1_Behavior_table.select_wrong_cat(si) = nanmean(Exp1_Trial_Data(si).main.location_catAcc(Exp1_Trial_Data(si).main.where == 0 & Exp1_Trial_Data(si).main.boundary_cat_okay > 0,:));    




    Exp1_Behavior_table.select_rt_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT(Exp1_Trial_Data(si).main.boundary_cat_okay > 0 ,:));
    Exp1_Behavior_table.select_rt_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT(Exp1_Trial_Data(si).main.boundary_cat_okay > 0 ,:));
    Exp1_Behavior_table.select_rt_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT(Exp1_Trial_Data(si).main.boundary_cat_okay > 0 ,:));

    Exp1_Behavior_table.select_log_rt_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT_log(Exp1_Trial_Data(si).main.boundary_cat_okay > 0 ,:));
    Exp1_Behavior_table.select_log_rt_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT_log(Exp1_Trial_Data(si).main.boundary_cat_okay > 0 ,:));
    Exp1_Behavior_table.select_log_rt_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT_log(Exp1_Trial_Data(si).main.boundary_cat_okay > 0 ,:));


    % right trials rt only
    Exp1_Behavior_table.select_rt_right_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT(((Exp1_Trial_Data(si).main.fullem == 1)) == 1,:));
    Exp1_Behavior_table.select_rt_right_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT(((Exp1_Trial_Data(si).main.animalAcc == 1)) == 1,:));
    Exp1_Behavior_table.select_rt_right_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT(((Exp1_Trial_Data(si).main.locationAcc == 1)) == 1,:));

    Exp1_Behavior_table.select_log_rt_right_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT_log(((Exp1_Trial_Data(si).main.fullem == 1)) == 1,:));
    Exp1_Behavior_table.select_log_rt_right_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT_log(((Exp1_Trial_Data(si).main.animalAcc == 1)) == 1,:));
    Exp1_Behavior_table.select_log_rt_right_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT_log(((Exp1_Trial_Data(si).main.locationAcc == 1)) == 1,:));


    Exp1_Behavior_table.AAB_log_rt_trial1_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT_log(Exp1_Trial_Data(si).main.order == 1  & Exp1_Trial_Data(si).main.boundary_cat_okay == 1));
    Exp1_Behavior_table.AAB_log_rt_trial1_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT_log(Exp1_Trial_Data(si).main.order == 1  & Exp1_Trial_Data(si).main.boundary_cat_okay == 1));
    Exp1_Behavior_table.AAB_log_rt_trial1_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT_log(Exp1_Trial_Data(si).main.order == 1  & Exp1_Trial_Data(si).main.boundary_cat_okay == 1));

    Exp1_Behavior_table.AAB_log_rt_trial2_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT_log(Exp1_Trial_Data(si).main.order == 2  & Exp1_Trial_Data(si).main.boundary_cat_okay == 1));
    Exp1_Behavior_table.AAB_log_rt_trial2_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT_log(Exp1_Trial_Data(si).main.order == 2  & Exp1_Trial_Data(si).main.boundary_cat_okay == 1));
    Exp1_Behavior_table.AAB_log_rt_trial2_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT_log(Exp1_Trial_Data(si).main.order == 2  & Exp1_Trial_Data(si).main.boundary_cat_okay == 1));

    Exp1_Behavior_table.AAB_log_rt_trial3_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT_log(Exp1_Trial_Data(si).main.order == 3  & Exp1_Trial_Data(si).main.boundary_cat_okay == 1));
    Exp1_Behavior_table.AAB_log_rt_trial3_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT_log(Exp1_Trial_Data(si).main.order == 3  & Exp1_Trial_Data(si).main.boundary_cat_okay == 1));
    Exp1_Behavior_table.AAB_log_rt_trial3_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT_log(Exp1_Trial_Data(si).main.order == 3  & Exp1_Trial_Data(si).main.boundary_cat_okay == 1));

    Exp1_Behavior_table.AAB_log_rt_right_trial1_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT_log(Exp1_Trial_Data(si).main.order == 1  & Exp1_Trial_Data(si).main.fullem == 1  & Exp1_Trial_Data(si).main.boundary_cat_okay == 1));
    Exp1_Behavior_table.AAB_log_rt_right_trial1_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT_log(Exp1_Trial_Data(si).main.order == 1 & Exp1_Trial_Data(si).main.animalAcc == 1 & Exp1_Trial_Data(si).main.boundary_cat_okay == 1));
    Exp1_Behavior_table.AAB_log_rt_right_trial1_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT_log(Exp1_Trial_Data(si).main.order == 1  & Exp1_Trial_Data(si).main.locationAcc == 1  & Exp1_Trial_Data(si).main.boundary_cat_okay == 1));

    Exp1_Behavior_table.AAB_log_rt_right_trial2_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT_log(Exp1_Trial_Data(si).main.order == 2 & Exp1_Trial_Data(si).main.fullem == 1  & Exp1_Trial_Data(si).main.boundary_cat_okay == 1));
    Exp1_Behavior_table.AAB_log_rt_right_trial2_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT_log(Exp1_Trial_Data(si).main.order == 2 & Exp1_Trial_Data(si).main.animalAcc == 1 & Exp1_Trial_Data(si).main.boundary_cat_okay == 1));
    Exp1_Behavior_table.AAB_log_rt_right_trial2_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT_log(Exp1_Trial_Data(si).main.order == 2 & Exp1_Trial_Data(si).main.locationAcc == 1 & Exp1_Trial_Data(si).main.boundary_cat_okay == 1));

    Exp1_Behavior_table.AAB_log_rt_right_trial3_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT_log(Exp1_Trial_Data(si).main.order == 3 & Exp1_Trial_Data(si).main.fullem == 1 & Exp1_Trial_Data(si).main.boundary_cat_okay == 1));
    Exp1_Behavior_table.AAB_log_rt_right_trial3_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT_log(Exp1_Trial_Data(si).main.order == 3 & Exp1_Trial_Data(si).main.animalAcc == 1  & Exp1_Trial_Data(si).main.boundary_cat_okay == 1));
    Exp1_Behavior_table.AAB_log_rt_right_trial3_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT_log(Exp1_Trial_Data(si).main.order == 3 & Exp1_Trial_Data(si).main.locationAcc == 1 & Exp1_Trial_Data(si).main.boundary_cat_okay == 1));


    
    Exp1_Behavior_table.ABB_log_rt_trial1_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT_log(Exp1_Trial_Data(si).main.order == 1  & Exp1_Trial_Data(si).main.boundary_cat_okay == 2));
    Exp1_Behavior_table.ABB_log_rt_trial1_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT_log(Exp1_Trial_Data(si).main.order == 1  & Exp1_Trial_Data(si).main.boundary_cat_okay == 2));
    Exp1_Behavior_table.ABB_log_rt_trial1_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT_log(Exp1_Trial_Data(si).main.order == 1  & Exp1_Trial_Data(si).main.boundary_cat_okay == 2));

    Exp1_Behavior_table.ABB_log_rt_trial2_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT_log(Exp1_Trial_Data(si).main.order == 2 & Exp1_Trial_Data(si).main.boundary_cat_okay == 2));
    Exp1_Behavior_table.ABB_log_rt_trial2_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT_log(Exp1_Trial_Data(si).main.order == 2 & Exp1_Trial_Data(si).main.boundary_cat_okay == 2));
    Exp1_Behavior_table.ABB_log_rt_trial2_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT_log(Exp1_Trial_Data(si).main.order == 2  & Exp1_Trial_Data(si).main.boundary_cat_okay == 2));

    Exp1_Behavior_table.ABB_log_rt_trial3_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT_log(Exp1_Trial_Data(si).main.order == 3  & Exp1_Trial_Data(si).main.boundary_cat_okay == 2));
    Exp1_Behavior_table.ABB_log_rt_trial3_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT_log(Exp1_Trial_Data(si).main.order == 3 & Exp1_Trial_Data(si).main.boundary_cat_okay == 2));
    Exp1_Behavior_table.ABB_log_rt_trial3_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT_log(Exp1_Trial_Data(si).main.order == 3 & Exp1_Trial_Data(si).main.boundary_cat_okay == 2));

    Exp1_Behavior_table.ABB_log_rt_right_trial1_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT_log(Exp1_Trial_Data(si).main.order == 1  & Exp1_Trial_Data(si).main.fullem == 1   & Exp1_Trial_Data(si).main.boundary_cat_okay == 2));
    Exp1_Behavior_table.ABB_log_rt_right_trial1_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT_log(Exp1_Trial_Data(si).main.order == 1 & Exp1_Trial_Data(si).main.animalAcc == 1   & Exp1_Trial_Data(si).main.boundary_cat_okay == 2));
    Exp1_Behavior_table.ABB_log_rt_right_trial1_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT_log(Exp1_Trial_Data(si).main.order == 1  & Exp1_Trial_Data(si).main.locationAcc == 1   & Exp1_Trial_Data(si).main.boundary_cat_okay == 2));

    Exp1_Behavior_table.ABB_log_rt_right_trial2_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT_log(Exp1_Trial_Data(si).main.order == 2 & Exp1_Trial_Data(si).main.fullem == 1  & Exp1_Trial_Data(si).main.boundary_cat_okay == 2));
    Exp1_Behavior_table.ABB_log_rt_right_trial2_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT_log(Exp1_Trial_Data(si).main.order == 2 & Exp1_Trial_Data(si).main.animalAcc == 1  & Exp1_Trial_Data(si).main.boundary_cat_okay == 2));
    Exp1_Behavior_table.ABB_log_rt_right_trial2_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT_log(Exp1_Trial_Data(si).main.order == 2 & Exp1_Trial_Data(si).main.locationAcc == 1  & Exp1_Trial_Data(si).main.boundary_cat_okay == 2));

    Exp1_Behavior_table.ABB_log_rt_right_trial3_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT_log(Exp1_Trial_Data(si).main.order == 3 & Exp1_Trial_Data(si).main.fullem == 1   & Exp1_Trial_Data(si).main.boundary_cat_okay == 2));
    Exp1_Behavior_table.ABB_log_rt_right_trial3_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT_log(Exp1_Trial_Data(si).main.order == 3 & Exp1_Trial_Data(si).main.animalAcc == 1 & Exp1_Trial_Data(si).main.boundary_cat_okay == 2));
    Exp1_Behavior_table.ABB_log_rt_right_trial3_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT_log(Exp1_Trial_Data(si).main.order == 3 & Exp1_Trial_Data(si).main.locationAcc == 1 & Exp1_Trial_Data(si).main.boundary_cat_okay == 2));





    
    if sum(Exp1_Trial_Data(si).main.categorical_Acc(Exp1_Trial_Data(si).main.boundary == 0 & Exp1_Trial_Data(si).main.boundary_cat_okay > 0,:) == 1) + sum(Exp1_Trial_Data(si).main.categorical_Acc(Exp1_Trial_Data(si).main.boundary == 0 & Exp1_Trial_Data(si).main.boundary_cat_okay > 0,:) == 0) ~= 0
        Exp1_Behavior_table.select_ABD_loc_chunking(si) = sum(Exp1_Trial_Data(si).main.categorical_Acc(Exp1_Trial_Data(si).main.boundary == 0 & Exp1_Trial_Data(si).main.boundary_cat_okay > 0,:) == 1) / (sum(Exp1_Trial_Data(si).main.categorical_Acc(Exp1_Trial_Data(si).main.boundary == 0 & Exp1_Trial_Data(si).main.boundary_cat_okay > 0,:) == 1) + sum(Exp1_Trial_Data(si).main.categorical_Acc(Exp1_Trial_Data(si).main.boundary == 0 & Exp1_Trial_Data(si).main.boundary_cat_okay > 0,:) == 0));
    else
        Exp1_Behavior_table.select_ABD_loc_chunking(si) = NaN;
    end

    Exp1_Behavior_table.select_ABD_across_acc(si) = nanmean(Exp1_Trial_Data(si).main_trial.across_acc(Exp1_Trial_Data(si).main_trial.boundary == 0  & Exp1_Trial_Data(si).main_trial.boundary_1cross_run > 0,:));    
    Exp1_Behavior_table.select_ABD_within_acc(si) = nanmean(Exp1_Trial_Data(si).main_trial.within_acc(Exp1_Trial_Data(si).main_trial.boundary == 0 & Exp1_Trial_Data(si).main_trial.boundary_1cross_run > 0,:));      

    Exp1_Behavior_table.select_ABD_acc_what(si) = nanmean(Exp1_Trial_Data(si).main.what(Exp1_Trial_Data(si).main.boundary == 0 & Exp1_Trial_Data(si).main.boundary_cat_okay > 0 ,:));
    Exp1_Behavior_table.select_ABD_acc_whatwhen(si) = nanmean(Exp1_Trial_Data(si).main.whatwhen(Exp1_Trial_Data(si).main.boundary == 0 & Exp1_Trial_Data(si).main.boundary_cat_okay > 0,:));
    Exp1_Behavior_table.select_ABD_acc_where(si) = nanmean(Exp1_Trial_Data(si).main.where(Exp1_Trial_Data(si).main.boundary == 0 & Exp1_Trial_Data(si).main.boundary_cat_okay > 0,:));
    Exp1_Behavior_table.select_ABD_acc_wherewhen(si) = nanmean(Exp1_Trial_Data(si).main.wherewhen(Exp1_Trial_Data(si).main.boundary == 0 & Exp1_Trial_Data(si).main.boundary_cat_okay > 0,:));
    Exp1_Behavior_table.select_ABD_acc_whatwhere(si) = nanmean(Exp1_Trial_Data(si).main.whatwhere(Exp1_Trial_Data(si).main.boundary == 0 & Exp1_Trial_Data(si).main.boundary_cat_okay > 0,:));
    Exp1_Behavior_table.select_ABD_acc_fullem(si) = nanmean(Exp1_Trial_Data(si).main.fullem(Exp1_Trial_Data(si).main.boundary == 0 & Exp1_Trial_Data(si).main.boundary_cat_okay > 0,:));
    Exp1_Behavior_table.select_ABD_acc_location_cat(si) = nanmean(Exp1_Trial_Data(si).main.location_catAcc(Exp1_Trial_Data(si).main.boundary == 0 & Exp1_Trial_Data(si).main.boundary_cat_okay > 0,:));


    Exp1_Behavior_table.select_ABD_acc_loc_cat_where(si) = nanmean(Exp1_Trial_Data(si).main.location_catAcc_where(Exp1_Trial_Data(si).main.boundary == 0 & Exp1_Trial_Data(si).main.boundary_cat_okay > 0,:));
    Exp1_Behavior_table.select_ABD_acc_loc_cat_wherewhen(si) = nanmean(Exp1_Trial_Data(si).main.location_catAcc_wherewhen(Exp1_Trial_Data(si).main.boundary == 0 & Exp1_Trial_Data(si).main.boundary_cat_okay > 0,:));
    Exp1_Behavior_table.select_ABD_acc_loc_cat_whatwhere(si) = nanmean(Exp1_Trial_Data(si).main.location_catAcc_whatwhere(Exp1_Trial_Data(si).main.boundary == 0 & Exp1_Trial_Data(si).main.boundary_cat_okay > 0,:));
    Exp1_Behavior_table.select_ABD_acc_loc_cat_fullem(si) = nanmean(Exp1_Trial_Data(si).main.location_catAcc_fullem(Exp1_Trial_Data(si).main.boundary == 0 & Exp1_Trial_Data(si).main.boundary_cat_okay > 0,:));



    Exp1_Behavior_table.select_ABD_acc_wrong_loc_cat_where(si) = nanmean(Exp1_Trial_Data(si).main.location_catAcc_where(Exp1_Trial_Data(si).main.where == 0 & Exp1_Trial_Data(si).main.boundary == 0 & Exp1_Trial_Data(si).main.boundary_cat_okay > 0,:));
    Exp1_Behavior_table.select_ABD_acc_wrong_loc_cat_wherewhen(si) = nanmean(Exp1_Trial_Data(si).main.location_catAcc_wherewhen(Exp1_Trial_Data(si).main.where == 0 & Exp1_Trial_Data(si).main.boundary == 0 & Exp1_Trial_Data(si).main.boundary_cat_okay > 0,:));
    Exp1_Behavior_table.select_ABD_acc_wrong_loc_cat_whatwhere(si) = nanmean(Exp1_Trial_Data(si).main.location_catAcc_whatwhere(Exp1_Trial_Data(si).main.where == 0 & Exp1_Trial_Data(si).main.boundary == 0 & Exp1_Trial_Data(si).main.boundary_cat_okay > 0,:));
    Exp1_Behavior_table.select_ABD_acc_wrong_loc_cat_fullem(si) = nanmean(Exp1_Trial_Data(si).main.location_catAcc_fullem(Exp1_Trial_Data(si).main.where == 0 & Exp1_Trial_Data(si).main.boundary == 0 & Exp1_Trial_Data(si).main.boundary_cat_okay > 0,:));




    Exp1_Behavior_table.select_ABD_wrong_cat(si) = nanmean(Exp1_Trial_Data(si).main.location_catAcc(Exp1_Trial_Data(si).main.where == 0 & Exp1_Trial_Data(si).main.boundary == 0 & Exp1_Trial_Data(si).main.boundary_cat_okay > 0,:));    



    Exp1_Behavior_table.select_ABD_rt_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT(Exp1_Trial_Data(si).main.boundary == 0 & Exp1_Trial_Data(si).main.boundary_cat_okay > 0,:));
    Exp1_Behavior_table.select_ABD_rt_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT(Exp1_Trial_Data(si).main.boundary == 0 & Exp1_Trial_Data(si).main.boundary_cat_okay > 0,:));
    Exp1_Behavior_table.select_ABD_rt_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT(Exp1_Trial_Data(si).main.boundary == 0 & Exp1_Trial_Data(si).main.boundary_cat_okay > 0,:));

    Exp1_Behavior_table.select_ABD_rt_right_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT(Exp1_Trial_Data(si).main.boundary == 0 & Exp1_Trial_Data(si).main.boundary_cat_okay > 0 & Exp1_Trial_Data(si).main.fullem == 1,:));
    Exp1_Behavior_table.select_ABD_rt_right_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT(Exp1_Trial_Data(si).main.boundary == 0 & Exp1_Trial_Data(si).main.boundary_cat_okay > 0 & Exp1_Trial_Data(si).main.animalAcc == 1,:));
    Exp1_Behavior_table.select_ABD_rt_right_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT(Exp1_Trial_Data(si).main.boundary == 0 & Exp1_Trial_Data(si).main.boundary_cat_okay > 0 & Exp1_Trial_Data(si).main.locationAcc == 1,:));

    Exp1_Behavior_table.select_ABD_log_rt_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT_log(Exp1_Trial_Data(si).main.boundary == 0 & Exp1_Trial_Data(si).main.boundary_cat_okay > 0,:));
    Exp1_Behavior_table.select_ABD_log_rt_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT_log(Exp1_Trial_Data(si).main.boundary == 0 & Exp1_Trial_Data(si).main.boundary_cat_okay > 0,:));
    Exp1_Behavior_table.select_ABD_log_rt_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT_log(Exp1_Trial_Data(si).main.boundary == 0 & Exp1_Trial_Data(si).main.boundary_cat_okay > 0,:));

    Exp1_Behavior_table.select_ABD_log_rt_right_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT_log(Exp1_Trial_Data(si).main.boundary == 0 & Exp1_Trial_Data(si).main.boundary_cat_okay > 0 & Exp1_Trial_Data(si).main.fullem == 1,:));
    Exp1_Behavior_table.select_ABD_log_rt_right_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT_log(Exp1_Trial_Data(si).main.boundary == 0 & Exp1_Trial_Data(si).main.boundary_cat_okay > 0 & Exp1_Trial_Data(si).main.animalAcc == 1,:));
    Exp1_Behavior_table.select_ABD_log_rt_right_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT_log(Exp1_Trial_Data(si).main.boundary == 0 & Exp1_Trial_Data(si).main.boundary_cat_okay > 0 & Exp1_Trial_Data(si).main.locationAcc == 1,:));



    Exp1_Behavior_table.AAB_ABD_log_rt_trial1_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT_log(Exp1_Trial_Data(si).main.order == 1 & Exp1_Trial_Data(si).main.boundary == 0  & Exp1_Trial_Data(si).main.boundary_cat_okay == 1));
    Exp1_Behavior_table.AAB_ABD_log_rt_trial1_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT_log(Exp1_Trial_Data(si).main.order == 1 & Exp1_Trial_Data(si).main.boundary == 0  & Exp1_Trial_Data(si).main.boundary_cat_okay == 1));
    Exp1_Behavior_table.AAB_ABD_log_rt_trial1_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT_log(Exp1_Trial_Data(si).main.order == 1 & Exp1_Trial_Data(si).main.boundary == 0  & Exp1_Trial_Data(si).main.boundary_cat_okay == 1));

    Exp1_Behavior_table.AAB_ABD_log_rt_trial2_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT_log(Exp1_Trial_Data(si).main.order == 2 & Exp1_Trial_Data(si).main.boundary == 0  & Exp1_Trial_Data(si).main.boundary_cat_okay == 1));
    Exp1_Behavior_table.AAB_ABD_log_rt_trial2_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT_log(Exp1_Trial_Data(si).main.order == 2 & Exp1_Trial_Data(si).main.boundary == 0  & Exp1_Trial_Data(si).main.boundary_cat_okay == 1));
    Exp1_Behavior_table.AAB_ABD_log_rt_trial2_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT_log(Exp1_Trial_Data(si).main.order == 2 & Exp1_Trial_Data(si).main.boundary == 0  & Exp1_Trial_Data(si).main.boundary_cat_okay == 1));

    Exp1_Behavior_table.AAB_ABD_log_rt_trial3_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT_log(Exp1_Trial_Data(si).main.order == 3 & Exp1_Trial_Data(si).main.boundary == 0  & Exp1_Trial_Data(si).main.boundary_cat_okay == 1));
    Exp1_Behavior_table.AAB_ABD_log_rt_trial3_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT_log(Exp1_Trial_Data(si).main.order == 3 & Exp1_Trial_Data(si).main.boundary == 0  & Exp1_Trial_Data(si).main.boundary_cat_okay == 1));
    Exp1_Behavior_table.AAB_ABD_log_rt_trial3_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT_log(Exp1_Trial_Data(si).main.order == 3 & Exp1_Trial_Data(si).main.boundary == 0  & Exp1_Trial_Data(si).main.boundary_cat_okay == 1));

    Exp1_Behavior_table.AAB_ABD_log_rt_right_trial1_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT_log(Exp1_Trial_Data(si).main.order == 1  & Exp1_Trial_Data(si).main.fullem == 1 & Exp1_Trial_Data(si).main.boundary == 0  & Exp1_Trial_Data(si).main.boundary_cat_okay == 1));
    Exp1_Behavior_table.AAB_ABD_log_rt_right_trial1_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT_log(Exp1_Trial_Data(si).main.order == 1 & Exp1_Trial_Data(si).main.animalAcc == 1 & Exp1_Trial_Data(si).main.boundary == 0  & Exp1_Trial_Data(si).main.boundary_cat_okay == 1));
    Exp1_Behavior_table.AAB_ABD_log_rt_right_trial1_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT_log(Exp1_Trial_Data(si).main.order == 1  & Exp1_Trial_Data(si).main.locationAcc == 1 & Exp1_Trial_Data(si).main.boundary == 0  & Exp1_Trial_Data(si).main.boundary_cat_okay == 1));

    Exp1_Behavior_table.AAB_ABD_log_rt_right_trial2_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT_log(Exp1_Trial_Data(si).main.order == 2 & Exp1_Trial_Data(si).main.fullem == 1 & Exp1_Trial_Data(si).main.boundary == 0  & Exp1_Trial_Data(si).main.boundary_cat_okay == 1));
    Exp1_Behavior_table.AAB_ABD_log_rt_right_trial2_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT_log(Exp1_Trial_Data(si).main.order == 2 & Exp1_Trial_Data(si).main.animalAcc == 1 & Exp1_Trial_Data(si).main.boundary == 0  & Exp1_Trial_Data(si).main.boundary_cat_okay == 1));
    Exp1_Behavior_table.AAB_ABD_log_rt_right_trial2_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT_log(Exp1_Trial_Data(si).main.order == 2 & Exp1_Trial_Data(si).main.locationAcc == 1 & Exp1_Trial_Data(si).main.boundary == 0 & Exp1_Trial_Data(si).main.boundary_cat_okay == 1));

    Exp1_Behavior_table.AAB_ABD_log_rt_right_trial3_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT_log(Exp1_Trial_Data(si).main.order == 3 & Exp1_Trial_Data(si).main.fullem == 1 & Exp1_Trial_Data(si).main.boundary == 0  & Exp1_Trial_Data(si).main.boundary_cat_okay == 1));
    Exp1_Behavior_table.AAB_ABD_log_rt_right_trial3_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT_log(Exp1_Trial_Data(si).main.order == 3 & Exp1_Trial_Data(si).main.animalAcc == 1 & Exp1_Trial_Data(si).main.boundary == 0 & Exp1_Trial_Data(si).main.boundary_cat_okay == 1));
    Exp1_Behavior_table.AAB_ABD_log_rt_right_trial3_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT_log(Exp1_Trial_Data(si).main.order == 3 & Exp1_Trial_Data(si).main.locationAcc == 1 & Exp1_Trial_Data(si).main.boundary == 0 & Exp1_Trial_Data(si).main.boundary_cat_okay == 1));


    
    Exp1_Behavior_table.ABB_ABD_log_rt_trial1_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT_log(Exp1_Trial_Data(si).main.order == 1 & Exp1_Trial_Data(si).main.boundary == 0  & Exp1_Trial_Data(si).main.boundary_cat_okay == 2));
    Exp1_Behavior_table.ABB_ABD_log_rt_trial1_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT_log(Exp1_Trial_Data(si).main.order == 1 & Exp1_Trial_Data(si).main.boundary == 0  & Exp1_Trial_Data(si).main.boundary_cat_okay == 2));
    Exp1_Behavior_table.ABB_ABD_log_rt_trial1_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT_log(Exp1_Trial_Data(si).main.order == 1 & Exp1_Trial_Data(si).main.boundary == 0  & Exp1_Trial_Data(si).main.boundary_cat_okay == 2));

    Exp1_Behavior_table.ABB_ABD_log_rt_trial2_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT_log(Exp1_Trial_Data(si).main.order == 2 & Exp1_Trial_Data(si).main.boundary == 0  & Exp1_Trial_Data(si).main.boundary_cat_okay == 2));
    Exp1_Behavior_table.ABB_ABD_log_rt_trial2_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT_log(Exp1_Trial_Data(si).main.order == 2 & Exp1_Trial_Data(si).main.boundary == 0  & Exp1_Trial_Data(si).main.boundary_cat_okay == 2));
    Exp1_Behavior_table.ABB_ABD_log_rt_trial2_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT_log(Exp1_Trial_Data(si).main.order == 2 & Exp1_Trial_Data(si).main.boundary == 0  & Exp1_Trial_Data(si).main.boundary_cat_okay == 2));

    Exp1_Behavior_table.ABB_ABD_log_rt_trial3_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT_log(Exp1_Trial_Data(si).main.order == 3 & Exp1_Trial_Data(si).main.boundary == 0  & Exp1_Trial_Data(si).main.boundary_cat_okay == 2));
    Exp1_Behavior_table.ABB_ABD_log_rt_trial3_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT_log(Exp1_Trial_Data(si).main.order == 3 & Exp1_Trial_Data(si).main.boundary == 0  & Exp1_Trial_Data(si).main.boundary_cat_okay == 2));
    Exp1_Behavior_table.ABB_ABD_log_rt_trial3_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT_log(Exp1_Trial_Data(si).main.order == 3 & Exp1_Trial_Data(si).main.boundary == 0  & Exp1_Trial_Data(si).main.boundary_cat_okay == 2));

    Exp1_Behavior_table.ABB_ABD_log_rt_right_trial1_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT_log(Exp1_Trial_Data(si).main.order == 1  & Exp1_Trial_Data(si).main.fullem == 1 & Exp1_Trial_Data(si).main.boundary == 0  & Exp1_Trial_Data(si).main.boundary_cat_okay == 2));
    Exp1_Behavior_table.ABB_ABD_log_rt_right_trial1_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT_log(Exp1_Trial_Data(si).main.order == 1 & Exp1_Trial_Data(si).main.animalAcc == 1 & Exp1_Trial_Data(si).main.boundary == 0  & Exp1_Trial_Data(si).main.boundary_cat_okay == 2));
    Exp1_Behavior_table.ABB_ABD_log_rt_right_trial1_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT_log(Exp1_Trial_Data(si).main.order == 1  & Exp1_Trial_Data(si).main.locationAcc == 1 & Exp1_Trial_Data(si).main.boundary == 0  & Exp1_Trial_Data(si).main.boundary_cat_okay == 2));

    Exp1_Behavior_table.ABB_ABD_log_rt_right_trial2_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT_log(Exp1_Trial_Data(si).main.order == 2 & Exp1_Trial_Data(si).main.fullem == 1 & Exp1_Trial_Data(si).main.boundary == 0  & Exp1_Trial_Data(si).main.boundary_cat_okay == 2));
    Exp1_Behavior_table.ABB_ABD_log_rt_right_trial2_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT_log(Exp1_Trial_Data(si).main.order == 2 & Exp1_Trial_Data(si).main.animalAcc == 1 & Exp1_Trial_Data(si).main.boundary == 0  & Exp1_Trial_Data(si).main.boundary_cat_okay == 2));
    Exp1_Behavior_table.ABB_ABD_log_rt_right_trial2_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT_log(Exp1_Trial_Data(si).main.order == 2 & Exp1_Trial_Data(si).main.locationAcc == 1 & Exp1_Trial_Data(si).main.boundary == 0 & Exp1_Trial_Data(si).main.boundary_cat_okay == 2));

    Exp1_Behavior_table.ABB_ABD_log_rt_right_trial3_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT_log(Exp1_Trial_Data(si).main.order == 3 & Exp1_Trial_Data(si).main.fullem == 1 & Exp1_Trial_Data(si).main.boundary == 0  & Exp1_Trial_Data(si).main.boundary_cat_okay == 2));
    Exp1_Behavior_table.ABB_ABD_log_rt_right_trial3_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT_log(Exp1_Trial_Data(si).main.order == 3 & Exp1_Trial_Data(si).main.animalAcc == 1 & Exp1_Trial_Data(si).main.boundary == 0 & Exp1_Trial_Data(si).main.boundary_cat_okay == 2));
    Exp1_Behavior_table.ABB_ABD_log_rt_right_trial3_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT_log(Exp1_Trial_Data(si).main.order == 3 & Exp1_Trial_Data(si).main.locationAcc == 1 & Exp1_Trial_Data(si).main.boundary == 0 & Exp1_Trial_Data(si).main.boundary_cat_okay == 2));


    


   if sum(Exp1_Trial_Data(si).main.categorical_Acc(Exp1_Trial_Data(si).main.boundary == 1 & Exp1_Trial_Data(si).main.boundary_cat_okay > 0,:) == 1) + sum(Exp1_Trial_Data(si).main.categorical_Acc(Exp1_Trial_Data(si).main.boundary == 1 & Exp1_Trial_Data(si).main.boundary_cat_okay > 0,:) == 0) ~= 0
        Exp1_Behavior_table.select_MBD_loc_chunking(si) = sum(Exp1_Trial_Data(si).main.categorical_Acc(Exp1_Trial_Data(si).main.boundary == 1 & Exp1_Trial_Data(si).main.boundary_cat_okay > 0,:) == 1) / (sum(Exp1_Trial_Data(si).main.categorical_Acc(Exp1_Trial_Data(si).main.boundary == 1 & Exp1_Trial_Data(si).main.boundary_cat_okay > 0,:) == 1) + sum(Exp1_Trial_Data(si).main.categorical_Acc(Exp1_Trial_Data(si).main.boundary == 1 & Exp1_Trial_Data(si).main.boundary_cat_okay > 0,:) == 0));
    else
        Exp1_Behavior_table.select_MBD_loc_chunking(si) = NaN;
   end


    Exp1_Behavior_table.select_MBD_across_acc(si) = nanmean(Exp1_Trial_Data(si).main_trial.across_acc(Exp1_Trial_Data(si).main_trial.boundary == 1  & Exp1_Trial_Data(si).main_trial.boundary_1cross_run > 0,:));
    Exp1_Behavior_table.select_MBD_within_acc(si) = nanmean(Exp1_Trial_Data(si).main_trial.within_acc(Exp1_Trial_Data(si).main_trial.boundary == 1 & Exp1_Trial_Data(si).main_trial.boundary_1cross_run > 0,:));    

    Exp1_Behavior_table.select_MBD_acc_what(si) = nanmean(Exp1_Trial_Data(si).main.what(Exp1_Trial_Data(si).main.boundary == 1 & Exp1_Trial_Data(si).main.boundary_cat_okay > 0,:));
    Exp1_Behavior_table.select_MBD_acc_whatwhen(si) = nanmean(Exp1_Trial_Data(si).main.whatwhen(Exp1_Trial_Data(si).main.boundary == 1 & Exp1_Trial_Data(si).main.boundary_cat_okay > 0,:));
    Exp1_Behavior_table.select_MBD_acc_where(si) = nanmean(Exp1_Trial_Data(si).main.where(Exp1_Trial_Data(si).main.boundary == 1 & Exp1_Trial_Data(si).main.boundary_cat_okay > 0,:));
    Exp1_Behavior_table.select_MBD_acc_wherewhen(si) = nanmean(Exp1_Trial_Data(si).main.wherewhen(Exp1_Trial_Data(si).main.boundary == 1 & Exp1_Trial_Data(si).main.boundary_cat_okay > 0,:));
    Exp1_Behavior_table.select_MBD_acc_whatwhere(si) = nanmean(Exp1_Trial_Data(si).main.whatwhere(Exp1_Trial_Data(si).main.boundary == 1 & Exp1_Trial_Data(si).main.boundary_cat_okay > 0,:));
    Exp1_Behavior_table.select_MBD_acc_fullem(si) = nanmean(Exp1_Trial_Data(si).main.fullem(Exp1_Trial_Data(si).main.boundary == 1 & Exp1_Trial_Data(si).main.boundary_cat_okay > 0,:));
    Exp1_Behavior_table.select_MBD_acc_location_cat(si) = nanmean(Exp1_Trial_Data(si).main.location_catAcc(Exp1_Trial_Data(si).main.boundary == 1 & Exp1_Trial_Data(si).main.boundary_cat_okay > 0,:));


    Exp1_Behavior_table.select_MBD_acc_loc_cat_where(si) = nanmean(Exp1_Trial_Data(si).main.location_catAcc_where(Exp1_Trial_Data(si).main.boundary == 1 & Exp1_Trial_Data(si).main.boundary_cat_okay > 0,:));
    Exp1_Behavior_table.select_MBD_acc_loc_cat_wherewhen(si) = nanmean(Exp1_Trial_Data(si).main.location_catAcc_wherewhen(Exp1_Trial_Data(si).main.boundary == 1 & Exp1_Trial_Data(si).main.boundary_cat_okay > 0,:));
    Exp1_Behavior_table.select_MBD_acc_loc_cat_whatwhere(si) = nanmean(Exp1_Trial_Data(si).main.location_catAcc_whatwhere(Exp1_Trial_Data(si).main.boundary == 1 & Exp1_Trial_Data(si).main.boundary_cat_okay > 0,:));
    Exp1_Behavior_table.select_MBD_acc_loc_cat_fullem(si) = nanmean(Exp1_Trial_Data(si).main.location_catAcc_fullem(Exp1_Trial_Data(si).main.boundary == 1 & Exp1_Trial_Data(si).main.boundary_cat_okay > 0,:));




    Exp1_Behavior_table.select_MBD_acc_wrong_loc_cat_where(si) = nanmean(Exp1_Trial_Data(si).main.location_catAcc_where(Exp1_Trial_Data(si).main.where == 0 & Exp1_Trial_Data(si).main.boundary == 1 & Exp1_Trial_Data(si).main.boundary_cat_okay > 0,:));
    Exp1_Behavior_table.select_MBD_acc_wrong_loc_cat_wherewhen(si) = nanmean(Exp1_Trial_Data(si).main.location_catAcc_wherewhen(Exp1_Trial_Data(si).main.where == 0 & Exp1_Trial_Data(si).main.boundary == 1 & Exp1_Trial_Data(si).main.boundary_cat_okay > 0,:));
    Exp1_Behavior_table.select_MBD_acc_wrong_loc_cat_whatwhere(si) = nanmean(Exp1_Trial_Data(si).main.location_catAcc_whatwhere(Exp1_Trial_Data(si).main.where == 0 & Exp1_Trial_Data(si).main.boundary == 1 & Exp1_Trial_Data(si).main.boundary_cat_okay > 0,:));
    Exp1_Behavior_table.select_MBD_acc_wrong_loc_cat_fullem(si) = nanmean(Exp1_Trial_Data(si).main.location_catAcc_fullem(Exp1_Trial_Data(si).main.where == 0 & Exp1_Trial_Data(si).main.boundary == 1 & Exp1_Trial_Data(si).main.boundary_cat_okay > 0,:));



    Exp1_Behavior_table.select_MBD_wrong_cat(si) = nanmean(Exp1_Trial_Data(si).main.location_catAcc(Exp1_Trial_Data(si).main.where == 0 & Exp1_Trial_Data(si).main.boundary == 1 & Exp1_Trial_Data(si).main.boundary_cat_okay > 0,:));    


    Exp1_Behavior_table.select_MBD_rt_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT(Exp1_Trial_Data(si).main.boundary == 1 & Exp1_Trial_Data(si).main.boundary_cat_okay > 0,:));
    Exp1_Behavior_table.select_MBD_rt_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT(Exp1_Trial_Data(si).main.boundary == 1 & Exp1_Trial_Data(si).main.boundary_cat_okay > 0,:));
    Exp1_Behavior_table.select_MBD_rt_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT(Exp1_Trial_Data(si).main.boundary == 1 & Exp1_Trial_Data(si).main.boundary_cat_okay > 0,:));


    Exp1_Behavior_table.select_MBD_rt_right_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT(Exp1_Trial_Data(si).main.boundary == 1 & Exp1_Trial_Data(si).main.boundary_cat_okay > 0 & Exp1_Trial_Data(si).main.fullem == 1,:));
    Exp1_Behavior_table.select_MBD_rt_right_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT(Exp1_Trial_Data(si).main.boundary == 1 & Exp1_Trial_Data(si).main.boundary_cat_okay > 0 & Exp1_Trial_Data(si).main.animalAcc == 1,:));
    Exp1_Behavior_table.select_MBD_rt_right_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT(Exp1_Trial_Data(si).main.boundary == 1 & Exp1_Trial_Data(si).main.boundary_cat_okay > 0 & Exp1_Trial_Data(si).main.locationAcc == 1,:));


    Exp1_Behavior_table.select_MBD_log_rt_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT_log(Exp1_Trial_Data(si).main.boundary == 1 & Exp1_Trial_Data(si).main.boundary_cat_okay > 0,:));
    Exp1_Behavior_table.select_MBD_log_rt_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT_log(Exp1_Trial_Data(si).main.boundary == 1 & Exp1_Trial_Data(si).main.boundary_cat_okay > 0,:));
    Exp1_Behavior_table.select_MBD_log_rt_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT_log(Exp1_Trial_Data(si).main.boundary == 1 & Exp1_Trial_Data(si).main.boundary_cat_okay > 0,:));


    Exp1_Behavior_table.select_MBD_log_rt_right_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT_log(Exp1_Trial_Data(si).main.boundary == 1 & Exp1_Trial_Data(si).main.boundary_cat_okay > 0 & Exp1_Trial_Data(si).main.fullem == 1,:));
    Exp1_Behavior_table.select_MBD_log_rt_right_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT_log(Exp1_Trial_Data(si).main.boundary == 1 & Exp1_Trial_Data(si).main.boundary_cat_okay > 0 & Exp1_Trial_Data(si).main.animalAcc == 1,:));
    Exp1_Behavior_table.select_MBD_log_rt_right_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT_log(Exp1_Trial_Data(si).main.boundary == 1 & Exp1_Trial_Data(si).main.boundary_cat_okay > 0 & Exp1_Trial_Data(si).main.locationAcc == 1,:));


    Exp1_Behavior_table.AAB_MBD_log_rt_trial1_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT_log(Exp1_Trial_Data(si).main.order == 1 & Exp1_Trial_Data(si).main.boundary == 1  & Exp1_Trial_Data(si).main.boundary_cat_okay == 1));
    Exp1_Behavior_table.AAB_MBD_log_rt_trial1_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT_log(Exp1_Trial_Data(si).main.order == 1 & Exp1_Trial_Data(si).main.boundary == 1  & Exp1_Trial_Data(si).main.boundary_cat_okay == 1));
    Exp1_Behavior_table.AAB_MBD_log_rt_trial1_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT_log(Exp1_Trial_Data(si).main.order == 1 & Exp1_Trial_Data(si).main.boundary == 1  & Exp1_Trial_Data(si).main.boundary_cat_okay == 1));

    Exp1_Behavior_table.AAB_MBD_log_rt_trial2_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT_log(Exp1_Trial_Data(si).main.order == 2 & Exp1_Trial_Data(si).main.boundary == 1  & Exp1_Trial_Data(si).main.boundary_cat_okay == 1));
    Exp1_Behavior_table.AAB_MBD_log_rt_trial2_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT_log(Exp1_Trial_Data(si).main.order == 2 & Exp1_Trial_Data(si).main.boundary == 1  & Exp1_Trial_Data(si).main.boundary_cat_okay == 1));
    Exp1_Behavior_table.AAB_MBD_log_rt_trial2_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT_log(Exp1_Trial_Data(si).main.order == 2 & Exp1_Trial_Data(si).main.boundary == 1  & Exp1_Trial_Data(si).main.boundary_cat_okay == 1));

    Exp1_Behavior_table.AAB_MBD_log_rt_trial3_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT_log(Exp1_Trial_Data(si).main.order == 3 & Exp1_Trial_Data(si).main.boundary == 1  & Exp1_Trial_Data(si).main.boundary_cat_okay == 1));
    Exp1_Behavior_table.AAB_MBD_log_rt_trial3_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT_log(Exp1_Trial_Data(si).main.order == 3 & Exp1_Trial_Data(si).main.boundary == 1  & Exp1_Trial_Data(si).main.boundary_cat_okay == 1));
    Exp1_Behavior_table.AAB_MBD_log_rt_trial3_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT_log(Exp1_Trial_Data(si).main.order == 3 & Exp1_Trial_Data(si).main.boundary == 1  & Exp1_Trial_Data(si).main.boundary_cat_okay == 1));

    Exp1_Behavior_table.AAB_MBD_log_rt_right_trial1_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT_log(Exp1_Trial_Data(si).main.order == 1  & Exp1_Trial_Data(si).main.fullem == 1 & Exp1_Trial_Data(si).main.boundary == 1  & Exp1_Trial_Data(si).main.boundary_cat_okay == 1));
    Exp1_Behavior_table.AAB_MBD_log_rt_right_trial1_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT_log(Exp1_Trial_Data(si).main.order == 1 & Exp1_Trial_Data(si).main.animalAcc == 1 & Exp1_Trial_Data(si).main.boundary == 1  & Exp1_Trial_Data(si).main.boundary_cat_okay == 1));
    Exp1_Behavior_table.AAB_MBD_log_rt_right_trial1_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT_log(Exp1_Trial_Data(si).main.order == 1  & Exp1_Trial_Data(si).main.locationAcc == 1 & Exp1_Trial_Data(si).main.boundary == 1  & Exp1_Trial_Data(si).main.boundary_cat_okay == 1));

    Exp1_Behavior_table.AAB_MBD_log_rt_right_trial2_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT_log(Exp1_Trial_Data(si).main.order == 2 & Exp1_Trial_Data(si).main.fullem == 1 & Exp1_Trial_Data(si).main.boundary == 1  & Exp1_Trial_Data(si).main.boundary_cat_okay == 1));
    Exp1_Behavior_table.AAB_MBD_log_rt_right_trial2_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT_log(Exp1_Trial_Data(si).main.order == 2 & Exp1_Trial_Data(si).main.animalAcc == 1 & Exp1_Trial_Data(si).main.boundary == 1  & Exp1_Trial_Data(si).main.boundary_cat_okay == 1));
    Exp1_Behavior_table.AAB_MBD_log_rt_right_trial2_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT_log(Exp1_Trial_Data(si).main.order == 2 & Exp1_Trial_Data(si).main.locationAcc == 1 & Exp1_Trial_Data(si).main.boundary == 1 & Exp1_Trial_Data(si).main.boundary_cat_okay == 1));

    Exp1_Behavior_table.AAB_MBD_log_rt_right_trial3_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT_log(Exp1_Trial_Data(si).main.order == 3 & Exp1_Trial_Data(si).main.fullem == 1 & Exp1_Trial_Data(si).main.boundary == 1  & Exp1_Trial_Data(si).main.boundary_cat_okay == 1));
    Exp1_Behavior_table.AAB_MBD_log_rt_right_trial3_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT_log(Exp1_Trial_Data(si).main.order == 3 & Exp1_Trial_Data(si).main.animalAcc == 1 & Exp1_Trial_Data(si).main.boundary == 1 & Exp1_Trial_Data(si).main.boundary_cat_okay == 1));
    Exp1_Behavior_table.AAB_MBD_log_rt_right_trial3_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT_log(Exp1_Trial_Data(si).main.order == 3 & Exp1_Trial_Data(si).main.locationAcc == 1 & Exp1_Trial_Data(si).main.boundary == 1 & Exp1_Trial_Data(si).main.boundary_cat_okay == 1));


    
    Exp1_Behavior_table.ABB_MBD_log_rt_trial1_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT_log(Exp1_Trial_Data(si).main.order == 1 & Exp1_Trial_Data(si).main.boundary == 1  & Exp1_Trial_Data(si).main.boundary_cat_okay == 2));
    Exp1_Behavior_table.ABB_MBD_log_rt_trial1_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT_log(Exp1_Trial_Data(si).main.order == 1 & Exp1_Trial_Data(si).main.boundary == 1  & Exp1_Trial_Data(si).main.boundary_cat_okay == 2));
    Exp1_Behavior_table.ABB_MBD_log_rt_trial1_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT_log(Exp1_Trial_Data(si).main.order == 1 & Exp1_Trial_Data(si).main.boundary == 1  & Exp1_Trial_Data(si).main.boundary_cat_okay == 2));

    Exp1_Behavior_table.ABB_MBD_log_rt_trial2_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT_log(Exp1_Trial_Data(si).main.order == 2 & Exp1_Trial_Data(si).main.boundary == 1  & Exp1_Trial_Data(si).main.boundary_cat_okay == 2));
    Exp1_Behavior_table.ABB_MBD_log_rt_trial2_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT_log(Exp1_Trial_Data(si).main.order == 2 & Exp1_Trial_Data(si).main.boundary == 1  & Exp1_Trial_Data(si).main.boundary_cat_okay == 2));
    Exp1_Behavior_table.ABB_MBD_log_rt_trial2_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT_log(Exp1_Trial_Data(si).main.order == 2 & Exp1_Trial_Data(si).main.boundary == 1  & Exp1_Trial_Data(si).main.boundary_cat_okay == 2));

    Exp1_Behavior_table.ABB_MBD_log_rt_trial3_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT_log(Exp1_Trial_Data(si).main.order == 3 & Exp1_Trial_Data(si).main.boundary == 1  & Exp1_Trial_Data(si).main.boundary_cat_okay == 2));
    Exp1_Behavior_table.ABB_MBD_log_rt_trial3_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT_log(Exp1_Trial_Data(si).main.order == 3 & Exp1_Trial_Data(si).main.boundary == 1  & Exp1_Trial_Data(si).main.boundary_cat_okay == 2));
    Exp1_Behavior_table.ABB_MBD_log_rt_trial3_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT_log(Exp1_Trial_Data(si).main.order == 3 & Exp1_Trial_Data(si).main.boundary == 1  & Exp1_Trial_Data(si).main.boundary_cat_okay == 2));

    Exp1_Behavior_table.ABB_MBD_log_rt_right_trial1_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT_log(Exp1_Trial_Data(si).main.order == 1  & Exp1_Trial_Data(si).main.fullem == 1 & Exp1_Trial_Data(si).main.boundary == 1  & Exp1_Trial_Data(si).main.boundary_cat_okay == 2));
    Exp1_Behavior_table.ABB_MBD_log_rt_right_trial1_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT_log(Exp1_Trial_Data(si).main.order == 1 & Exp1_Trial_Data(si).main.animalAcc == 1 & Exp1_Trial_Data(si).main.boundary == 1  & Exp1_Trial_Data(si).main.boundary_cat_okay == 2));
    Exp1_Behavior_table.ABB_MBD_log_rt_right_trial1_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT_log(Exp1_Trial_Data(si).main.order == 1  & Exp1_Trial_Data(si).main.locationAcc == 1 & Exp1_Trial_Data(si).main.boundary == 1  & Exp1_Trial_Data(si).main.boundary_cat_okay == 2));

    Exp1_Behavior_table.ABB_MBD_log_rt_right_trial2_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT_log(Exp1_Trial_Data(si).main.order == 2 & Exp1_Trial_Data(si).main.fullem == 1 & Exp1_Trial_Data(si).main.boundary == 1  & Exp1_Trial_Data(si).main.boundary_cat_okay == 2));
    Exp1_Behavior_table.ABB_MBD_log_rt_right_trial2_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT_log(Exp1_Trial_Data(si).main.order == 2 & Exp1_Trial_Data(si).main.animalAcc == 1 & Exp1_Trial_Data(si).main.boundary == 1  & Exp1_Trial_Data(si).main.boundary_cat_okay == 2));
    Exp1_Behavior_table.ABB_MBD_log_rt_right_trial2_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT_log(Exp1_Trial_Data(si).main.order == 2 & Exp1_Trial_Data(si).main.locationAcc == 1 & Exp1_Trial_Data(si).main.boundary == 1 & Exp1_Trial_Data(si).main.boundary_cat_okay == 2));

    Exp1_Behavior_table.ABB_MBD_log_rt_right_trial3_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT_log(Exp1_Trial_Data(si).main.order == 3 & Exp1_Trial_Data(si).main.fullem == 1 & Exp1_Trial_Data(si).main.boundary == 1  & Exp1_Trial_Data(si).main.boundary_cat_okay == 2));
    Exp1_Behavior_table.ABB_MBD_log_rt_right_trial3_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT_log(Exp1_Trial_Data(si).main.order == 3 & Exp1_Trial_Data(si).main.animalAcc == 1 & Exp1_Trial_Data(si).main.boundary == 1 & Exp1_Trial_Data(si).main.boundary_cat_okay == 2));
    Exp1_Behavior_table.ABB_MBD_log_rt_right_trial3_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT_log(Exp1_Trial_Data(si).main.order == 3 & Exp1_Trial_Data(si).main.locationAcc == 1 & Exp1_Trial_Data(si).main.boundary == 1 & Exp1_Trial_Data(si).main.boundary_cat_okay == 2));






    % crossing 0
    Exp1_Behavior_table.cross0_acc_what(si) = nanmean(Exp1_Trial_Data(si).main.what(Exp1_Trial_Data(si).main.boundary_crossing == 0 ,:));
    Exp1_Behavior_table.cross0_acc_whatwhen(si) = nanmean(Exp1_Trial_Data(si).main.whatwhen(Exp1_Trial_Data(si).main.boundary_crossing == 0 ,:));
    Exp1_Behavior_table.cross0_acc_where(si) = nanmean(Exp1_Trial_Data(si).main.where(Exp1_Trial_Data(si).main.boundary_crossing == 0  ,:));
    Exp1_Behavior_table.cross0_acc_wherewhen(si) = nanmean(Exp1_Trial_Data(si).main.wherewhen(Exp1_Trial_Data(si).main.boundary_crossing == 0 ,:));
    Exp1_Behavior_table.cross0_acc_whatwhere(si) = nanmean(Exp1_Trial_Data(si).main.whatwhere(Exp1_Trial_Data(si).main.boundary_crossing == 0 ,:));
    Exp1_Behavior_table.cross0_acc_fullem(si) = nanmean(Exp1_Trial_Data(si).main.fullem(Exp1_Trial_Data(si).main.boundary_crossing == 0 ,:));

    Exp1_Behavior_table.cross0_acc_loc_cat_where(si) = nanmean(Exp1_Trial_Data(si).main.location_catAcc_where(Exp1_Trial_Data(si).main.boundary_crossing == 0  ,:));
    Exp1_Behavior_table.cross0_acc_loc_cat_wherewhen(si) = nanmean(Exp1_Trial_Data(si).main.location_catAcc_wherewhen(Exp1_Trial_Data(si).main.boundary_crossing == 0 ,:));
    Exp1_Behavior_table.cross0_acc_loc_cat_whatwhere(si) = nanmean(Exp1_Trial_Data(si).main.location_catAcc_whatwhere(Exp1_Trial_Data(si).main.boundary_crossing == 0 ,:));
    Exp1_Behavior_table.cross0_acc_loc_cat_fullem(si) = nanmean(Exp1_Trial_Data(si).main.location_catAcc_fullem(Exp1_Trial_Data(si).main.boundary_crossing == 0 ,:));


    Exp1_Behavior_table.cross0_rt_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT(Exp1_Trial_Data(si).main.boundary_crossing == 0 ,:));
    Exp1_Behavior_table.cross0_rt_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT(Exp1_Trial_Data(si).main.boundary_crossing == 0 ,:));
    Exp1_Behavior_table.cross0_rt_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT(Exp1_Trial_Data(si).main.boundary_crossing == 0 ,:));

    Exp1_Behavior_table.cross0_ABD_acc_what(si) = nanmean(Exp1_Trial_Data(si).main.what(Exp1_Trial_Data(si).main.boundary == 0 & Exp1_Trial_Data(si).main.boundary_crossing == 0 ,:));
    Exp1_Behavior_table.cross0_ABD_acc_whatwhen(si) = nanmean(Exp1_Trial_Data(si).main.whatwhen(Exp1_Trial_Data(si).main.boundary == 0 & Exp1_Trial_Data(si).main.boundary_crossing == 0,:));
    Exp1_Behavior_table.cross0_ABD_acc_where(si) = nanmean(Exp1_Trial_Data(si).main.where(Exp1_Trial_Data(si).main.boundary == 0 & Exp1_Trial_Data(si).main.boundary_crossing == 0,:));
    Exp1_Behavior_table.cross0_ABD_acc_wherewhen(si) = nanmean(Exp1_Trial_Data(si).main.wherewhen(Exp1_Trial_Data(si).main.boundary == 0 & Exp1_Trial_Data(si).main.boundary_crossing == 0,:));
    Exp1_Behavior_table.cross0_ABD_acc_whatwhere(si) = nanmean(Exp1_Trial_Data(si).main.whatwhere(Exp1_Trial_Data(si).main.boundary == 0 & Exp1_Trial_Data(si).main.boundary_crossing == 0,:));
    Exp1_Behavior_table.cross0_ABD_acc_fullem(si) = nanmean(Exp1_Trial_Data(si).main.fullem(Exp1_Trial_Data(si).main.boundary == 0 & Exp1_Trial_Data(si).main.boundary_crossing == 0,:));
    Exp1_Behavior_table.cross0_ABD_acc_location_cat(si) = nanmean(Exp1_Trial_Data(si).main.location_catAcc(Exp1_Trial_Data(si).main.boundary == 0 & Exp1_Trial_Data(si).main.boundary_crossing == 0,:));


    Exp1_Behavior_table.cross0_ABD_wrong_cat(si) = nanmean(Exp1_Trial_Data(si).main.location_catAcc(Exp1_Trial_Data(si).main.where == 0 & Exp1_Trial_Data(si).main.boundary == 0 & Exp1_Trial_Data(si).main.boundary_crossing == 0,:));    
    


    Exp1_Behavior_table.cross0_ABD_rt_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT(Exp1_Trial_Data(si).main.boundary == 0 & Exp1_Trial_Data(si).main.boundary_crossing == 0,:));
    Exp1_Behavior_table.cross0_ABD_rt_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT(Exp1_Trial_Data(si).main.boundary == 0 & Exp1_Trial_Data(si).main.boundary_crossing == 0,:));
    Exp1_Behavior_table.cross0_ABD_rt_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT(Exp1_Trial_Data(si).main.boundary == 0 & Exp1_Trial_Data(si).main.boundary_crossing == 0,:));

    Exp1_Behavior_table.cross0_ABD_rt_right_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT(Exp1_Trial_Data(si).main.boundary == 0 & Exp1_Trial_Data(si).main.boundary_crossing == 0 & Exp1_Trial_Data(si).main.fullem == 1,:));
    Exp1_Behavior_table.cross0_ABD_rt_right_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT(Exp1_Trial_Data(si).main.boundary == 0 & Exp1_Trial_Data(si).main.boundary_crossing == 0 & Exp1_Trial_Data(si).main.animalAcc == 1,:));
    Exp1_Behavior_table.cross0_ABD_rt_right_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT(Exp1_Trial_Data(si).main.boundary == 0 & Exp1_Trial_Data(si).main.boundary_crossing == 0 & Exp1_Trial_Data(si).main.locationAcc == 1,:));



    Exp1_Behavior_table.cross0_MBD_acc_what(si) = nanmean(Exp1_Trial_Data(si).main.what(Exp1_Trial_Data(si).main.boundary == 1 & Exp1_Trial_Data(si).main.boundary_crossing == 0,:));
    Exp1_Behavior_table.cross0_MBD_acc_whatwhen(si) = nanmean(Exp1_Trial_Data(si).main.whatwhen(Exp1_Trial_Data(si).main.boundary == 1 & Exp1_Trial_Data(si).main.boundary_crossing == 0,:));
    Exp1_Behavior_table.cross0_MBD_acc_where(si) = nanmean(Exp1_Trial_Data(si).main.where(Exp1_Trial_Data(si).main.boundary == 1 & Exp1_Trial_Data(si).main.boundary_crossing == 0,:));
    Exp1_Behavior_table.cross0_MBD_acc_wherewhen(si) = nanmean(Exp1_Trial_Data(si).main.wherewhen(Exp1_Trial_Data(si).main.boundary == 1 & Exp1_Trial_Data(si).main.boundary_crossing == 0,:));
    Exp1_Behavior_table.cross0_MBD_acc_whatwhere(si) = nanmean(Exp1_Trial_Data(si).main.whatwhere(Exp1_Trial_Data(si).main.boundary == 1 & Exp1_Trial_Data(si).main.boundary_crossing == 0,:));
    Exp1_Behavior_table.cross0_MBD_acc_fullem(si) = nanmean(Exp1_Trial_Data(si).main.fullem(Exp1_Trial_Data(si).main.boundary == 1 & Exp1_Trial_Data(si).main.boundary_crossing == 0,:));
    Exp1_Behavior_table.cross0_MBD_acc_location_cat(si) = nanmean(Exp1_Trial_Data(si).main.location_catAcc(Exp1_Trial_Data(si).main.boundary == 1 & Exp1_Trial_Data(si).main.boundary_crossing == 0,:));

    Exp1_Behavior_table.cross0_MBD_wrong_cat(si) = nanmean(Exp1_Trial_Data(si).main.location_catAcc(Exp1_Trial_Data(si).main.where == 0 & Exp1_Trial_Data(si).main.boundary == 1 & Exp1_Trial_Data(si).main.boundary_crossing == 0,:));    
    


    Exp1_Behavior_table.cross0_MBD_rt_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT(Exp1_Trial_Data(si).main.boundary == 1 & Exp1_Trial_Data(si).main.boundary_crossing == 0,:));
    Exp1_Behavior_table.cross0_MBD_rt_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT(Exp1_Trial_Data(si).main.boundary == 1 & Exp1_Trial_Data(si).main.boundary_crossing == 0,:));
    Exp1_Behavior_table.cross0_MBD_rt_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT(Exp1_Trial_Data(si).main.boundary == 1 & Exp1_Trial_Data(si).main.boundary_crossing == 0,:));


    Exp1_Behavior_table.cross0_MBD_rt_right_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT(Exp1_Trial_Data(si).main.boundary == 1 & Exp1_Trial_Data(si).main.boundary_crossing == 0 & Exp1_Trial_Data(si).main.fullem == 1,:));
    Exp1_Behavior_table.cross0_MBD_rt_right_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT(Exp1_Trial_Data(si).main.boundary == 1 & Exp1_Trial_Data(si).main.boundary_crossing == 0 & Exp1_Trial_Data(si).main.animalAcc == 1,:));
    Exp1_Behavior_table.cross0_MBD_rt_right_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT(Exp1_Trial_Data(si).main.boundary == 1 & Exp1_Trial_Data(si).main.boundary_crossing == 0 & Exp1_Trial_Data(si).main.locationAcc == 1,:));


    % bnd index 
    Exp1_Behavior_table.cross0_MBD_ABD_acc_what(si) = Exp1_Behavior_table.cross0_MBD_acc_what(si) - Exp1_Behavior_table.cross0_ABD_acc_what(si);
    Exp1_Behavior_table.cross0_MBD_ABD_acc_whatwhen(si) = Exp1_Behavior_table.cross0_MBD_acc_whatwhen(si) - Exp1_Behavior_table.cross0_ABD_acc_whatwhen(si);
    Exp1_Behavior_table.cross0_MBD_ABD_acc_where(si) = Exp1_Behavior_table.cross0_MBD_acc_where(si) - Exp1_Behavior_table.cross0_ABD_acc_where(si);
    Exp1_Behavior_table.cross0_MBD_ABD_acc_wherewhen(si) = Exp1_Behavior_table.cross0_MBD_acc_wherewhen(si) - Exp1_Behavior_table.cross0_ABD_acc_wherewhen(si);
    Exp1_Behavior_table.cross0_MBD_ABD_acc_whatwhere(si) = Exp1_Behavior_table.cross0_MBD_acc_whatwhere(si) - Exp1_Behavior_table.cross0_ABD_acc_whatwhere(si);
    Exp1_Behavior_table.cross0_MBD_ABD_acc_fullem(si) = Exp1_Behavior_table.cross0_MBD_acc_fullem(si) - Exp1_Behavior_table.cross0_ABD_acc_fullem(si);
                        




    % crossing 2

    Exp1_Behavior_table.cross2_acc_what(si) = nanmean(Exp1_Trial_Data(si).main.what(Exp1_Trial_Data(si).main.boundary_crossing == 2 ,:));
    Exp1_Behavior_table.cross2_acc_whatwhen(si) = nanmean(Exp1_Trial_Data(si).main.whatwhen(Exp1_Trial_Data(si).main.boundary_crossing == 2 ,:));
    Exp1_Behavior_table.cross2_acc_where(si) = nanmean(Exp1_Trial_Data(si).main.where(Exp1_Trial_Data(si).main.boundary_crossing == 2 ,:));
    Exp1_Behavior_table.cross2_acc_wherewhen(si) = nanmean(Exp1_Trial_Data(si).main.wherewhen(Exp1_Trial_Data(si).main.boundary_crossing == 2 ,:));
    Exp1_Behavior_table.cross2_acc_whatwhere(si) = nanmean(Exp1_Trial_Data(si).main.whatwhere(Exp1_Trial_Data(si).main.boundary_crossing == 2 ,:));
    Exp1_Behavior_table.cross2_acc_fullem(si) = nanmean(Exp1_Trial_Data(si).main.fullem(Exp1_Trial_Data(si).main.boundary_crossing == 2 ,:));

    Exp1_Behavior_table.cross2_rt_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT(Exp1_Trial_Data(si).main.boundary_crossing == 2 ,:));
    Exp1_Behavior_table.cross2_rt_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT(Exp1_Trial_Data(si).main.boundary_crossing == 2 ,:));
    Exp1_Behavior_table.cross2_rt_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT(Exp1_Trial_Data(si).main.boundary_crossing == 2 ,:));

    Exp1_Behavior_table.cross2_ABD_acc_what(si) = nanmean(Exp1_Trial_Data(si).main.what(Exp1_Trial_Data(si).main.boundary == 0 & Exp1_Trial_Data(si).main.boundary_crossing == 2 ,:));
    Exp1_Behavior_table.cross2_ABD_acc_whatwhen(si) = nanmean(Exp1_Trial_Data(si).main.whatwhen(Exp1_Trial_Data(si).main.boundary == 0 & Exp1_Trial_Data(si).main.boundary_crossing == 2,:));
    Exp1_Behavior_table.cross2_ABD_acc_where(si) = nanmean(Exp1_Trial_Data(si).main.where(Exp1_Trial_Data(si).main.boundary == 0 & Exp1_Trial_Data(si).main.boundary_crossing == 2,:));
    Exp1_Behavior_table.cross2_ABD_acc_wherewhen(si) = nanmean(Exp1_Trial_Data(si).main.wherewhen(Exp1_Trial_Data(si).main.boundary == 0 & Exp1_Trial_Data(si).main.boundary_crossing == 2,:));
    Exp1_Behavior_table.cross2_ABD_acc_whatwhere(si) = nanmean(Exp1_Trial_Data(si).main.whatwhere(Exp1_Trial_Data(si).main.boundary == 0 & Exp1_Trial_Data(si).main.boundary_crossing == 2,:));
    Exp1_Behavior_table.cross2_ABD_acc_fullem(si) = nanmean(Exp1_Trial_Data(si).main.fullem(Exp1_Trial_Data(si).main.boundary == 0 & Exp1_Trial_Data(si).main.boundary_crossing == 2,:));
    Exp1_Behavior_table.cross2_ABD_acc_location_cat(si) = nanmean(Exp1_Trial_Data(si).main.location_catAcc(Exp1_Trial_Data(si).main.boundary == 0 & Exp1_Trial_Data(si).main.boundary_crossing == 2,:));

    Exp1_Behavior_table.cross2_ABD_rt_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT(Exp1_Trial_Data(si).main.boundary == 0 & Exp1_Trial_Data(si).main.boundary_crossing == 2,:));
    Exp1_Behavior_table.cross2_ABD_rt_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT(Exp1_Trial_Data(si).main.boundary == 0 & Exp1_Trial_Data(si).main.boundary_crossing == 2,:));
    Exp1_Behavior_table.cross2_ABD_rt_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT(Exp1_Trial_Data(si).main.boundary == 0 & Exp1_Trial_Data(si).main.boundary_crossing == 2,:));

    Exp1_Behavior_table.cross2_ABD_rt_right_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT(Exp1_Trial_Data(si).main.boundary == 0 & Exp1_Trial_Data(si).main.boundary_crossing == 2 & Exp1_Trial_Data(si).main.fullem == 1,:));
    Exp1_Behavior_table.cross2_ABD_rt_right_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT(Exp1_Trial_Data(si).main.boundary == 0 & Exp1_Trial_Data(si).main.boundary_crossing == 2 & Exp1_Trial_Data(si).main.animalAcc == 1,:));
    Exp1_Behavior_table.cross2_ABD_rt_right_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT(Exp1_Trial_Data(si).main.boundary == 0 & Exp1_Trial_Data(si).main.boundary_crossing == 2 & Exp1_Trial_Data(si).main.locationAcc == 1,:));



    Exp1_Behavior_table.cross2_MBD_acc_what(si) = nanmean(Exp1_Trial_Data(si).main.what(Exp1_Trial_Data(si).main.boundary == 1 & Exp1_Trial_Data(si).main.boundary_crossing == 2,:));
    Exp1_Behavior_table.cross2_MBD_acc_whatwhen(si) = nanmean(Exp1_Trial_Data(si).main.whatwhen(Exp1_Trial_Data(si).main.boundary == 1 & Exp1_Trial_Data(si).main.boundary_crossing == 2,:));
    Exp1_Behavior_table.cross2_MBD_acc_where(si) = nanmean(Exp1_Trial_Data(si).main.where(Exp1_Trial_Data(si).main.boundary == 1 & Exp1_Trial_Data(si).main.boundary_crossing == 2,:));
    Exp1_Behavior_table.cross2_MBD_acc_wherewhen(si) = nanmean(Exp1_Trial_Data(si).main.wherewhen(Exp1_Trial_Data(si).main.boundary == 1 & Exp1_Trial_Data(si).main.boundary_crossing == 2,:));
    Exp1_Behavior_table.cross2_MBD_acc_whatwhere(si) = nanmean(Exp1_Trial_Data(si).main.whatwhere(Exp1_Trial_Data(si).main.boundary == 1 & Exp1_Trial_Data(si).main.boundary_crossing == 2,:));
    Exp1_Behavior_table.cross2_MBD_acc_fullem(si) = nanmean(Exp1_Trial_Data(si).main.fullem(Exp1_Trial_Data(si).main.boundary == 1 & Exp1_Trial_Data(si).main.boundary_crossing == 2,:));
    Exp1_Behavior_table.cross2_MBD_acc_location_cat(si) = nanmean(Exp1_Trial_Data(si).main.location_catAcc(Exp1_Trial_Data(si).main.boundary == 1 & Exp1_Trial_Data(si).main.boundary_crossing == 2,:));

    Exp1_Behavior_table.cross2_MBD_rt_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT(Exp1_Trial_Data(si).main.boundary == 1 & Exp1_Trial_Data(si).main.boundary_crossing == 2,:));
    Exp1_Behavior_table.cross2_MBD_rt_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT(Exp1_Trial_Data(si).main.boundary == 1 & Exp1_Trial_Data(si).main.boundary_crossing == 2,:));
    Exp1_Behavior_table.cross2_MBD_rt_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT(Exp1_Trial_Data(si).main.boundary == 1 & Exp1_Trial_Data(si).main.boundary_crossing == 2,:));


    Exp1_Behavior_table.cross2_MBD_rt_right_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT(Exp1_Trial_Data(si).main.boundary == 1 & Exp1_Trial_Data(si).main.boundary_crossing == 2 & Exp1_Trial_Data(si).main.fullem == 1,:));
    Exp1_Behavior_table.cross2_MBD_rt_right_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT(Exp1_Trial_Data(si).main.boundary == 1 & Exp1_Trial_Data(si).main.boundary_crossing == 2 & Exp1_Trial_Data(si).main.animalAcc == 1,:));
    Exp1_Behavior_table.cross2_MBD_rt_right_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT(Exp1_Trial_Data(si).main.boundary == 1 & Exp1_Trial_Data(si).main.boundary_crossing == 2 & Exp1_Trial_Data(si).main.locationAcc == 1,:));


    % crossing 0 & 2
    Exp1_Behavior_table.cross0and2_acc_what(si) = nanmean(Exp1_Trial_Data(si).main.what(ismember(Exp1_Trial_Data(si).main.boundary_crossing, [0, 2]) ,:));
    Exp1_Behavior_table.cross0and2_acc_whatwhen(si) = nanmean(Exp1_Trial_Data(si).main.whatwhen(ismember(Exp1_Trial_Data(si).main.boundary_crossing, [0, 2]) ,:));
    Exp1_Behavior_table.cross0and2_acc_where(si) = nanmean(Exp1_Trial_Data(si).main.where(ismember(Exp1_Trial_Data(si).main.boundary_crossing, [0, 2]) ,:));
    Exp1_Behavior_table.cross0and2_acc_wherewhen(si) = nanmean(Exp1_Trial_Data(si).main.wherewhen(ismember(Exp1_Trial_Data(si).main.boundary_crossing, [0, 2]),:));
    Exp1_Behavior_table.cross0and2_acc_whatwhere(si) = nanmean(Exp1_Trial_Data(si).main.whatwhere(ismember(Exp1_Trial_Data(si).main.boundary_crossing, [0, 2]),:));
    Exp1_Behavior_table.cross0and2_acc_fullem(si) = nanmean(Exp1_Trial_Data(si).main.fullem(ismember(Exp1_Trial_Data(si).main.boundary_crossing, [0, 2]),:));


    Exp1_Behavior_table.cross0and2_rt_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT(ismember(Exp1_Trial_Data(si).main.boundary_crossing, [0, 2]) ,:));
    Exp1_Behavior_table.cross0and2_rt_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT(ismember(Exp1_Trial_Data(si).main.boundary_crossing, [0, 2]) ,:));
    Exp1_Behavior_table.cross0and2_rt_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT(ismember(Exp1_Trial_Data(si).main.boundary_crossing, [0, 2]) ,:));

    Exp1_Behavior_table.cross0and2_ABD_acc_what(si) = nanmean(Exp1_Trial_Data(si).main.what(Exp1_Trial_Data(si).main.boundary == 0 & ismember(Exp1_Trial_Data(si).main.boundary_crossing, [0, 2]) ,:));
    Exp1_Behavior_table.cross0and2_ABD_acc_whatwhen(si) = nanmean(Exp1_Trial_Data(si).main.whatwhen(Exp1_Trial_Data(si).main.boundary == 0 & ismember(Exp1_Trial_Data(si).main.boundary_crossing, [0, 2]),:));
    Exp1_Behavior_table.cross0and2_ABD_acc_where(si) = nanmean(Exp1_Trial_Data(si).main.where(Exp1_Trial_Data(si).main.boundary == 0 & ismember(Exp1_Trial_Data(si).main.boundary_crossing, [0, 2]),:));
    Exp1_Behavior_table.cross0and2_ABD_acc_wherewhen(si) = nanmean(Exp1_Trial_Data(si).main.wherewhen(Exp1_Trial_Data(si).main.boundary == 0 & ismember(Exp1_Trial_Data(si).main.boundary_crossing, [0, 2]),:));
    Exp1_Behavior_table.cross0and2_ABD_acc_whatwhere(si) = nanmean(Exp1_Trial_Data(si).main.whatwhere(Exp1_Trial_Data(si).main.boundary == 0 & ismember(Exp1_Trial_Data(si).main.boundary_crossing, [0, 2]),:));
    Exp1_Behavior_table.cross0and2_ABD_acc_fullem(si) = nanmean(Exp1_Trial_Data(si).main.fullem(Exp1_Trial_Data(si).main.boundary == 0 & ismember(Exp1_Trial_Data(si).main.boundary_crossing, [0, 2]),:));
    Exp1_Behavior_table.cross0and2_ABD_acc_location_cat(si) = nanmean(Exp1_Trial_Data(si).main.location_catAcc(Exp1_Trial_Data(si).main.boundary == 0 & ismember(Exp1_Trial_Data(si).main.boundary_crossing, [0, 2]),:));

    Exp1_Behavior_table.cross0and2_ABD_rt_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT(Exp1_Trial_Data(si).main.boundary == 0 & ismember(Exp1_Trial_Data(si).main.boundary_crossing, [0, 2]),:));
    Exp1_Behavior_table.cross0and2_ABD_rt_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT(Exp1_Trial_Data(si).main.boundary == 0 & ismember(Exp1_Trial_Data(si).main.boundary_crossing, [0, 2]),:));
    Exp1_Behavior_table.cross0and2_ABD_rt_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT(Exp1_Trial_Data(si).main.boundary == 0 & ismember(Exp1_Trial_Data(si).main.boundary_crossing, [0, 2]),:));

    Exp1_Behavior_table.cross0and2_ABD_rt_right_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT(Exp1_Trial_Data(si).main.boundary == 0 & ismember(Exp1_Trial_Data(si).main.boundary_crossing, [0, 2]) & Exp1_Trial_Data(si).main.fullem == 1,:));
    Exp1_Behavior_table.cross0and2_ABD_rt_right_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT(Exp1_Trial_Data(si).main.boundary == 0 & ismember(Exp1_Trial_Data(si).main.boundary_crossing, [0, 2]) & Exp1_Trial_Data(si).main.animalAcc == 1,:));
    Exp1_Behavior_table.cross0and2_ABD_rt_right_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT(Exp1_Trial_Data(si).main.boundary == 0 & ismember(Exp1_Trial_Data(si).main.boundary_crossing, [0, 2]) & Exp1_Trial_Data(si).main.locationAcc == 1,:));



    Exp1_Behavior_table.cross0and2_MBD_acc_what(si) = nanmean(Exp1_Trial_Data(si).main.what(Exp1_Trial_Data(si).main.boundary == 1 & ismember(Exp1_Trial_Data(si).main.boundary_crossing, [0, 2]),:));
    Exp1_Behavior_table.cross0and2_MBD_acc_whatwhen(si) = nanmean(Exp1_Trial_Data(si).main.whatwhen(Exp1_Trial_Data(si).main.boundary == 1 & ismember(Exp1_Trial_Data(si).main.boundary_crossing, [0, 2]),:));
    Exp1_Behavior_table.cross0and2_MBD_acc_where(si) = nanmean(Exp1_Trial_Data(si).main.where(Exp1_Trial_Data(si).main.boundary == 1 & ismember(Exp1_Trial_Data(si).main.boundary_crossing, [0, 2]),:));
    Exp1_Behavior_table.cross0and2_MBD_acc_wherewhen(si) = nanmean(Exp1_Trial_Data(si).main.wherewhen(Exp1_Trial_Data(si).main.boundary == 1 & ismember(Exp1_Trial_Data(si).main.boundary_crossing, [0, 2]),:));
    Exp1_Behavior_table.cross0and2_MBD_acc_whatwhere(si) = nanmean(Exp1_Trial_Data(si).main.whatwhere(Exp1_Trial_Data(si).main.boundary == 1 & ismember(Exp1_Trial_Data(si).main.boundary_crossing, [0, 2]),:));
    Exp1_Behavior_table.cross0and2_MBD_acc_fullem(si) = nanmean(Exp1_Trial_Data(si).main.fullem(Exp1_Trial_Data(si).main.boundary == 1 & ismember(Exp1_Trial_Data(si).main.boundary_crossing, [0, 2]),:));
    Exp1_Behavior_table.cross0and2_MBD_acc_location_cat(si) = nanmean(Exp1_Trial_Data(si).main.location_catAcc(Exp1_Trial_Data(si).main.boundary == 1 & ismember(Exp1_Trial_Data(si).main.boundary_crossing, [0, 2]),:));

    Exp1_Behavior_table.cross0and2_MBD_rt_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT(Exp1_Trial_Data(si).main.boundary == 1 & ismember(Exp1_Trial_Data(si).main.boundary_crossing, [0, 2]),:));
    Exp1_Behavior_table.cross0and2_MBD_rt_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT(Exp1_Trial_Data(si).main.boundary == 1 & ismember(Exp1_Trial_Data(si).main.boundary_crossing, [0, 2]),:));
    Exp1_Behavior_table.cross0and2_MBD_rt_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT(Exp1_Trial_Data(si).main.boundary == 1 & ismember(Exp1_Trial_Data(si).main.boundary_crossing, [0, 2]),:));


    Exp1_Behavior_table.cross0and2_MBD_rt_right_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT(Exp1_Trial_Data(si).main.boundary == 1 & ismember(Exp1_Trial_Data(si).main.boundary_crossing, [0, 2]) & Exp1_Trial_Data(si).main.fullem == 1,:));
    Exp1_Behavior_table.cross0and2_MBD_rt_right_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT(Exp1_Trial_Data(si).main.boundary == 1 & ismember(Exp1_Trial_Data(si).main.boundary_crossing, [0, 2]) & Exp1_Trial_Data(si).main.animalAcc == 1,:));
    Exp1_Behavior_table.cross0and2_MBD_rt_right_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT(Exp1_Trial_Data(si).main.boundary == 1 & ismember(Exp1_Trial_Data(si).main.boundary_crossing, [0, 2]) & Exp1_Trial_Data(si).main.locationAcc == 1,:));


    % crossing 1 & 2
    Exp1_Behavior_table.cross1and2_acc_what(si) = nanmean(Exp1_Trial_Data(si).main.what(ismember(Exp1_Trial_Data(si).main.boundary_crossing, [1, 2]) ,:));
    Exp1_Behavior_table.cross1and2_acc_whatwhen(si) = nanmean(Exp1_Trial_Data(si).main.whatwhen(ismember(Exp1_Trial_Data(si).main.boundary_crossing, [1, 2]) ,:));
    Exp1_Behavior_table.cross1and2_acc_where(si) = nanmean(Exp1_Trial_Data(si).main.where(ismember(Exp1_Trial_Data(si).main.boundary_crossing, [1, 2]) ,:));
    Exp1_Behavior_table.cross1and2_acc_wherewhen(si) = nanmean(Exp1_Trial_Data(si).main.wherewhen(ismember(Exp1_Trial_Data(si).main.boundary_crossing, [1, 2]),:));
    Exp1_Behavior_table.cross1and2_acc_whatwhere(si) = nanmean(Exp1_Trial_Data(si).main.whatwhere(ismember(Exp1_Trial_Data(si).main.boundary_crossing, [1, 2]),:));
    Exp1_Behavior_table.cross1and2_acc_fullem(si) = nanmean(Exp1_Trial_Data(si).main.fullem(ismember(Exp1_Trial_Data(si).main.boundary_crossing, [1, 2]),:));


    Exp1_Behavior_table.cross1and2_rt_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT(ismember(Exp1_Trial_Data(si).main.boundary_crossing, [1, 2]) ,:));
    Exp1_Behavior_table.cross1and2_rt_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT(ismember(Exp1_Trial_Data(si).main.boundary_crossing, [1, 2]) ,:));
    Exp1_Behavior_table.cross1and2_rt_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT(ismember(Exp1_Trial_Data(si).main.boundary_crossing, [1, 2]) ,:));


    Exp1_Behavior_table.cross1and2_ABD_acc_what(si) = nanmean(Exp1_Trial_Data(si).main.what(Exp1_Trial_Data(si).main.boundary == 0 & ismember(Exp1_Trial_Data(si).main.boundary_crossing, [1, 2]) ,:));
    Exp1_Behavior_table.cross1and2_ABD_acc_whatwhen(si) = nanmean(Exp1_Trial_Data(si).main.whatwhen(Exp1_Trial_Data(si).main.boundary == 0 & ismember(Exp1_Trial_Data(si).main.boundary_crossing, [1, 2]),:));
    Exp1_Behavior_table.cross1and2_ABD_acc_where(si) = nanmean(Exp1_Trial_Data(si).main.where(Exp1_Trial_Data(si).main.boundary == 0 & ismember(Exp1_Trial_Data(si).main.boundary_crossing, [1, 2]),:));
    Exp1_Behavior_table.cross1and2_ABD_acc_wherewhen(si) = nanmean(Exp1_Trial_Data(si).main.wherewhen(Exp1_Trial_Data(si).main.boundary == 0 & ismember(Exp1_Trial_Data(si).main.boundary_crossing, [1, 2]),:));
    Exp1_Behavior_table.cross1and2_ABD_acc_whatwhere(si) = nanmean(Exp1_Trial_Data(si).main.whatwhere(Exp1_Trial_Data(si).main.boundary == 0 & ismember(Exp1_Trial_Data(si).main.boundary_crossing, [1, 2]),:));
    Exp1_Behavior_table.cross1and2_ABD_acc_fullem(si) = nanmean(Exp1_Trial_Data(si).main.fullem(Exp1_Trial_Data(si).main.boundary == 0 & ismember(Exp1_Trial_Data(si).main.boundary_crossing, [1, 2]),:));
    Exp1_Behavior_table.cross1and2_ABD_acc_location_cat(si) = nanmean(Exp1_Trial_Data(si).main.location_catAcc(Exp1_Trial_Data(si).main.boundary == 0 & ismember(Exp1_Trial_Data(si).main.boundary_crossing, [1, 2]),:));

    Exp1_Behavior_table.cross1and2_ABD_rt_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT(Exp1_Trial_Data(si).main.boundary == 0 & ismember(Exp1_Trial_Data(si).main.boundary_crossing, [1, 2]),:));
    Exp1_Behavior_table.cross1and2_ABD_rt_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT(Exp1_Trial_Data(si).main.boundary == 0 & ismember(Exp1_Trial_Data(si).main.boundary_crossing, [1, 2]),:));
    Exp1_Behavior_table.cross1and2_ABD_rt_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT(Exp1_Trial_Data(si).main.boundary == 0 & ismember(Exp1_Trial_Data(si).main.boundary_crossing, [1, 2]),:));

    Exp1_Behavior_table.cross1and2_ABD_rt_right_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT(Exp1_Trial_Data(si).main.boundary == 0 & ismember(Exp1_Trial_Data(si).main.boundary_crossing, [1, 2]) & Exp1_Trial_Data(si).main.fullem == 1,:));
    Exp1_Behavior_table.cross1and2_ABD_rt_right_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT(Exp1_Trial_Data(si).main.boundary == 0 & ismember(Exp1_Trial_Data(si).main.boundary_crossing, [1, 2]) & Exp1_Trial_Data(si).main.animalAcc == 1,:));
    Exp1_Behavior_table.cross1and2_ABD_rt_right_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT(Exp1_Trial_Data(si).main.boundary == 0 & ismember(Exp1_Trial_Data(si).main.boundary_crossing, [1, 2]) & Exp1_Trial_Data(si).main.locationAcc == 1,:));



    Exp1_Behavior_table.cross1and2_MBD_acc_what(si) = nanmean(Exp1_Trial_Data(si).main.what(Exp1_Trial_Data(si).main.boundary == 1 & ismember(Exp1_Trial_Data(si).main.boundary_crossing, [1, 2]),:));
    Exp1_Behavior_table.cross1and2_MBD_acc_whatwhen(si) = nanmean(Exp1_Trial_Data(si).main.whatwhen(Exp1_Trial_Data(si).main.boundary == 1 & ismember(Exp1_Trial_Data(si).main.boundary_crossing, [1, 2]),:));
    Exp1_Behavior_table.cross1and2_MBD_acc_where(si) = nanmean(Exp1_Trial_Data(si).main.where(Exp1_Trial_Data(si).main.boundary == 1 & ismember(Exp1_Trial_Data(si).main.boundary_crossing, [1, 2]),:));
    Exp1_Behavior_table.cross1and2_MBD_acc_wherewhen(si) = nanmean(Exp1_Trial_Data(si).main.wherewhen(Exp1_Trial_Data(si).main.boundary == 1 & ismember(Exp1_Trial_Data(si).main.boundary_crossing, [1, 2]),:));
    Exp1_Behavior_table.cross1and2_MBD_acc_whatwhere(si) = nanmean(Exp1_Trial_Data(si).main.whatwhere(Exp1_Trial_Data(si).main.boundary == 1 & ismember(Exp1_Trial_Data(si).main.boundary_crossing, [1, 2]),:));
    Exp1_Behavior_table.cross1and2_MBD_acc_fullem(si) = nanmean(Exp1_Trial_Data(si).main.fullem(Exp1_Trial_Data(si).main.boundary == 1 & ismember(Exp1_Trial_Data(si).main.boundary_crossing, [1, 2]),:));
    Exp1_Behavior_table.cross1and2_MBD_acc_location_cat(si) = nanmean(Exp1_Trial_Data(si).main.location_catAcc(Exp1_Trial_Data(si).main.boundary == 1 & ismember(Exp1_Trial_Data(si).main.boundary_crossing, [1, 2]),:));

    Exp1_Behavior_table.cross1and2_MBD_rt_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT(Exp1_Trial_Data(si).main.boundary == 1 & ismember(Exp1_Trial_Data(si).main.boundary_crossing, [1, 2]),:));
    Exp1_Behavior_table.cross1and2_MBD_rt_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT(Exp1_Trial_Data(si).main.boundary == 1 & ismember(Exp1_Trial_Data(si).main.boundary_crossing, [1, 2]),:));
    Exp1_Behavior_table.cross1and2_MBD_rt_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT(Exp1_Trial_Data(si).main.boundary == 1 & ismember(Exp1_Trial_Data(si).main.boundary_crossing, [1, 2]),:));


    Exp1_Behavior_table.cross1and2_MBD_rt_right_respond(si) = nanmean(Exp1_Trial_Data(si).main.respondRT(Exp1_Trial_Data(si).main.boundary == 1 & ismember(Exp1_Trial_Data(si).main.boundary_crossing, [1, 2]) & Exp1_Trial_Data(si).main.fullem == 1,:));
    Exp1_Behavior_table.cross1and2_MBD_rt_right_animal(si) = nanmean(Exp1_Trial_Data(si).main.animalRT(Exp1_Trial_Data(si).main.boundary == 1 & ismember(Exp1_Trial_Data(si).main.boundary_crossing, [1, 2]) & Exp1_Trial_Data(si).main.animalAcc == 1,:));
    Exp1_Behavior_table.cross1and2_MBD_rt_right_location(si) = nanmean(Exp1_Trial_Data(si).main.locationRT(Exp1_Trial_Data(si).main.boundary == 1 & ismember(Exp1_Trial_Data(si).main.boundary_crossing, [1, 2]) & Exp1_Trial_Data(si).main.locationAcc == 1,:));


    % bnd index (multi - audio)
    Exp1_Behavior_table.all_MBD_ABD_acc_what(si) = Exp1_Behavior_table.all_MBD_acc_what(si) - Exp1_Behavior_table.all_ABD_acc_what(si);
    Exp1_Behavior_table.all_MBD_ABD_acc_whatwhen(si) = Exp1_Behavior_table.all_MBD_acc_whatwhen(si) - Exp1_Behavior_table.all_ABD_acc_whatwhen(si);
    Exp1_Behavior_table.all_MBD_ABD_acc_where(si) = Exp1_Behavior_table.all_MBD_acc_where(si) - Exp1_Behavior_table.all_ABD_acc_where(si);
    Exp1_Behavior_table.all_MBD_ABD_acc_wherewhen(si) = Exp1_Behavior_table.all_MBD_acc_wherewhen(si) - Exp1_Behavior_table.all_ABD_acc_wherewhen(si);
    Exp1_Behavior_table.all_MBD_ABD_acc_whatwhere(si) = Exp1_Behavior_table.all_MBD_acc_whatwhere(si) - Exp1_Behavior_table.all_ABD_acc_whatwhere(si);
    Exp1_Behavior_table.all_MBD_ABD_acc_fullem(si) = Exp1_Behavior_table.all_MBD_acc_fullem(si) - Exp1_Behavior_table.all_ABD_acc_fullem(si);
                        

    Exp1_Behavior_table.select_MBD_ABD_acc_what(si) = Exp1_Behavior_table.select_MBD_acc_what(si) - Exp1_Behavior_table.select_ABD_acc_what(si);
    Exp1_Behavior_table.select_MBD_ABD_acc_whatwhen(si) = Exp1_Behavior_table.select_MBD_acc_whatwhen(si) - Exp1_Behavior_table.select_ABD_acc_whatwhen(si);
    Exp1_Behavior_table.select_MBD_ABD_acc_where(si) = Exp1_Behavior_table.select_MBD_acc_where(si) - Exp1_Behavior_table.select_ABD_acc_where(si);
    Exp1_Behavior_table.select_MBD_ABD_acc_wherewhen(si) = Exp1_Behavior_table.select_MBD_acc_wherewhen(si) - Exp1_Behavior_table.select_ABD_acc_wherewhen(si);
    Exp1_Behavior_table.select_MBD_ABD_acc_whatwhere(si) = Exp1_Behavior_table.select_MBD_acc_whatwhere(si) - Exp1_Behavior_table.select_ABD_acc_whatwhere(si);
    Exp1_Behavior_table.select_MBD_ABD_acc_fullem(si) = Exp1_Behavior_table.select_MBD_acc_fullem(si) - Exp1_Behavior_table.select_ABD_acc_fullem(si);
                   
    Exp1_Behavior_table.cross0_MBD_ABD_acc_what(si) = Exp1_Behavior_table.cross0_MBD_acc_what(si) - Exp1_Behavior_table.cross0_ABD_acc_what(si);
    Exp1_Behavior_table.cross0_MBD_ABD_acc_whatwhen(si) = Exp1_Behavior_table.cross0_MBD_acc_whatwhen(si) - Exp1_Behavior_table.cross0_ABD_acc_whatwhen(si);
    Exp1_Behavior_table.cross0_MBD_ABD_acc_where(si) = Exp1_Behavior_table.cross0_MBD_acc_where(si) - Exp1_Behavior_table.cross0_ABD_acc_where(si);
    Exp1_Behavior_table.cross0_MBD_ABD_acc_wherewhen(si) = Exp1_Behavior_table.cross0_MBD_acc_wherewhen(si) - Exp1_Behavior_table.cross0_ABD_acc_wherewhen(si);
    Exp1_Behavior_table.cross0_MBD_ABD_acc_whatwhere(si) = Exp1_Behavior_table.cross0_MBD_acc_whatwhere(si) - Exp1_Behavior_table.cross0_ABD_acc_whatwhere(si);
    Exp1_Behavior_table.cross0_MBD_ABD_acc_fullem(si) = Exp1_Behavior_table.cross0_MBD_acc_fullem(si) - Exp1_Behavior_table.cross0_ABD_acc_fullem(si);
                   
                   
    Exp1_Behavior_table.cross2_MBD_ABD_acc_what(si) = Exp1_Behavior_table.cross2_MBD_acc_what(si) - Exp1_Behavior_table.cross2_ABD_acc_what(si);
    Exp1_Behavior_table.cross2_MBD_ABD_acc_whatwhen(si) = Exp1_Behavior_table.cross2_MBD_acc_whatwhen(si) - Exp1_Behavior_table.cross2_ABD_acc_whatwhen(si);
    Exp1_Behavior_table.cross2_MBD_ABD_acc_where(si) = Exp1_Behavior_table.cross2_MBD_acc_where(si) - Exp1_Behavior_table.cross2_ABD_acc_where(si);
    Exp1_Behavior_table.cross2_MBD_ABD_acc_wherewhen(si) = Exp1_Behavior_table.cross2_MBD_acc_wherewhen(si) - Exp1_Behavior_table.cross2_ABD_acc_wherewhen(si);
    Exp1_Behavior_table.cross2_MBD_ABD_acc_whatwhere(si) = Exp1_Behavior_table.cross2_MBD_acc_whatwhere(si) - Exp1_Behavior_table.cross2_ABD_acc_whatwhere(si);
    Exp1_Behavior_table.cross2_MBD_ABD_acc_fullem(si) = Exp1_Behavior_table.cross2_MBD_acc_fullem(si) - Exp1_Behavior_table.cross2_ABD_acc_fullem(si);
                   
                   
    Exp1_Behavior_table.cross0and2_MBD_ABD_acc_what(si) = Exp1_Behavior_table.cross0and2_MBD_acc_what(si) - Exp1_Behavior_table.cross0and2_ABD_acc_what(si);
    Exp1_Behavior_table.cross0and2_MBD_ABD_acc_whatwhen(si) = Exp1_Behavior_table.cross0and2_MBD_acc_whatwhen(si) - Exp1_Behavior_table.cross0and2_ABD_acc_whatwhen(si);
    Exp1_Behavior_table.cross0and2_MBD_ABD_acc_where(si) = Exp1_Behavior_table.cross0and2_MBD_acc_where(si) - Exp1_Behavior_table.cross0and2_ABD_acc_where(si);
    Exp1_Behavior_table.cross0and2_MBD_ABD_acc_wherewhen(si) = Exp1_Behavior_table.cross0and2_MBD_acc_wherewhen(si) - Exp1_Behavior_table.cross0and2_ABD_acc_wherewhen(si);
    Exp1_Behavior_table.cross0and2_MBD_ABD_acc_whatwhere(si) = Exp1_Behavior_table.cross0and2_MBD_acc_whatwhere(si) - Exp1_Behavior_table.cross0and2_ABD_acc_whatwhere(si);
    Exp1_Behavior_table.cross0and2_MBD_ABD_acc_fullem(si) = Exp1_Behavior_table.cross0and2_MBD_acc_fullem(si) - Exp1_Behavior_table.cross0and2_ABD_acc_fullem(si);
                   
    Exp1_Behavior_table.cross1and2_MBD_ABD_acc_what(si) = Exp1_Behavior_table.cross1and2_MBD_acc_what(si) - Exp1_Behavior_table.cross1and2_ABD_acc_what(si);
    Exp1_Behavior_table.cross1and2_MBD_ABD_acc_whatwhen(si) = Exp1_Behavior_table.cross1and2_MBD_acc_whatwhen(si) - Exp1_Behavior_table.cross1and2_ABD_acc_whatwhen(si);
    Exp1_Behavior_table.cross1and2_MBD_ABD_acc_where(si) = Exp1_Behavior_table.cross1and2_MBD_acc_where(si) - Exp1_Behavior_table.cross1and2_ABD_acc_where(si);
    Exp1_Behavior_table.cross1and2_MBD_ABD_acc_wherewhen(si) = Exp1_Behavior_table.cross1and2_MBD_acc_wherewhen(si) - Exp1_Behavior_table.cross1and2_ABD_acc_wherewhen(si);
    Exp1_Behavior_table.cross1and2_MBD_ABD_acc_whatwhere(si) = Exp1_Behavior_table.cross1and2_MBD_acc_whatwhere(si) - Exp1_Behavior_table.cross1and2_ABD_acc_whatwhere(si);
    Exp1_Behavior_table.cross1and2_MBD_ABD_acc_fullem(si) = Exp1_Behavior_table.cross1and2_MBD_acc_fullem(si) - Exp1_Behavior_table.cross1and2_ABD_acc_fullem(si);
                   

    Exp1_Behavior_table.cross1_cross0_acc_what(si) = Exp1_Behavior_table.select_acc_what(si) - Exp1_Behavior_table.cross0_acc_what(si);
    Exp1_Behavior_table.cross1_cross0_acc_whatwhen(si) = Exp1_Behavior_table.select_acc_whatwhen(si) - Exp1_Behavior_table.cross0_acc_whatwhen(si);
    Exp1_Behavior_table.cross1_cross0_acc_where(si) = Exp1_Behavior_table.select_acc_where(si) - Exp1_Behavior_table.cross0_acc_where(si);
    Exp1_Behavior_table.cross1_cross0_acc_wherewhen(si) = Exp1_Behavior_table.select_acc_wherewhen(si) - Exp1_Behavior_table.cross0_acc_wherewhen(si);
    Exp1_Behavior_table.cross1_cross0_acc_whatwhere(si) = Exp1_Behavior_table.select_acc_whatwhere(si) - Exp1_Behavior_table.cross0_acc_whatwhere(si);
    Exp1_Behavior_table.cross1_cross0_acc_fullem(si) = Exp1_Behavior_table.select_acc_fullem(si) - Exp1_Behavior_table.cross0_acc_fullem(si);
        
    Exp1_Behavior_table.cross1_cross0and2_acc_what(si) = Exp1_Behavior_table.select_acc_what(si) - Exp1_Behavior_table.cross0and2_acc_what(si);
    Exp1_Behavior_table.cross1_cross0and2_acc_whatwhen(si) = Exp1_Behavior_table.select_acc_whatwhen(si) - Exp1_Behavior_table.cross0and2_acc_whatwhen(si);
    Exp1_Behavior_table.cross1_cross0and2_acc_where(si) = Exp1_Behavior_table.select_acc_where(si) - Exp1_Behavior_table.cross0and2_acc_where(si);
    Exp1_Behavior_table.cross1_cross0and2_acc_wherewhen(si) = Exp1_Behavior_table.select_acc_wherewhen(si) - Exp1_Behavior_table.cross0and2_acc_wherewhen(si);
    Exp1_Behavior_table.cross1_cross0and2_acc_whatwhere(si) = Exp1_Behavior_table.select_acc_whatwhere(si) - Exp1_Behavior_table.cross0and2_acc_whatwhere(si);
    Exp1_Behavior_table.cross1_cross0and2_acc_fullem(si) = Exp1_Behavior_table.select_acc_fullem(si) - Exp1_Behavior_table.cross0and2_acc_fullem(si);
        
    Exp1_Behavior_table.cross1and2_cross0_acc_what(si) = Exp1_Behavior_table.cross1and2_acc_what(si) - Exp1_Behavior_table.cross0_acc_what(si);
    Exp1_Behavior_table.cross1and2_cross0_acc_whatwhen(si) = Exp1_Behavior_table.cross1and2_acc_whatwhen(si) - Exp1_Behavior_table.cross0_acc_whatwhen(si);
    Exp1_Behavior_table.cross1and2_cross0_acc_where(si) = Exp1_Behavior_table.cross1and2_acc_where(si) - Exp1_Behavior_table.cross0_acc_where(si);
    Exp1_Behavior_table.cross1and2_cross0_acc_wherewhen(si) = Exp1_Behavior_table.cross1and2_acc_wherewhen(si) - Exp1_Behavior_table.cross0_acc_wherewhen(si);
    Exp1_Behavior_table.cross1and2_cross0_acc_whatwhere(si) = Exp1_Behavior_table.cross1and2_acc_whatwhere(si) - Exp1_Behavior_table.cross0_acc_whatwhere(si);
    Exp1_Behavior_table.cross1and2_cross0_acc_fullem(si) = Exp1_Behavior_table.cross1and2_acc_fullem(si) - Exp1_Behavior_table.cross0_acc_fullem(si);
        
    Exp1_Behavior_table.cross1_cross2_acc_what(si) = Exp1_Behavior_table.select_acc_what(si) - Exp1_Behavior_table.cross2_acc_what(si);
    Exp1_Behavior_table.cross1_cross2_acc_whatwhen(si) = Exp1_Behavior_table.select_acc_whatwhen(si) - Exp1_Behavior_table.cross2_acc_whatwhen(si);
    Exp1_Behavior_table.cross1_cross2_acc_where(si) = Exp1_Behavior_table.select_acc_where(si) - Exp1_Behavior_table.cross2_acc_where(si);
    Exp1_Behavior_table.cross1_cross2_acc_wherewhen(si) = Exp1_Behavior_table.select_acc_wherewhen(si) - Exp1_Behavior_table.cross2_acc_wherewhen(si);
    Exp1_Behavior_table.cross1_cross2_acc_whatwhere(si) = Exp1_Behavior_table.select_acc_whatwhere(si) - Exp1_Behavior_table.cross2_acc_whatwhere(si);
    Exp1_Behavior_table.cross1_cross2_acc_fullem(si) = Exp1_Behavior_table.select_acc_fullem(si) - Exp1_Behavior_table.cross2_acc_fullem(si);
    

    Exp1_Behavior_table.cross1_cross0_ABD_acc_what(si) = Exp1_Behavior_table.select_ABD_acc_what(si) - Exp1_Behavior_table.cross0_ABD_acc_what(si);
    Exp1_Behavior_table.cross1_cross0_ABD_acc_whatwhen(si) = Exp1_Behavior_table.select_ABD_acc_whatwhen(si) - Exp1_Behavior_table.cross0_ABD_acc_whatwhen(si);
    Exp1_Behavior_table.cross1_cross0_ABD_acc_where(si) = Exp1_Behavior_table.select_ABD_acc_where(si) - Exp1_Behavior_table.cross0_ABD_acc_where(si);
    Exp1_Behavior_table.cross1_cross0_ABD_acc_wherewhen(si) = Exp1_Behavior_table.select_ABD_acc_wherewhen(si) - Exp1_Behavior_table.cross0_ABD_acc_wherewhen(si);
    Exp1_Behavior_table.cross1_cross0_ABD_acc_whatwhere(si) = Exp1_Behavior_table.select_ABD_acc_whatwhere(si) - Exp1_Behavior_table.cross0_ABD_acc_whatwhere(si);
    Exp1_Behavior_table.cross1_cross0_ABD_acc_fullem(si) = Exp1_Behavior_table.select_ABD_acc_fullem(si) - Exp1_Behavior_table.cross0_ABD_acc_fullem(si);
        
    Exp1_Behavior_table.cross1_cross0and2_ABD_acc_what(si) = Exp1_Behavior_table.select_ABD_acc_what(si) - Exp1_Behavior_table.cross0and2_ABD_acc_what(si);
    Exp1_Behavior_table.cross1_cross0and2_ABD_acc_whatwhen(si) = Exp1_Behavior_table.select_ABD_acc_whatwhen(si) - Exp1_Behavior_table.cross0and2_ABD_acc_whatwhen(si);
    Exp1_Behavior_table.cross1_cross0and2_ABD_acc_where(si) = Exp1_Behavior_table.select_ABD_acc_where(si) - Exp1_Behavior_table.cross0and2_ABD_acc_where(si);
    Exp1_Behavior_table.cross1_cross0and2_ABD_acc_wherewhen(si) = Exp1_Behavior_table.select_ABD_acc_wherewhen(si) - Exp1_Behavior_table.cross0and2_ABD_acc_wherewhen(si);
    Exp1_Behavior_table.cross1_cross0and2_ABD_acc_whatwhere(si) = Exp1_Behavior_table.select_ABD_acc_whatwhere(si) - Exp1_Behavior_table.cross0and2_ABD_acc_whatwhere(si);
    Exp1_Behavior_table.cross1_cross0and2_ABD_acc_fullem(si) = Exp1_Behavior_table.select_ABD_acc_fullem(si) - Exp1_Behavior_table.cross0and2_ABD_acc_fullem(si);
        
    Exp1_Behavior_table.cross1and2_cross0_ABD_acc_what(si) = Exp1_Behavior_table.cross1and2_ABD_acc_what(si) - Exp1_Behavior_table.cross0_ABD_acc_what(si);
    Exp1_Behavior_table.cross1and2_cross0_ABD_acc_whatwhen(si) = Exp1_Behavior_table.cross1and2_ABD_acc_whatwhen(si) - Exp1_Behavior_table.cross0_ABD_acc_whatwhen(si);
    Exp1_Behavior_table.cross1and2_cross0_ABD_acc_where(si) = Exp1_Behavior_table.cross1and2_ABD_acc_where(si) - Exp1_Behavior_table.cross0_ABD_acc_where(si);
    Exp1_Behavior_table.cross1and2_cross0_ABD_acc_wherewhen(si) = Exp1_Behavior_table.cross1and2_ABD_acc_wherewhen(si) - Exp1_Behavior_table.cross0_ABD_acc_wherewhen(si);
    Exp1_Behavior_table.cross1and2_cross0_ABD_acc_whatwhere(si) = Exp1_Behavior_table.cross1and2_ABD_acc_whatwhere(si) - Exp1_Behavior_table.cross0_ABD_acc_whatwhere(si);
    Exp1_Behavior_table.cross1and2_cross0_ABD_acc_fullem(si) = Exp1_Behavior_table.cross1and2_ABD_acc_fullem(si) - Exp1_Behavior_table.cross0_ABD_acc_fullem(si);
        
    Exp1_Behavior_table.cross1_cross2_ABD_acc_what(si) = Exp1_Behavior_table.select_ABD_acc_what(si) - Exp1_Behavior_table.cross2_ABD_acc_what(si);
    Exp1_Behavior_table.cross1_cross2_ABD_acc_whatwhen(si) = Exp1_Behavior_table.select_ABD_acc_whatwhen(si) - Exp1_Behavior_table.cross2_ABD_acc_whatwhen(si);
    Exp1_Behavior_table.cross1_cross2_ABD_acc_where(si) = Exp1_Behavior_table.select_ABD_acc_where(si) - Exp1_Behavior_table.cross2_ABD_acc_where(si);
    Exp1_Behavior_table.cross1_cross2_ABD_acc_wherewhen(si) = Exp1_Behavior_table.select_ABD_acc_wherewhen(si) - Exp1_Behavior_table.cross2_ABD_acc_wherewhen(si);
    Exp1_Behavior_table.cross1_cross2_ABD_acc_whatwhere(si) = Exp1_Behavior_table.select_ABD_acc_whatwhere(si) - Exp1_Behavior_table.cross2_ABD_acc_whatwhere(si);
    Exp1_Behavior_table.cross1_cross2_ABD_acc_fullem(si) = Exp1_Behavior_table.select_ABD_acc_fullem(si) - Exp1_Behavior_table.cross2_ABD_acc_fullem(si);
    


    Exp1_Behavior_table.cross1_cross0_MBD_acc_what(si) = Exp1_Behavior_table.select_MBD_acc_what(si) - Exp1_Behavior_table.cross0_MBD_acc_what(si);
    Exp1_Behavior_table.cross1_cross0_MBD_acc_whatwhen(si) = Exp1_Behavior_table.select_MBD_acc_whatwhen(si) - Exp1_Behavior_table.cross0_MBD_acc_whatwhen(si);
    Exp1_Behavior_table.cross1_cross0_MBD_acc_where(si) = Exp1_Behavior_table.select_MBD_acc_where(si) - Exp1_Behavior_table.cross0_MBD_acc_where(si);
    Exp1_Behavior_table.cross1_cross0_MBD_acc_wherewhen(si) = Exp1_Behavior_table.select_MBD_acc_wherewhen(si) - Exp1_Behavior_table.cross0_MBD_acc_wherewhen(si);
    Exp1_Behavior_table.cross1_cross0_MBD_acc_whatwhere(si) = Exp1_Behavior_table.select_MBD_acc_whatwhere(si) - Exp1_Behavior_table.cross0_MBD_acc_whatwhere(si);
    Exp1_Behavior_table.cross1_cross0_MBD_acc_fullem(si) = Exp1_Behavior_table.select_MBD_acc_fullem(si) - Exp1_Behavior_table.cross0_MBD_acc_fullem(si);
        
    Exp1_Behavior_table.cross1_cross0and2_MBD_acc_what(si) = Exp1_Behavior_table.select_MBD_acc_what(si) - Exp1_Behavior_table.cross0and2_MBD_acc_what(si);
    Exp1_Behavior_table.cross1_cross0and2_MBD_acc_whatwhen(si) = Exp1_Behavior_table.select_MBD_acc_whatwhen(si) - Exp1_Behavior_table.cross0and2_MBD_acc_whatwhen(si);
    Exp1_Behavior_table.cross1_cross0and2_MBD_acc_where(si) = Exp1_Behavior_table.select_MBD_acc_where(si) - Exp1_Behavior_table.cross0and2_MBD_acc_where(si);
    Exp1_Behavior_table.cross1_cross0and2_MBD_acc_wherewhen(si) = Exp1_Behavior_table.select_MBD_acc_wherewhen(si) - Exp1_Behavior_table.cross0and2_MBD_acc_wherewhen(si);
    Exp1_Behavior_table.cross1_cross0and2_MBD_acc_whatwhere(si) = Exp1_Behavior_table.select_MBD_acc_whatwhere(si) - Exp1_Behavior_table.cross0and2_MBD_acc_whatwhere(si);
    Exp1_Behavior_table.cross1_cross0and2_MBD_acc_fullem(si) = Exp1_Behavior_table.select_MBD_acc_fullem(si) - Exp1_Behavior_table.cross0and2_MBD_acc_fullem(si);
        
    Exp1_Behavior_table.cross1and2_cross0_MBD_acc_what(si) = Exp1_Behavior_table.cross1and2_MBD_acc_what(si) - Exp1_Behavior_table.cross0_MBD_acc_what(si);
    Exp1_Behavior_table.cross1and2_cross0_MBD_acc_whatwhen(si) = Exp1_Behavior_table.cross1and2_MBD_acc_whatwhen(si) - Exp1_Behavior_table.cross0_MBD_acc_whatwhen(si);
    Exp1_Behavior_table.cross1and2_cross0_MBD_acc_where(si) = Exp1_Behavior_table.cross1and2_MBD_acc_where(si) - Exp1_Behavior_table.cross0_MBD_acc_where(si);
    Exp1_Behavior_table.cross1and2_cross0_MBD_acc_wherewhen(si) = Exp1_Behavior_table.cross1and2_MBD_acc_wherewhen(si) - Exp1_Behavior_table.cross0_MBD_acc_wherewhen(si);
    Exp1_Behavior_table.cross1and2_cross0_MBD_acc_whatwhere(si) = Exp1_Behavior_table.cross1and2_MBD_acc_whatwhere(si) - Exp1_Behavior_table.cross0_MBD_acc_whatwhere(si);
    Exp1_Behavior_table.cross1and2_cross0_MBD_acc_fullem(si) = Exp1_Behavior_table.cross1and2_MBD_acc_fullem(si) - Exp1_Behavior_table.cross0_MBD_acc_fullem(si);
        
    Exp1_Behavior_table.cross1_cross2_MBD_acc_what(si) = Exp1_Behavior_table.select_MBD_acc_what(si) - Exp1_Behavior_table.cross2_MBD_acc_what(si);
    Exp1_Behavior_table.cross1_cross2_MBD_acc_whatwhen(si) = Exp1_Behavior_table.select_MBD_acc_whatwhen(si) - Exp1_Behavior_table.cross2_MBD_acc_whatwhen(si);
    Exp1_Behavior_table.cross1_cross2_MBD_acc_where(si) = Exp1_Behavior_table.select_MBD_acc_where(si) - Exp1_Behavior_table.cross2_MBD_acc_where(si);
    Exp1_Behavior_table.cross1_cross2_MBD_acc_wherewhen(si) = Exp1_Behavior_table.select_MBD_acc_wherewhen(si) - Exp1_Behavior_table.cross2_MBD_acc_wherewhen(si);
    Exp1_Behavior_table.cross1_cross2_MBD_acc_whatwhere(si) = Exp1_Behavior_table.select_MBD_acc_whatwhere(si) - Exp1_Behavior_table.cross2_MBD_acc_whatwhere(si);
    Exp1_Behavior_table.cross1_cross2_MBD_acc_fullem(si) = Exp1_Behavior_table.select_MBD_acc_fullem(si) - Exp1_Behavior_table.cross2_MBD_acc_fullem(si);
    



    % boundary 전 후 RT는 나중에
    %     Behavior_table.rt_befBoundary(si) = NaN;
    %     Behavior_table.rt_aftBoundary(si) = NaN;
    %
    %
    %     response1 = []; response2 = []; respond_av1 = NaN; respond_av2 = NaN;
    %     if sum(ismember(Trial_Data(si).main.boundary_cat, [1, 4]))
    %         response1 = Trial_Data(si).main.respondRT(ismember(Trial_Data(si).main.boundary_cat, [1, 4]),:);
    %         a1 = length(response1); remainders = mod([1:1:a1], 3);
    %
    %     elseif sum(ismember(Trial_Data(si).main.boundary_cat, [3, 6]))
    %         response2 = Trial_Data(si).main.respondRT(ismember(Trial_Data(si).main.boundary_cat, [3, 6]),:);
    %         nanmean(Trial_Data(si).main.locationRT);
    %
    %     end



end




for si = 1:length(www_sbj_data)

    WWW_Behavior_table.cross0(si) = sum(WWW_Trial_Data(si).main.boundary_crossing == 0);
    WWW_Behavior_table.cross1(si) = sum(WWW_Trial_Data(si).main.boundary_crossing == 1);
    WWW_Behavior_table.cross2(si) = sum(WWW_Trial_Data(si).main.boundary_crossing == 2);

    % inter trial accuracy
    WWW_Behavior_table.inter_acc(si) = nanmean(WWW_Trial_Data(si).inter.correct);
    WWW_Behavior_table.inter_acc_cat1(si) = nanmean(WWW_Trial_Data(si).inter.correct(WWW_Trial_Data(si).inter.condition == 1));
    WWW_Behavior_table.inter_acc_cat2(si) = nanmean(WWW_Trial_Data(si).inter.correct(WWW_Trial_Data(si).inter.condition == 2));
    WWW_Behavior_table.inter_bnd_use_index(si) =  WWW_Behavior_table.inter_acc_cat2(si) -  WWW_Behavior_table.inter_acc_cat1(si);

    WWW_Behavior_table.inter_bnd_user(si) = WWW_Behavior_table.inter_acc_cat1(si) < WWW_Behavior_table.inter_acc_cat2(si);


    WWW_Behavior_table.across_acc(si) = nanmean(WWW_Trial_Data(si).main_trial.across_acc);
    WWW_Behavior_table.within_acc(si) = nanmean(WWW_Trial_Data(si).main_trial.within_acc);

    WWW_Behavior_table.acc_what(si) = nanmean(WWW_Trial_Data(si).main.what);
    WWW_Behavior_table.acc_whatwhen(si) = nanmean(WWW_Trial_Data(si).main.whatwhen);
    WWW_Behavior_table.acc_where(si) = nanmean(WWW_Trial_Data(si).main.where);
    WWW_Behavior_table.acc_wherewhen(si) = nanmean(WWW_Trial_Data(si).main.wherewhen);
    WWW_Behavior_table.acc_whatwhere(si) = nanmean(WWW_Trial_Data(si).main.whatwhere);
    WWW_Behavior_table.acc_fullem(si) = nanmean(WWW_Trial_Data(si).main.fullem);
    WWW_Behavior_table.acc_location_cat(si) = nanmean(WWW_Trial_Data(si).main.location_catAcc);
    WWW_Behavior_table.acc_location_cat_only(si) = nanmean(WWW_Trial_Data(si).main.location_catWhere);


    WWW_Behavior_table.acc_loc_cat_where(si) = nanmean(WWW_Trial_Data(si).main.location_catAcc_where);
    WWW_Behavior_table.acc_loc_cat_wherewhen(si) = nanmean(WWW_Trial_Data(si).main.location_catAcc_wherewhen);
    WWW_Behavior_table.acc_loc_cat_whatwhere(si) = nanmean(WWW_Trial_Data(si).main.location_catAcc_whatwhere);
    WWW_Behavior_table.acc_loc_cat_fullem(si) = nanmean(WWW_Trial_Data(si).main.location_catAcc_fullem);



    WWW_Behavior_table.acc_wrong_loc_cat_where(si) = nanmean(WWW_Trial_Data(si).main.location_catAcc_where(WWW_Trial_Data(si).main.where == 0,:));
    WWW_Behavior_table.acc_wrong_loc_cat_wherewhen(si) = nanmean(WWW_Trial_Data(si).main.location_catAcc_wherewhen(WWW_Trial_Data(si).main.where == 0,:));
    WWW_Behavior_table.acc_wrong_loc_cat_whatwhere(si) = nanmean(WWW_Trial_Data(si).main.location_catAcc_whatwhere(WWW_Trial_Data(si).main.where == 0,:));
    WWW_Behavior_table.acc_wrong_loc_cat_fullem(si) = nanmean(WWW_Trial_Data(si).main.location_catAcc_fullem(WWW_Trial_Data(si).main.where == 0,:));





    if sum(WWW_Trial_Data(si).main.categorical_Acc == 2) + sum(WWW_Trial_Data(si).main.categorical_Acc == 0) ~= 0
        WWW_Behavior_table.loc_chunking(si) = sum(WWW_Trial_Data(si).main.categorical_Acc == 2) / (sum(WWW_Trial_Data(si).main.categorical_Acc == 2) + sum(WWW_Trial_Data(si).main.categorical_Acc == 0));
    else
        WWW_Behavior_table.loc_chunking(si) = NaN;
    end

    WWW_Behavior_table.all_wrong_cat(si) = nanmean(WWW_Trial_Data(si).main.location_catAcc(WWW_Trial_Data(si).main.where == 0,:));    
    



    WWW_Behavior_table.rt_respond(si) = nanmean(WWW_Trial_Data(si).main.respondRT);
    WWW_Behavior_table.rt_animal(si) = nanmean(WWW_Trial_Data(si).main.animalRT);
    WWW_Behavior_table.rt_location(si) = nanmean(WWW_Trial_Data(si).main.locationRT);

    %reaction time (right only)
    WWW_Behavior_table.rt_right_respond(si) = nanmean(WWW_Trial_Data(si).main.respondRT(WWW_Trial_Data(si).main.fullem == 1));
    WWW_Behavior_table.rt_right_animal(si) = nanmean(WWW_Trial_Data(si).main.animalRT(WWW_Trial_Data(si).main.animalAcc == 1));
    WWW_Behavior_table.rt_right_location(si) = nanmean(WWW_Trial_Data(si).main.locationRT(WWW_Trial_Data(si).main.locationAcc == 1));


    WWW_Behavior_table.rt_trial1_respond(si) = nanmean(WWW_Trial_Data(si).main.respondRT(WWW_Trial_Data(si).main.order == 1));
    WWW_Behavior_table.rt_trial1_animal(si) = nanmean(WWW_Trial_Data(si).main.animalRT(WWW_Trial_Data(si).main.order == 1));
    WWW_Behavior_table.rt_trial1_location(si) = nanmean(WWW_Trial_Data(si).main.locationRT(WWW_Trial_Data(si).main.order == 1));

    WWW_Behavior_table.rt_trial2_respond(si) = nanmean(WWW_Trial_Data(si).main.respondRT(WWW_Trial_Data(si).main.order == 2));
    WWW_Behavior_table.rt_trial2_animal(si) = nanmean(WWW_Trial_Data(si).main.animalRT(WWW_Trial_Data(si).main.order == 2));
    WWW_Behavior_table.rt_trial2_location(si) = nanmean(WWW_Trial_Data(si).main.locationRT(WWW_Trial_Data(si).main.order == 2));

    WWW_Behavior_table.rt_trial3_respond(si) = nanmean(WWW_Trial_Data(si).main.respondRT(WWW_Trial_Data(si).main.order == 3));
    WWW_Behavior_table.rt_trial3_animal(si) = nanmean(WWW_Trial_Data(si).main.animalRT(WWW_Trial_Data(si).main.order == 3));
    WWW_Behavior_table.rt_trial3_location(si) = nanmean(WWW_Trial_Data(si).main.locationRT(WWW_Trial_Data(si).main.order == 3));





    WWW_Behavior_table.log_rt_respond(si) = nanmean(WWW_Trial_Data(si).main.respondRT_log);
    WWW_Behavior_table.log_rt_animal(si) = nanmean(WWW_Trial_Data(si).main.animalRT_log);
    WWW_Behavior_table.log_rt_location(si) = nanmean(WWW_Trial_Data(si).main.locationRT_log);

    %reaction time (right only)
    WWW_Behavior_table.log_rt_right_respond(si) = nanmean(WWW_Trial_Data(si).main.respondRT_log(WWW_Trial_Data(si).main.fullem == 1));
    WWW_Behavior_table.log_rt_right_animal(si) = nanmean(WWW_Trial_Data(si).main.animalRT_log(WWW_Trial_Data(si).main.animalAcc == 1));
    WWW_Behavior_table.log_rt_right_location(si) = nanmean(WWW_Trial_Data(si).main.locationRT_log(WWW_Trial_Data(si).main.locationAcc == 1));


    WWW_Behavior_table.log_rt_trial1_respond(si) = nanmean(WWW_Trial_Data(si).main.respondRT_log(WWW_Trial_Data(si).main.order == 1));
    WWW_Behavior_table.log_rt_trial1_animal(si) = nanmean(WWW_Trial_Data(si).main.animalRT_log(WWW_Trial_Data(si).main.order == 1));
    WWW_Behavior_table.log_rt_trial1_location(si) = nanmean(WWW_Trial_Data(si).main.locationRT_log(WWW_Trial_Data(si).main.order == 1));

    WWW_Behavior_table.log_rt_trial2_respond(si) = nanmean(WWW_Trial_Data(si).main.respondRT_log(WWW_Trial_Data(si).main.order == 2));
    WWW_Behavior_table.log_rt_trial2_animal(si) = nanmean(WWW_Trial_Data(si).main.animalRT_log(WWW_Trial_Data(si).main.order == 2));
    WWW_Behavior_table.log_rt_trial2_location(si) = nanmean(WWW_Trial_Data(si).main.locationRT_log(WWW_Trial_Data(si).main.order == 2));

    WWW_Behavior_table.log_rt_trial3_respond(si) = nanmean(WWW_Trial_Data(si).main.respondRT_log(WWW_Trial_Data(si).main.order == 3));
    WWW_Behavior_table.log_rt_trial3_animal(si) = nanmean(WWW_Trial_Data(si).main.animalRT_log(WWW_Trial_Data(si).main.order == 3));
    WWW_Behavior_table.log_rt_trial3_location(si) = nanmean(WWW_Trial_Data(si).main.locationRT_log(WWW_Trial_Data(si).main.order == 3));







    % crossing 0
    WWW_Behavior_table.cross0_acc_what(si) = nanmean(WWW_Trial_Data(si).main.what(WWW_Trial_Data(si).main.boundary_crossing == 0 ,:));
    WWW_Behavior_table.cross0_acc_whatwhen(si) = nanmean(WWW_Trial_Data(si).main.whatwhen(WWW_Trial_Data(si).main.boundary_crossing == 0 ,:));
    WWW_Behavior_table.cross0_acc_where(si) = nanmean(WWW_Trial_Data(si).main.where(WWW_Trial_Data(si).main.boundary_crossing == 0  ,:));
    WWW_Behavior_table.cross0_acc_wherewhen(si) = nanmean(WWW_Trial_Data(si).main.wherewhen(WWW_Trial_Data(si).main.boundary_crossing == 0 ,:));
    WWW_Behavior_table.cross0_acc_whatwhere(si) = nanmean(WWW_Trial_Data(si).main.whatwhere(WWW_Trial_Data(si).main.boundary_crossing == 0 ,:));
    WWW_Behavior_table.cross0_acc_fullem(si) = nanmean(WWW_Trial_Data(si).main.fullem(WWW_Trial_Data(si).main.boundary_crossing == 0 ,:));

    WWW_Behavior_table.cross0_wrong_cat(si) = nanmean(WWW_Trial_Data(si).main.location_catAcc(WWW_Trial_Data(si).main.where == 0 & WWW_Trial_Data(si).main.boundary_crossing == 0,:));




    WWW_Behavior_table.cross0_rt_respond(si) = nanmean(WWW_Trial_Data(si).main.respondRT(ismember(WWW_Trial_Data(si).main.boundary_crossing, [0]) ,:));
    WWW_Behavior_table.cross0_rt_animal(si) = nanmean(WWW_Trial_Data(si).main.animalRT(ismember(WWW_Trial_Data(si).main.boundary_crossing, [0]) ,:));
    WWW_Behavior_table.cross0_rt_location(si) = nanmean(WWW_Trial_Data(si).main.locationRT(ismember(WWW_Trial_Data(si).main.boundary_crossing, [0]) ,:));



    WWW_Behavior_table.cross1_across_acc(si) = nanmean(WWW_Trial_Data(si).main_trial.across_acc(WWW_Trial_Data(si).main_trial.boundary_crossing == 1 ,:))
    WWW_Behavior_table.cross1_within_acc(si) = nanmean(WWW_Trial_Data(si).main_trial.within_acc(WWW_Trial_Data(si).main_trial.boundary_crossing == 1 ,:))

    WWW_Behavior_table.cross1_acc_what(si) = nanmean(WWW_Trial_Data(si).main.what(WWW_Trial_Data(si).main.boundary_crossing == 1 ,:));
    WWW_Behavior_table.cross1_acc_whatwhen(si) = nanmean(WWW_Trial_Data(si).main.whatwhen(WWW_Trial_Data(si).main.boundary_crossing == 1 ,:));
    WWW_Behavior_table.cross1_acc_where(si) = nanmean(WWW_Trial_Data(si).main.where(WWW_Trial_Data(si).main.boundary_crossing == 1  ,:));
    WWW_Behavior_table.cross1_acc_wherewhen(si) = nanmean(WWW_Trial_Data(si).main.wherewhen(WWW_Trial_Data(si).main.boundary_crossing == 1 ,:));
    WWW_Behavior_table.cross1_acc_whatwhere(si) = nanmean(WWW_Trial_Data(si).main.whatwhere(WWW_Trial_Data(si).main.boundary_crossing == 1 ,:));
    WWW_Behavior_table.cross1_acc_fullem(si) = nanmean(WWW_Trial_Data(si).main.fullem(WWW_Trial_Data(si).main.boundary_crossing == 1 ,:));


    WWW_Behavior_table.cross1_acc_loc_cat_where(si) = nanmean(WWW_Trial_Data(si).main.location_catAcc_where(WWW_Trial_Data(si).main.boundary_crossing == 1  ,:));
    WWW_Behavior_table.cross1_acc_loc_cat_wherewhen(si) = nanmean(WWW_Trial_Data(si).main.location_catAcc_wherewhen(WWW_Trial_Data(si).main.boundary_crossing == 1 ,:));
    WWW_Behavior_table.cross1_acc_loc_cat_whatwhere(si) = nanmean(WWW_Trial_Data(si).main.location_catAcc_whatwhere(WWW_Trial_Data(si).main.boundary_crossing == 1 ,:));
    WWW_Behavior_table.cross1_acc_loc_cat_fullem(si) = nanmean(WWW_Trial_Data(si).main.location_catAcc_fullem(WWW_Trial_Data(si).main.boundary_crossing == 1 ,:));


    WWW_Behavior_table.cross1_acc_wrong_loc_cat_where(si) = nanmean(WWW_Trial_Data(si).main.location_catAcc_where(WWW_Trial_Data(si).main.where == 0 &WWW_Trial_Data(si).main.boundary_crossing == 1  ,:));
    WWW_Behavior_table.cross1_acc_wrong_loc_cat_wherewhen(si) = nanmean(WWW_Trial_Data(si).main.location_catAcc_wherewhen(WWW_Trial_Data(si).main.where == 0 &WWW_Trial_Data(si).main.boundary_crossing == 1 ,:));
    WWW_Behavior_table.cross1_acc_wrong_loc_cat_whatwhere(si) = nanmean(WWW_Trial_Data(si).main.location_catAcc_whatwhere(WWW_Trial_Data(si).main.where == 0 &WWW_Trial_Data(si).main.boundary_crossing == 1 ,:));
    WWW_Behavior_table.cross1_acc_wrong_loc_cat_fullem(si) = nanmean(WWW_Trial_Data(si).main.location_catAcc_fullem(WWW_Trial_Data(si).main.where == 0 &WWW_Trial_Data(si).main.boundary_crossing == 1 ,:));



    WWW_Behavior_table.cross1_acc_location_cat(si) = nanmean(WWW_Trial_Data(si).main.location_catAcc(ismember(WWW_Trial_Data(si).main.boundary_crossing, [1]) ,:));

    WWW_Behavior_table.cross1_wrong_cat(si) = nanmean(WWW_Trial_Data(si).main.location_catAcc(WWW_Trial_Data(si).main.where == 0 & WWW_Trial_Data(si).main.boundary_crossing == 1,:));    
    

    WWW_Behavior_table.cross1_rt_respond(si) = nanmean(WWW_Trial_Data(si).main.respondRT(ismember(WWW_Trial_Data(si).main.boundary_crossing, [1]) ,:));
    WWW_Behavior_table.cross1_rt_animal(si) = nanmean(WWW_Trial_Data(si).main.animalRT(ismember(WWW_Trial_Data(si).main.boundary_crossing, [1]) ,:));
    WWW_Behavior_table.cross1_rt_location(si) = nanmean(WWW_Trial_Data(si).main.locationRT(ismember(WWW_Trial_Data(si).main.boundary_crossing, [1]) ,:));


    WWW_Behavior_table.cross1_rt_right_respond(si) = nanmean(WWW_Trial_Data(si).main.respondRT(WWW_Trial_Data(si).main.fullem == 1 & ismember(WWW_Trial_Data(si).main.boundary_crossing, [1])));
    WWW_Behavior_table.cross1_rt_right_animal(si) = nanmean(WWW_Trial_Data(si).main.animalRT(WWW_Trial_Data(si).main.animalAcc == 1 & ismember(WWW_Trial_Data(si).main.boundary_crossing, [1])));
    WWW_Behavior_table.cross1_rt_right_location(si) = nanmean(WWW_Trial_Data(si).main.locationRT(WWW_Trial_Data(si).main.locationAcc == 1 & ismember(WWW_Trial_Data(si).main.boundary_crossing, [1])));


    WWW_Behavior_table.cross1_log_rt_respond(si) = nanmean(WWW_Trial_Data(si).main.respondRT_log(ismember(WWW_Trial_Data(si).main.boundary_crossing, [1]) ,:));
    WWW_Behavior_table.cross1_log_rt_animal(si) = nanmean(WWW_Trial_Data(si).main.animalRT_log(ismember(WWW_Trial_Data(si).main.boundary_crossing, [1]) ,:));
    WWW_Behavior_table.cross1_log_rt_location(si) = nanmean(WWW_Trial_Data(si).main.locationRT_log(ismember(WWW_Trial_Data(si).main.boundary_crossing, [1]) ,:));


    WWW_Behavior_table.cross1_log_rt_right_respond(si) = nanmean(WWW_Trial_Data(si).main.respondRT_log(WWW_Trial_Data(si).main.fullem == 1 & ismember(WWW_Trial_Data(si).main.boundary_crossing, [1])));
    WWW_Behavior_table.cross1_log_rt_right_animal(si) = nanmean(WWW_Trial_Data(si).main.animalRT_log(WWW_Trial_Data(si).main.animalAcc == 1 & ismember(WWW_Trial_Data(si).main.boundary_crossing, [1])));
    WWW_Behavior_table.cross1_log_rt_right_location(si) = nanmean(WWW_Trial_Data(si).main.locationRT_log(WWW_Trial_Data(si).main.locationAcc == 1 & ismember(WWW_Trial_Data(si).main.boundary_crossing, [1])));


    WWW_Behavior_table.cross1_log_rt_trial1_respond(si) = nanmean(WWW_Trial_Data(si).main.respondRT_log(ismember(WWW_Trial_Data(si).main.boundary_crossing, [1]) & WWW_Trial_Data(si).main.order == 1 ,:));
    WWW_Behavior_table.cross1_log_rt_trial1_animal(si) = nanmean(WWW_Trial_Data(si).main.animalRT_log(ismember(WWW_Trial_Data(si).main.boundary_crossing, [1])  & WWW_Trial_Data(si).main.order == 1  ,:));
    WWW_Behavior_table.cross1_log_rt_trial1_location(si) = nanmean(WWW_Trial_Data(si).main.locationRT_log(ismember(WWW_Trial_Data(si).main.boundary_crossing, [1])  & WWW_Trial_Data(si).main.order == 1  ,:));


    WWW_Behavior_table.cross1_log_rt_right_trial1_respond(si) = nanmean(WWW_Trial_Data(si).main.respondRT_log(WWW_Trial_Data(si).main.fullem == 1 & ismember(WWW_Trial_Data(si).main.boundary_crossing, [1])  & WWW_Trial_Data(si).main.order == 1 ));
    WWW_Behavior_table.cross1_log_rt_right_trial1_animal(si) = nanmean(WWW_Trial_Data(si).main.animalRT_log(WWW_Trial_Data(si).main.animalAcc == 1 & ismember(WWW_Trial_Data(si).main.boundary_crossing, [1])  & WWW_Trial_Data(si).main.order == 1 ));
    WWW_Behavior_table.cross1_log_rt_right_trial1_location(si) = nanmean(WWW_Trial_Data(si).main.locationRT_log(WWW_Trial_Data(si).main.locationAcc == 1 & ismember(WWW_Trial_Data(si).main.boundary_crossing, [1]) & WWW_Trial_Data(si).main.order == 1 ));



    WWW_Behavior_table.cross1_log_rt_trial2_respond(si) = nanmean(WWW_Trial_Data(si).main.respondRT_log(ismember(WWW_Trial_Data(si).main.boundary_crossing, [1]) & WWW_Trial_Data(si).main.order == 2 ,:));
    WWW_Behavior_table.cross1_log_rt_trial2_animal(si) = nanmean(WWW_Trial_Data(si).main.animalRT_log(ismember(WWW_Trial_Data(si).main.boundary_crossing, [1])  & WWW_Trial_Data(si).main.order == 2  ,:));
    WWW_Behavior_table.cross1_log_rt_trial2_location(si) = nanmean(WWW_Trial_Data(si).main.locationRT_log(ismember(WWW_Trial_Data(si).main.boundary_crossing, [1])  & WWW_Trial_Data(si).main.order == 2  ,:));


    WWW_Behavior_table.cross1_log_rt_right_trial2_respond(si) = nanmean(WWW_Trial_Data(si).main.respondRT_log(WWW_Trial_Data(si).main.fullem == 1 & ismember(WWW_Trial_Data(si).main.boundary_crossing, [1])  & WWW_Trial_Data(si).main.order == 2 ));
    WWW_Behavior_table.cross1_log_rt_right_trial2_animal(si) = nanmean(WWW_Trial_Data(si).main.animalRT_log(WWW_Trial_Data(si).main.animalAcc == 1 & ismember(WWW_Trial_Data(si).main.boundary_crossing, [1])  & WWW_Trial_Data(si).main.order == 2 ));
    WWW_Behavior_table.cross1_log_rt_right_trial2_location(si) = nanmean(WWW_Trial_Data(si).main.locationRT_log(WWW_Trial_Data(si).main.locationAcc == 1 & ismember(WWW_Trial_Data(si).main.boundary_crossing, [1]) & WWW_Trial_Data(si).main.order == 2 ));



    WWW_Behavior_table.cross1_log_rt_trial3_respond(si) = nanmean(WWW_Trial_Data(si).main.respondRT_log(ismember(WWW_Trial_Data(si).main.boundary_crossing, [1]) & WWW_Trial_Data(si).main.order == 3 ,:));
    WWW_Behavior_table.cross1_log_rt_trial3_animal(si) = nanmean(WWW_Trial_Data(si).main.animalRT_log(ismember(WWW_Trial_Data(si).main.boundary_crossing, [1])  & WWW_Trial_Data(si).main.order == 3  ,:));
    WWW_Behavior_table.cross1_log_rt_trial3_location(si) = nanmean(WWW_Trial_Data(si).main.locationRT_log(ismember(WWW_Trial_Data(si).main.boundary_crossing, [1])  & WWW_Trial_Data(si).main.order == 3  ,:));


    WWW_Behavior_table.cross1_log_rt_right_trial3_respond(si) = nanmean(WWW_Trial_Data(si).main.respondRT_log(WWW_Trial_Data(si).main.fullem == 1 & ismember(WWW_Trial_Data(si).main.boundary_crossing, [1])  & WWW_Trial_Data(si).main.order == 3 ));
    WWW_Behavior_table.cross1_log_rt_right_trial3_animal(si) = nanmean(WWW_Trial_Data(si).main.animalRT_log(WWW_Trial_Data(si).main.animalAcc == 1 & ismember(WWW_Trial_Data(si).main.boundary_crossing, [1])  & WWW_Trial_Data(si).main.order == 3 ));
    WWW_Behavior_table.cross1_log_rt_right_trial3_location(si) = nanmean(WWW_Trial_Data(si).main.locationRT_log(WWW_Trial_Data(si).main.locationAcc == 1 & ismember(WWW_Trial_Data(si).main.boundary_crossing, [1]) & WWW_Trial_Data(si).main.order == 3 ));


    
    
    
    
    
    

    if sum(WWW_Trial_Data(si).main.categorical_Acc(ismember(WWW_Trial_Data(si).main.boundary_crossing, [1]) ,:) == 2) + sum(WWW_Trial_Data(si).main.categorical_Acc(ismember(WWW_Trial_Data(si).main.boundary_crossing, [1]) ,:) == 0) ~= 0
        WWW_Behavior_table.cross1_loc_chunking(si) = sum(WWW_Trial_Data(si).main.categorical_Acc(ismember(WWW_Trial_Data(si).main.boundary_crossing, [1]) ,:) == 2) / (sum(WWW_Trial_Data(si).main.categorical_Acc(ismember(WWW_Trial_Data(si).main.boundary_crossing, [1]) ,:) == 2) + sum(WWW_Trial_Data(si).main.categorical_Acc(ismember(WWW_Trial_Data(si).main.boundary_crossing, [1]) ,:) == 0));
    else
        WWW_Behavior_table.cross1_loc_chunking(si) = NaN;
    end


    WWW_Behavior_table.cross2_acc_what(si) = nanmean(WWW_Trial_Data(si).main.what(WWW_Trial_Data(si).main.boundary_crossing == 2 ,:));
    WWW_Behavior_table.cross2_acc_whatwhen(si) = nanmean(WWW_Trial_Data(si).main.whatwhen(WWW_Trial_Data(si).main.boundary_crossing == 2 ,:));
    WWW_Behavior_table.cross2_acc_where(si) = nanmean(WWW_Trial_Data(si).main.where(WWW_Trial_Data(si).main.boundary_crossing == 2  ,:));
    WWW_Behavior_table.cross2_acc_wherewhen(si) = nanmean(WWW_Trial_Data(si).main.wherewhen(WWW_Trial_Data(si).main.boundary_crossing == 2 ,:));
    WWW_Behavior_table.cross2_acc_whatwhere(si) = nanmean(WWW_Trial_Data(si).main.whatwhere(WWW_Trial_Data(si).main.boundary_crossing == 2 ,:));
    WWW_Behavior_table.cross2_acc_fullem(si) = nanmean(WWW_Trial_Data(si).main.fullem(WWW_Trial_Data(si).main.boundary_crossing == 2 ,:));

    WWW_Behavior_table.cross2_rt_respond(si) = nanmean(WWW_Trial_Data(si).main.respondRT(ismember(WWW_Trial_Data(si).main.boundary_crossing, [ 2]) ,:));
    WWW_Behavior_table.cross2_rt_animal(si) = nanmean(WWW_Trial_Data(si).main.animalRT(ismember(WWW_Trial_Data(si).main.boundary_crossing, [ 2]) ,:));
    WWW_Behavior_table.cross2_rt_location(si) = nanmean(WWW_Trial_Data(si).main.locationRT(ismember(WWW_Trial_Data(si).main.boundary_crossing, [ 2]) ,:));
    


    WWW_Behavior_table.cross0and2_acc_what(si) = nanmean(WWW_Trial_Data(si).main.what(ismember(WWW_Trial_Data(si).main.boundary_crossing, [0, 2]) ,:));
    WWW_Behavior_table.cross0and2_acc_whatwhen(si) = nanmean(WWW_Trial_Data(si).main.whatwhen(ismember(WWW_Trial_Data(si).main.boundary_crossing, [0, 2]) ,:));
    WWW_Behavior_table.cross0and2_acc_where(si) = nanmean(WWW_Trial_Data(si).main.where(ismember(WWW_Trial_Data(si).main.boundary_crossing, [0, 2]) ,:));
    WWW_Behavior_table.cross0and2_acc_wherewhen(si) = nanmean(WWW_Trial_Data(si).main.wherewhen(ismember(WWW_Trial_Data(si).main.boundary_crossing, [0, 2]),:));
    WWW_Behavior_table.cross0and2_acc_whatwhere(si) = nanmean(WWW_Trial_Data(si).main.whatwhere(ismember(WWW_Trial_Data(si).main.boundary_crossing, [0, 2]),:));
    WWW_Behavior_table.cross0and2_acc_fullem(si) = nanmean(WWW_Trial_Data(si).main.fullem(ismember(WWW_Trial_Data(si).main.boundary_crossing, [0, 2]),:));

    WWW_Behavior_table.cross0and2_rt_respond(si) = nanmean(WWW_Trial_Data(si).main.respondRT(ismember(WWW_Trial_Data(si).main.boundary_crossing, [0, 2]) ,:));
    WWW_Behavior_table.cross0and2_rt_animal(si) = nanmean(WWW_Trial_Data(si).main.animalRT(ismember(WWW_Trial_Data(si).main.boundary_crossing, [0, 2]) ,:));
    WWW_Behavior_table.cross0and2_rt_location(si) = nanmean(WWW_Trial_Data(si).main.locationRT(ismember(WWW_Trial_Data(si).main.boundary_crossing, [0, 2]) ,:));



    WWW_Behavior_table.cross1and2_acc_what(si) = nanmean(WWW_Trial_Data(si).main.what(ismember(WWW_Trial_Data(si).main.boundary_crossing, [1, 2]) ,:));
    WWW_Behavior_table.cross1and2_acc_whatwhen(si) = nanmean(WWW_Trial_Data(si).main.whatwhen(ismember(WWW_Trial_Data(si).main.boundary_crossing, [1, 2]) ,:));
    WWW_Behavior_table.cross1and2_acc_where(si) = nanmean(WWW_Trial_Data(si).main.where(ismember(WWW_Trial_Data(si).main.boundary_crossing, [1, 2]) ,:));
    WWW_Behavior_table.cross1and2_acc_wherewhen(si) = nanmean(WWW_Trial_Data(si).main.wherewhen(ismember(WWW_Trial_Data(si).main.boundary_crossing, [1, 2]),:));
    WWW_Behavior_table.cross1and2_acc_whatwhere(si) = nanmean(WWW_Trial_Data(si).main.whatwhere(ismember(WWW_Trial_Data(si).main.boundary_crossing, [1, 2]),:));
    WWW_Behavior_table.cross1and2_acc_fullem(si) = nanmean(WWW_Trial_Data(si).main.fullem(ismember(WWW_Trial_Data(si).main.boundary_crossing, [1, 2]),:));

    WWW_Behavior_table.cross1and2_rt_respond(si) = nanmean(WWW_Trial_Data(si).main.respondRT(ismember(WWW_Trial_Data(si).main.boundary_crossing, [1, 2]) ,:));
    WWW_Behavior_table.cross1and2_rt_animal(si) = nanmean(WWW_Trial_Data(si).main.animalRT(ismember(WWW_Trial_Data(si).main.boundary_crossing, [1, 2]) ,:));
    WWW_Behavior_table.cross1and2_rt_location(si) = nanmean(WWW_Trial_Data(si).main.locationRT(ismember(WWW_Trial_Data(si).main.boundary_crossing, [1, 2]) ,:));




end










for si = 1:length(Exp2_sbj_data)
    Exp2_Behavior_table.cross0(si) = sum(Exp2_Trial_Data(si).main.boundary_crossing == 0);
    Exp2_Behavior_table.cross1(si) = sum(Exp2_Trial_Data(si).main.boundary_crossing == 1);
    Exp2_Behavior_table.cross2(si) = sum(Exp2_Trial_Data(si).main.boundary_crossing == 2);
    Exp2_Behavior_table.cross0_ABD(si) = sum(Exp2_Trial_Data(si).main.boundary_crossing == 0 & Exp2_Trial_Data(si).main.boundary == 0);
    Exp2_Behavior_table.cross1_ABD(si) = sum(Exp2_Trial_Data(si).main.boundary_crossing == 1 & Exp2_Trial_Data(si).main.boundary == 0);
    Exp2_Behavior_table.cross2_ABD(si) = sum(Exp2_Trial_Data(si).main.boundary_crossing == 2 & Exp2_Trial_Data(si).main.boundary == 0);
    Exp2_Behavior_table.cross0_MBD(si) = sum(Exp2_Trial_Data(si).main.boundary_crossing == 0 & Exp2_Trial_Data(si).main.boundary == 1);
    Exp2_Behavior_table.cross1_MBD(si) = sum(Exp2_Trial_Data(si).main.boundary_crossing == 1 & Exp2_Trial_Data(si).main.boundary == 1);
    Exp2_Behavior_table.cross2_MBD(si) = sum(Exp2_Trial_Data(si).main.boundary_crossing == 2 & Exp2_Trial_Data(si).main.boundary == 1);    
    % inter trial accuracy
    Exp2_Behavior_table.inter_acc(si) = nanmean(Exp2_Trial_Data(si).inter.correct);
    Exp2_Behavior_table.inter_acc_cat1(si) = nanmean(Exp2_Trial_Data(si).inter.correct(Exp2_Trial_Data(si).inter.condition == 1));
    Exp2_Behavior_table.inter_acc_cat2(si) = nanmean(Exp2_Trial_Data(si).inter.correct(Exp2_Trial_Data(si).inter.condition == 2));
    Exp2_Behavior_table.inter_bnd_use_index(si) = Exp2_Behavior_table.inter_acc_cat2(si) - Exp2_Behavior_table.inter_acc_cat1(si);
    Exp2_Behavior_table.inter_bnd_user(si) = Exp2_Behavior_table.inter_acc_cat1(si) < Exp2_Behavior_table.inter_acc_cat2(si);

    % yj method ( 1 location cat / 2 detail right / 0 really wrong)
%     WWW_ctrl_Trial_Data(si).main.categorical_Acc = WWW_ctrl_Trial_Data(si).main.location_catAcc + WWW_ctrl_Trial_Data(si).main.locationAcc;
    
    if sum(Exp2_Trial_Data(si).main.categorical_Acc == 1) + sum(Exp2_Trial_Data(si).main.categorical_Acc == 0) ~= 0
        Exp2_Behavior_table.loc_chunking(si) = sum(Exp2_Trial_Data(si).main.categorical_Acc == 1) / (sum(Exp2_Trial_Data(si).main.categorical_Acc == 1) + sum(Exp2_Trial_Data(si).main.categorical_Acc == 0));
    else
        Exp2_Behavior_table.loc_chunking(si) = NaN;
    end

    % accuracy
    Exp2_Behavior_table.acc_what(si) = nanmean(Exp2_Trial_Data(si).main.what);
    Exp2_Behavior_table.acc_whatwhen(si) = nanmean(Exp2_Trial_Data(si).main.whatwhen);
    Exp2_Behavior_table.acc_where(si) = nanmean(Exp2_Trial_Data(si).main.where);
    Exp2_Behavior_table.acc_wherewhen(si) = nanmean(Exp2_Trial_Data(si).main.wherewhen);
    Exp2_Behavior_table.acc_whatwhere(si) = nanmean(Exp2_Trial_Data(si).main.whatwhere);
    Exp2_Behavior_table.acc_fullem(si) = nanmean(Exp2_Trial_Data(si).main.fullem);


    % accuracy - location categorically divided
    Exp2_Behavior_table.acc_location_cat(si) = nanmean(Exp2_Trial_Data(si).main.location_catAcc);
    Exp2_Behavior_table.acc_location_cat_only(si) = nanmean(Exp2_Trial_Data(si).main.location_catWhere);


    % reaction time (right or wrong whole)
    Exp2_Behavior_table.rt_respond(si) = nanmean(Exp2_Trial_Data(si).main.respondRT);
    Exp2_Behavior_table.rt_animal(si) = nanmean(Exp2_Trial_Data(si).main.animalRT);
    Exp2_Behavior_table.rt_location(si) = nanmean(Exp2_Trial_Data(si).main.locationRT);

    Exp2_Behavior_table.log_rt_respond(si) = nanmean(Exp2_Trial_Data(si).main.respondRT_log);
    Exp2_Behavior_table.log_rt_animal(si) = nanmean(Exp2_Trial_Data(si).main.animalRT_log);
    Exp2_Behavior_table.log_rt_location(si) = nanmean(Exp2_Trial_Data(si).main.locationRT_log);



    %reaction time (right only)
    Exp2_Behavior_table.rt_right_respond(si) = nanmean(Exp2_Trial_Data(si).main.respondRT(Exp2_Trial_Data(si).main.fullem == 1));
    Exp2_Behavior_table.rt_right_animal(si) = nanmean(Exp2_Trial_Data(si).main.animalRT(Exp2_Trial_Data(si).main.animalAcc == 1));
    Exp2_Behavior_table.rt_right_location(si) = nanmean(Exp2_Trial_Data(si).main.locationRT(Exp2_Trial_Data(si).main.locationAcc == 1));

    Exp2_Behavior_table.log_rt_right_respond(si) = nanmean(Exp2_Trial_Data(si).main.respondRT_log(Exp2_Trial_Data(si).main.fullem == 1));
    Exp2_Behavior_table.log_rt_right_animal(si) = nanmean(Exp2_Trial_Data(si).main.animalRT_log(Exp2_Trial_Data(si).main.animalAcc == 1));
    Exp2_Behavior_table.log_rt_right_location(si) = nanmean(Exp2_Trial_Data(si).main.locationRT_log(Exp2_Trial_Data(si).main.locationAcc == 1));



    % each trial (right & wrong)
    Exp2_Behavior_table.rt_trial1_respond(si) = nanmean(Exp2_Trial_Data(si).main.respondRT(Exp2_Trial_Data(si).main.order == 1));
    Exp2_Behavior_table.rt_trial1_animal(si) = nanmean(Exp2_Trial_Data(si).main.animalRT(Exp2_Trial_Data(si).main.order == 1));
    Exp2_Behavior_table.rt_trial1_location(si) = nanmean(Exp2_Trial_Data(si).main.locationRT(Exp2_Trial_Data(si).main.order == 1));

    Exp2_Behavior_table.rt_trial2_respond(si) = nanmean(Exp2_Trial_Data(si).main.respondRT(Exp2_Trial_Data(si).main.order == 2));
    Exp2_Behavior_table.rt_trial2_animal(si) = nanmean(Exp2_Trial_Data(si).main.animalRT(Exp2_Trial_Data(si).main.order == 2));
    Exp2_Behavior_table.rt_trial2_location(si) = nanmean(Exp2_Trial_Data(si).main.locationRT(Exp2_Trial_Data(si).main.order == 2));

    Exp2_Behavior_table.rt_trial3_respond(si) = nanmean(Exp2_Trial_Data(si).main.respondRT(Exp2_Trial_Data(si).main.order == 3));
    Exp2_Behavior_table.rt_trial3_animal(si) = nanmean(Exp2_Trial_Data(si).main.animalRT(Exp2_Trial_Data(si).main.order == 3));
    Exp2_Behavior_table.rt_trial3_location(si) = nanmean(Exp2_Trial_Data(si).main.locationRT(Exp2_Trial_Data(si).main.order == 3));


    Exp2_Behavior_table.log_rt_trial1_respond(si) = nanmean(Exp2_Trial_Data(si).main.respondRT_log(Exp2_Trial_Data(si).main.order == 1));
    Exp2_Behavior_table.log_rt_trial1_animal(si) = nanmean(Exp2_Trial_Data(si).main.animalRT_log(Exp2_Trial_Data(si).main.order == 1));
    Exp2_Behavior_table.log_rt_trial1_location(si) = nanmean(Exp2_Trial_Data(si).main.locationRT_log(Exp2_Trial_Data(si).main.order == 1));

    Exp2_Behavior_table.log_rt_trial2_respond(si) = nanmean(Exp2_Trial_Data(si).main.respondRT_log(Exp2_Trial_Data(si).main.order == 2));
    Exp2_Behavior_table.log_rt_trial2_animal(si) = nanmean(Exp2_Trial_Data(si).main.animalRT_log(Exp2_Trial_Data(si).main.order == 2));
    Exp2_Behavior_table.log_rt_trial2_location(si) = nanmean(Exp2_Trial_Data(si).main.locationRT_log(Exp2_Trial_Data(si).main.order == 2));

    Exp2_Behavior_table.log_rt_trial3_respond(si) = nanmean(Exp2_Trial_Data(si).main.respondRT_log(Exp2_Trial_Data(si).main.order == 3));
    Exp2_Behavior_table.log_rt_trial3_animal(si) = nanmean(Exp2_Trial_Data(si).main.animalRT_log(Exp2_Trial_Data(si).main.order == 3));
    Exp2_Behavior_table.log_rt_trial3_location(si) = nanmean(Exp2_Trial_Data(si).main.locationRT_log(Exp2_Trial_Data(si).main.order == 3));




    % a signle boundary only
    Exp2_Behavior_table.all_ABD_across_acc(si) = nanmean(Exp2_Trial_Data(si).main_trial.across_acc(Exp2_Trial_Data(si).main_trial.boundary == 0,:))    
    Exp2_Behavior_table.all_ABD_within_acc(si) = nanmean(Exp2_Trial_Data(si).main_trial.within_acc(Exp2_Trial_Data(si).main_trial.boundary == 0,:))    
    Exp2_Behavior_table.all_ABD_acc_what(si) = nanmean(Exp2_Trial_Data(si).main.what(Exp2_Trial_Data(si).main.boundary == 0,:));
    Exp2_Behavior_table.all_ABD_acc_whatwhen(si) = nanmean(Exp2_Trial_Data(si).main.whatwhen(Exp2_Trial_Data(si).main.boundary == 0,:));
    Exp2_Behavior_table.all_ABD_acc_where(si) = nanmean(Exp2_Trial_Data(si).main.where(Exp2_Trial_Data(si).main.boundary == 0,:));
    Exp2_Behavior_table.all_ABD_acc_wherewhen(si) = nanmean(Exp2_Trial_Data(si).main.wherewhen(Exp2_Trial_Data(si).main.boundary == 0,:));
    Exp2_Behavior_table.all_ABD_acc_whatwhere(si) = nanmean(Exp2_Trial_Data(si).main.whatwhere(Exp2_Trial_Data(si).main.boundary == 0,:));
    Exp2_Behavior_table.all_ABD_acc_fullem(si) = nanmean(Exp2_Trial_Data(si).main.fullem(Exp2_Trial_Data(si).main.boundary == 0,:));
    Exp2_Behavior_table.all_ABD_acc_location_cat(si) = nanmean(Exp2_Trial_Data(si).main.location_catAcc(Exp2_Trial_Data(si).main.boundary == 0,:));

    if sum(Exp2_Trial_Data(si).main.categorical_Acc(Exp2_Trial_Data(si).main.boundary == 0,:) == 1) + sum(Exp2_Trial_Data(si).main.categorical_Acc(Exp2_Trial_Data(si).main.boundary == 0,:) == 0) ~= 0
        Exp2_Behavior_table.ABD_loc_chunking(si) = sum(Exp2_Trial_Data(si).main.categorical_Acc(Exp2_Trial_Data(si).main.boundary == 0,:) == 1) / (sum(Exp2_Trial_Data(si).main.categorical_Acc(Exp2_Trial_Data(si).main.boundary == 0,:) == 1) + sum(Exp2_Trial_Data(si).main.categorical_Acc(Exp2_Trial_Data(si).main.boundary == 0,:) == 0));
    else
        Exp2_Behavior_table.ABD_loc_chunking(si) = NaN;
    end


    Exp2_Behavior_table.all_ABD_rt_respond(si) = nanmean(Exp2_Trial_Data(si).main.respondRT(Exp2_Trial_Data(si).main.boundary == 0,:));
    Exp2_Behavior_table.all_ABD_rt_animal(si) = nanmean(Exp2_Trial_Data(si).main.animalRT(Exp2_Trial_Data(si).main.boundary == 0,:));
    Exp2_Behavior_table.all_ABD_rt_location(si) = nanmean(Exp2_Trial_Data(si).main.locationRT(Exp2_Trial_Data(si).main.boundary == 0,:));


    Exp2_Behavior_table.all_ABD_log_rt_respond(si) = nanmean(Exp2_Trial_Data(si).main.respondRT_log(Exp2_Trial_Data(si).main.boundary == 0,:));
    Exp2_Behavior_table.all_ABD_log_rt_animal(si) = nanmean(Exp2_Trial_Data(si).main.animalRT_log(Exp2_Trial_Data(si).main.boundary == 0,:));
    Exp2_Behavior_table.all_ABD_log_rt_location(si) = nanmean(Exp2_Trial_Data(si).main.locationRT_log(Exp2_Trial_Data(si).main.boundary == 0,:));


    % right trials rt only
    Exp2_Behavior_table.all_ABD_rt_right_respond(si) = nanmean(Exp2_Trial_Data(si).main.respondRT(((Exp2_Trial_Data(si).main.boundary == 0) & (Exp2_Trial_Data(si).main.fullem == 1)) == 1,:));
    Exp2_Behavior_table.all_ABD_rt_right_animal(si) = nanmean(Exp2_Trial_Data(si).main.animalRT(((Exp2_Trial_Data(si).main.boundary == 0) & (Exp2_Trial_Data(si).main.animalAcc == 1)) == 1,:));
    Exp2_Behavior_table.all_ABD_rt_right_location(si) = nanmean(Exp2_Trial_Data(si).main.locationRT(((Exp2_Trial_Data(si).main.boundary == 0) & (Exp2_Trial_Data(si).main.locationAcc == 1)) == 1,:));


    Exp2_Behavior_table.all_ABD_log_rt_right_respond(si) = nanmean(Exp2_Trial_Data(si).main.respondRT_log(((Exp2_Trial_Data(si).main.boundary == 0) & (Exp2_Trial_Data(si).main.fullem == 1)) == 1,:));
    Exp2_Behavior_table.all_ABD_log_rt_right_animal(si) = nanmean(Exp2_Trial_Data(si).main.animalRT_log(((Exp2_Trial_Data(si).main.boundary == 0) & (Exp2_Trial_Data(si).main.animalAcc == 1)) == 1,:));
    Exp2_Behavior_table.all_ABD_log_rt_right_location(si) = nanmean(Exp2_Trial_Data(si).main.locationRT_log(((Exp2_Trial_Data(si).main.boundary == 0) & (Exp2_Trial_Data(si).main.locationAcc == 1)) == 1,:));





    % multiple boundary
    Exp2_Behavior_table.all_MBD_across_acc(si) = nanmean(Exp2_Trial_Data(si).main_trial.across_acc(Exp2_Trial_Data(si).main_trial.boundary == 1,:))    
    Exp2_Behavior_table.all_MBD_within_acc(si) = nanmean(Exp2_Trial_Data(si).main_trial.within_acc(Exp2_Trial_Data(si).main_trial.boundary == 1,:))        
    Exp2_Behavior_table.all_MBD_acc_what(si) = nanmean(Exp2_Trial_Data(si).main.what(Exp2_Trial_Data(si).main.boundary == 1,:));
    Exp2_Behavior_table.all_MBD_acc_whatwhen(si) = nanmean(Exp2_Trial_Data(si).main.whatwhen(Exp2_Trial_Data(si).main.boundary == 1,:));
    Exp2_Behavior_table.all_MBD_acc_where(si) = nanmean(Exp2_Trial_Data(si).main.where(Exp2_Trial_Data(si).main.boundary == 1,:));
    Exp2_Behavior_table.all_MBD_acc_wherewhen(si) = nanmean(Exp2_Trial_Data(si).main.wherewhen(Exp2_Trial_Data(si).main.boundary == 1,:));
    Exp2_Behavior_table.all_MBD_acc_whatwhere(si) = nanmean(Exp2_Trial_Data(si).main.whatwhere(Exp2_Trial_Data(si).main.boundary == 1,:));
    Exp2_Behavior_table.all_MBD_acc_fullem(si) = nanmean(Exp2_Trial_Data(si).main.fullem(Exp2_Trial_Data(si).main.boundary == 1,:));
    Exp2_Behavior_table.all_MBD_acc_location_cat(si) = nanmean(Exp2_Trial_Data(si).main.location_catAcc(Exp2_Trial_Data(si).main.boundary == 1,:));

    Exp2_Behavior_table.all_MBD_rt_respond(si) = nanmean(Exp2_Trial_Data(si).main.respondRT(Exp2_Trial_Data(si).main.boundary == 1,:));
    Exp2_Behavior_table.all_MBD_rt_animal(si) = nanmean(Exp2_Trial_Data(si).main.animalRT(Exp2_Trial_Data(si).main.boundary == 1,:));
    Exp2_Behavior_table.all_MBD_rt_location(si) = nanmean(Exp2_Trial_Data(si).main.locationRT(Exp2_Trial_Data(si).main.boundary == 1,:));


    Exp2_Behavior_table.all_MBD_log_rt_respond(si) = nanmean(Exp2_Trial_Data(si).main.respondRT_log(Exp2_Trial_Data(si).main.boundary == 1,:));
    Exp2_Behavior_table.all_MBD_log_rt_animal(si) = nanmean(Exp2_Trial_Data(si).main.animalRT_log(Exp2_Trial_Data(si).main.boundary == 1,:));
    Exp2_Behavior_table.all_MBD_log_rt_location(si) = nanmean(Exp2_Trial_Data(si).main.locationRT_log(Exp2_Trial_Data(si).main.boundary == 1,:));




    if sum(Exp2_Trial_Data(si).main.categorical_Acc(Exp2_Trial_Data(si).main.boundary == 1,:) == 1) + sum(Exp2_Trial_Data(si).main.categorical_Acc(Exp2_Trial_Data(si).main.boundary == 1,:) == 0) ~= 0
        Exp2_Behavior_table.MBD_loc_chunking(si) = sum(Exp2_Trial_Data(si).main.categorical_Acc(Exp2_Trial_Data(si).main.boundary == 1,:) == 1) / (sum(Exp2_Trial_Data(si).main.categorical_Acc(Exp2_Trial_Data(si).main.boundary == 1,:) == 1) + sum(Exp2_Trial_Data(si).main.categorical_Acc(Exp2_Trial_Data(si).main.boundary == 1,:) == 0));
    else
        Exp2_Behavior_table.MBD_loc_chunking(si) = NaN;
    end

    % right trials rt only
    Exp2_Behavior_table.all_MBD_rt_right_respond(si) = nanmean(Exp2_Trial_Data(si).main.respondRT(((Exp2_Trial_Data(si).main.boundary == 1) & (Exp2_Trial_Data(si).main.fullem == 1)) == 1,:));
    Exp2_Behavior_table.all_MBD_rt_right_animal(si) = nanmean(Exp2_Trial_Data(si).main.animalRT(((Exp2_Trial_Data(si).main.boundary == 1) & (Exp2_Trial_Data(si).main.animalAcc == 1)) == 1,:));
    Exp2_Behavior_table.all_MBD_rt_right_location(si) = nanmean(Exp2_Trial_Data(si).main.locationRT(((Exp2_Trial_Data(si).main.boundary == 1) & (Exp2_Trial_Data(si).main.locationAcc == 1)) == 1,:));

    Exp2_Behavior_table.all_MBD_log_rt_right_respond(si) = nanmean(Exp2_Trial_Data(si).main.respondRT_log(((Exp2_Trial_Data(si).main.boundary == 1) & (Exp2_Trial_Data(si).main.fullem == 1)) == 1,:));
    Exp2_Behavior_table.all_MBD_log_rt_right_animal(si) = nanmean(Exp2_Trial_Data(si).main.animalRT_log(((Exp2_Trial_Data(si).main.boundary == 1) & (Exp2_Trial_Data(si).main.animalAcc == 1)) == 1,:));
    Exp2_Behavior_table.all_MBD_log_rt_right_location(si) = nanmean(Exp2_Trial_Data(si).main.locationRT_log(((Exp2_Trial_Data(si).main.boundary == 1) & (Exp2_Trial_Data(si).main.locationAcc == 1)) == 1,:));


  

    %selected (boundary crossing 1) - no right rt yet
    Exp2_Behavior_table.select_acc_what(si) = nanmean(Exp2_Trial_Data(si).main.what(Exp2_Trial_Data(si).main.boundary_cat_okay > 0 ,:));
    Exp2_Behavior_table.select_acc_whatwhen(si) = nanmean(Exp2_Trial_Data(si).main.whatwhen(Exp2_Trial_Data(si).main.boundary_cat_okay > 0 ,:));
    Exp2_Behavior_table.select_acc_where(si) = nanmean(Exp2_Trial_Data(si).main.where(Exp2_Trial_Data(si).main.boundary_cat_okay > 0 ,:));
    Exp2_Behavior_table.select_acc_wherewhen(si) = nanmean(Exp2_Trial_Data(si).main.wherewhen(Exp2_Trial_Data(si).main.boundary_cat_okay > 0 ,:));
    Exp2_Behavior_table.select_acc_whatwhere(si) = nanmean(Exp2_Trial_Data(si).main.whatwhere(Exp2_Trial_Data(si).main.boundary_cat_okay > 0 ,:));
    Exp2_Behavior_table.select_acc_fullem(si) = nanmean(Exp2_Trial_Data(si).main.fullem(Exp2_Trial_Data(si).main.boundary_cat_okay > 0 ,:));

    Exp2_Behavior_table.select_acc_location_cat(si) = nanmean(Exp2_Trial_Data(si).main.location_catAcc(Exp2_Trial_Data(si).main.boundary_cat_okay > 0 ,:));

    if sum(Exp2_Trial_Data(si).main.categorical_Acc(Exp2_Trial_Data(si).main.boundary_cat_okay > 0,:) == 1) + sum(Exp2_Trial_Data(si).main.categorical_Acc( Exp2_Trial_Data(si).main.boundary_cat_okay > 0,:) == 0) ~= 0
        Exp2_Behavior_table.select_loc_chunking(si) = sum(Exp2_Trial_Data(si).main.categorical_Acc(Exp2_Trial_Data(si).main.boundary_cat_okay > 0,:) == 1) / (sum(Exp2_Trial_Data(si).main.categorical_Acc(Exp2_Trial_Data(si).main.boundary_cat_okay > 0,:) == 1) + sum(Exp2_Trial_Data(si).main.categorical_Acc(Exp2_Trial_Data(si).main.boundary_cat_okay > 0,:) == 0));
    else
        Exp2_Behavior_table.select_loc_chunking(si) = NaN;
    end


    Exp2_Behavior_table.select_rt_respond(si) = nanmean(Exp2_Trial_Data(si).main.respondRT(Exp2_Trial_Data(si).main.boundary_cat_okay > 0 ,:));
    Exp2_Behavior_table.select_rt_animal(si) = nanmean(Exp2_Trial_Data(si).main.animalRT(Exp2_Trial_Data(si).main.boundary_cat_okay > 0 ,:));
    Exp2_Behavior_table.select_rt_location(si) = nanmean(Exp2_Trial_Data(si).main.locationRT(Exp2_Trial_Data(si).main.boundary_cat_okay > 0 ,:));

    Exp2_Behavior_table.select_log_rt_respond(si) = nanmean(Exp2_Trial_Data(si).main.respondRT_log(Exp2_Trial_Data(si).main.boundary_cat_okay > 0 ,:));
    Exp2_Behavior_table.select_log_rt_animal(si) = nanmean(Exp2_Trial_Data(si).main.animalRT_log(Exp2_Trial_Data(si).main.boundary_cat_okay > 0 ,:));
    Exp2_Behavior_table.select_log_rt_location(si) = nanmean(Exp2_Trial_Data(si).main.locationRT_log(Exp2_Trial_Data(si).main.boundary_cat_okay > 0 ,:));


    % right trials rt only
    Exp2_Behavior_table.select_rt_right_respond(si) = nanmean(Exp2_Trial_Data(si).main.respondRT(((Exp2_Trial_Data(si).main.fullem == 1)) == 1,:));
    Exp2_Behavior_table.select_rt_right_animal(si) = nanmean(Exp2_Trial_Data(si).main.animalRT(((Exp2_Trial_Data(si).main.animalAcc == 1)) == 1,:));
    Exp2_Behavior_table.select_rt_right_location(si) = nanmean(Exp2_Trial_Data(si).main.locationRT(((Exp2_Trial_Data(si).main.locationAcc == 1)) == 1,:));

    Exp2_Behavior_table.select_log_rt_right_respond(si) = nanmean(Exp2_Trial_Data(si).main.respondRT_log(((Exp2_Trial_Data(si).main.fullem == 1)) == 1,:));
    Exp2_Behavior_table.select_log_rt_right_animal(si) = nanmean(Exp2_Trial_Data(si).main.animalRT_log(((Exp2_Trial_Data(si).main.animalAcc == 1)) == 1,:));
    Exp2_Behavior_table.select_log_rt_right_location(si) = nanmean(Exp2_Trial_Data(si).main.locationRT_log(((Exp2_Trial_Data(si).main.locationAcc == 1)) == 1,:));


    if sum(Exp2_Trial_Data(si).main.categorical_Acc(Exp2_Trial_Data(si).main.boundary == 0 & Exp2_Trial_Data(si).main.boundary_cat_okay > 0,:) == 1) + sum(Exp2_Trial_Data(si).main.categorical_Acc(Exp2_Trial_Data(si).main.boundary == 0 & Exp2_Trial_Data(si).main.boundary_cat_okay > 0,:) == 0) ~= 0
        Exp2_Behavior_table.select_ABD_loc_chunking(si) = sum(Exp2_Trial_Data(si).main.categorical_Acc(Exp2_Trial_Data(si).main.boundary == 0 & Exp2_Trial_Data(si).main.boundary_cat_okay > 0,:) == 1) / (sum(Exp2_Trial_Data(si).main.categorical_Acc(Exp2_Trial_Data(si).main.boundary == 0 & Exp2_Trial_Data(si).main.boundary_cat_okay > 0,:) == 1) + sum(Exp2_Trial_Data(si).main.categorical_Acc(Exp2_Trial_Data(si).main.boundary == 0 & Exp2_Trial_Data(si).main.boundary_cat_okay > 0,:) == 0));
    else
        Exp2_Behavior_table.select_ABD_loc_chunking(si) = NaN;
    end

    Exp2_Behavior_table.select_ABD_across_acc(si) = nanmean(Exp2_Trial_Data(si).main_trial.across_acc(Exp2_Trial_Data(si).main_trial.boundary == 0  & Exp2_Trial_Data(si).main_trial.boundary_1cross_run > 0,:));    
    Exp2_Behavior_table.select_ABD_within_acc(si) = nanmean(Exp2_Trial_Data(si).main_trial.within_acc(Exp2_Trial_Data(si).main_trial.boundary == 0 & Exp2_Trial_Data(si).main_trial.boundary_1cross_run > 0,:));      

    Exp2_Behavior_table.select_ABD_acc_what(si) = nanmean(Exp2_Trial_Data(si).main.what(Exp2_Trial_Data(si).main.boundary == 0 & Exp2_Trial_Data(si).main.boundary_cat_okay > 0 ,:));
    Exp2_Behavior_table.select_ABD_acc_whatwhen(si) = nanmean(Exp2_Trial_Data(si).main.whatwhen(Exp2_Trial_Data(si).main.boundary == 0 & Exp2_Trial_Data(si).main.boundary_cat_okay > 0,:));
    Exp2_Behavior_table.select_ABD_acc_where(si) = nanmean(Exp2_Trial_Data(si).main.where(Exp2_Trial_Data(si).main.boundary == 0 & Exp2_Trial_Data(si).main.boundary_cat_okay > 0,:));
    Exp2_Behavior_table.select_ABD_acc_wherewhen(si) = nanmean(Exp2_Trial_Data(si).main.wherewhen(Exp2_Trial_Data(si).main.boundary == 0 & Exp2_Trial_Data(si).main.boundary_cat_okay > 0,:));
    Exp2_Behavior_table.select_ABD_acc_whatwhere(si) = nanmean(Exp2_Trial_Data(si).main.whatwhere(Exp2_Trial_Data(si).main.boundary == 0 & Exp2_Trial_Data(si).main.boundary_cat_okay > 0,:));
    Exp2_Behavior_table.select_ABD_acc_fullem(si) = nanmean(Exp2_Trial_Data(si).main.fullem(Exp2_Trial_Data(si).main.boundary == 0 & Exp2_Trial_Data(si).main.boundary_cat_okay > 0,:));
    Exp2_Behavior_table.select_ABD_acc_location_cat(si) = nanmean(Exp2_Trial_Data(si).main.location_catAcc(Exp2_Trial_Data(si).main.boundary == 0 & Exp2_Trial_Data(si).main.boundary_cat_okay > 0,:));

    Exp2_Behavior_table.select_ABD_rt_respond(si) = nanmean(Exp2_Trial_Data(si).main.respondRT(Exp2_Trial_Data(si).main.boundary == 0 & Exp2_Trial_Data(si).main.boundary_cat_okay > 0,:));
    Exp2_Behavior_table.select_ABD_rt_animal(si) = nanmean(Exp2_Trial_Data(si).main.animalRT(Exp2_Trial_Data(si).main.boundary == 0 & Exp2_Trial_Data(si).main.boundary_cat_okay > 0,:));
    Exp2_Behavior_table.select_ABD_rt_location(si) = nanmean(Exp2_Trial_Data(si).main.locationRT(Exp2_Trial_Data(si).main.boundary == 0 & Exp2_Trial_Data(si).main.boundary_cat_okay > 0,:));

    Exp2_Behavior_table.select_ABD_rt_right_respond(si) = nanmean(Exp2_Trial_Data(si).main.respondRT(Exp2_Trial_Data(si).main.boundary == 0 & Exp2_Trial_Data(si).main.boundary_cat_okay > 0 & Exp2_Trial_Data(si).main.fullem == 1,:));
    Exp2_Behavior_table.select_ABD_rt_right_animal(si) = nanmean(Exp2_Trial_Data(si).main.animalRT(Exp2_Trial_Data(si).main.boundary == 0 & Exp2_Trial_Data(si).main.boundary_cat_okay > 0 & Exp2_Trial_Data(si).main.animalAcc == 1,:));
    Exp2_Behavior_table.select_ABD_rt_right_location(si) = nanmean(Exp2_Trial_Data(si).main.locationRT(Exp2_Trial_Data(si).main.boundary == 0 & Exp2_Trial_Data(si).main.boundary_cat_okay > 0 & Exp2_Trial_Data(si).main.locationAcc == 1,:));

    Exp2_Behavior_table.select_ABD_log_rt_respond(si) = nanmean(Exp2_Trial_Data(si).main.respondRT_log(Exp2_Trial_Data(si).main.boundary == 0 & Exp2_Trial_Data(si).main.boundary_cat_okay > 0,:));
    Exp2_Behavior_table.select_ABD_log_rt_animal(si) = nanmean(Exp2_Trial_Data(si).main.animalRT_log(Exp2_Trial_Data(si).main.boundary == 0 & Exp2_Trial_Data(si).main.boundary_cat_okay > 0,:));
    Exp2_Behavior_table.select_ABD_log_rt_location(si) = nanmean(Exp2_Trial_Data(si).main.locationRT_log(Exp2_Trial_Data(si).main.boundary == 0 & Exp2_Trial_Data(si).main.boundary_cat_okay > 0,:));

    Exp2_Behavior_table.select_ABD_log_rt_right_respond(si) = nanmean(Exp2_Trial_Data(si).main.respondRT_log(Exp2_Trial_Data(si).main.boundary == 0 & Exp2_Trial_Data(si).main.boundary_cat_okay > 0 & Exp2_Trial_Data(si).main.fullem == 1,:));
    Exp2_Behavior_table.select_ABD_log_rt_right_animal(si) = nanmean(Exp2_Trial_Data(si).main.animalRT_log(Exp2_Trial_Data(si).main.boundary == 0 & Exp2_Trial_Data(si).main.boundary_cat_okay > 0 & Exp2_Trial_Data(si).main.animalAcc == 1,:));
    Exp2_Behavior_table.select_ABD_log_rt_right_location(si) = nanmean(Exp2_Trial_Data(si).main.locationRT_log(Exp2_Trial_Data(si).main.boundary == 0 & Exp2_Trial_Data(si).main.boundary_cat_okay > 0 & Exp2_Trial_Data(si).main.locationAcc == 1,:));




   if sum(Exp2_Trial_Data(si).main.categorical_Acc(Exp2_Trial_Data(si).main.boundary == 1 & Exp2_Trial_Data(si).main.boundary_cat_okay > 0,:) == 1) + sum(Exp2_Trial_Data(si).main.categorical_Acc(Exp2_Trial_Data(si).main.boundary == 1 & Exp2_Trial_Data(si).main.boundary_cat_okay > 0,:) == 0) ~= 0
        Exp2_Behavior_table.select_MBD_loc_chunking(si) = sum(Exp2_Trial_Data(si).main.categorical_Acc(Exp2_Trial_Data(si).main.boundary == 1 & Exp2_Trial_Data(si).main.boundary_cat_okay > 0,:) == 1) / (sum(Exp2_Trial_Data(si).main.categorical_Acc(Exp2_Trial_Data(si).main.boundary == 1 & Exp2_Trial_Data(si).main.boundary_cat_okay > 0,:) == 1) + sum(Exp2_Trial_Data(si).main.categorical_Acc(Exp2_Trial_Data(si).main.boundary == 1 & Exp2_Trial_Data(si).main.boundary_cat_okay > 0,:) == 0));
    else
        Exp2_Behavior_table.select_MBD_loc_chunking(si) = NaN;
   end


    Exp2_Behavior_table.select_MBD_across_acc(si) = nanmean(Exp2_Trial_Data(si).main_trial.across_acc(Exp2_Trial_Data(si).main_trial.boundary == 1  & Exp2_Trial_Data(si).main_trial.boundary_1cross_run > 0,:));
    Exp2_Behavior_table.select_MBD_within_acc(si) = nanmean(Exp2_Trial_Data(si).main_trial.within_acc(Exp2_Trial_Data(si).main_trial.boundary == 1 & Exp2_Trial_Data(si).main_trial.boundary_1cross_run > 0,:));    

    Exp2_Behavior_table.select_MBD_acc_what(si) = nanmean(Exp2_Trial_Data(si).main.what(Exp2_Trial_Data(si).main.boundary == 1 & Exp2_Trial_Data(si).main.boundary_cat_okay > 0,:));
    Exp2_Behavior_table.select_MBD_acc_whatwhen(si) = nanmean(Exp2_Trial_Data(si).main.whatwhen(Exp2_Trial_Data(si).main.boundary == 1 & Exp2_Trial_Data(si).main.boundary_cat_okay > 0,:));
    Exp2_Behavior_table.select_MBD_acc_where(si) = nanmean(Exp2_Trial_Data(si).main.where(Exp2_Trial_Data(si).main.boundary == 1 & Exp2_Trial_Data(si).main.boundary_cat_okay > 0,:));
    Exp2_Behavior_table.select_MBD_acc_wherewhen(si) = nanmean(Exp2_Trial_Data(si).main.wherewhen(Exp2_Trial_Data(si).main.boundary == 1 & Exp2_Trial_Data(si).main.boundary_cat_okay > 0,:));
    Exp2_Behavior_table.select_MBD_acc_whatwhere(si) = nanmean(Exp2_Trial_Data(si).main.whatwhere(Exp2_Trial_Data(si).main.boundary == 1 & Exp2_Trial_Data(si).main.boundary_cat_okay > 0,:));
    Exp2_Behavior_table.select_MBD_acc_fullem(si) = nanmean(Exp2_Trial_Data(si).main.fullem(Exp2_Trial_Data(si).main.boundary == 1 & Exp2_Trial_Data(si).main.boundary_cat_okay > 0,:));
    Exp2_Behavior_table.select_MBD_acc_location_cat(si) = nanmean(Exp2_Trial_Data(si).main.location_catAcc(Exp2_Trial_Data(si).main.boundary == 1 & Exp2_Trial_Data(si).main.boundary_cat_okay > 0,:));

    Exp2_Behavior_table.select_MBD_rt_respond(si) = nanmean(Exp2_Trial_Data(si).main.respondRT(Exp2_Trial_Data(si).main.boundary == 1 & Exp2_Trial_Data(si).main.boundary_cat_okay > 0,:));
    Exp2_Behavior_table.select_MBD_rt_animal(si) = nanmean(Exp2_Trial_Data(si).main.animalRT(Exp2_Trial_Data(si).main.boundary == 1 & Exp2_Trial_Data(si).main.boundary_cat_okay > 0,:));
    Exp2_Behavior_table.select_MBD_rt_location(si) = nanmean(Exp2_Trial_Data(si).main.locationRT(Exp2_Trial_Data(si).main.boundary == 1 & Exp2_Trial_Data(si).main.boundary_cat_okay > 0,:));


    Exp2_Behavior_table.select_MBD_rt_right_respond(si) = nanmean(Exp2_Trial_Data(si).main.respondRT(Exp2_Trial_Data(si).main.boundary == 1 & Exp2_Trial_Data(si).main.boundary_cat_okay > 0 & Exp2_Trial_Data(si).main.fullem == 1,:));
    Exp2_Behavior_table.select_MBD_rt_right_animal(si) = nanmean(Exp2_Trial_Data(si).main.animalRT(Exp2_Trial_Data(si).main.boundary == 1 & Exp2_Trial_Data(si).main.boundary_cat_okay > 0 & Exp2_Trial_Data(si).main.animalAcc == 1,:));
    Exp2_Behavior_table.select_MBD_rt_right_location(si) = nanmean(Exp2_Trial_Data(si).main.locationRT(Exp2_Trial_Data(si).main.boundary == 1 & Exp2_Trial_Data(si).main.boundary_cat_okay > 0 & Exp2_Trial_Data(si).main.locationAcc == 1,:));


    Exp2_Behavior_table.select_MBD_log_rt_respond(si) = nanmean(Exp2_Trial_Data(si).main.respondRT_log(Exp2_Trial_Data(si).main.boundary == 1 & Exp2_Trial_Data(si).main.boundary_cat_okay > 0,:));
    Exp2_Behavior_table.select_MBD_log_rt_animal(si) = nanmean(Exp2_Trial_Data(si).main.animalRT_log(Exp2_Trial_Data(si).main.boundary == 1 & Exp2_Trial_Data(si).main.boundary_cat_okay > 0,:));
    Exp2_Behavior_table.select_MBD_log_rt_location(si) = nanmean(Exp2_Trial_Data(si).main.locationRT_log(Exp2_Trial_Data(si).main.boundary == 1 & Exp2_Trial_Data(si).main.boundary_cat_okay > 0,:));


    Exp2_Behavior_table.select_MBD_log_rt_right_respond(si) = nanmean(Exp2_Trial_Data(si).main.respondRT_log(Exp2_Trial_Data(si).main.boundary == 1 & Exp2_Trial_Data(si).main.boundary_cat_okay > 0 & Exp2_Trial_Data(si).main.fullem == 1,:));
    Exp2_Behavior_table.select_MBD_log_rt_right_animal(si) = nanmean(Exp2_Trial_Data(si).main.animalRT_log(Exp2_Trial_Data(si).main.boundary == 1 & Exp2_Trial_Data(si).main.boundary_cat_okay > 0 & Exp2_Trial_Data(si).main.animalAcc == 1,:));
    Exp2_Behavior_table.select_MBD_log_rt_right_location(si) = nanmean(Exp2_Trial_Data(si).main.locationRT_log(Exp2_Trial_Data(si).main.boundary == 1 & Exp2_Trial_Data(si).main.boundary_cat_okay > 0 & Exp2_Trial_Data(si).main.locationAcc == 1,:));



    % crossing 0
    Exp2_Behavior_table.cross0_acc_what(si) = nanmean(Exp2_Trial_Data(si).main.what(Exp2_Trial_Data(si).main.boundary_crossing == 0 ,:));
    Exp2_Behavior_table.cross0_acc_whatwhen(si) = nanmean(Exp2_Trial_Data(si).main.whatwhen(Exp2_Trial_Data(si).main.boundary_crossing == 0 ,:));
    Exp2_Behavior_table.cross0_acc_where(si) = nanmean(Exp2_Trial_Data(si).main.where(Exp2_Trial_Data(si).main.boundary_crossing == 0  ,:));
    Exp2_Behavior_table.cross0_acc_wherewhen(si) = nanmean(Exp2_Trial_Data(si).main.wherewhen(Exp2_Trial_Data(si).main.boundary_crossing == 0 ,:));
    Exp2_Behavior_table.cross0_acc_whatwhere(si) = nanmean(Exp2_Trial_Data(si).main.whatwhere(Exp2_Trial_Data(si).main.boundary_crossing == 0 ,:));
    Exp2_Behavior_table.cross0_acc_fullem(si) = nanmean(Exp2_Trial_Data(si).main.fullem(Exp2_Trial_Data(si).main.boundary_crossing == 0 ,:));

    Exp2_Behavior_table.cross0_rt_respond(si) = nanmean(Exp2_Trial_Data(si).main.respondRT(Exp2_Trial_Data(si).main.boundary_crossing == 0 ,:));
    Exp2_Behavior_table.cross0_rt_animal(si) = nanmean(Exp2_Trial_Data(si).main.animalRT(Exp2_Trial_Data(si).main.boundary_crossing == 0 ,:));
    Exp2_Behavior_table.cross0_rt_location(si) = nanmean(Exp2_Trial_Data(si).main.locationRT(Exp2_Trial_Data(si).main.boundary_crossing == 0 ,:));

    Exp2_Behavior_table.cross0_ABD_acc_what(si) = nanmean(Exp2_Trial_Data(si).main.what(Exp2_Trial_Data(si).main.boundary == 0 & Exp2_Trial_Data(si).main.boundary_crossing == 0 ,:));
    Exp2_Behavior_table.cross0_ABD_acc_whatwhen(si) = nanmean(Exp2_Trial_Data(si).main.whatwhen(Exp2_Trial_Data(si).main.boundary == 0 & Exp2_Trial_Data(si).main.boundary_crossing == 0,:));
    Exp2_Behavior_table.cross0_ABD_acc_where(si) = nanmean(Exp2_Trial_Data(si).main.where(Exp2_Trial_Data(si).main.boundary == 0 & Exp2_Trial_Data(si).main.boundary_crossing == 0,:));
    Exp2_Behavior_table.cross0_ABD_acc_wherewhen(si) = nanmean(Exp2_Trial_Data(si).main.wherewhen(Exp2_Trial_Data(si).main.boundary == 0 & Exp2_Trial_Data(si).main.boundary_crossing == 0,:));
    Exp2_Behavior_table.cross0_ABD_acc_whatwhere(si) = nanmean(Exp2_Trial_Data(si).main.whatwhere(Exp2_Trial_Data(si).main.boundary == 0 & Exp2_Trial_Data(si).main.boundary_crossing == 0,:));
    Exp2_Behavior_table.cross0_ABD_acc_fullem(si) = nanmean(Exp2_Trial_Data(si).main.fullem(Exp2_Trial_Data(si).main.boundary == 0 & Exp2_Trial_Data(si).main.boundary_crossing == 0,:));
    Exp2_Behavior_table.cross0_ABD_acc_location_cat(si) = nanmean(Exp2_Trial_Data(si).main.location_catAcc(Exp2_Trial_Data(si).main.boundary == 0 & Exp2_Trial_Data(si).main.boundary_crossing == 0,:));

    Exp2_Behavior_table.cross0_ABD_rt_respond(si) = nanmean(Exp2_Trial_Data(si).main.respondRT(Exp2_Trial_Data(si).main.boundary == 0 & Exp2_Trial_Data(si).main.boundary_crossing == 0,:));
    Exp2_Behavior_table.cross0_ABD_rt_animal(si) = nanmean(Exp2_Trial_Data(si).main.animalRT(Exp2_Trial_Data(si).main.boundary == 0 & Exp2_Trial_Data(si).main.boundary_crossing == 0,:));
    Exp2_Behavior_table.cross0_ABD_rt_location(si) = nanmean(Exp2_Trial_Data(si).main.locationRT(Exp2_Trial_Data(si).main.boundary == 0 & Exp2_Trial_Data(si).main.boundary_crossing == 0,:));

    Exp2_Behavior_table.cross0_ABD_rt_right_respond(si) = nanmean(Exp2_Trial_Data(si).main.respondRT(Exp2_Trial_Data(si).main.boundary == 0 & Exp2_Trial_Data(si).main.boundary_crossing == 0 & Exp2_Trial_Data(si).main.fullem == 1,:));
    Exp2_Behavior_table.cross0_ABD_rt_right_animal(si) = nanmean(Exp2_Trial_Data(si).main.animalRT(Exp2_Trial_Data(si).main.boundary == 0 & Exp2_Trial_Data(si).main.boundary_crossing == 0 & Exp2_Trial_Data(si).main.animalAcc == 1,:));
    Exp2_Behavior_table.cross0_ABD_rt_right_location(si) = nanmean(Exp2_Trial_Data(si).main.locationRT(Exp2_Trial_Data(si).main.boundary == 0 & Exp2_Trial_Data(si).main.boundary_crossing == 0 & Exp2_Trial_Data(si).main.locationAcc == 1,:));



    Exp2_Behavior_table.cross0_MBD_acc_what(si) = nanmean(Exp2_Trial_Data(si).main.what(Exp2_Trial_Data(si).main.boundary == 1 & Exp2_Trial_Data(si).main.boundary_crossing == 0,:));
    Exp2_Behavior_table.cross0_MBD_acc_whatwhen(si) = nanmean(Exp2_Trial_Data(si).main.whatwhen(Exp2_Trial_Data(si).main.boundary == 1 & Exp2_Trial_Data(si).main.boundary_crossing == 0,:));
    Exp2_Behavior_table.cross0_MBD_acc_where(si) = nanmean(Exp2_Trial_Data(si).main.where(Exp2_Trial_Data(si).main.boundary == 1 & Exp2_Trial_Data(si).main.boundary_crossing == 0,:));
    Exp2_Behavior_table.cross0_MBD_acc_wherewhen(si) = nanmean(Exp2_Trial_Data(si).main.wherewhen(Exp2_Trial_Data(si).main.boundary == 1 & Exp2_Trial_Data(si).main.boundary_crossing == 0,:));
    Exp2_Behavior_table.cross0_MBD_acc_whatwhere(si) = nanmean(Exp2_Trial_Data(si).main.whatwhere(Exp2_Trial_Data(si).main.boundary == 1 & Exp2_Trial_Data(si).main.boundary_crossing == 0,:));
    Exp2_Behavior_table.cross0_MBD_acc_fullem(si) = nanmean(Exp2_Trial_Data(si).main.fullem(Exp2_Trial_Data(si).main.boundary == 1 & Exp2_Trial_Data(si).main.boundary_crossing == 0,:));
    Exp2_Behavior_table.cross0_MBD_acc_location_cat(si) = nanmean(Exp2_Trial_Data(si).main.location_catAcc(Exp2_Trial_Data(si).main.boundary == 1 & Exp2_Trial_Data(si).main.boundary_crossing == 0,:));

    Exp2_Behavior_table.cross0_MBD_rt_respond(si) = nanmean(Exp2_Trial_Data(si).main.respondRT(Exp2_Trial_Data(si).main.boundary == 1 & Exp2_Trial_Data(si).main.boundary_crossing == 0,:));
    Exp2_Behavior_table.cross0_MBD_rt_animal(si) = nanmean(Exp2_Trial_Data(si).main.animalRT(Exp2_Trial_Data(si).main.boundary == 1 & Exp2_Trial_Data(si).main.boundary_crossing == 0,:));
    Exp2_Behavior_table.cross0_MBD_rt_location(si) = nanmean(Exp2_Trial_Data(si).main.locationRT(Exp2_Trial_Data(si).main.boundary == 1 & Exp2_Trial_Data(si).main.boundary_crossing == 0,:));


    Exp2_Behavior_table.cross0_MBD_rt_right_respond(si) = nanmean(Exp2_Trial_Data(si).main.respondRT(Exp2_Trial_Data(si).main.boundary == 1 & Exp2_Trial_Data(si).main.boundary_crossing == 0 & Exp2_Trial_Data(si).main.fullem == 1,:));
    Exp2_Behavior_table.cross0_MBD_rt_right_animal(si) = nanmean(Exp2_Trial_Data(si).main.animalRT(Exp2_Trial_Data(si).main.boundary == 1 & Exp2_Trial_Data(si).main.boundary_crossing == 0 & Exp2_Trial_Data(si).main.animalAcc == 1,:));
    Exp2_Behavior_table.cross0_MBD_rt_right_location(si) = nanmean(Exp2_Trial_Data(si).main.locationRT(Exp2_Trial_Data(si).main.boundary == 1 & Exp2_Trial_Data(si).main.boundary_crossing == 0 & Exp2_Trial_Data(si).main.locationAcc == 1,:));


    % bnd index 
    Exp2_Behavior_table.cross0_MBD_ABD_acc_what(si) = Exp2_Behavior_table.cross0_MBD_acc_what(si) - Exp2_Behavior_table.cross0_ABD_acc_what(si);
    Exp2_Behavior_table.cross0_MBD_ABD_acc_whatwhen(si) = Exp2_Behavior_table.cross0_MBD_acc_whatwhen(si) - Exp2_Behavior_table.cross0_ABD_acc_whatwhen(si);
    Exp2_Behavior_table.cross0_MBD_ABD_acc_where(si) = Exp2_Behavior_table.cross0_MBD_acc_where(si) - Exp2_Behavior_table.cross0_ABD_acc_where(si);
    Exp2_Behavior_table.cross0_MBD_ABD_acc_wherewhen(si) = Exp2_Behavior_table.cross0_MBD_acc_wherewhen(si) - Exp2_Behavior_table.cross0_ABD_acc_wherewhen(si);
    Exp2_Behavior_table.cross0_MBD_ABD_acc_whatwhere(si) = Exp2_Behavior_table.cross0_MBD_acc_whatwhere(si) - Exp2_Behavior_table.cross0_ABD_acc_whatwhere(si);
    Exp2_Behavior_table.cross0_MBD_ABD_acc_fullem(si) = Exp2_Behavior_table.cross0_MBD_acc_fullem(si) - Exp2_Behavior_table.cross0_ABD_acc_fullem(si);
                        




    % crossing 2

    Exp2_Behavior_table.cross2_acc_what(si) = nanmean(Exp2_Trial_Data(si).main.what(Exp2_Trial_Data(si).main.boundary_crossing == 2 ,:));
    Exp2_Behavior_table.cross2_acc_whatwhen(si) = nanmean(Exp2_Trial_Data(si).main.whatwhen(Exp2_Trial_Data(si).main.boundary_crossing == 2 ,:));
    Exp2_Behavior_table.cross2_acc_where(si) = nanmean(Exp2_Trial_Data(si).main.where(Exp2_Trial_Data(si).main.boundary_crossing == 2 ,:));
    Exp2_Behavior_table.cross2_acc_wherewhen(si) = nanmean(Exp2_Trial_Data(si).main.wherewhen(Exp2_Trial_Data(si).main.boundary_crossing == 2 ,:));
    Exp2_Behavior_table.cross2_acc_whatwhere(si) = nanmean(Exp2_Trial_Data(si).main.whatwhere(Exp2_Trial_Data(si).main.boundary_crossing == 2 ,:));
    Exp2_Behavior_table.cross2_acc_fullem(si) = nanmean(Exp2_Trial_Data(si).main.fullem(Exp2_Trial_Data(si).main.boundary_crossing == 2 ,:));

    Exp2_Behavior_table.cross2_rt_respond(si) = nanmean(Exp2_Trial_Data(si).main.respondRT(Exp2_Trial_Data(si).main.boundary_crossing == 2 ,:));
    Exp2_Behavior_table.cross2_rt_animal(si) = nanmean(Exp2_Trial_Data(si).main.animalRT(Exp2_Trial_Data(si).main.boundary_crossing == 2 ,:));
    Exp2_Behavior_table.cross2_rt_location(si) = nanmean(Exp2_Trial_Data(si).main.locationRT(Exp2_Trial_Data(si).main.boundary_crossing == 2 ,:));

    Exp2_Behavior_table.cross2_ABD_acc_what(si) = nanmean(Exp2_Trial_Data(si).main.what(Exp2_Trial_Data(si).main.boundary == 0 & Exp2_Trial_Data(si).main.boundary_crossing == 2 ,:));
    Exp2_Behavior_table.cross2_ABD_acc_whatwhen(si) = nanmean(Exp2_Trial_Data(si).main.whatwhen(Exp2_Trial_Data(si).main.boundary == 0 & Exp2_Trial_Data(si).main.boundary_crossing == 2,:));
    Exp2_Behavior_table.cross2_ABD_acc_where(si) = nanmean(Exp2_Trial_Data(si).main.where(Exp2_Trial_Data(si).main.boundary == 0 & Exp2_Trial_Data(si).main.boundary_crossing == 2,:));
    Exp2_Behavior_table.cross2_ABD_acc_wherewhen(si) = nanmean(Exp2_Trial_Data(si).main.wherewhen(Exp2_Trial_Data(si).main.boundary == 0 & Exp2_Trial_Data(si).main.boundary_crossing == 2,:));
    Exp2_Behavior_table.cross2_ABD_acc_whatwhere(si) = nanmean(Exp2_Trial_Data(si).main.whatwhere(Exp2_Trial_Data(si).main.boundary == 0 & Exp2_Trial_Data(si).main.boundary_crossing == 2,:));
    Exp2_Behavior_table.cross2_ABD_acc_fullem(si) = nanmean(Exp2_Trial_Data(si).main.fullem(Exp2_Trial_Data(si).main.boundary == 0 & Exp2_Trial_Data(si).main.boundary_crossing == 2,:));
    Exp2_Behavior_table.cross2_ABD_acc_location_cat(si) = nanmean(Exp2_Trial_Data(si).main.location_catAcc(Exp2_Trial_Data(si).main.boundary == 0 & Exp2_Trial_Data(si).main.boundary_crossing == 2,:));

    Exp2_Behavior_table.cross2_ABD_rt_respond(si) = nanmean(Exp2_Trial_Data(si).main.respondRT(Exp2_Trial_Data(si).main.boundary == 0 & Exp2_Trial_Data(si).main.boundary_crossing == 2,:));
    Exp2_Behavior_table.cross2_ABD_rt_animal(si) = nanmean(Exp2_Trial_Data(si).main.animalRT(Exp2_Trial_Data(si).main.boundary == 0 & Exp2_Trial_Data(si).main.boundary_crossing == 2,:));
    Exp2_Behavior_table.cross2_ABD_rt_location(si) = nanmean(Exp2_Trial_Data(si).main.locationRT(Exp2_Trial_Data(si).main.boundary == 0 & Exp2_Trial_Data(si).main.boundary_crossing == 2,:));

    Exp2_Behavior_table.cross2_ABD_rt_right_respond(si) = nanmean(Exp2_Trial_Data(si).main.respondRT(Exp2_Trial_Data(si).main.boundary == 0 & Exp2_Trial_Data(si).main.boundary_crossing == 2 & Exp2_Trial_Data(si).main.fullem == 1,:));
    Exp2_Behavior_table.cross2_ABD_rt_right_animal(si) = nanmean(Exp2_Trial_Data(si).main.animalRT(Exp2_Trial_Data(si).main.boundary == 0 & Exp2_Trial_Data(si).main.boundary_crossing == 2 & Exp2_Trial_Data(si).main.animalAcc == 1,:));
    Exp2_Behavior_table.cross2_ABD_rt_right_location(si) = nanmean(Exp2_Trial_Data(si).main.locationRT(Exp2_Trial_Data(si).main.boundary == 0 & Exp2_Trial_Data(si).main.boundary_crossing == 2 & Exp2_Trial_Data(si).main.locationAcc == 1,:));



    Exp2_Behavior_table.cross2_MBD_acc_what(si) = nanmean(Exp2_Trial_Data(si).main.what(Exp2_Trial_Data(si).main.boundary == 1 & Exp2_Trial_Data(si).main.boundary_crossing == 2,:));
    Exp2_Behavior_table.cross2_MBD_acc_whatwhen(si) = nanmean(Exp2_Trial_Data(si).main.whatwhen(Exp2_Trial_Data(si).main.boundary == 1 & Exp2_Trial_Data(si).main.boundary_crossing == 2,:));
    Exp2_Behavior_table.cross2_MBD_acc_where(si) = nanmean(Exp2_Trial_Data(si).main.where(Exp2_Trial_Data(si).main.boundary == 1 & Exp2_Trial_Data(si).main.boundary_crossing == 2,:));
    Exp2_Behavior_table.cross2_MBD_acc_wherewhen(si) = nanmean(Exp2_Trial_Data(si).main.wherewhen(Exp2_Trial_Data(si).main.boundary == 1 & Exp2_Trial_Data(si).main.boundary_crossing == 2,:));
    Exp2_Behavior_table.cross2_MBD_acc_whatwhere(si) = nanmean(Exp2_Trial_Data(si).main.whatwhere(Exp2_Trial_Data(si).main.boundary == 1 & Exp2_Trial_Data(si).main.boundary_crossing == 2,:));
    Exp2_Behavior_table.cross2_MBD_acc_fullem(si) = nanmean(Exp2_Trial_Data(si).main.fullem(Exp2_Trial_Data(si).main.boundary == 1 & Exp2_Trial_Data(si).main.boundary_crossing == 2,:));
    Exp2_Behavior_table.cross2_MBD_acc_location_cat(si) = nanmean(Exp2_Trial_Data(si).main.location_catAcc(Exp2_Trial_Data(si).main.boundary == 1 & Exp2_Trial_Data(si).main.boundary_crossing == 2,:));

    Exp2_Behavior_table.cross2_MBD_rt_respond(si) = nanmean(Exp2_Trial_Data(si).main.respondRT(Exp2_Trial_Data(si).main.boundary == 1 & Exp2_Trial_Data(si).main.boundary_crossing == 2,:));
    Exp2_Behavior_table.cross2_MBD_rt_animal(si) = nanmean(Exp2_Trial_Data(si).main.animalRT(Exp2_Trial_Data(si).main.boundary == 1 & Exp2_Trial_Data(si).main.boundary_crossing == 2,:));
    Exp2_Behavior_table.cross2_MBD_rt_location(si) = nanmean(Exp2_Trial_Data(si).main.locationRT(Exp2_Trial_Data(si).main.boundary == 1 & Exp2_Trial_Data(si).main.boundary_crossing == 2,:));


    Exp2_Behavior_table.cross2_MBD_rt_right_respond(si) = nanmean(Exp2_Trial_Data(si).main.respondRT(Exp2_Trial_Data(si).main.boundary == 1 & Exp2_Trial_Data(si).main.boundary_crossing == 2 & Exp2_Trial_Data(si).main.fullem == 1,:));
    Exp2_Behavior_table.cross2_MBD_rt_right_animal(si) = nanmean(Exp2_Trial_Data(si).main.animalRT(Exp2_Trial_Data(si).main.boundary == 1 & Exp2_Trial_Data(si).main.boundary_crossing == 2 & Exp2_Trial_Data(si).main.animalAcc == 1,:));
    Exp2_Behavior_table.cross2_MBD_rt_right_location(si) = nanmean(Exp2_Trial_Data(si).main.locationRT(Exp2_Trial_Data(si).main.boundary == 1 & Exp2_Trial_Data(si).main.boundary_crossing == 2 & Exp2_Trial_Data(si).main.locationAcc == 1,:));


    % crossing 0 & 2
    Exp2_Behavior_table.cross0and2_acc_what(si) = nanmean(Exp2_Trial_Data(si).main.what(ismember(Exp2_Trial_Data(si).main.boundary_crossing, [0, 2]) ,:));
    Exp2_Behavior_table.cross0and2_acc_whatwhen(si) = nanmean(Exp2_Trial_Data(si).main.whatwhen(ismember(Exp2_Trial_Data(si).main.boundary_crossing, [0, 2]) ,:));
    Exp2_Behavior_table.cross0and2_acc_where(si) = nanmean(Exp2_Trial_Data(si).main.where(ismember(Exp2_Trial_Data(si).main.boundary_crossing, [0, 2]) ,:));
    Exp2_Behavior_table.cross0and2_acc_wherewhen(si) = nanmean(Exp2_Trial_Data(si).main.wherewhen(ismember(Exp2_Trial_Data(si).main.boundary_crossing, [0, 2]),:));
    Exp2_Behavior_table.cross0and2_acc_whatwhere(si) = nanmean(Exp2_Trial_Data(si).main.whatwhere(ismember(Exp2_Trial_Data(si).main.boundary_crossing, [0, 2]),:));
    Exp2_Behavior_table.cross0and2_acc_fullem(si) = nanmean(Exp2_Trial_Data(si).main.fullem(ismember(Exp2_Trial_Data(si).main.boundary_crossing, [0, 2]),:));


    Exp2_Behavior_table.cross0and2_rt_respond(si) = nanmean(Exp2_Trial_Data(si).main.respondRT(ismember(Exp2_Trial_Data(si).main.boundary_crossing, [0, 2]) ,:));
    Exp2_Behavior_table.cross0and2_rt_animal(si) = nanmean(Exp2_Trial_Data(si).main.animalRT(ismember(Exp2_Trial_Data(si).main.boundary_crossing, [0, 2]) ,:));
    Exp2_Behavior_table.cross0and2_rt_location(si) = nanmean(Exp2_Trial_Data(si).main.locationRT(ismember(Exp2_Trial_Data(si).main.boundary_crossing, [0, 2]) ,:));

    Exp2_Behavior_table.cross0and2_ABD_acc_what(si) = nanmean(Exp2_Trial_Data(si).main.what(Exp2_Trial_Data(si).main.boundary == 0 & ismember(Exp2_Trial_Data(si).main.boundary_crossing, [0, 2]) ,:));
    Exp2_Behavior_table.cross0and2_ABD_acc_whatwhen(si) = nanmean(Exp2_Trial_Data(si).main.whatwhen(Exp2_Trial_Data(si).main.boundary == 0 & ismember(Exp2_Trial_Data(si).main.boundary_crossing, [0, 2]),:));
    Exp2_Behavior_table.cross0and2_ABD_acc_where(si) = nanmean(Exp2_Trial_Data(si).main.where(Exp2_Trial_Data(si).main.boundary == 0 & ismember(Exp2_Trial_Data(si).main.boundary_crossing, [0, 2]),:));
    Exp2_Behavior_table.cross0and2_ABD_acc_wherewhen(si) = nanmean(Exp2_Trial_Data(si).main.wherewhen(Exp2_Trial_Data(si).main.boundary == 0 & ismember(Exp2_Trial_Data(si).main.boundary_crossing, [0, 2]),:));
    Exp2_Behavior_table.cross0and2_ABD_acc_whatwhere(si) = nanmean(Exp2_Trial_Data(si).main.whatwhere(Exp2_Trial_Data(si).main.boundary == 0 & ismember(Exp2_Trial_Data(si).main.boundary_crossing, [0, 2]),:));
    Exp2_Behavior_table.cross0and2_ABD_acc_fullem(si) = nanmean(Exp2_Trial_Data(si).main.fullem(Exp2_Trial_Data(si).main.boundary == 0 & ismember(Exp2_Trial_Data(si).main.boundary_crossing, [0, 2]),:));
    Exp2_Behavior_table.cross0and2_ABD_acc_location_cat(si) = nanmean(Exp2_Trial_Data(si).main.location_catAcc(Exp2_Trial_Data(si).main.boundary == 0 & ismember(Exp2_Trial_Data(si).main.boundary_crossing, [0, 2]),:));

    Exp2_Behavior_table.cross0and2_ABD_rt_respond(si) = nanmean(Exp2_Trial_Data(si).main.respondRT(Exp2_Trial_Data(si).main.boundary == 0 & ismember(Exp2_Trial_Data(si).main.boundary_crossing, [0, 2]),:));
    Exp2_Behavior_table.cross0and2_ABD_rt_animal(si) = nanmean(Exp2_Trial_Data(si).main.animalRT(Exp2_Trial_Data(si).main.boundary == 0 & ismember(Exp2_Trial_Data(si).main.boundary_crossing, [0, 2]),:));
    Exp2_Behavior_table.cross0and2_ABD_rt_location(si) = nanmean(Exp2_Trial_Data(si).main.locationRT(Exp2_Trial_Data(si).main.boundary == 0 & ismember(Exp2_Trial_Data(si).main.boundary_crossing, [0, 2]),:));

    Exp2_Behavior_table.cross0and2_ABD_rt_right_respond(si) = nanmean(Exp2_Trial_Data(si).main.respondRT(Exp2_Trial_Data(si).main.boundary == 0 & ismember(Exp2_Trial_Data(si).main.boundary_crossing, [0, 2]) & Exp2_Trial_Data(si).main.fullem == 1,:));
    Exp2_Behavior_table.cross0and2_ABD_rt_right_animal(si) = nanmean(Exp2_Trial_Data(si).main.animalRT(Exp2_Trial_Data(si).main.boundary == 0 & ismember(Exp2_Trial_Data(si).main.boundary_crossing, [0, 2]) & Exp2_Trial_Data(si).main.animalAcc == 1,:));
    Exp2_Behavior_table.cross0and2_ABD_rt_right_location(si) = nanmean(Exp2_Trial_Data(si).main.locationRT(Exp2_Trial_Data(si).main.boundary == 0 & ismember(Exp2_Trial_Data(si).main.boundary_crossing, [0, 2]) & Exp2_Trial_Data(si).main.locationAcc == 1,:));



    Exp2_Behavior_table.cross0and2_MBD_acc_what(si) = nanmean(Exp2_Trial_Data(si).main.what(Exp2_Trial_Data(si).main.boundary == 1 & ismember(Exp2_Trial_Data(si).main.boundary_crossing, [0, 2]),:));
    Exp2_Behavior_table.cross0and2_MBD_acc_whatwhen(si) = nanmean(Exp2_Trial_Data(si).main.whatwhen(Exp2_Trial_Data(si).main.boundary == 1 & ismember(Exp2_Trial_Data(si).main.boundary_crossing, [0, 2]),:));
    Exp2_Behavior_table.cross0and2_MBD_acc_where(si) = nanmean(Exp2_Trial_Data(si).main.where(Exp2_Trial_Data(si).main.boundary == 1 & ismember(Exp2_Trial_Data(si).main.boundary_crossing, [0, 2]),:));
    Exp2_Behavior_table.cross0and2_MBD_acc_wherewhen(si) = nanmean(Exp2_Trial_Data(si).main.wherewhen(Exp2_Trial_Data(si).main.boundary == 1 & ismember(Exp2_Trial_Data(si).main.boundary_crossing, [0, 2]),:));
    Exp2_Behavior_table.cross0and2_MBD_acc_whatwhere(si) = nanmean(Exp2_Trial_Data(si).main.whatwhere(Exp2_Trial_Data(si).main.boundary == 1 & ismember(Exp2_Trial_Data(si).main.boundary_crossing, [0, 2]),:));
    Exp2_Behavior_table.cross0and2_MBD_acc_fullem(si) = nanmean(Exp2_Trial_Data(si).main.fullem(Exp2_Trial_Data(si).main.boundary == 1 & ismember(Exp2_Trial_Data(si).main.boundary_crossing, [0, 2]),:));
    Exp2_Behavior_table.cross0and2_MBD_acc_location_cat(si) = nanmean(Exp2_Trial_Data(si).main.location_catAcc(Exp2_Trial_Data(si).main.boundary == 1 & ismember(Exp2_Trial_Data(si).main.boundary_crossing, [0, 2]),:));

    Exp2_Behavior_table.cross0and2_MBD_rt_respond(si) = nanmean(Exp2_Trial_Data(si).main.respondRT(Exp2_Trial_Data(si).main.boundary == 1 & ismember(Exp2_Trial_Data(si).main.boundary_crossing, [0, 2]),:));
    Exp2_Behavior_table.cross0and2_MBD_rt_animal(si) = nanmean(Exp2_Trial_Data(si).main.animalRT(Exp2_Trial_Data(si).main.boundary == 1 & ismember(Exp2_Trial_Data(si).main.boundary_crossing, [0, 2]),:));
    Exp2_Behavior_table.cross0and2_MBD_rt_location(si) = nanmean(Exp2_Trial_Data(si).main.locationRT(Exp2_Trial_Data(si).main.boundary == 1 & ismember(Exp2_Trial_Data(si).main.boundary_crossing, [0, 2]),:));


    Exp2_Behavior_table.cross0and2_MBD_rt_right_respond(si) = nanmean(Exp2_Trial_Data(si).main.respondRT(Exp2_Trial_Data(si).main.boundary == 1 & ismember(Exp2_Trial_Data(si).main.boundary_crossing, [0, 2]) & Exp2_Trial_Data(si).main.fullem == 1,:));
    Exp2_Behavior_table.cross0and2_MBD_rt_right_animal(si) = nanmean(Exp2_Trial_Data(si).main.animalRT(Exp2_Trial_Data(si).main.boundary == 1 & ismember(Exp2_Trial_Data(si).main.boundary_crossing, [0, 2]) & Exp2_Trial_Data(si).main.animalAcc == 1,:));
    Exp2_Behavior_table.cross0and2_MBD_rt_right_location(si) = nanmean(Exp2_Trial_Data(si).main.locationRT(Exp2_Trial_Data(si).main.boundary == 1 & ismember(Exp2_Trial_Data(si).main.boundary_crossing, [0, 2]) & Exp2_Trial_Data(si).main.locationAcc == 1,:));


    % crossing 1 & 2
    Exp2_Behavior_table.cross1and2_acc_what(si) = nanmean(Exp2_Trial_Data(si).main.what(ismember(Exp2_Trial_Data(si).main.boundary_crossing, [1, 2]) ,:));
    Exp2_Behavior_table.cross1and2_acc_whatwhen(si) = nanmean(Exp2_Trial_Data(si).main.whatwhen(ismember(Exp2_Trial_Data(si).main.boundary_crossing, [1, 2]) ,:));
    Exp2_Behavior_table.cross1and2_acc_where(si) = nanmean(Exp2_Trial_Data(si).main.where(ismember(Exp2_Trial_Data(si).main.boundary_crossing, [1, 2]) ,:));
    Exp2_Behavior_table.cross1and2_acc_wherewhen(si) = nanmean(Exp2_Trial_Data(si).main.wherewhen(ismember(Exp2_Trial_Data(si).main.boundary_crossing, [1, 2]),:));
    Exp2_Behavior_table.cross1and2_acc_whatwhere(si) = nanmean(Exp2_Trial_Data(si).main.whatwhere(ismember(Exp2_Trial_Data(si).main.boundary_crossing, [1, 2]),:));
    Exp2_Behavior_table.cross1and2_acc_fullem(si) = nanmean(Exp2_Trial_Data(si).main.fullem(ismember(Exp2_Trial_Data(si).main.boundary_crossing, [1, 2]),:));


    Exp2_Behavior_table.cross1and2_rt_respond(si) = nanmean(Exp2_Trial_Data(si).main.respondRT(ismember(Exp2_Trial_Data(si).main.boundary_crossing, [1, 2]) ,:));
    Exp2_Behavior_table.cross1and2_rt_animal(si) = nanmean(Exp2_Trial_Data(si).main.animalRT(ismember(Exp2_Trial_Data(si).main.boundary_crossing, [1, 2]) ,:));
    Exp2_Behavior_table.cross1and2_rt_location(si) = nanmean(Exp2_Trial_Data(si).main.locationRT(ismember(Exp2_Trial_Data(si).main.boundary_crossing, [1, 2]) ,:));


    Exp2_Behavior_table.cross1and2_ABD_acc_what(si) = nanmean(Exp2_Trial_Data(si).main.what(Exp2_Trial_Data(si).main.boundary == 0 & ismember(Exp2_Trial_Data(si).main.boundary_crossing, [1, 2]) ,:));
    Exp2_Behavior_table.cross1and2_ABD_acc_whatwhen(si) = nanmean(Exp2_Trial_Data(si).main.whatwhen(Exp2_Trial_Data(si).main.boundary == 0 & ismember(Exp2_Trial_Data(si).main.boundary_crossing, [1, 2]),:));
    Exp2_Behavior_table.cross1and2_ABD_acc_where(si) = nanmean(Exp2_Trial_Data(si).main.where(Exp2_Trial_Data(si).main.boundary == 0 & ismember(Exp2_Trial_Data(si).main.boundary_crossing, [1, 2]),:));
    Exp2_Behavior_table.cross1and2_ABD_acc_wherewhen(si) = nanmean(Exp2_Trial_Data(si).main.wherewhen(Exp2_Trial_Data(si).main.boundary == 0 & ismember(Exp2_Trial_Data(si).main.boundary_crossing, [1, 2]),:));
    Exp2_Behavior_table.cross1and2_ABD_acc_whatwhere(si) = nanmean(Exp2_Trial_Data(si).main.whatwhere(Exp2_Trial_Data(si).main.boundary == 0 & ismember(Exp2_Trial_Data(si).main.boundary_crossing, [1, 2]),:));
    Exp2_Behavior_table.cross1and2_ABD_acc_fullem(si) = nanmean(Exp2_Trial_Data(si).main.fullem(Exp2_Trial_Data(si).main.boundary == 0 & ismember(Exp2_Trial_Data(si).main.boundary_crossing, [1, 2]),:));
    Exp2_Behavior_table.cross1and2_ABD_acc_location_cat(si) = nanmean(Exp2_Trial_Data(si).main.location_catAcc(Exp2_Trial_Data(si).main.boundary == 0 & ismember(Exp2_Trial_Data(si).main.boundary_crossing, [1, 2]),:));

    Exp2_Behavior_table.cross1and2_ABD_rt_respond(si) = nanmean(Exp2_Trial_Data(si).main.respondRT(Exp2_Trial_Data(si).main.boundary == 0 & ismember(Exp2_Trial_Data(si).main.boundary_crossing, [1, 2]),:));
    Exp2_Behavior_table.cross1and2_ABD_rt_animal(si) = nanmean(Exp2_Trial_Data(si).main.animalRT(Exp2_Trial_Data(si).main.boundary == 0 & ismember(Exp2_Trial_Data(si).main.boundary_crossing, [1, 2]),:));
    Exp2_Behavior_table.cross1and2_ABD_rt_location(si) = nanmean(Exp2_Trial_Data(si).main.locationRT(Exp2_Trial_Data(si).main.boundary == 0 & ismember(Exp2_Trial_Data(si).main.boundary_crossing, [1, 2]),:));

    Exp2_Behavior_table.cross1and2_ABD_rt_right_respond(si) = nanmean(Exp2_Trial_Data(si).main.respondRT(Exp2_Trial_Data(si).main.boundary == 0 & ismember(Exp2_Trial_Data(si).main.boundary_crossing, [1, 2]) & Exp2_Trial_Data(si).main.fullem == 1,:));
    Exp2_Behavior_table.cross1and2_ABD_rt_right_animal(si) = nanmean(Exp2_Trial_Data(si).main.animalRT(Exp2_Trial_Data(si).main.boundary == 0 & ismember(Exp2_Trial_Data(si).main.boundary_crossing, [1, 2]) & Exp2_Trial_Data(si).main.animalAcc == 1,:));
    Exp2_Behavior_table.cross1and2_ABD_rt_right_location(si) = nanmean(Exp2_Trial_Data(si).main.locationRT(Exp2_Trial_Data(si).main.boundary == 0 & ismember(Exp2_Trial_Data(si).main.boundary_crossing, [1, 2]) & Exp2_Trial_Data(si).main.locationAcc == 1,:));



    Exp2_Behavior_table.cross1and2_MBD_acc_what(si) = nanmean(Exp2_Trial_Data(si).main.what(Exp2_Trial_Data(si).main.boundary == 1 & ismember(Exp2_Trial_Data(si).main.boundary_crossing, [1, 2]),:));
    Exp2_Behavior_table.cross1and2_MBD_acc_whatwhen(si) = nanmean(Exp2_Trial_Data(si).main.whatwhen(Exp2_Trial_Data(si).main.boundary == 1 & ismember(Exp2_Trial_Data(si).main.boundary_crossing, [1, 2]),:));
    Exp2_Behavior_table.cross1and2_MBD_acc_where(si) = nanmean(Exp2_Trial_Data(si).main.where(Exp2_Trial_Data(si).main.boundary == 1 & ismember(Exp2_Trial_Data(si).main.boundary_crossing, [1, 2]),:));
    Exp2_Behavior_table.cross1and2_MBD_acc_wherewhen(si) = nanmean(Exp2_Trial_Data(si).main.wherewhen(Exp2_Trial_Data(si).main.boundary == 1 & ismember(Exp2_Trial_Data(si).main.boundary_crossing, [1, 2]),:));
    Exp2_Behavior_table.cross1and2_MBD_acc_whatwhere(si) = nanmean(Exp2_Trial_Data(si).main.whatwhere(Exp2_Trial_Data(si).main.boundary == 1 & ismember(Exp2_Trial_Data(si).main.boundary_crossing, [1, 2]),:));
    Exp2_Behavior_table.cross1and2_MBD_acc_fullem(si) = nanmean(Exp2_Trial_Data(si).main.fullem(Exp2_Trial_Data(si).main.boundary == 1 & ismember(Exp2_Trial_Data(si).main.boundary_crossing, [1, 2]),:));
    Exp2_Behavior_table.cross1and2_MBD_acc_location_cat(si) = nanmean(Exp2_Trial_Data(si).main.location_catAcc(Exp2_Trial_Data(si).main.boundary == 1 & ismember(Exp2_Trial_Data(si).main.boundary_crossing, [1, 2]),:));

    Exp2_Behavior_table.cross1and2_MBD_rt_respond(si) = nanmean(Exp2_Trial_Data(si).main.respondRT(Exp2_Trial_Data(si).main.boundary == 1 & ismember(Exp2_Trial_Data(si).main.boundary_crossing, [1, 2]),:));
    Exp2_Behavior_table.cross1and2_MBD_rt_animal(si) = nanmean(Exp2_Trial_Data(si).main.animalRT(Exp2_Trial_Data(si).main.boundary == 1 & ismember(Exp2_Trial_Data(si).main.boundary_crossing, [1, 2]),:));
    Exp2_Behavior_table.cross1and2_MBD_rt_location(si) = nanmean(Exp2_Trial_Data(si).main.locationRT(Exp2_Trial_Data(si).main.boundary == 1 & ismember(Exp2_Trial_Data(si).main.boundary_crossing, [1, 2]),:));


    Exp2_Behavior_table.cross1and2_MBD_rt_right_respond(si) = nanmean(Exp2_Trial_Data(si).main.respondRT(Exp2_Trial_Data(si).main.boundary == 1 & ismember(Exp2_Trial_Data(si).main.boundary_crossing, [1, 2]) & Exp2_Trial_Data(si).main.fullem == 1,:));
    Exp2_Behavior_table.cross1and2_MBD_rt_right_animal(si) = nanmean(Exp2_Trial_Data(si).main.animalRT(Exp2_Trial_Data(si).main.boundary == 1 & ismember(Exp2_Trial_Data(si).main.boundary_crossing, [1, 2]) & Exp2_Trial_Data(si).main.animalAcc == 1,:));
    Exp2_Behavior_table.cross1and2_MBD_rt_right_location(si) = nanmean(Exp2_Trial_Data(si).main.locationRT(Exp2_Trial_Data(si).main.boundary == 1 & ismember(Exp2_Trial_Data(si).main.boundary_crossing, [1, 2]) & Exp2_Trial_Data(si).main.locationAcc == 1,:));


    % bnd index (multi - audio)
    Exp2_Behavior_table.all_MBD_ABD_acc_what(si) = Exp2_Behavior_table.all_MBD_acc_what(si) - Exp2_Behavior_table.all_ABD_acc_what(si);
    Exp2_Behavior_table.all_MBD_ABD_acc_whatwhen(si) = Exp2_Behavior_table.all_MBD_acc_whatwhen(si) - Exp2_Behavior_table.all_ABD_acc_whatwhen(si);
    Exp2_Behavior_table.all_MBD_ABD_acc_where(si) = Exp2_Behavior_table.all_MBD_acc_where(si) - Exp2_Behavior_table.all_ABD_acc_where(si);
    Exp2_Behavior_table.all_MBD_ABD_acc_wherewhen(si) = Exp2_Behavior_table.all_MBD_acc_wherewhen(si) - Exp2_Behavior_table.all_ABD_acc_wherewhen(si);
    Exp2_Behavior_table.all_MBD_ABD_acc_whatwhere(si) = Exp2_Behavior_table.all_MBD_acc_whatwhere(si) - Exp2_Behavior_table.all_ABD_acc_whatwhere(si);
    Exp2_Behavior_table.all_MBD_ABD_acc_fullem(si) = Exp2_Behavior_table.all_MBD_acc_fullem(si) - Exp2_Behavior_table.all_ABD_acc_fullem(si);
                        

    Exp2_Behavior_table.select_MBD_ABD_acc_what(si) = Exp2_Behavior_table.select_MBD_acc_what(si) - Exp2_Behavior_table.select_ABD_acc_what(si);
    Exp2_Behavior_table.select_MBD_ABD_acc_whatwhen(si) = Exp2_Behavior_table.select_MBD_acc_whatwhen(si) - Exp2_Behavior_table.select_ABD_acc_whatwhen(si);
    Exp2_Behavior_table.select_MBD_ABD_acc_where(si) = Exp2_Behavior_table.select_MBD_acc_where(si) - Exp2_Behavior_table.select_ABD_acc_where(si);
    Exp2_Behavior_table.select_MBD_ABD_acc_wherewhen(si) = Exp2_Behavior_table.select_MBD_acc_wherewhen(si) - Exp2_Behavior_table.select_ABD_acc_wherewhen(si);
    Exp2_Behavior_table.select_MBD_ABD_acc_whatwhere(si) = Exp2_Behavior_table.select_MBD_acc_whatwhere(si) - Exp2_Behavior_table.select_ABD_acc_whatwhere(si);
    Exp2_Behavior_table.select_MBD_ABD_acc_fullem(si) = Exp2_Behavior_table.select_MBD_acc_fullem(si) - Exp2_Behavior_table.select_ABD_acc_fullem(si);
                   
    Exp2_Behavior_table.cross0_MBD_ABD_acc_what(si) = Exp2_Behavior_table.cross0_MBD_acc_what(si) - Exp2_Behavior_table.cross0_ABD_acc_what(si);
    Exp2_Behavior_table.cross0_MBD_ABD_acc_whatwhen(si) = Exp2_Behavior_table.cross0_MBD_acc_whatwhen(si) - Exp2_Behavior_table.cross0_ABD_acc_whatwhen(si);
    Exp2_Behavior_table.cross0_MBD_ABD_acc_where(si) = Exp2_Behavior_table.cross0_MBD_acc_where(si) - Exp2_Behavior_table.cross0_ABD_acc_where(si);
    Exp2_Behavior_table.cross0_MBD_ABD_acc_wherewhen(si) = Exp2_Behavior_table.cross0_MBD_acc_wherewhen(si) - Exp2_Behavior_table.cross0_ABD_acc_wherewhen(si);
    Exp2_Behavior_table.cross0_MBD_ABD_acc_whatwhere(si) = Exp2_Behavior_table.cross0_MBD_acc_whatwhere(si) - Exp2_Behavior_table.cross0_ABD_acc_whatwhere(si);
    Exp2_Behavior_table.cross0_MBD_ABD_acc_fullem(si) = Exp2_Behavior_table.cross0_MBD_acc_fullem(si) - Exp2_Behavior_table.cross0_ABD_acc_fullem(si);
                   
                   
    Exp2_Behavior_table.cross2_MBD_ABD_acc_what(si) = Exp2_Behavior_table.cross2_MBD_acc_what(si) - Exp2_Behavior_table.cross2_ABD_acc_what(si);
    Exp2_Behavior_table.cross2_MBD_ABD_acc_whatwhen(si) = Exp2_Behavior_table.cross2_MBD_acc_whatwhen(si) - Exp2_Behavior_table.cross2_ABD_acc_whatwhen(si);
    Exp2_Behavior_table.cross2_MBD_ABD_acc_where(si) = Exp2_Behavior_table.cross2_MBD_acc_where(si) - Exp2_Behavior_table.cross2_ABD_acc_where(si);
    Exp2_Behavior_table.cross2_MBD_ABD_acc_wherewhen(si) = Exp2_Behavior_table.cross2_MBD_acc_wherewhen(si) - Exp2_Behavior_table.cross2_ABD_acc_wherewhen(si);
    Exp2_Behavior_table.cross2_MBD_ABD_acc_whatwhere(si) = Exp2_Behavior_table.cross2_MBD_acc_whatwhere(si) - Exp2_Behavior_table.cross2_ABD_acc_whatwhere(si);
    Exp2_Behavior_table.cross2_MBD_ABD_acc_fullem(si) = Exp2_Behavior_table.cross2_MBD_acc_fullem(si) - Exp2_Behavior_table.cross2_ABD_acc_fullem(si);
                   
                   
    Exp2_Behavior_table.cross0and2_MBD_ABD_acc_what(si) = Exp2_Behavior_table.cross0and2_MBD_acc_what(si) - Exp2_Behavior_table.cross0and2_ABD_acc_what(si);
    Exp2_Behavior_table.cross0and2_MBD_ABD_acc_whatwhen(si) = Exp2_Behavior_table.cross0and2_MBD_acc_whatwhen(si) - Exp2_Behavior_table.cross0and2_ABD_acc_whatwhen(si);
    Exp2_Behavior_table.cross0and2_MBD_ABD_acc_where(si) = Exp2_Behavior_table.cross0and2_MBD_acc_where(si) - Exp2_Behavior_table.cross0and2_ABD_acc_where(si);
    Exp2_Behavior_table.cross0and2_MBD_ABD_acc_wherewhen(si) = Exp2_Behavior_table.cross0and2_MBD_acc_wherewhen(si) - Exp2_Behavior_table.cross0and2_ABD_acc_wherewhen(si);
    Exp2_Behavior_table.cross0and2_MBD_ABD_acc_whatwhere(si) = Exp2_Behavior_table.cross0and2_MBD_acc_whatwhere(si) - Exp2_Behavior_table.cross0and2_ABD_acc_whatwhere(si);
    Exp2_Behavior_table.cross0and2_MBD_ABD_acc_fullem(si) = Exp2_Behavior_table.cross0and2_MBD_acc_fullem(si) - Exp2_Behavior_table.cross0and2_ABD_acc_fullem(si);
                   
    Exp2_Behavior_table.cross1and2_MBD_ABD_acc_what(si) = Exp2_Behavior_table.cross1and2_MBD_acc_what(si) - Exp2_Behavior_table.cross1and2_ABD_acc_what(si);
    Exp2_Behavior_table.cross1and2_MBD_ABD_acc_whatwhen(si) = Exp2_Behavior_table.cross1and2_MBD_acc_whatwhen(si) - Exp2_Behavior_table.cross1and2_ABD_acc_whatwhen(si);
    Exp2_Behavior_table.cross1and2_MBD_ABD_acc_where(si) = Exp2_Behavior_table.cross1and2_MBD_acc_where(si) - Exp2_Behavior_table.cross1and2_ABD_acc_where(si);
    Exp2_Behavior_table.cross1and2_MBD_ABD_acc_wherewhen(si) = Exp2_Behavior_table.cross1and2_MBD_acc_wherewhen(si) - Exp2_Behavior_table.cross1and2_ABD_acc_wherewhen(si);
    Exp2_Behavior_table.cross1and2_MBD_ABD_acc_whatwhere(si) = Exp2_Behavior_table.cross1and2_MBD_acc_whatwhere(si) - Exp2_Behavior_table.cross1and2_ABD_acc_whatwhere(si);
    Exp2_Behavior_table.cross1and2_MBD_ABD_acc_fullem(si) = Exp2_Behavior_table.cross1and2_MBD_acc_fullem(si) - Exp2_Behavior_table.cross1and2_ABD_acc_fullem(si);
                   

    Exp2_Behavior_table.cross1_cross0_acc_what(si) = Exp2_Behavior_table.select_acc_what(si) - Exp2_Behavior_table.cross0_acc_what(si);
    Exp2_Behavior_table.cross1_cross0_acc_whatwhen(si) = Exp2_Behavior_table.select_acc_whatwhen(si) - Exp2_Behavior_table.cross0_acc_whatwhen(si);
    Exp2_Behavior_table.cross1_cross0_acc_where(si) = Exp2_Behavior_table.select_acc_where(si) - Exp2_Behavior_table.cross0_acc_where(si);
    Exp2_Behavior_table.cross1_cross0_acc_wherewhen(si) = Exp2_Behavior_table.select_acc_wherewhen(si) - Exp2_Behavior_table.cross0_acc_wherewhen(si);
    Exp2_Behavior_table.cross1_cross0_acc_whatwhere(si) = Exp2_Behavior_table.select_acc_whatwhere(si) - Exp2_Behavior_table.cross0_acc_whatwhere(si);
    Exp2_Behavior_table.cross1_cross0_acc_fullem(si) = Exp2_Behavior_table.select_acc_fullem(si) - Exp2_Behavior_table.cross0_acc_fullem(si);
        
    Exp2_Behavior_table.cross1_cross0and2_acc_what(si) = Exp2_Behavior_table.select_acc_what(si) - Exp2_Behavior_table.cross0and2_acc_what(si);
    Exp2_Behavior_table.cross1_cross0and2_acc_whatwhen(si) = Exp2_Behavior_table.select_acc_whatwhen(si) - Exp2_Behavior_table.cross0and2_acc_whatwhen(si);
    Exp2_Behavior_table.cross1_cross0and2_acc_where(si) = Exp2_Behavior_table.select_acc_where(si) - Exp2_Behavior_table.cross0and2_acc_where(si);
    Exp2_Behavior_table.cross1_cross0and2_acc_wherewhen(si) = Exp2_Behavior_table.select_acc_wherewhen(si) - Exp2_Behavior_table.cross0and2_acc_wherewhen(si);
    Exp2_Behavior_table.cross1_cross0and2_acc_whatwhere(si) = Exp2_Behavior_table.select_acc_whatwhere(si) - Exp2_Behavior_table.cross0and2_acc_whatwhere(si);
    Exp2_Behavior_table.cross1_cross0and2_acc_fullem(si) = Exp2_Behavior_table.select_acc_fullem(si) - Exp2_Behavior_table.cross0and2_acc_fullem(si);
        
    Exp2_Behavior_table.cross1and2_cross0_acc_what(si) = Exp2_Behavior_table.cross1and2_acc_what(si) - Exp2_Behavior_table.cross0_acc_what(si);
    Exp2_Behavior_table.cross1and2_cross0_acc_whatwhen(si) = Exp2_Behavior_table.cross1and2_acc_whatwhen(si) - Exp2_Behavior_table.cross0_acc_whatwhen(si);
    Exp2_Behavior_table.cross1and2_cross0_acc_where(si) = Exp2_Behavior_table.cross1and2_acc_where(si) - Exp2_Behavior_table.cross0_acc_where(si);
    Exp2_Behavior_table.cross1and2_cross0_acc_wherewhen(si) = Exp2_Behavior_table.cross1and2_acc_wherewhen(si) - Exp2_Behavior_table.cross0_acc_wherewhen(si);
    Exp2_Behavior_table.cross1and2_cross0_acc_whatwhere(si) = Exp2_Behavior_table.cross1and2_acc_whatwhere(si) - Exp2_Behavior_table.cross0_acc_whatwhere(si);
    Exp2_Behavior_table.cross1and2_cross0_acc_fullem(si) = Exp2_Behavior_table.cross1and2_acc_fullem(si) - Exp2_Behavior_table.cross0_acc_fullem(si);
        
    Exp2_Behavior_table.cross1_cross2_acc_what(si) = Exp2_Behavior_table.select_acc_what(si) - Exp2_Behavior_table.cross2_acc_what(si);
    Exp2_Behavior_table.cross1_cross2_acc_whatwhen(si) = Exp2_Behavior_table.select_acc_whatwhen(si) - Exp2_Behavior_table.cross2_acc_whatwhen(si);
    Exp2_Behavior_table.cross1_cross2_acc_where(si) = Exp2_Behavior_table.select_acc_where(si) - Exp2_Behavior_table.cross2_acc_where(si);
    Exp2_Behavior_table.cross1_cross2_acc_wherewhen(si) = Exp2_Behavior_table.select_acc_wherewhen(si) - Exp2_Behavior_table.cross2_acc_wherewhen(si);
    Exp2_Behavior_table.cross1_cross2_acc_whatwhere(si) = Exp2_Behavior_table.select_acc_whatwhere(si) - Exp2_Behavior_table.cross2_acc_whatwhere(si);
    Exp2_Behavior_table.cross1_cross2_acc_fullem(si) = Exp2_Behavior_table.select_acc_fullem(si) - Exp2_Behavior_table.cross2_acc_fullem(si);
    

    Exp2_Behavior_table.cross1_cross0_ABD_acc_what(si) = Exp2_Behavior_table.select_ABD_acc_what(si) - Exp2_Behavior_table.cross0_ABD_acc_what(si);
    Exp2_Behavior_table.cross1_cross0_ABD_acc_whatwhen(si) = Exp2_Behavior_table.select_ABD_acc_whatwhen(si) - Exp2_Behavior_table.cross0_ABD_acc_whatwhen(si);
    Exp2_Behavior_table.cross1_cross0_ABD_acc_where(si) = Exp2_Behavior_table.select_ABD_acc_where(si) - Exp2_Behavior_table.cross0_ABD_acc_where(si);
    Exp2_Behavior_table.cross1_cross0_ABD_acc_wherewhen(si) = Exp2_Behavior_table.select_ABD_acc_wherewhen(si) - Exp2_Behavior_table.cross0_ABD_acc_wherewhen(si);
    Exp2_Behavior_table.cross1_cross0_ABD_acc_whatwhere(si) = Exp2_Behavior_table.select_ABD_acc_whatwhere(si) - Exp2_Behavior_table.cross0_ABD_acc_whatwhere(si);
    Exp2_Behavior_table.cross1_cross0_ABD_acc_fullem(si) = Exp2_Behavior_table.select_ABD_acc_fullem(si) - Exp2_Behavior_table.cross0_ABD_acc_fullem(si);
        
    Exp2_Behavior_table.cross1_cross0and2_ABD_acc_what(si) = Exp2_Behavior_table.select_ABD_acc_what(si) - Exp2_Behavior_table.cross0and2_ABD_acc_what(si);
    Exp2_Behavior_table.cross1_cross0and2_ABD_acc_whatwhen(si) = Exp2_Behavior_table.select_ABD_acc_whatwhen(si) - Exp2_Behavior_table.cross0and2_ABD_acc_whatwhen(si);
    Exp2_Behavior_table.cross1_cross0and2_ABD_acc_where(si) = Exp2_Behavior_table.select_ABD_acc_where(si) - Exp2_Behavior_table.cross0and2_ABD_acc_where(si);
    Exp2_Behavior_table.cross1_cross0and2_ABD_acc_wherewhen(si) = Exp2_Behavior_table.select_ABD_acc_wherewhen(si) - Exp2_Behavior_table.cross0and2_ABD_acc_wherewhen(si);
    Exp2_Behavior_table.cross1_cross0and2_ABD_acc_whatwhere(si) = Exp2_Behavior_table.select_ABD_acc_whatwhere(si) - Exp2_Behavior_table.cross0and2_ABD_acc_whatwhere(si);
    Exp2_Behavior_table.cross1_cross0and2_ABD_acc_fullem(si) = Exp2_Behavior_table.select_ABD_acc_fullem(si) - Exp2_Behavior_table.cross0and2_ABD_acc_fullem(si);
        
    Exp2_Behavior_table.cross1and2_cross0_ABD_acc_what(si) = Exp2_Behavior_table.cross1and2_ABD_acc_what(si) - Exp2_Behavior_table.cross0_ABD_acc_what(si);
    Exp2_Behavior_table.cross1and2_cross0_ABD_acc_whatwhen(si) = Exp2_Behavior_table.cross1and2_ABD_acc_whatwhen(si) - Exp2_Behavior_table.cross0_ABD_acc_whatwhen(si);
    Exp2_Behavior_table.cross1and2_cross0_ABD_acc_where(si) = Exp2_Behavior_table.cross1and2_ABD_acc_where(si) - Exp2_Behavior_table.cross0_ABD_acc_where(si);
    Exp2_Behavior_table.cross1and2_cross0_ABD_acc_wherewhen(si) = Exp2_Behavior_table.cross1and2_ABD_acc_wherewhen(si) - Exp2_Behavior_table.cross0_ABD_acc_wherewhen(si);
    Exp2_Behavior_table.cross1and2_cross0_ABD_acc_whatwhere(si) = Exp2_Behavior_table.cross1and2_ABD_acc_whatwhere(si) - Exp2_Behavior_table.cross0_ABD_acc_whatwhere(si);
    Exp2_Behavior_table.cross1and2_cross0_ABD_acc_fullem(si) = Exp2_Behavior_table.cross1and2_ABD_acc_fullem(si) - Exp2_Behavior_table.cross0_ABD_acc_fullem(si);
        
    Exp2_Behavior_table.cross1_cross2_ABD_acc_what(si) = Exp2_Behavior_table.select_ABD_acc_what(si) - Exp2_Behavior_table.cross2_ABD_acc_what(si);
    Exp2_Behavior_table.cross1_cross2_ABD_acc_whatwhen(si) = Exp2_Behavior_table.select_ABD_acc_whatwhen(si) - Exp2_Behavior_table.cross2_ABD_acc_whatwhen(si);
    Exp2_Behavior_table.cross1_cross2_ABD_acc_where(si) = Exp2_Behavior_table.select_ABD_acc_where(si) - Exp2_Behavior_table.cross2_ABD_acc_where(si);
    Exp2_Behavior_table.cross1_cross2_ABD_acc_wherewhen(si) = Exp2_Behavior_table.select_ABD_acc_wherewhen(si) - Exp2_Behavior_table.cross2_ABD_acc_wherewhen(si);
    Exp2_Behavior_table.cross1_cross2_ABD_acc_whatwhere(si) = Exp2_Behavior_table.select_ABD_acc_whatwhere(si) - Exp2_Behavior_table.cross2_ABD_acc_whatwhere(si);
    Exp2_Behavior_table.cross1_cross2_ABD_acc_fullem(si) = Exp2_Behavior_table.select_ABD_acc_fullem(si) - Exp2_Behavior_table.cross2_ABD_acc_fullem(si);
    


    Exp2_Behavior_table.cross1_cross0_MBD_acc_what(si) = Exp2_Behavior_table.select_MBD_acc_what(si) - Exp2_Behavior_table.cross0_MBD_acc_what(si);
    Exp2_Behavior_table.cross1_cross0_MBD_acc_whatwhen(si) = Exp2_Behavior_table.select_MBD_acc_whatwhen(si) - Exp2_Behavior_table.cross0_MBD_acc_whatwhen(si);
    Exp2_Behavior_table.cross1_cross0_MBD_acc_where(si) = Exp2_Behavior_table.select_MBD_acc_where(si) - Exp2_Behavior_table.cross0_MBD_acc_where(si);
    Exp2_Behavior_table.cross1_cross0_MBD_acc_wherewhen(si) = Exp2_Behavior_table.select_MBD_acc_wherewhen(si) - Exp2_Behavior_table.cross0_MBD_acc_wherewhen(si);
    Exp2_Behavior_table.cross1_cross0_MBD_acc_whatwhere(si) = Exp2_Behavior_table.select_MBD_acc_whatwhere(si) - Exp2_Behavior_table.cross0_MBD_acc_whatwhere(si);
    Exp2_Behavior_table.cross1_cross0_MBD_acc_fullem(si) = Exp2_Behavior_table.select_MBD_acc_fullem(si) - Exp2_Behavior_table.cross0_MBD_acc_fullem(si);
        
    Exp2_Behavior_table.cross1_cross0and2_MBD_acc_what(si) = Exp2_Behavior_table.select_MBD_acc_what(si) - Exp2_Behavior_table.cross0and2_MBD_acc_what(si);
    Exp2_Behavior_table.cross1_cross0and2_MBD_acc_whatwhen(si) = Exp2_Behavior_table.select_MBD_acc_whatwhen(si) - Exp2_Behavior_table.cross0and2_MBD_acc_whatwhen(si);
    Exp2_Behavior_table.cross1_cross0and2_MBD_acc_where(si) = Exp2_Behavior_table.select_MBD_acc_where(si) - Exp2_Behavior_table.cross0and2_MBD_acc_where(si);
    Exp2_Behavior_table.cross1_cross0and2_MBD_acc_wherewhen(si) = Exp2_Behavior_table.select_MBD_acc_wherewhen(si) - Exp2_Behavior_table.cross0and2_MBD_acc_wherewhen(si);
    Exp2_Behavior_table.cross1_cross0and2_MBD_acc_whatwhere(si) = Exp2_Behavior_table.select_MBD_acc_whatwhere(si) - Exp2_Behavior_table.cross0and2_MBD_acc_whatwhere(si);
    Exp2_Behavior_table.cross1_cross0and2_MBD_acc_fullem(si) = Exp2_Behavior_table.select_MBD_acc_fullem(si) - Exp2_Behavior_table.cross0and2_MBD_acc_fullem(si);
        
    Exp2_Behavior_table.cross1and2_cross0_MBD_acc_what(si) = Exp2_Behavior_table.cross1and2_MBD_acc_what(si) - Exp2_Behavior_table.cross0_MBD_acc_what(si);
    Exp2_Behavior_table.cross1and2_cross0_MBD_acc_whatwhen(si) = Exp2_Behavior_table.cross1and2_MBD_acc_whatwhen(si) - Exp2_Behavior_table.cross0_MBD_acc_whatwhen(si);
    Exp2_Behavior_table.cross1and2_cross0_MBD_acc_where(si) = Exp2_Behavior_table.cross1and2_MBD_acc_where(si) - Exp2_Behavior_table.cross0_MBD_acc_where(si);
    Exp2_Behavior_table.cross1and2_cross0_MBD_acc_wherewhen(si) = Exp2_Behavior_table.cross1and2_MBD_acc_wherewhen(si) - Exp2_Behavior_table.cross0_MBD_acc_wherewhen(si);
    Exp2_Behavior_table.cross1and2_cross0_MBD_acc_whatwhere(si) = Exp2_Behavior_table.cross1and2_MBD_acc_whatwhere(si) - Exp2_Behavior_table.cross0_MBD_acc_whatwhere(si);
    Exp2_Behavior_table.cross1and2_cross0_MBD_acc_fullem(si) = Exp2_Behavior_table.cross1and2_MBD_acc_fullem(si) - Exp2_Behavior_table.cross0_MBD_acc_fullem(si);
        
    Exp2_Behavior_table.cross1_cross2_MBD_acc_what(si) = Exp2_Behavior_table.select_MBD_acc_what(si) - Exp2_Behavior_table.cross2_MBD_acc_what(si);
    Exp2_Behavior_table.cross1_cross2_MBD_acc_whatwhen(si) = Exp2_Behavior_table.select_MBD_acc_whatwhen(si) - Exp2_Behavior_table.cross2_MBD_acc_whatwhen(si);
    Exp2_Behavior_table.cross1_cross2_MBD_acc_where(si) = Exp2_Behavior_table.select_MBD_acc_where(si) - Exp2_Behavior_table.cross2_MBD_acc_where(si);
    Exp2_Behavior_table.cross1_cross2_MBD_acc_wherewhen(si) = Exp2_Behavior_table.select_MBD_acc_wherewhen(si) - Exp2_Behavior_table.cross2_MBD_acc_wherewhen(si);
    Exp2_Behavior_table.cross1_cross2_MBD_acc_whatwhere(si) = Exp2_Behavior_table.select_MBD_acc_whatwhere(si) - Exp2_Behavior_table.cross2_MBD_acc_whatwhere(si);
    Exp2_Behavior_table.cross1_cross2_MBD_acc_fullem(si) = Exp2_Behavior_table.select_MBD_acc_fullem(si) - Exp2_Behavior_table.cross2_MBD_acc_fullem(si);
    



    % boundary 전 후 RT는 나중에
    %     Behavior_table.rt_befBoundary(si) = NaN;
    %     Behavior_table.rt_aftBoundary(si) = NaN;
    %
    %
    %     response1 = []; response2 = []; respond_av1 = NaN; respond_av2 = NaN;
    %     if sum(ismember(Trial_Data(si).main.boundary_cat, [1, 4]))
    %         response1 = Trial_Data(si).main.respondRT(ismember(Trial_Data(si).main.boundary_cat, [1, 4]),:);
    %         a1 = length(response1); remainders = mod([1:1:a1], 3);
    %
    %     elseif sum(ismember(Trial_Data(si).main.boundary_cat, [3, 6]))
    %         response2 = Trial_Data(si).main.respondRT(ismember(Trial_Data(si).main.boundary_cat, [3, 6]),:);
    %         nanmean(Trial_Data(si).main.locationRT);
    %
    %     end



end






for si = 1:length(Exp3_sbj_data)
    Exp3_Behavior_table.cross0(si) = sum(Exp3_Trial_Data(si).main.boundary_crossing == 0);
    Exp3_Behavior_table.cross1(si) = sum(Exp3_Trial_Data(si).main.boundary_crossing == 1);
    Exp3_Behavior_table.cross2(si) = sum(Exp3_Trial_Data(si).main.boundary_crossing == 2);
    Exp3_Behavior_table.cross0_Chunk(si) = sum(Exp3_Trial_Data(si).main.boundary_crossing == 0 & Exp3_Trial_Data(si).main.boundary == 0);
    Exp3_Behavior_table.cross1_Chunk(si) = sum(Exp3_Trial_Data(si).main.boundary_crossing == 1 & Exp3_Trial_Data(si).main.boundary == 0);
    Exp3_Behavior_table.cross2_Chunk(si) = sum(Exp3_Trial_Data(si).main.boundary_crossing == 2 & Exp3_Trial_Data(si).main.boundary == 0);
    Exp3_Behavior_table.cross0_MBD(si) = sum(Exp3_Trial_Data(si).main.boundary_crossing == 0 & Exp3_Trial_Data(si).main.boundary == 1);
    Exp3_Behavior_table.cross1_MBD(si) = sum(Exp3_Trial_Data(si).main.boundary_crossing == 1 & Exp3_Trial_Data(si).main.boundary == 1);
    Exp3_Behavior_table.cross2_MBD(si) = sum(Exp3_Trial_Data(si).main.boundary_crossing == 2 & Exp3_Trial_Data(si).main.boundary == 1);    
    % inter trial accuracy
    Exp3_Behavior_table.inter_acc(si) = nanmean(Exp3_Trial_Data(si).inter.correct);
    Exp3_Behavior_table.inter_acc_cat1(si) = nanmean(Exp3_Trial_Data(si).inter.correct(Exp3_Trial_Data(si).inter.condition == 1));
    Exp3_Behavior_table.inter_acc_cat2(si) = nanmean(Exp3_Trial_Data(si).inter.correct(Exp3_Trial_Data(si).inter.condition == 2));
    Exp3_Behavior_table.inter_bnd_use_index(si) = Exp3_Behavior_table.inter_acc_cat2(si) - Exp3_Behavior_table.inter_acc_cat1(si);
    Exp3_Behavior_table.inter_bnd_user(si) = Exp3_Behavior_table.inter_acc_cat1(si) < Exp3_Behavior_table.inter_acc_cat2(si);

    % yj method ( 1 location cat / 2 detail right / 0 really wrong)
%     WWW_ctrl_Trial_Data(si).main.categorical_Acc = WWW_ctrl_Trial_Data(si).main.location_catAcc + WWW_ctrl_Trial_Data(si).main.locationAcc;
    
    if sum(Exp3_Trial_Data(si).main.categorical_Acc == 1) + sum(Exp3_Trial_Data(si).main.categorical_Acc == 0) ~= 0
        Exp3_Behavior_table.loc_chunking(si) = sum(Exp3_Trial_Data(si).main.categorical_Acc == 1) / (sum(Exp3_Trial_Data(si).main.categorical_Acc == 1) + sum(Exp3_Trial_Data(si).main.categorical_Acc == 0));
    else
        Exp3_Behavior_table.loc_chunking(si) = NaN;
    end

    % accuracy
    Exp3_Behavior_table.acc_what(si) = nanmean(Exp3_Trial_Data(si).main.what);
    Exp3_Behavior_table.acc_whatwhen(si) = nanmean(Exp3_Trial_Data(si).main.whatwhen);
    Exp3_Behavior_table.acc_where(si) = nanmean(Exp3_Trial_Data(si).main.where);
    Exp3_Behavior_table.acc_wherewhen(si) = nanmean(Exp3_Trial_Data(si).main.wherewhen);
    Exp3_Behavior_table.acc_whatwhere(si) = nanmean(Exp3_Trial_Data(si).main.whatwhere);
    Exp3_Behavior_table.acc_fullem(si) = nanmean(Exp3_Trial_Data(si).main.fullem);


    % accuracy - location categorically divided
    Exp3_Behavior_table.acc_location_cat(si) = nanmean(Exp3_Trial_Data(si).main.location_catAcc);
    Exp3_Behavior_table.acc_location_cat_only(si) = nanmean(Exp3_Trial_Data(si).main.location_catWhere);


    % reaction time (right or wrong whole)
    Exp3_Behavior_table.rt_respond(si) = nanmean(Exp3_Trial_Data(si).main.respondRT);
    Exp3_Behavior_table.rt_animal(si) = nanmean(Exp3_Trial_Data(si).main.animalRT);
    Exp3_Behavior_table.rt_location(si) = nanmean(Exp3_Trial_Data(si).main.locationRT);

    Exp3_Behavior_table.log_rt_respond(si) = nanmean(Exp3_Trial_Data(si).main.respondRT_log);
    Exp3_Behavior_table.log_rt_animal(si) = nanmean(Exp3_Trial_Data(si).main.animalRT_log);
    Exp3_Behavior_table.log_rt_location(si) = nanmean(Exp3_Trial_Data(si).main.locationRT_log);



    %reaction time (right only)
    Exp3_Behavior_table.rt_right_respond(si) = nanmean(Exp3_Trial_Data(si).main.respondRT(Exp3_Trial_Data(si).main.fullem == 1));
    Exp3_Behavior_table.rt_right_animal(si) = nanmean(Exp3_Trial_Data(si).main.animalRT(Exp3_Trial_Data(si).main.animalAcc == 1));
    Exp3_Behavior_table.rt_right_location(si) = nanmean(Exp3_Trial_Data(si).main.locationRT(Exp3_Trial_Data(si).main.locationAcc == 1));

    Exp3_Behavior_table.log_rt_right_respond(si) = nanmean(Exp3_Trial_Data(si).main.respondRT_log(Exp3_Trial_Data(si).main.fullem == 1));
    Exp3_Behavior_table.log_rt_right_animal(si) = nanmean(Exp3_Trial_Data(si).main.animalRT_log(Exp3_Trial_Data(si).main.animalAcc == 1));
    Exp3_Behavior_table.log_rt_right_location(si) = nanmean(Exp3_Trial_Data(si).main.locationRT_log(Exp3_Trial_Data(si).main.locationAcc == 1));



    % each trial (right & wrong)
    Exp3_Behavior_table.rt_trial1_respond(si) = nanmean(Exp3_Trial_Data(si).main.respondRT(Exp3_Trial_Data(si).main.order == 1));
    Exp3_Behavior_table.rt_trial1_animal(si) = nanmean(Exp3_Trial_Data(si).main.animalRT(Exp3_Trial_Data(si).main.order == 1));
    Exp3_Behavior_table.rt_trial1_location(si) = nanmean(Exp3_Trial_Data(si).main.locationRT(Exp3_Trial_Data(si).main.order == 1));

    Exp3_Behavior_table.rt_trial2_respond(si) = nanmean(Exp3_Trial_Data(si).main.respondRT(Exp3_Trial_Data(si).main.order == 2));
    Exp3_Behavior_table.rt_trial2_animal(si) = nanmean(Exp3_Trial_Data(si).main.animalRT(Exp3_Trial_Data(si).main.order == 2));
    Exp3_Behavior_table.rt_trial2_location(si) = nanmean(Exp3_Trial_Data(si).main.locationRT(Exp3_Trial_Data(si).main.order == 2));

    Exp3_Behavior_table.rt_trial3_respond(si) = nanmean(Exp3_Trial_Data(si).main.respondRT(Exp3_Trial_Data(si).main.order == 3));
    Exp3_Behavior_table.rt_trial3_animal(si) = nanmean(Exp3_Trial_Data(si).main.animalRT(Exp3_Trial_Data(si).main.order == 3));
    Exp3_Behavior_table.rt_trial3_location(si) = nanmean(Exp3_Trial_Data(si).main.locationRT(Exp3_Trial_Data(si).main.order == 3));


    Exp3_Behavior_table.log_rt_trial1_respond(si) = nanmean(Exp3_Trial_Data(si).main.respondRT_log(Exp3_Trial_Data(si).main.order == 1));
    Exp3_Behavior_table.log_rt_trial1_animal(si) = nanmean(Exp3_Trial_Data(si).main.animalRT_log(Exp3_Trial_Data(si).main.order == 1));
    Exp3_Behavior_table.log_rt_trial1_location(si) = nanmean(Exp3_Trial_Data(si).main.locationRT_log(Exp3_Trial_Data(si).main.order == 1));

    Exp3_Behavior_table.log_rt_trial2_respond(si) = nanmean(Exp3_Trial_Data(si).main.respondRT_log(Exp3_Trial_Data(si).main.order == 2));
    Exp3_Behavior_table.log_rt_trial2_animal(si) = nanmean(Exp3_Trial_Data(si).main.animalRT_log(Exp3_Trial_Data(si).main.order == 2));
    Exp3_Behavior_table.log_rt_trial2_location(si) = nanmean(Exp3_Trial_Data(si).main.locationRT_log(Exp3_Trial_Data(si).main.order == 2));

    Exp3_Behavior_table.log_rt_trial3_respond(si) = nanmean(Exp3_Trial_Data(si).main.respondRT_log(Exp3_Trial_Data(si).main.order == 3));
    Exp3_Behavior_table.log_rt_trial3_animal(si) = nanmean(Exp3_Trial_Data(si).main.animalRT_log(Exp3_Trial_Data(si).main.order == 3));
    Exp3_Behavior_table.log_rt_trial3_location(si) = nanmean(Exp3_Trial_Data(si).main.locationRT_log(Exp3_Trial_Data(si).main.order == 3));




    % a signle boundary only
    Exp3_Behavior_table.all_Chunk_across_acc(si) = nanmean(Exp3_Trial_Data(si).main_trial.across_acc(Exp3_Trial_Data(si).main_trial.boundary == 0,:))    
    Exp3_Behavior_table.all_Chunk_within_acc(si) = nanmean(Exp3_Trial_Data(si).main_trial.within_acc(Exp3_Trial_Data(si).main_trial.boundary == 0,:))    
    Exp3_Behavior_table.all_Chunk_acc_what(si) = nanmean(Exp3_Trial_Data(si).main.what(Exp3_Trial_Data(si).main.boundary == 0,:));
    Exp3_Behavior_table.all_Chunk_acc_whatwhen(si) = nanmean(Exp3_Trial_Data(si).main.whatwhen(Exp3_Trial_Data(si).main.boundary == 0,:));
    Exp3_Behavior_table.all_Chunk_acc_where(si) = nanmean(Exp3_Trial_Data(si).main.where(Exp3_Trial_Data(si).main.boundary == 0,:));
    Exp3_Behavior_table.all_Chunk_acc_wherewhen(si) = nanmean(Exp3_Trial_Data(si).main.wherewhen(Exp3_Trial_Data(si).main.boundary == 0,:));
    Exp3_Behavior_table.all_Chunk_acc_whatwhere(si) = nanmean(Exp3_Trial_Data(si).main.whatwhere(Exp3_Trial_Data(si).main.boundary == 0,:));
    Exp3_Behavior_table.all_Chunk_acc_fullem(si) = nanmean(Exp3_Trial_Data(si).main.fullem(Exp3_Trial_Data(si).main.boundary == 0,:));
    Exp3_Behavior_table.all_Chunk_acc_location_cat(si) = nanmean(Exp3_Trial_Data(si).main.location_catAcc(Exp3_Trial_Data(si).main.boundary == 0,:));

    if sum(Exp3_Trial_Data(si).main.categorical_Acc(Exp3_Trial_Data(si).main.boundary == 0,:) == 1) + sum(Exp3_Trial_Data(si).main.categorical_Acc(Exp3_Trial_Data(si).main.boundary == 0,:) == 0) ~= 0
        Exp3_Behavior_table.Chunk_loc_chunking(si) = sum(Exp3_Trial_Data(si).main.categorical_Acc(Exp3_Trial_Data(si).main.boundary == 0,:) == 1) / (sum(Exp3_Trial_Data(si).main.categorical_Acc(Exp3_Trial_Data(si).main.boundary == 0,:) == 1) + sum(Exp3_Trial_Data(si).main.categorical_Acc(Exp3_Trial_Data(si).main.boundary == 0,:) == 0));
    else
        Exp3_Behavior_table.Chunk_loc_chunking(si) = NaN;
    end


    Exp3_Behavior_table.all_Chunk_rt_respond(si) = nanmean(Exp3_Trial_Data(si).main.respondRT(Exp3_Trial_Data(si).main.boundary == 0,:));
    Exp3_Behavior_table.all_Chunk_rt_animal(si) = nanmean(Exp3_Trial_Data(si).main.animalRT(Exp3_Trial_Data(si).main.boundary == 0,:));
    Exp3_Behavior_table.all_Chunk_rt_location(si) = nanmean(Exp3_Trial_Data(si).main.locationRT(Exp3_Trial_Data(si).main.boundary == 0,:));


    Exp3_Behavior_table.all_Chunk_log_rt_respond(si) = nanmean(Exp3_Trial_Data(si).main.respondRT_log(Exp3_Trial_Data(si).main.boundary == 0,:));
    Exp3_Behavior_table.all_Chunk_log_rt_animal(si) = nanmean(Exp3_Trial_Data(si).main.animalRT_log(Exp3_Trial_Data(si).main.boundary == 0,:));
    Exp3_Behavior_table.all_Chunk_log_rt_location(si) = nanmean(Exp3_Trial_Data(si).main.locationRT_log(Exp3_Trial_Data(si).main.boundary == 0,:));


    % right trials rt only
    Exp3_Behavior_table.all_Chunk_rt_right_respond(si) = nanmean(Exp3_Trial_Data(si).main.respondRT(((Exp3_Trial_Data(si).main.boundary == 0) & (Exp3_Trial_Data(si).main.fullem == 1)) == 1,:));
    Exp3_Behavior_table.all_Chunk_rt_right_animal(si) = nanmean(Exp3_Trial_Data(si).main.animalRT(((Exp3_Trial_Data(si).main.boundary == 0) & (Exp3_Trial_Data(si).main.animalAcc == 1)) == 1,:));
    Exp3_Behavior_table.all_Chunk_rt_right_location(si) = nanmean(Exp3_Trial_Data(si).main.locationRT(((Exp3_Trial_Data(si).main.boundary == 0) & (Exp3_Trial_Data(si).main.locationAcc == 1)) == 1,:));


    Exp3_Behavior_table.all_Chunk_log_rt_right_respond(si) = nanmean(Exp3_Trial_Data(si).main.respondRT_log(((Exp3_Trial_Data(si).main.boundary == 0) & (Exp3_Trial_Data(si).main.fullem == 1)) == 1,:));
    Exp3_Behavior_table.all_Chunk_log_rt_right_animal(si) = nanmean(Exp3_Trial_Data(si).main.animalRT_log(((Exp3_Trial_Data(si).main.boundary == 0) & (Exp3_Trial_Data(si).main.animalAcc == 1)) == 1,:));
    Exp3_Behavior_table.all_Chunk_log_rt_right_location(si) = nanmean(Exp3_Trial_Data(si).main.locationRT_log(((Exp3_Trial_Data(si).main.boundary == 0) & (Exp3_Trial_Data(si).main.locationAcc == 1)) == 1,:));





    % multiple boundary
    Exp3_Behavior_table.all_MBD_across_acc(si) = nanmean(Exp3_Trial_Data(si).main_trial.across_acc(Exp3_Trial_Data(si).main_trial.boundary == 1,:))    
    Exp3_Behavior_table.all_MBD_within_acc(si) = nanmean(Exp3_Trial_Data(si).main_trial.within_acc(Exp3_Trial_Data(si).main_trial.boundary == 1,:))        
    Exp3_Behavior_table.all_MBD_acc_what(si) = nanmean(Exp3_Trial_Data(si).main.what(Exp3_Trial_Data(si).main.boundary == 1,:));
    Exp3_Behavior_table.all_MBD_acc_whatwhen(si) = nanmean(Exp3_Trial_Data(si).main.whatwhen(Exp3_Trial_Data(si).main.boundary == 1,:));
    Exp3_Behavior_table.all_MBD_acc_where(si) = nanmean(Exp3_Trial_Data(si).main.where(Exp3_Trial_Data(si).main.boundary == 1,:));
    Exp3_Behavior_table.all_MBD_acc_wherewhen(si) = nanmean(Exp3_Trial_Data(si).main.wherewhen(Exp3_Trial_Data(si).main.boundary == 1,:));
    Exp3_Behavior_table.all_MBD_acc_whatwhere(si) = nanmean(Exp3_Trial_Data(si).main.whatwhere(Exp3_Trial_Data(si).main.boundary == 1,:));
    Exp3_Behavior_table.all_MBD_acc_fullem(si) = nanmean(Exp3_Trial_Data(si).main.fullem(Exp3_Trial_Data(si).main.boundary == 1,:));
    Exp3_Behavior_table.all_MBD_acc_location_cat(si) = nanmean(Exp3_Trial_Data(si).main.location_catAcc(Exp3_Trial_Data(si).main.boundary == 1,:));

    Exp3_Behavior_table.all_MBD_rt_respond(si) = nanmean(Exp3_Trial_Data(si).main.respondRT(Exp3_Trial_Data(si).main.boundary == 1,:));
    Exp3_Behavior_table.all_MBD_rt_animal(si) = nanmean(Exp3_Trial_Data(si).main.animalRT(Exp3_Trial_Data(si).main.boundary == 1,:));
    Exp3_Behavior_table.all_MBD_rt_location(si) = nanmean(Exp3_Trial_Data(si).main.locationRT(Exp3_Trial_Data(si).main.boundary == 1,:));


    Exp3_Behavior_table.all_MBD_log_rt_respond(si) = nanmean(Exp3_Trial_Data(si).main.respondRT_log(Exp3_Trial_Data(si).main.boundary == 1,:));
    Exp3_Behavior_table.all_MBD_log_rt_animal(si) = nanmean(Exp3_Trial_Data(si).main.animalRT_log(Exp3_Trial_Data(si).main.boundary == 1,:));
    Exp3_Behavior_table.all_MBD_log_rt_location(si) = nanmean(Exp3_Trial_Data(si).main.locationRT_log(Exp3_Trial_Data(si).main.boundary == 1,:));




    if sum(Exp3_Trial_Data(si).main.categorical_Acc(Exp3_Trial_Data(si).main.boundary == 1,:) == 1) + sum(Exp3_Trial_Data(si).main.categorical_Acc(Exp3_Trial_Data(si).main.boundary == 1,:) == 0) ~= 0
        Exp3_Behavior_table.MBD_loc_chunking(si) = sum(Exp3_Trial_Data(si).main.categorical_Acc(Exp3_Trial_Data(si).main.boundary == 1,:) == 1) / (sum(Exp3_Trial_Data(si).main.categorical_Acc(Exp3_Trial_Data(si).main.boundary == 1,:) == 1) + sum(Exp3_Trial_Data(si).main.categorical_Acc(Exp3_Trial_Data(si).main.boundary == 1,:) == 0));
    else
        Exp3_Behavior_table.MBD_loc_chunking(si) = NaN;
    end

    % right trials rt only
    Exp3_Behavior_table.all_MBD_rt_right_respond(si) = nanmean(Exp3_Trial_Data(si).main.respondRT(((Exp3_Trial_Data(si).main.boundary == 1) & (Exp3_Trial_Data(si).main.fullem == 1)) == 1,:));
    Exp3_Behavior_table.all_MBD_rt_right_animal(si) = nanmean(Exp3_Trial_Data(si).main.animalRT(((Exp3_Trial_Data(si).main.boundary == 1) & (Exp3_Trial_Data(si).main.animalAcc == 1)) == 1,:));
    Exp3_Behavior_table.all_MBD_rt_right_location(si) = nanmean(Exp3_Trial_Data(si).main.locationRT(((Exp3_Trial_Data(si).main.boundary == 1) & (Exp3_Trial_Data(si).main.locationAcc == 1)) == 1,:));

    Exp3_Behavior_table.all_MBD_log_rt_right_respond(si) = nanmean(Exp3_Trial_Data(si).main.respondRT_log(((Exp3_Trial_Data(si).main.boundary == 1) & (Exp3_Trial_Data(si).main.fullem == 1)) == 1,:));
    Exp3_Behavior_table.all_MBD_log_rt_right_animal(si) = nanmean(Exp3_Trial_Data(si).main.animalRT_log(((Exp3_Trial_Data(si).main.boundary == 1) & (Exp3_Trial_Data(si).main.animalAcc == 1)) == 1,:));
    Exp3_Behavior_table.all_MBD_log_rt_right_location(si) = nanmean(Exp3_Trial_Data(si).main.locationRT_log(((Exp3_Trial_Data(si).main.boundary == 1) & (Exp3_Trial_Data(si).main.locationAcc == 1)) == 1,:));


  

    %selected (boundary crossing 1) - no right rt yet
    Exp3_Behavior_table.select_acc_what(si) = nanmean(Exp3_Trial_Data(si).main.what(Exp3_Trial_Data(si).main.boundary_cat_okay > 0 ,:));
    Exp3_Behavior_table.select_acc_whatwhen(si) = nanmean(Exp3_Trial_Data(si).main.whatwhen(Exp3_Trial_Data(si).main.boundary_cat_okay > 0 ,:));
    Exp3_Behavior_table.select_acc_where(si) = nanmean(Exp3_Trial_Data(si).main.where(Exp3_Trial_Data(si).main.boundary_cat_okay > 0 ,:));
    Exp3_Behavior_table.select_acc_wherewhen(si) = nanmean(Exp3_Trial_Data(si).main.wherewhen(Exp3_Trial_Data(si).main.boundary_cat_okay > 0 ,:));
    Exp3_Behavior_table.select_acc_whatwhere(si) = nanmean(Exp3_Trial_Data(si).main.whatwhere(Exp3_Trial_Data(si).main.boundary_cat_okay > 0 ,:));
    Exp3_Behavior_table.select_acc_fullem(si) = nanmean(Exp3_Trial_Data(si).main.fullem(Exp3_Trial_Data(si).main.boundary_cat_okay > 0 ,:));

    Exp3_Behavior_table.select_acc_location_cat(si) = nanmean(Exp3_Trial_Data(si).main.location_catAcc(Exp3_Trial_Data(si).main.boundary_cat_okay > 0 ,:));

    if sum(Exp3_Trial_Data(si).main.categorical_Acc(Exp3_Trial_Data(si).main.boundary_cat_okay > 0,:) == 1) + sum(Exp3_Trial_Data(si).main.categorical_Acc( Exp3_Trial_Data(si).main.boundary_cat_okay > 0,:) == 0) ~= 0
        Exp3_Behavior_table.select_loc_chunking(si) = sum(Exp3_Trial_Data(si).main.categorical_Acc(Exp3_Trial_Data(si).main.boundary_cat_okay > 0,:) == 1) / (sum(Exp3_Trial_Data(si).main.categorical_Acc(Exp3_Trial_Data(si).main.boundary_cat_okay > 0,:) == 1) + sum(Exp3_Trial_Data(si).main.categorical_Acc(Exp3_Trial_Data(si).main.boundary_cat_okay > 0,:) == 0));
    else
        Exp3_Behavior_table.select_loc_chunking(si) = NaN;
    end


    Exp3_Behavior_table.select_rt_respond(si) = nanmean(Exp3_Trial_Data(si).main.respondRT(Exp3_Trial_Data(si).main.boundary_cat_okay > 0 ,:));
    Exp3_Behavior_table.select_rt_animal(si) = nanmean(Exp3_Trial_Data(si).main.animalRT(Exp3_Trial_Data(si).main.boundary_cat_okay > 0 ,:));
    Exp3_Behavior_table.select_rt_location(si) = nanmean(Exp3_Trial_Data(si).main.locationRT(Exp3_Trial_Data(si).main.boundary_cat_okay > 0 ,:));

    Exp3_Behavior_table.select_log_rt_respond(si) = nanmean(Exp3_Trial_Data(si).main.respondRT_log(Exp3_Trial_Data(si).main.boundary_cat_okay > 0 ,:));
    Exp3_Behavior_table.select_log_rt_animal(si) = nanmean(Exp3_Trial_Data(si).main.animalRT_log(Exp3_Trial_Data(si).main.boundary_cat_okay > 0 ,:));
    Exp3_Behavior_table.select_log_rt_location(si) = nanmean(Exp3_Trial_Data(si).main.locationRT_log(Exp3_Trial_Data(si).main.boundary_cat_okay > 0 ,:));


    % right trials rt only
    Exp3_Behavior_table.select_rt_right_respond(si) = nanmean(Exp3_Trial_Data(si).main.respondRT(((Exp3_Trial_Data(si).main.fullem == 1)) == 1,:));
    Exp3_Behavior_table.select_rt_right_animal(si) = nanmean(Exp3_Trial_Data(si).main.animalRT(((Exp3_Trial_Data(si).main.animalAcc == 1)) == 1,:));
    Exp3_Behavior_table.select_rt_right_location(si) = nanmean(Exp3_Trial_Data(si).main.locationRT(((Exp3_Trial_Data(si).main.locationAcc == 1)) == 1,:));

    Exp3_Behavior_table.select_log_rt_right_respond(si) = nanmean(Exp3_Trial_Data(si).main.respondRT_log(((Exp3_Trial_Data(si).main.fullem == 1)) == 1,:));
    Exp3_Behavior_table.select_log_rt_right_animal(si) = nanmean(Exp3_Trial_Data(si).main.animalRT_log(((Exp3_Trial_Data(si).main.animalAcc == 1)) == 1,:));
    Exp3_Behavior_table.select_log_rt_right_location(si) = nanmean(Exp3_Trial_Data(si).main.locationRT_log(((Exp3_Trial_Data(si).main.locationAcc == 1)) == 1,:));


    if sum(Exp3_Trial_Data(si).main.categorical_Acc(Exp3_Trial_Data(si).main.boundary == 0 & Exp3_Trial_Data(si).main.boundary_cat_okay > 0,:) == 1) + sum(Exp3_Trial_Data(si).main.categorical_Acc(Exp3_Trial_Data(si).main.boundary == 0 & Exp3_Trial_Data(si).main.boundary_cat_okay > 0,:) == 0) ~= 0
        Exp3_Behavior_table.select_Chunk_loc_chunking(si) = sum(Exp3_Trial_Data(si).main.categorical_Acc(Exp3_Trial_Data(si).main.boundary == 0 & Exp3_Trial_Data(si).main.boundary_cat_okay > 0,:) == 1) / (sum(Exp3_Trial_Data(si).main.categorical_Acc(Exp3_Trial_Data(si).main.boundary == 0 & Exp3_Trial_Data(si).main.boundary_cat_okay > 0,:) == 1) + sum(Exp3_Trial_Data(si).main.categorical_Acc(Exp3_Trial_Data(si).main.boundary == 0 & Exp3_Trial_Data(si).main.boundary_cat_okay > 0,:) == 0));
    else
        Exp3_Behavior_table.select_Chunk_loc_chunking(si) = NaN;
    end

    Exp3_Behavior_table.select_Chunk_across_acc(si) = nanmean(Exp3_Trial_Data(si).main_trial.across_acc(Exp3_Trial_Data(si).main_trial.boundary == 0  & Exp3_Trial_Data(si).main_trial.boundary_1cross_run > 0,:));    
    Exp3_Behavior_table.select_Chunk_within_acc(si) = nanmean(Exp3_Trial_Data(si).main_trial.within_acc(Exp3_Trial_Data(si).main_trial.boundary == 0 & Exp3_Trial_Data(si).main_trial.boundary_1cross_run > 0,:));      

    Exp3_Behavior_table.select_Chunk_acc_what(si) = nanmean(Exp3_Trial_Data(si).main.what(Exp3_Trial_Data(si).main.boundary == 0 & Exp3_Trial_Data(si).main.boundary_cat_okay > 0 ,:));
    Exp3_Behavior_table.select_Chunk_acc_whatwhen(si) = nanmean(Exp3_Trial_Data(si).main.whatwhen(Exp3_Trial_Data(si).main.boundary == 0 & Exp3_Trial_Data(si).main.boundary_cat_okay > 0,:));
    Exp3_Behavior_table.select_Chunk_acc_where(si) = nanmean(Exp3_Trial_Data(si).main.where(Exp3_Trial_Data(si).main.boundary == 0 & Exp3_Trial_Data(si).main.boundary_cat_okay > 0,:));
    Exp3_Behavior_table.select_Chunk_acc_wherewhen(si) = nanmean(Exp3_Trial_Data(si).main.wherewhen(Exp3_Trial_Data(si).main.boundary == 0 & Exp3_Trial_Data(si).main.boundary_cat_okay > 0,:));
    Exp3_Behavior_table.select_Chunk_acc_whatwhere(si) = nanmean(Exp3_Trial_Data(si).main.whatwhere(Exp3_Trial_Data(si).main.boundary == 0 & Exp3_Trial_Data(si).main.boundary_cat_okay > 0,:));
    Exp3_Behavior_table.select_Chunk_acc_fullem(si) = nanmean(Exp3_Trial_Data(si).main.fullem(Exp3_Trial_Data(si).main.boundary == 0 & Exp3_Trial_Data(si).main.boundary_cat_okay > 0,:));
    Exp3_Behavior_table.select_Chunk_acc_location_cat(si) = nanmean(Exp3_Trial_Data(si).main.location_catAcc(Exp3_Trial_Data(si).main.boundary == 0 & Exp3_Trial_Data(si).main.boundary_cat_okay > 0,:));

    Exp3_Behavior_table.select_Chunk_rt_respond(si) = nanmean(Exp3_Trial_Data(si).main.respondRT(Exp3_Trial_Data(si).main.boundary == 0 & Exp3_Trial_Data(si).main.boundary_cat_okay > 0,:));
    Exp3_Behavior_table.select_Chunk_rt_animal(si) = nanmean(Exp3_Trial_Data(si).main.animalRT(Exp3_Trial_Data(si).main.boundary == 0 & Exp3_Trial_Data(si).main.boundary_cat_okay > 0,:));
    Exp3_Behavior_table.select_Chunk_rt_location(si) = nanmean(Exp3_Trial_Data(si).main.locationRT(Exp3_Trial_Data(si).main.boundary == 0 & Exp3_Trial_Data(si).main.boundary_cat_okay > 0,:));

    Exp3_Behavior_table.select_Chunk_rt_right_respond(si) = nanmean(Exp3_Trial_Data(si).main.respondRT(Exp3_Trial_Data(si).main.boundary == 0 & Exp3_Trial_Data(si).main.boundary_cat_okay > 0 & Exp3_Trial_Data(si).main.fullem == 1,:));
    Exp3_Behavior_table.select_Chunk_rt_right_animal(si) = nanmean(Exp3_Trial_Data(si).main.animalRT(Exp3_Trial_Data(si).main.boundary == 0 & Exp3_Trial_Data(si).main.boundary_cat_okay > 0 & Exp3_Trial_Data(si).main.animalAcc == 1,:));
    Exp3_Behavior_table.select_Chunk_rt_right_location(si) = nanmean(Exp3_Trial_Data(si).main.locationRT(Exp3_Trial_Data(si).main.boundary == 0 & Exp3_Trial_Data(si).main.boundary_cat_okay > 0 & Exp3_Trial_Data(si).main.locationAcc == 1,:));

    Exp3_Behavior_table.select_Chunk_log_rt_respond(si) = nanmean(Exp3_Trial_Data(si).main.respondRT_log(Exp3_Trial_Data(si).main.boundary == 0 & Exp3_Trial_Data(si).main.boundary_cat_okay > 0,:));
    Exp3_Behavior_table.select_Chunk_log_rt_animal(si) = nanmean(Exp3_Trial_Data(si).main.animalRT_log(Exp3_Trial_Data(si).main.boundary == 0 & Exp3_Trial_Data(si).main.boundary_cat_okay > 0,:));
    Exp3_Behavior_table.select_Chunk_log_rt_location(si) = nanmean(Exp3_Trial_Data(si).main.locationRT_log(Exp3_Trial_Data(si).main.boundary == 0 & Exp3_Trial_Data(si).main.boundary_cat_okay > 0,:));

    Exp3_Behavior_table.select_Chunk_log_rt_right_respond(si) = nanmean(Exp3_Trial_Data(si).main.respondRT_log(Exp3_Trial_Data(si).main.boundary == 0 & Exp3_Trial_Data(si).main.boundary_cat_okay > 0 & Exp3_Trial_Data(si).main.fullem == 1,:));
    Exp3_Behavior_table.select_Chunk_log_rt_right_animal(si) = nanmean(Exp3_Trial_Data(si).main.animalRT_log(Exp3_Trial_Data(si).main.boundary == 0 & Exp3_Trial_Data(si).main.boundary_cat_okay > 0 & Exp3_Trial_Data(si).main.animalAcc == 1,:));
    Exp3_Behavior_table.select_Chunk_log_rt_right_location(si) = nanmean(Exp3_Trial_Data(si).main.locationRT_log(Exp3_Trial_Data(si).main.boundary == 0 & Exp3_Trial_Data(si).main.boundary_cat_okay > 0 & Exp3_Trial_Data(si).main.locationAcc == 1,:));




   if sum(Exp3_Trial_Data(si).main.categorical_Acc(Exp3_Trial_Data(si).main.boundary == 1 & Exp3_Trial_Data(si).main.boundary_cat_okay > 0,:) == 1) + sum(Exp3_Trial_Data(si).main.categorical_Acc(Exp3_Trial_Data(si).main.boundary == 1 & Exp3_Trial_Data(si).main.boundary_cat_okay > 0,:) == 0) ~= 0
        Exp3_Behavior_table.select_MBD_loc_chunking(si) = sum(Exp3_Trial_Data(si).main.categorical_Acc(Exp3_Trial_Data(si).main.boundary == 1 & Exp3_Trial_Data(si).main.boundary_cat_okay > 0,:) == 1) / (sum(Exp3_Trial_Data(si).main.categorical_Acc(Exp3_Trial_Data(si).main.boundary == 1 & Exp3_Trial_Data(si).main.boundary_cat_okay > 0,:) == 1) + sum(Exp3_Trial_Data(si).main.categorical_Acc(Exp3_Trial_Data(si).main.boundary == 1 & Exp3_Trial_Data(si).main.boundary_cat_okay > 0,:) == 0));
    else
        Exp3_Behavior_table.select_MBD_loc_chunking(si) = NaN;
   end


    Exp3_Behavior_table.select_MBD_across_acc(si) = nanmean(Exp3_Trial_Data(si).main_trial.across_acc(Exp3_Trial_Data(si).main_trial.boundary == 1  & Exp3_Trial_Data(si).main_trial.boundary_1cross_run > 0,:));
    Exp3_Behavior_table.select_MBD_within_acc(si) = nanmean(Exp3_Trial_Data(si).main_trial.within_acc(Exp3_Trial_Data(si).main_trial.boundary == 1 & Exp3_Trial_Data(si).main_trial.boundary_1cross_run > 0,:));    

    Exp3_Behavior_table.select_MBD_acc_what(si) = nanmean(Exp3_Trial_Data(si).main.what(Exp3_Trial_Data(si).main.boundary == 1 & Exp3_Trial_Data(si).main.boundary_cat_okay > 0,:));
    Exp3_Behavior_table.select_MBD_acc_whatwhen(si) = nanmean(Exp3_Trial_Data(si).main.whatwhen(Exp3_Trial_Data(si).main.boundary == 1 & Exp3_Trial_Data(si).main.boundary_cat_okay > 0,:));
    Exp3_Behavior_table.select_MBD_acc_where(si) = nanmean(Exp3_Trial_Data(si).main.where(Exp3_Trial_Data(si).main.boundary == 1 & Exp3_Trial_Data(si).main.boundary_cat_okay > 0,:));
    Exp3_Behavior_table.select_MBD_acc_wherewhen(si) = nanmean(Exp3_Trial_Data(si).main.wherewhen(Exp3_Trial_Data(si).main.boundary == 1 & Exp3_Trial_Data(si).main.boundary_cat_okay > 0,:));
    Exp3_Behavior_table.select_MBD_acc_whatwhere(si) = nanmean(Exp3_Trial_Data(si).main.whatwhere(Exp3_Trial_Data(si).main.boundary == 1 & Exp3_Trial_Data(si).main.boundary_cat_okay > 0,:));
    Exp3_Behavior_table.select_MBD_acc_fullem(si) = nanmean(Exp3_Trial_Data(si).main.fullem(Exp3_Trial_Data(si).main.boundary == 1 & Exp3_Trial_Data(si).main.boundary_cat_okay > 0,:));
    Exp3_Behavior_table.select_MBD_acc_location_cat(si) = nanmean(Exp3_Trial_Data(si).main.location_catAcc(Exp3_Trial_Data(si).main.boundary == 1 & Exp3_Trial_Data(si).main.boundary_cat_okay > 0,:));

    Exp3_Behavior_table.select_MBD_rt_respond(si) = nanmean(Exp3_Trial_Data(si).main.respondRT(Exp3_Trial_Data(si).main.boundary == 1 & Exp3_Trial_Data(si).main.boundary_cat_okay > 0,:));
    Exp3_Behavior_table.select_MBD_rt_animal(si) = nanmean(Exp3_Trial_Data(si).main.animalRT(Exp3_Trial_Data(si).main.boundary == 1 & Exp3_Trial_Data(si).main.boundary_cat_okay > 0,:));
    Exp3_Behavior_table.select_MBD_rt_location(si) = nanmean(Exp3_Trial_Data(si).main.locationRT(Exp3_Trial_Data(si).main.boundary == 1 & Exp3_Trial_Data(si).main.boundary_cat_okay > 0,:));


    Exp3_Behavior_table.select_MBD_rt_right_respond(si) = nanmean(Exp3_Trial_Data(si).main.respondRT(Exp3_Trial_Data(si).main.boundary == 1 & Exp3_Trial_Data(si).main.boundary_cat_okay > 0 & Exp3_Trial_Data(si).main.fullem == 1,:));
    Exp3_Behavior_table.select_MBD_rt_right_animal(si) = nanmean(Exp3_Trial_Data(si).main.animalRT(Exp3_Trial_Data(si).main.boundary == 1 & Exp3_Trial_Data(si).main.boundary_cat_okay > 0 & Exp3_Trial_Data(si).main.animalAcc == 1,:));
    Exp3_Behavior_table.select_MBD_rt_right_location(si) = nanmean(Exp3_Trial_Data(si).main.locationRT(Exp3_Trial_Data(si).main.boundary == 1 & Exp3_Trial_Data(si).main.boundary_cat_okay > 0 & Exp3_Trial_Data(si).main.locationAcc == 1,:));


    Exp3_Behavior_table.select_MBD_log_rt_respond(si) = nanmean(Exp3_Trial_Data(si).main.respondRT_log(Exp3_Trial_Data(si).main.boundary == 1 & Exp3_Trial_Data(si).main.boundary_cat_okay > 0,:));
    Exp3_Behavior_table.select_MBD_log_rt_animal(si) = nanmean(Exp3_Trial_Data(si).main.animalRT_log(Exp3_Trial_Data(si).main.boundary == 1 & Exp3_Trial_Data(si).main.boundary_cat_okay > 0,:));
    Exp3_Behavior_table.select_MBD_log_rt_location(si) = nanmean(Exp3_Trial_Data(si).main.locationRT_log(Exp3_Trial_Data(si).main.boundary == 1 & Exp3_Trial_Data(si).main.boundary_cat_okay > 0,:));


    Exp3_Behavior_table.select_MBD_log_rt_right_respond(si) = nanmean(Exp3_Trial_Data(si).main.respondRT_log(Exp3_Trial_Data(si).main.boundary == 1 & Exp3_Trial_Data(si).main.boundary_cat_okay > 0 & Exp3_Trial_Data(si).main.fullem == 1,:));
    Exp3_Behavior_table.select_MBD_log_rt_right_animal(si) = nanmean(Exp3_Trial_Data(si).main.animalRT_log(Exp3_Trial_Data(si).main.boundary == 1 & Exp3_Trial_Data(si).main.boundary_cat_okay > 0 & Exp3_Trial_Data(si).main.animalAcc == 1,:));
    Exp3_Behavior_table.select_MBD_log_rt_right_location(si) = nanmean(Exp3_Trial_Data(si).main.locationRT_log(Exp3_Trial_Data(si).main.boundary == 1 & Exp3_Trial_Data(si).main.boundary_cat_okay > 0 & Exp3_Trial_Data(si).main.locationAcc == 1,:));



    % crossing 0
    Exp3_Behavior_table.cross0_acc_what(si) = nanmean(Exp3_Trial_Data(si).main.what(Exp3_Trial_Data(si).main.boundary_crossing == 0 ,:));
    Exp3_Behavior_table.cross0_acc_whatwhen(si) = nanmean(Exp3_Trial_Data(si).main.whatwhen(Exp3_Trial_Data(si).main.boundary_crossing == 0 ,:));
    Exp3_Behavior_table.cross0_acc_where(si) = nanmean(Exp3_Trial_Data(si).main.where(Exp3_Trial_Data(si).main.boundary_crossing == 0  ,:));
    Exp3_Behavior_table.cross0_acc_wherewhen(si) = nanmean(Exp3_Trial_Data(si).main.wherewhen(Exp3_Trial_Data(si).main.boundary_crossing == 0 ,:));
    Exp3_Behavior_table.cross0_acc_whatwhere(si) = nanmean(Exp3_Trial_Data(si).main.whatwhere(Exp3_Trial_Data(si).main.boundary_crossing == 0 ,:));
    Exp3_Behavior_table.cross0_acc_fullem(si) = nanmean(Exp3_Trial_Data(si).main.fullem(Exp3_Trial_Data(si).main.boundary_crossing == 0 ,:));

    Exp3_Behavior_table.cross0_rt_respond(si) = nanmean(Exp3_Trial_Data(si).main.respondRT(Exp3_Trial_Data(si).main.boundary_crossing == 0 ,:));
    Exp3_Behavior_table.cross0_rt_animal(si) = nanmean(Exp3_Trial_Data(si).main.animalRT(Exp3_Trial_Data(si).main.boundary_crossing == 0 ,:));
    Exp3_Behavior_table.cross0_rt_location(si) = nanmean(Exp3_Trial_Data(si).main.locationRT(Exp3_Trial_Data(si).main.boundary_crossing == 0 ,:));

    Exp3_Behavior_table.cross0_Chunk_acc_what(si) = nanmean(Exp3_Trial_Data(si).main.what(Exp3_Trial_Data(si).main.boundary == 0 & Exp3_Trial_Data(si).main.boundary_crossing == 0 ,:));
    Exp3_Behavior_table.cross0_Chunk_acc_whatwhen(si) = nanmean(Exp3_Trial_Data(si).main.whatwhen(Exp3_Trial_Data(si).main.boundary == 0 & Exp3_Trial_Data(si).main.boundary_crossing == 0,:));
    Exp3_Behavior_table.cross0_Chunk_acc_where(si) = nanmean(Exp3_Trial_Data(si).main.where(Exp3_Trial_Data(si).main.boundary == 0 & Exp3_Trial_Data(si).main.boundary_crossing == 0,:));
    Exp3_Behavior_table.cross0_Chunk_acc_wherewhen(si) = nanmean(Exp3_Trial_Data(si).main.wherewhen(Exp3_Trial_Data(si).main.boundary == 0 & Exp3_Trial_Data(si).main.boundary_crossing == 0,:));
    Exp3_Behavior_table.cross0_Chunk_acc_whatwhere(si) = nanmean(Exp3_Trial_Data(si).main.whatwhere(Exp3_Trial_Data(si).main.boundary == 0 & Exp3_Trial_Data(si).main.boundary_crossing == 0,:));
    Exp3_Behavior_table.cross0_Chunk_acc_fullem(si) = nanmean(Exp3_Trial_Data(si).main.fullem(Exp3_Trial_Data(si).main.boundary == 0 & Exp3_Trial_Data(si).main.boundary_crossing == 0,:));
    Exp3_Behavior_table.cross0_Chunk_acc_location_cat(si) = nanmean(Exp3_Trial_Data(si).main.location_catAcc(Exp3_Trial_Data(si).main.boundary == 0 & Exp3_Trial_Data(si).main.boundary_crossing == 0,:));

    Exp3_Behavior_table.cross0_Chunk_rt_respond(si) = nanmean(Exp3_Trial_Data(si).main.respondRT(Exp3_Trial_Data(si).main.boundary == 0 & Exp3_Trial_Data(si).main.boundary_crossing == 0,:));
    Exp3_Behavior_table.cross0_Chunk_rt_animal(si) = nanmean(Exp3_Trial_Data(si).main.animalRT(Exp3_Trial_Data(si).main.boundary == 0 & Exp3_Trial_Data(si).main.boundary_crossing == 0,:));
    Exp3_Behavior_table.cross0_Chunk_rt_location(si) = nanmean(Exp3_Trial_Data(si).main.locationRT(Exp3_Trial_Data(si).main.boundary == 0 & Exp3_Trial_Data(si).main.boundary_crossing == 0,:));

    Exp3_Behavior_table.cross0_Chunk_rt_right_respond(si) = nanmean(Exp3_Trial_Data(si).main.respondRT(Exp3_Trial_Data(si).main.boundary == 0 & Exp3_Trial_Data(si).main.boundary_crossing == 0 & Exp3_Trial_Data(si).main.fullem == 1,:));
    Exp3_Behavior_table.cross0_Chunk_rt_right_animal(si) = nanmean(Exp3_Trial_Data(si).main.animalRT(Exp3_Trial_Data(si).main.boundary == 0 & Exp3_Trial_Data(si).main.boundary_crossing == 0 & Exp3_Trial_Data(si).main.animalAcc == 1,:));
    Exp3_Behavior_table.cross0_Chunk_rt_right_location(si) = nanmean(Exp3_Trial_Data(si).main.locationRT(Exp3_Trial_Data(si).main.boundary == 0 & Exp3_Trial_Data(si).main.boundary_crossing == 0 & Exp3_Trial_Data(si).main.locationAcc == 1,:));



    Exp3_Behavior_table.cross0_MBD_acc_what(si) = nanmean(Exp3_Trial_Data(si).main.what(Exp3_Trial_Data(si).main.boundary == 1 & Exp3_Trial_Data(si).main.boundary_crossing == 0,:));
    Exp3_Behavior_table.cross0_MBD_acc_whatwhen(si) = nanmean(Exp3_Trial_Data(si).main.whatwhen(Exp3_Trial_Data(si).main.boundary == 1 & Exp3_Trial_Data(si).main.boundary_crossing == 0,:));
    Exp3_Behavior_table.cross0_MBD_acc_where(si) = nanmean(Exp3_Trial_Data(si).main.where(Exp3_Trial_Data(si).main.boundary == 1 & Exp3_Trial_Data(si).main.boundary_crossing == 0,:));
    Exp3_Behavior_table.cross0_MBD_acc_wherewhen(si) = nanmean(Exp3_Trial_Data(si).main.wherewhen(Exp3_Trial_Data(si).main.boundary == 1 & Exp3_Trial_Data(si).main.boundary_crossing == 0,:));
    Exp3_Behavior_table.cross0_MBD_acc_whatwhere(si) = nanmean(Exp3_Trial_Data(si).main.whatwhere(Exp3_Trial_Data(si).main.boundary == 1 & Exp3_Trial_Data(si).main.boundary_crossing == 0,:));
    Exp3_Behavior_table.cross0_MBD_acc_fullem(si) = nanmean(Exp3_Trial_Data(si).main.fullem(Exp3_Trial_Data(si).main.boundary == 1 & Exp3_Trial_Data(si).main.boundary_crossing == 0,:));
    Exp3_Behavior_table.cross0_MBD_acc_location_cat(si) = nanmean(Exp3_Trial_Data(si).main.location_catAcc(Exp3_Trial_Data(si).main.boundary == 1 & Exp3_Trial_Data(si).main.boundary_crossing == 0,:));

    Exp3_Behavior_table.cross0_MBD_rt_respond(si) = nanmean(Exp3_Trial_Data(si).main.respondRT(Exp3_Trial_Data(si).main.boundary == 1 & Exp3_Trial_Data(si).main.boundary_crossing == 0,:));
    Exp3_Behavior_table.cross0_MBD_rt_animal(si) = nanmean(Exp3_Trial_Data(si).main.animalRT(Exp3_Trial_Data(si).main.boundary == 1 & Exp3_Trial_Data(si).main.boundary_crossing == 0,:));
    Exp3_Behavior_table.cross0_MBD_rt_location(si) = nanmean(Exp3_Trial_Data(si).main.locationRT(Exp3_Trial_Data(si).main.boundary == 1 & Exp3_Trial_Data(si).main.boundary_crossing == 0,:));


    Exp3_Behavior_table.cross0_MBD_rt_right_respond(si) = nanmean(Exp3_Trial_Data(si).main.respondRT(Exp3_Trial_Data(si).main.boundary == 1 & Exp3_Trial_Data(si).main.boundary_crossing == 0 & Exp3_Trial_Data(si).main.fullem == 1,:));
    Exp3_Behavior_table.cross0_MBD_rt_right_animal(si) = nanmean(Exp3_Trial_Data(si).main.animalRT(Exp3_Trial_Data(si).main.boundary == 1 & Exp3_Trial_Data(si).main.boundary_crossing == 0 & Exp3_Trial_Data(si).main.animalAcc == 1,:));
    Exp3_Behavior_table.cross0_MBD_rt_right_location(si) = nanmean(Exp3_Trial_Data(si).main.locationRT(Exp3_Trial_Data(si).main.boundary == 1 & Exp3_Trial_Data(si).main.boundary_crossing == 0 & Exp3_Trial_Data(si).main.locationAcc == 1,:));


    % bnd index 
    Exp3_Behavior_table.cross0_MBD_Chunk_acc_what(si) = Exp3_Behavior_table.cross0_MBD_acc_what(si) - Exp3_Behavior_table.cross0_Chunk_acc_what(si);
    Exp3_Behavior_table.cross0_MBD_Chunk_acc_whatwhen(si) = Exp3_Behavior_table.cross0_MBD_acc_whatwhen(si) - Exp3_Behavior_table.cross0_Chunk_acc_whatwhen(si);
    Exp3_Behavior_table.cross0_MBD_Chunk_acc_where(si) = Exp3_Behavior_table.cross0_MBD_acc_where(si) - Exp3_Behavior_table.cross0_Chunk_acc_where(si);
    Exp3_Behavior_table.cross0_MBD_Chunk_acc_wherewhen(si) = Exp3_Behavior_table.cross0_MBD_acc_wherewhen(si) - Exp3_Behavior_table.cross0_Chunk_acc_wherewhen(si);
    Exp3_Behavior_table.cross0_MBD_Chunk_acc_whatwhere(si) = Exp3_Behavior_table.cross0_MBD_acc_whatwhere(si) - Exp3_Behavior_table.cross0_Chunk_acc_whatwhere(si);
    Exp3_Behavior_table.cross0_MBD_Chunk_acc_fullem(si) = Exp3_Behavior_table.cross0_MBD_acc_fullem(si) - Exp3_Behavior_table.cross0_Chunk_acc_fullem(si);
                        




    % crossing 2

    Exp3_Behavior_table.cross2_acc_what(si) = nanmean(Exp3_Trial_Data(si).main.what(Exp3_Trial_Data(si).main.boundary_crossing == 2 ,:));
    Exp3_Behavior_table.cross2_acc_whatwhen(si) = nanmean(Exp3_Trial_Data(si).main.whatwhen(Exp3_Trial_Data(si).main.boundary_crossing == 2 ,:));
    Exp3_Behavior_table.cross2_acc_where(si) = nanmean(Exp3_Trial_Data(si).main.where(Exp3_Trial_Data(si).main.boundary_crossing == 2 ,:));
    Exp3_Behavior_table.cross2_acc_wherewhen(si) = nanmean(Exp3_Trial_Data(si).main.wherewhen(Exp3_Trial_Data(si).main.boundary_crossing == 2 ,:));
    Exp3_Behavior_table.cross2_acc_whatwhere(si) = nanmean(Exp3_Trial_Data(si).main.whatwhere(Exp3_Trial_Data(si).main.boundary_crossing == 2 ,:));
    Exp3_Behavior_table.cross2_acc_fullem(si) = nanmean(Exp3_Trial_Data(si).main.fullem(Exp3_Trial_Data(si).main.boundary_crossing == 2 ,:));

    Exp3_Behavior_table.cross2_rt_respond(si) = nanmean(Exp3_Trial_Data(si).main.respondRT(Exp3_Trial_Data(si).main.boundary_crossing == 2 ,:));
    Exp3_Behavior_table.cross2_rt_animal(si) = nanmean(Exp3_Trial_Data(si).main.animalRT(Exp3_Trial_Data(si).main.boundary_crossing == 2 ,:));
    Exp3_Behavior_table.cross2_rt_location(si) = nanmean(Exp3_Trial_Data(si).main.locationRT(Exp3_Trial_Data(si).main.boundary_crossing == 2 ,:));

    Exp3_Behavior_table.cross2_Chunk_acc_what(si) = nanmean(Exp3_Trial_Data(si).main.what(Exp3_Trial_Data(si).main.boundary == 0 & Exp3_Trial_Data(si).main.boundary_crossing == 2 ,:));
    Exp3_Behavior_table.cross2_Chunk_acc_whatwhen(si) = nanmean(Exp3_Trial_Data(si).main.whatwhen(Exp3_Trial_Data(si).main.boundary == 0 & Exp3_Trial_Data(si).main.boundary_crossing == 2,:));
    Exp3_Behavior_table.cross2_Chunk_acc_where(si) = nanmean(Exp3_Trial_Data(si).main.where(Exp3_Trial_Data(si).main.boundary == 0 & Exp3_Trial_Data(si).main.boundary_crossing == 2,:));
    Exp3_Behavior_table.cross2_Chunk_acc_wherewhen(si) = nanmean(Exp3_Trial_Data(si).main.wherewhen(Exp3_Trial_Data(si).main.boundary == 0 & Exp3_Trial_Data(si).main.boundary_crossing == 2,:));
    Exp3_Behavior_table.cross2_Chunk_acc_whatwhere(si) = nanmean(Exp3_Trial_Data(si).main.whatwhere(Exp3_Trial_Data(si).main.boundary == 0 & Exp3_Trial_Data(si).main.boundary_crossing == 2,:));
    Exp3_Behavior_table.cross2_Chunk_acc_fullem(si) = nanmean(Exp3_Trial_Data(si).main.fullem(Exp3_Trial_Data(si).main.boundary == 0 & Exp3_Trial_Data(si).main.boundary_crossing == 2,:));
    Exp3_Behavior_table.cross2_Chunk_acc_location_cat(si) = nanmean(Exp3_Trial_Data(si).main.location_catAcc(Exp3_Trial_Data(si).main.boundary == 0 & Exp3_Trial_Data(si).main.boundary_crossing == 2,:));

    Exp3_Behavior_table.cross2_Chunk_rt_respond(si) = nanmean(Exp3_Trial_Data(si).main.respondRT(Exp3_Trial_Data(si).main.boundary == 0 & Exp3_Trial_Data(si).main.boundary_crossing == 2,:));
    Exp3_Behavior_table.cross2_Chunk_rt_animal(si) = nanmean(Exp3_Trial_Data(si).main.animalRT(Exp3_Trial_Data(si).main.boundary == 0 & Exp3_Trial_Data(si).main.boundary_crossing == 2,:));
    Exp3_Behavior_table.cross2_Chunk_rt_location(si) = nanmean(Exp3_Trial_Data(si).main.locationRT(Exp3_Trial_Data(si).main.boundary == 0 & Exp3_Trial_Data(si).main.boundary_crossing == 2,:));

    Exp3_Behavior_table.cross2_Chunk_rt_right_respond(si) = nanmean(Exp3_Trial_Data(si).main.respondRT(Exp3_Trial_Data(si).main.boundary == 0 & Exp3_Trial_Data(si).main.boundary_crossing == 2 & Exp3_Trial_Data(si).main.fullem == 1,:));
    Exp3_Behavior_table.cross2_Chunk_rt_right_animal(si) = nanmean(Exp3_Trial_Data(si).main.animalRT(Exp3_Trial_Data(si).main.boundary == 0 & Exp3_Trial_Data(si).main.boundary_crossing == 2 & Exp3_Trial_Data(si).main.animalAcc == 1,:));
    Exp3_Behavior_table.cross2_Chunk_rt_right_location(si) = nanmean(Exp3_Trial_Data(si).main.locationRT(Exp3_Trial_Data(si).main.boundary == 0 & Exp3_Trial_Data(si).main.boundary_crossing == 2 & Exp3_Trial_Data(si).main.locationAcc == 1,:));



    Exp3_Behavior_table.cross2_MBD_acc_what(si) = nanmean(Exp3_Trial_Data(si).main.what(Exp3_Trial_Data(si).main.boundary == 1 & Exp3_Trial_Data(si).main.boundary_crossing == 2,:));
    Exp3_Behavior_table.cross2_MBD_acc_whatwhen(si) = nanmean(Exp3_Trial_Data(si).main.whatwhen(Exp3_Trial_Data(si).main.boundary == 1 & Exp3_Trial_Data(si).main.boundary_crossing == 2,:));
    Exp3_Behavior_table.cross2_MBD_acc_where(si) = nanmean(Exp3_Trial_Data(si).main.where(Exp3_Trial_Data(si).main.boundary == 1 & Exp3_Trial_Data(si).main.boundary_crossing == 2,:));
    Exp3_Behavior_table.cross2_MBD_acc_wherewhen(si) = nanmean(Exp3_Trial_Data(si).main.wherewhen(Exp3_Trial_Data(si).main.boundary == 1 & Exp3_Trial_Data(si).main.boundary_crossing == 2,:));
    Exp3_Behavior_table.cross2_MBD_acc_whatwhere(si) = nanmean(Exp3_Trial_Data(si).main.whatwhere(Exp3_Trial_Data(si).main.boundary == 1 & Exp3_Trial_Data(si).main.boundary_crossing == 2,:));
    Exp3_Behavior_table.cross2_MBD_acc_fullem(si) = nanmean(Exp3_Trial_Data(si).main.fullem(Exp3_Trial_Data(si).main.boundary == 1 & Exp3_Trial_Data(si).main.boundary_crossing == 2,:));
    Exp3_Behavior_table.cross2_MBD_acc_location_cat(si) = nanmean(Exp3_Trial_Data(si).main.location_catAcc(Exp3_Trial_Data(si).main.boundary == 1 & Exp3_Trial_Data(si).main.boundary_crossing == 2,:));

    Exp3_Behavior_table.cross2_MBD_rt_respond(si) = nanmean(Exp3_Trial_Data(si).main.respondRT(Exp3_Trial_Data(si).main.boundary == 1 & Exp3_Trial_Data(si).main.boundary_crossing == 2,:));
    Exp3_Behavior_table.cross2_MBD_rt_animal(si) = nanmean(Exp3_Trial_Data(si).main.animalRT(Exp3_Trial_Data(si).main.boundary == 1 & Exp3_Trial_Data(si).main.boundary_crossing == 2,:));
    Exp3_Behavior_table.cross2_MBD_rt_location(si) = nanmean(Exp3_Trial_Data(si).main.locationRT(Exp3_Trial_Data(si).main.boundary == 1 & Exp3_Trial_Data(si).main.boundary_crossing == 2,:));


    Exp3_Behavior_table.cross2_MBD_rt_right_respond(si) = nanmean(Exp3_Trial_Data(si).main.respondRT(Exp3_Trial_Data(si).main.boundary == 1 & Exp3_Trial_Data(si).main.boundary_crossing == 2 & Exp3_Trial_Data(si).main.fullem == 1,:));
    Exp3_Behavior_table.cross2_MBD_rt_right_animal(si) = nanmean(Exp3_Trial_Data(si).main.animalRT(Exp3_Trial_Data(si).main.boundary == 1 & Exp3_Trial_Data(si).main.boundary_crossing == 2 & Exp3_Trial_Data(si).main.animalAcc == 1,:));
    Exp3_Behavior_table.cross2_MBD_rt_right_location(si) = nanmean(Exp3_Trial_Data(si).main.locationRT(Exp3_Trial_Data(si).main.boundary == 1 & Exp3_Trial_Data(si).main.boundary_crossing == 2 & Exp3_Trial_Data(si).main.locationAcc == 1,:));


    % crossing 0 & 2
    Exp3_Behavior_table.cross0and2_acc_what(si) = nanmean(Exp3_Trial_Data(si).main.what(ismember(Exp3_Trial_Data(si).main.boundary_crossing, [0, 2]) ,:));
    Exp3_Behavior_table.cross0and2_acc_whatwhen(si) = nanmean(Exp3_Trial_Data(si).main.whatwhen(ismember(Exp3_Trial_Data(si).main.boundary_crossing, [0, 2]) ,:));
    Exp3_Behavior_table.cross0and2_acc_where(si) = nanmean(Exp3_Trial_Data(si).main.where(ismember(Exp3_Trial_Data(si).main.boundary_crossing, [0, 2]) ,:));
    Exp3_Behavior_table.cross0and2_acc_wherewhen(si) = nanmean(Exp3_Trial_Data(si).main.wherewhen(ismember(Exp3_Trial_Data(si).main.boundary_crossing, [0, 2]),:));
    Exp3_Behavior_table.cross0and2_acc_whatwhere(si) = nanmean(Exp3_Trial_Data(si).main.whatwhere(ismember(Exp3_Trial_Data(si).main.boundary_crossing, [0, 2]),:));
    Exp3_Behavior_table.cross0and2_acc_fullem(si) = nanmean(Exp3_Trial_Data(si).main.fullem(ismember(Exp3_Trial_Data(si).main.boundary_crossing, [0, 2]),:));


    Exp3_Behavior_table.cross0and2_rt_respond(si) = nanmean(Exp3_Trial_Data(si).main.respondRT(ismember(Exp3_Trial_Data(si).main.boundary_crossing, [0, 2]) ,:));
    Exp3_Behavior_table.cross0and2_rt_animal(si) = nanmean(Exp3_Trial_Data(si).main.animalRT(ismember(Exp3_Trial_Data(si).main.boundary_crossing, [0, 2]) ,:));
    Exp3_Behavior_table.cross0and2_rt_location(si) = nanmean(Exp3_Trial_Data(si).main.locationRT(ismember(Exp3_Trial_Data(si).main.boundary_crossing, [0, 2]) ,:));

    Exp3_Behavior_table.cross0and2_Chunk_acc_what(si) = nanmean(Exp3_Trial_Data(si).main.what(Exp3_Trial_Data(si).main.boundary == 0 & ismember(Exp3_Trial_Data(si).main.boundary_crossing, [0, 2]) ,:));
    Exp3_Behavior_table.cross0and2_Chunk_acc_whatwhen(si) = nanmean(Exp3_Trial_Data(si).main.whatwhen(Exp3_Trial_Data(si).main.boundary == 0 & ismember(Exp3_Trial_Data(si).main.boundary_crossing, [0, 2]),:));
    Exp3_Behavior_table.cross0and2_Chunk_acc_where(si) = nanmean(Exp3_Trial_Data(si).main.where(Exp3_Trial_Data(si).main.boundary == 0 & ismember(Exp3_Trial_Data(si).main.boundary_crossing, [0, 2]),:));
    Exp3_Behavior_table.cross0and2_Chunk_acc_wherewhen(si) = nanmean(Exp3_Trial_Data(si).main.wherewhen(Exp3_Trial_Data(si).main.boundary == 0 & ismember(Exp3_Trial_Data(si).main.boundary_crossing, [0, 2]),:));
    Exp3_Behavior_table.cross0and2_Chunk_acc_whatwhere(si) = nanmean(Exp3_Trial_Data(si).main.whatwhere(Exp3_Trial_Data(si).main.boundary == 0 & ismember(Exp3_Trial_Data(si).main.boundary_crossing, [0, 2]),:));
    Exp3_Behavior_table.cross0and2_Chunk_acc_fullem(si) = nanmean(Exp3_Trial_Data(si).main.fullem(Exp3_Trial_Data(si).main.boundary == 0 & ismember(Exp3_Trial_Data(si).main.boundary_crossing, [0, 2]),:));
    Exp3_Behavior_table.cross0and2_Chunk_acc_location_cat(si) = nanmean(Exp3_Trial_Data(si).main.location_catAcc(Exp3_Trial_Data(si).main.boundary == 0 & ismember(Exp3_Trial_Data(si).main.boundary_crossing, [0, 2]),:));

    Exp3_Behavior_table.cross0and2_Chunk_rt_respond(si) = nanmean(Exp3_Trial_Data(si).main.respondRT(Exp3_Trial_Data(si).main.boundary == 0 & ismember(Exp3_Trial_Data(si).main.boundary_crossing, [0, 2]),:));
    Exp3_Behavior_table.cross0and2_Chunk_rt_animal(si) = nanmean(Exp3_Trial_Data(si).main.animalRT(Exp3_Trial_Data(si).main.boundary == 0 & ismember(Exp3_Trial_Data(si).main.boundary_crossing, [0, 2]),:));
    Exp3_Behavior_table.cross0and2_Chunk_rt_location(si) = nanmean(Exp3_Trial_Data(si).main.locationRT(Exp3_Trial_Data(si).main.boundary == 0 & ismember(Exp3_Trial_Data(si).main.boundary_crossing, [0, 2]),:));

    Exp3_Behavior_table.cross0and2_Chunk_rt_right_respond(si) = nanmean(Exp3_Trial_Data(si).main.respondRT(Exp3_Trial_Data(si).main.boundary == 0 & ismember(Exp3_Trial_Data(si).main.boundary_crossing, [0, 2]) & Exp3_Trial_Data(si).main.fullem == 1,:));
    Exp3_Behavior_table.cross0and2_Chunk_rt_right_animal(si) = nanmean(Exp3_Trial_Data(si).main.animalRT(Exp3_Trial_Data(si).main.boundary == 0 & ismember(Exp3_Trial_Data(si).main.boundary_crossing, [0, 2]) & Exp3_Trial_Data(si).main.animalAcc == 1,:));
    Exp3_Behavior_table.cross0and2_Chunk_rt_right_location(si) = nanmean(Exp3_Trial_Data(si).main.locationRT(Exp3_Trial_Data(si).main.boundary == 0 & ismember(Exp3_Trial_Data(si).main.boundary_crossing, [0, 2]) & Exp3_Trial_Data(si).main.locationAcc == 1,:));



    Exp3_Behavior_table.cross0and2_MBD_acc_what(si) = nanmean(Exp3_Trial_Data(si).main.what(Exp3_Trial_Data(si).main.boundary == 1 & ismember(Exp3_Trial_Data(si).main.boundary_crossing, [0, 2]),:));
    Exp3_Behavior_table.cross0and2_MBD_acc_whatwhen(si) = nanmean(Exp3_Trial_Data(si).main.whatwhen(Exp3_Trial_Data(si).main.boundary == 1 & ismember(Exp3_Trial_Data(si).main.boundary_crossing, [0, 2]),:));
    Exp3_Behavior_table.cross0and2_MBD_acc_where(si) = nanmean(Exp3_Trial_Data(si).main.where(Exp3_Trial_Data(si).main.boundary == 1 & ismember(Exp3_Trial_Data(si).main.boundary_crossing, [0, 2]),:));
    Exp3_Behavior_table.cross0and2_MBD_acc_wherewhen(si) = nanmean(Exp3_Trial_Data(si).main.wherewhen(Exp3_Trial_Data(si).main.boundary == 1 & ismember(Exp3_Trial_Data(si).main.boundary_crossing, [0, 2]),:));
    Exp3_Behavior_table.cross0and2_MBD_acc_whatwhere(si) = nanmean(Exp3_Trial_Data(si).main.whatwhere(Exp3_Trial_Data(si).main.boundary == 1 & ismember(Exp3_Trial_Data(si).main.boundary_crossing, [0, 2]),:));
    Exp3_Behavior_table.cross0and2_MBD_acc_fullem(si) = nanmean(Exp3_Trial_Data(si).main.fullem(Exp3_Trial_Data(si).main.boundary == 1 & ismember(Exp3_Trial_Data(si).main.boundary_crossing, [0, 2]),:));
    Exp3_Behavior_table.cross0and2_MBD_acc_location_cat(si) = nanmean(Exp3_Trial_Data(si).main.location_catAcc(Exp3_Trial_Data(si).main.boundary == 1 & ismember(Exp3_Trial_Data(si).main.boundary_crossing, [0, 2]),:));

    Exp3_Behavior_table.cross0and2_MBD_rt_respond(si) = nanmean(Exp3_Trial_Data(si).main.respondRT(Exp3_Trial_Data(si).main.boundary == 1 & ismember(Exp3_Trial_Data(si).main.boundary_crossing, [0, 2]),:));
    Exp3_Behavior_table.cross0and2_MBD_rt_animal(si) = nanmean(Exp3_Trial_Data(si).main.animalRT(Exp3_Trial_Data(si).main.boundary == 1 & ismember(Exp3_Trial_Data(si).main.boundary_crossing, [0, 2]),:));
    Exp3_Behavior_table.cross0and2_MBD_rt_location(si) = nanmean(Exp3_Trial_Data(si).main.locationRT(Exp3_Trial_Data(si).main.boundary == 1 & ismember(Exp3_Trial_Data(si).main.boundary_crossing, [0, 2]),:));


    Exp3_Behavior_table.cross0and2_MBD_rt_right_respond(si) = nanmean(Exp3_Trial_Data(si).main.respondRT(Exp3_Trial_Data(si).main.boundary == 1 & ismember(Exp3_Trial_Data(si).main.boundary_crossing, [0, 2]) & Exp3_Trial_Data(si).main.fullem == 1,:));
    Exp3_Behavior_table.cross0and2_MBD_rt_right_animal(si) = nanmean(Exp3_Trial_Data(si).main.animalRT(Exp3_Trial_Data(si).main.boundary == 1 & ismember(Exp3_Trial_Data(si).main.boundary_crossing, [0, 2]) & Exp3_Trial_Data(si).main.animalAcc == 1,:));
    Exp3_Behavior_table.cross0and2_MBD_rt_right_location(si) = nanmean(Exp3_Trial_Data(si).main.locationRT(Exp3_Trial_Data(si).main.boundary == 1 & ismember(Exp3_Trial_Data(si).main.boundary_crossing, [0, 2]) & Exp3_Trial_Data(si).main.locationAcc == 1,:));


    % crossing 1 & 2
    Exp3_Behavior_table.cross1and2_acc_what(si) = nanmean(Exp3_Trial_Data(si).main.what(ismember(Exp3_Trial_Data(si).main.boundary_crossing, [1, 2]) ,:));
    Exp3_Behavior_table.cross1and2_acc_whatwhen(si) = nanmean(Exp3_Trial_Data(si).main.whatwhen(ismember(Exp3_Trial_Data(si).main.boundary_crossing, [1, 2]) ,:));
    Exp3_Behavior_table.cross1and2_acc_where(si) = nanmean(Exp3_Trial_Data(si).main.where(ismember(Exp3_Trial_Data(si).main.boundary_crossing, [1, 2]) ,:));
    Exp3_Behavior_table.cross1and2_acc_wherewhen(si) = nanmean(Exp3_Trial_Data(si).main.wherewhen(ismember(Exp3_Trial_Data(si).main.boundary_crossing, [1, 2]),:));
    Exp3_Behavior_table.cross1and2_acc_whatwhere(si) = nanmean(Exp3_Trial_Data(si).main.whatwhere(ismember(Exp3_Trial_Data(si).main.boundary_crossing, [1, 2]),:));
    Exp3_Behavior_table.cross1and2_acc_fullem(si) = nanmean(Exp3_Trial_Data(si).main.fullem(ismember(Exp3_Trial_Data(si).main.boundary_crossing, [1, 2]),:));


    Exp3_Behavior_table.cross1and2_rt_respond(si) = nanmean(Exp3_Trial_Data(si).main.respondRT(ismember(Exp3_Trial_Data(si).main.boundary_crossing, [1, 2]) ,:));
    Exp3_Behavior_table.cross1and2_rt_animal(si) = nanmean(Exp3_Trial_Data(si).main.animalRT(ismember(Exp3_Trial_Data(si).main.boundary_crossing, [1, 2]) ,:));
    Exp3_Behavior_table.cross1and2_rt_location(si) = nanmean(Exp3_Trial_Data(si).main.locationRT(ismember(Exp3_Trial_Data(si).main.boundary_crossing, [1, 2]) ,:));


    Exp3_Behavior_table.cross1and2_Chunk_acc_what(si) = nanmean(Exp3_Trial_Data(si).main.what(Exp3_Trial_Data(si).main.boundary == 0 & ismember(Exp3_Trial_Data(si).main.boundary_crossing, [1, 2]) ,:));
    Exp3_Behavior_table.cross1and2_Chunk_acc_whatwhen(si) = nanmean(Exp3_Trial_Data(si).main.whatwhen(Exp3_Trial_Data(si).main.boundary == 0 & ismember(Exp3_Trial_Data(si).main.boundary_crossing, [1, 2]),:));
    Exp3_Behavior_table.cross1and2_Chunk_acc_where(si) = nanmean(Exp3_Trial_Data(si).main.where(Exp3_Trial_Data(si).main.boundary == 0 & ismember(Exp3_Trial_Data(si).main.boundary_crossing, [1, 2]),:));
    Exp3_Behavior_table.cross1and2_Chunk_acc_wherewhen(si) = nanmean(Exp3_Trial_Data(si).main.wherewhen(Exp3_Trial_Data(si).main.boundary == 0 & ismember(Exp3_Trial_Data(si).main.boundary_crossing, [1, 2]),:));
    Exp3_Behavior_table.cross1and2_Chunk_acc_whatwhere(si) = nanmean(Exp3_Trial_Data(si).main.whatwhere(Exp3_Trial_Data(si).main.boundary == 0 & ismember(Exp3_Trial_Data(si).main.boundary_crossing, [1, 2]),:));
    Exp3_Behavior_table.cross1and2_Chunk_acc_fullem(si) = nanmean(Exp3_Trial_Data(si).main.fullem(Exp3_Trial_Data(si).main.boundary == 0 & ismember(Exp3_Trial_Data(si).main.boundary_crossing, [1, 2]),:));
    Exp3_Behavior_table.cross1and2_Chunk_acc_location_cat(si) = nanmean(Exp3_Trial_Data(si).main.location_catAcc(Exp3_Trial_Data(si).main.boundary == 0 & ismember(Exp3_Trial_Data(si).main.boundary_crossing, [1, 2]),:));

    Exp3_Behavior_table.cross1and2_Chunk_rt_respond(si) = nanmean(Exp3_Trial_Data(si).main.respondRT(Exp3_Trial_Data(si).main.boundary == 0 & ismember(Exp3_Trial_Data(si).main.boundary_crossing, [1, 2]),:));
    Exp3_Behavior_table.cross1and2_Chunk_rt_animal(si) = nanmean(Exp3_Trial_Data(si).main.animalRT(Exp3_Trial_Data(si).main.boundary == 0 & ismember(Exp3_Trial_Data(si).main.boundary_crossing, [1, 2]),:));
    Exp3_Behavior_table.cross1and2_Chunk_rt_location(si) = nanmean(Exp3_Trial_Data(si).main.locationRT(Exp3_Trial_Data(si).main.boundary == 0 & ismember(Exp3_Trial_Data(si).main.boundary_crossing, [1, 2]),:));

    Exp3_Behavior_table.cross1and2_Chunk_rt_right_respond(si) = nanmean(Exp3_Trial_Data(si).main.respondRT(Exp3_Trial_Data(si).main.boundary == 0 & ismember(Exp3_Trial_Data(si).main.boundary_crossing, [1, 2]) & Exp3_Trial_Data(si).main.fullem == 1,:));
    Exp3_Behavior_table.cross1and2_Chunk_rt_right_animal(si) = nanmean(Exp3_Trial_Data(si).main.animalRT(Exp3_Trial_Data(si).main.boundary == 0 & ismember(Exp3_Trial_Data(si).main.boundary_crossing, [1, 2]) & Exp3_Trial_Data(si).main.animalAcc == 1,:));
    Exp3_Behavior_table.cross1and2_Chunk_rt_right_location(si) = nanmean(Exp3_Trial_Data(si).main.locationRT(Exp3_Trial_Data(si).main.boundary == 0 & ismember(Exp3_Trial_Data(si).main.boundary_crossing, [1, 2]) & Exp3_Trial_Data(si).main.locationAcc == 1,:));



    Exp3_Behavior_table.cross1and2_MBD_acc_what(si) = nanmean(Exp3_Trial_Data(si).main.what(Exp3_Trial_Data(si).main.boundary == 1 & ismember(Exp3_Trial_Data(si).main.boundary_crossing, [1, 2]),:));
    Exp3_Behavior_table.cross1and2_MBD_acc_whatwhen(si) = nanmean(Exp3_Trial_Data(si).main.whatwhen(Exp3_Trial_Data(si).main.boundary == 1 & ismember(Exp3_Trial_Data(si).main.boundary_crossing, [1, 2]),:));
    Exp3_Behavior_table.cross1and2_MBD_acc_where(si) = nanmean(Exp3_Trial_Data(si).main.where(Exp3_Trial_Data(si).main.boundary == 1 & ismember(Exp3_Trial_Data(si).main.boundary_crossing, [1, 2]),:));
    Exp3_Behavior_table.cross1and2_MBD_acc_wherewhen(si) = nanmean(Exp3_Trial_Data(si).main.wherewhen(Exp3_Trial_Data(si).main.boundary == 1 & ismember(Exp3_Trial_Data(si).main.boundary_crossing, [1, 2]),:));
    Exp3_Behavior_table.cross1and2_MBD_acc_whatwhere(si) = nanmean(Exp3_Trial_Data(si).main.whatwhere(Exp3_Trial_Data(si).main.boundary == 1 & ismember(Exp3_Trial_Data(si).main.boundary_crossing, [1, 2]),:));
    Exp3_Behavior_table.cross1and2_MBD_acc_fullem(si) = nanmean(Exp3_Trial_Data(si).main.fullem(Exp3_Trial_Data(si).main.boundary == 1 & ismember(Exp3_Trial_Data(si).main.boundary_crossing, [1, 2]),:));
    Exp3_Behavior_table.cross1and2_MBD_acc_location_cat(si) = nanmean(Exp3_Trial_Data(si).main.location_catAcc(Exp3_Trial_Data(si).main.boundary == 1 & ismember(Exp3_Trial_Data(si).main.boundary_crossing, [1, 2]),:));

    Exp3_Behavior_table.cross1and2_MBD_rt_respond(si) = nanmean(Exp3_Trial_Data(si).main.respondRT(Exp3_Trial_Data(si).main.boundary == 1 & ismember(Exp3_Trial_Data(si).main.boundary_crossing, [1, 2]),:));
    Exp3_Behavior_table.cross1and2_MBD_rt_animal(si) = nanmean(Exp3_Trial_Data(si).main.animalRT(Exp3_Trial_Data(si).main.boundary == 1 & ismember(Exp3_Trial_Data(si).main.boundary_crossing, [1, 2]),:));
    Exp3_Behavior_table.cross1and2_MBD_rt_location(si) = nanmean(Exp3_Trial_Data(si).main.locationRT(Exp3_Trial_Data(si).main.boundary == 1 & ismember(Exp3_Trial_Data(si).main.boundary_crossing, [1, 2]),:));


    Exp3_Behavior_table.cross1and2_MBD_rt_right_respond(si) = nanmean(Exp3_Trial_Data(si).main.respondRT(Exp3_Trial_Data(si).main.boundary == 1 & ismember(Exp3_Trial_Data(si).main.boundary_crossing, [1, 2]) & Exp3_Trial_Data(si).main.fullem == 1,:));
    Exp3_Behavior_table.cross1and2_MBD_rt_right_animal(si) = nanmean(Exp3_Trial_Data(si).main.animalRT(Exp3_Trial_Data(si).main.boundary == 1 & ismember(Exp3_Trial_Data(si).main.boundary_crossing, [1, 2]) & Exp3_Trial_Data(si).main.animalAcc == 1,:));
    Exp3_Behavior_table.cross1and2_MBD_rt_right_location(si) = nanmean(Exp3_Trial_Data(si).main.locationRT(Exp3_Trial_Data(si).main.boundary == 1 & ismember(Exp3_Trial_Data(si).main.boundary_crossing, [1, 2]) & Exp3_Trial_Data(si).main.locationAcc == 1,:));


    % bnd index (multi - audio)
    Exp3_Behavior_table.all_MBD_Chunk_acc_what(si) = Exp3_Behavior_table.all_MBD_acc_what(si) - Exp3_Behavior_table.all_Chunk_acc_what(si);
    Exp3_Behavior_table.all_MBD_Chunk_acc_whatwhen(si) = Exp3_Behavior_table.all_MBD_acc_whatwhen(si) - Exp3_Behavior_table.all_Chunk_acc_whatwhen(si);
    Exp3_Behavior_table.all_MBD_Chunk_acc_where(si) = Exp3_Behavior_table.all_MBD_acc_where(si) - Exp3_Behavior_table.all_Chunk_acc_where(si);
    Exp3_Behavior_table.all_MBD_Chunk_acc_wherewhen(si) = Exp3_Behavior_table.all_MBD_acc_wherewhen(si) - Exp3_Behavior_table.all_Chunk_acc_wherewhen(si);
    Exp3_Behavior_table.all_MBD_Chunk_acc_whatwhere(si) = Exp3_Behavior_table.all_MBD_acc_whatwhere(si) - Exp3_Behavior_table.all_Chunk_acc_whatwhere(si);
    Exp3_Behavior_table.all_MBD_Chunk_acc_fullem(si) = Exp3_Behavior_table.all_MBD_acc_fullem(si) - Exp3_Behavior_table.all_Chunk_acc_fullem(si);
                        

    Exp3_Behavior_table.select_MBD_Chunk_acc_what(si) = Exp3_Behavior_table.select_MBD_acc_what(si) - Exp3_Behavior_table.select_Chunk_acc_what(si);
    Exp3_Behavior_table.select_MBD_Chunk_acc_whatwhen(si) = Exp3_Behavior_table.select_MBD_acc_whatwhen(si) - Exp3_Behavior_table.select_Chunk_acc_whatwhen(si);
    Exp3_Behavior_table.select_MBD_Chunk_acc_where(si) = Exp3_Behavior_table.select_MBD_acc_where(si) - Exp3_Behavior_table.select_Chunk_acc_where(si);
    Exp3_Behavior_table.select_MBD_Chunk_acc_wherewhen(si) = Exp3_Behavior_table.select_MBD_acc_wherewhen(si) - Exp3_Behavior_table.select_Chunk_acc_wherewhen(si);
    Exp3_Behavior_table.select_MBD_Chunk_acc_whatwhere(si) = Exp3_Behavior_table.select_MBD_acc_whatwhere(si) - Exp3_Behavior_table.select_Chunk_acc_whatwhere(si);
    Exp3_Behavior_table.select_MBD_Chunk_acc_fullem(si) = Exp3_Behavior_table.select_MBD_acc_fullem(si) - Exp3_Behavior_table.select_Chunk_acc_fullem(si);
                   
    Exp3_Behavior_table.cross0_MBD_Chunk_acc_what(si) = Exp3_Behavior_table.cross0_MBD_acc_what(si) - Exp3_Behavior_table.cross0_Chunk_acc_what(si);
    Exp3_Behavior_table.cross0_MBD_Chunk_acc_whatwhen(si) = Exp3_Behavior_table.cross0_MBD_acc_whatwhen(si) - Exp3_Behavior_table.cross0_Chunk_acc_whatwhen(si);
    Exp3_Behavior_table.cross0_MBD_Chunk_acc_where(si) = Exp3_Behavior_table.cross0_MBD_acc_where(si) - Exp3_Behavior_table.cross0_Chunk_acc_where(si);
    Exp3_Behavior_table.cross0_MBD_Chunk_acc_wherewhen(si) = Exp3_Behavior_table.cross0_MBD_acc_wherewhen(si) - Exp3_Behavior_table.cross0_Chunk_acc_wherewhen(si);
    Exp3_Behavior_table.cross0_MBD_Chunk_acc_whatwhere(si) = Exp3_Behavior_table.cross0_MBD_acc_whatwhere(si) - Exp3_Behavior_table.cross0_Chunk_acc_whatwhere(si);
    Exp3_Behavior_table.cross0_MBD_Chunk_acc_fullem(si) = Exp3_Behavior_table.cross0_MBD_acc_fullem(si) - Exp3_Behavior_table.cross0_Chunk_acc_fullem(si);
                   
                   
    Exp3_Behavior_table.cross2_MBD_Chunk_acc_what(si) = Exp3_Behavior_table.cross2_MBD_acc_what(si) - Exp3_Behavior_table.cross2_Chunk_acc_what(si);
    Exp3_Behavior_table.cross2_MBD_Chunk_acc_whatwhen(si) = Exp3_Behavior_table.cross2_MBD_acc_whatwhen(si) - Exp3_Behavior_table.cross2_Chunk_acc_whatwhen(si);
    Exp3_Behavior_table.cross2_MBD_Chunk_acc_where(si) = Exp3_Behavior_table.cross2_MBD_acc_where(si) - Exp3_Behavior_table.cross2_Chunk_acc_where(si);
    Exp3_Behavior_table.cross2_MBD_Chunk_acc_wherewhen(si) = Exp3_Behavior_table.cross2_MBD_acc_wherewhen(si) - Exp3_Behavior_table.cross2_Chunk_acc_wherewhen(si);
    Exp3_Behavior_table.cross2_MBD_Chunk_acc_whatwhere(si) = Exp3_Behavior_table.cross2_MBD_acc_whatwhere(si) - Exp3_Behavior_table.cross2_Chunk_acc_whatwhere(si);
    Exp3_Behavior_table.cross2_MBD_Chunk_acc_fullem(si) = Exp3_Behavior_table.cross2_MBD_acc_fullem(si) - Exp3_Behavior_table.cross2_Chunk_acc_fullem(si);
                   
                   
    Exp3_Behavior_table.cross0and2_MBD_Chunk_acc_what(si) = Exp3_Behavior_table.cross0and2_MBD_acc_what(si) - Exp3_Behavior_table.cross0and2_Chunk_acc_what(si);
    Exp3_Behavior_table.cross0and2_MBD_Chunk_acc_whatwhen(si) = Exp3_Behavior_table.cross0and2_MBD_acc_whatwhen(si) - Exp3_Behavior_table.cross0and2_Chunk_acc_whatwhen(si);
    Exp3_Behavior_table.cross0and2_MBD_Chunk_acc_where(si) = Exp3_Behavior_table.cross0and2_MBD_acc_where(si) - Exp3_Behavior_table.cross0and2_Chunk_acc_where(si);
    Exp3_Behavior_table.cross0and2_MBD_Chunk_acc_wherewhen(si) = Exp3_Behavior_table.cross0and2_MBD_acc_wherewhen(si) - Exp3_Behavior_table.cross0and2_Chunk_acc_wherewhen(si);
    Exp3_Behavior_table.cross0and2_MBD_Chunk_acc_whatwhere(si) = Exp3_Behavior_table.cross0and2_MBD_acc_whatwhere(si) - Exp3_Behavior_table.cross0and2_Chunk_acc_whatwhere(si);
    Exp3_Behavior_table.cross0and2_MBD_Chunk_acc_fullem(si) = Exp3_Behavior_table.cross0and2_MBD_acc_fullem(si) - Exp3_Behavior_table.cross0and2_Chunk_acc_fullem(si);
                   
    Exp3_Behavior_table.cross1and2_MBD_Chunk_acc_what(si) = Exp3_Behavior_table.cross1and2_MBD_acc_what(si) - Exp3_Behavior_table.cross1and2_Chunk_acc_what(si);
    Exp3_Behavior_table.cross1and2_MBD_Chunk_acc_whatwhen(si) = Exp3_Behavior_table.cross1and2_MBD_acc_whatwhen(si) - Exp3_Behavior_table.cross1and2_Chunk_acc_whatwhen(si);
    Exp3_Behavior_table.cross1and2_MBD_Chunk_acc_where(si) = Exp3_Behavior_table.cross1and2_MBD_acc_where(si) - Exp3_Behavior_table.cross1and2_Chunk_acc_where(si);
    Exp3_Behavior_table.cross1and2_MBD_Chunk_acc_wherewhen(si) = Exp3_Behavior_table.cross1and2_MBD_acc_wherewhen(si) - Exp3_Behavior_table.cross1and2_Chunk_acc_wherewhen(si);
    Exp3_Behavior_table.cross1and2_MBD_Chunk_acc_whatwhere(si) = Exp3_Behavior_table.cross1and2_MBD_acc_whatwhere(si) - Exp3_Behavior_table.cross1and2_Chunk_acc_whatwhere(si);
    Exp3_Behavior_table.cross1and2_MBD_Chunk_acc_fullem(si) = Exp3_Behavior_table.cross1and2_MBD_acc_fullem(si) - Exp3_Behavior_table.cross1and2_Chunk_acc_fullem(si);
                   

    Exp3_Behavior_table.cross1_cross0_acc_what(si) = Exp3_Behavior_table.select_acc_what(si) - Exp3_Behavior_table.cross0_acc_what(si);
    Exp3_Behavior_table.cross1_cross0_acc_whatwhen(si) = Exp3_Behavior_table.select_acc_whatwhen(si) - Exp3_Behavior_table.cross0_acc_whatwhen(si);
    Exp3_Behavior_table.cross1_cross0_acc_where(si) = Exp3_Behavior_table.select_acc_where(si) - Exp3_Behavior_table.cross0_acc_where(si);
    Exp3_Behavior_table.cross1_cross0_acc_wherewhen(si) = Exp3_Behavior_table.select_acc_wherewhen(si) - Exp3_Behavior_table.cross0_acc_wherewhen(si);
    Exp3_Behavior_table.cross1_cross0_acc_whatwhere(si) = Exp3_Behavior_table.select_acc_whatwhere(si) - Exp3_Behavior_table.cross0_acc_whatwhere(si);
    Exp3_Behavior_table.cross1_cross0_acc_fullem(si) = Exp3_Behavior_table.select_acc_fullem(si) - Exp3_Behavior_table.cross0_acc_fullem(si);
        
    Exp3_Behavior_table.cross1_cross0and2_acc_what(si) = Exp3_Behavior_table.select_acc_what(si) - Exp3_Behavior_table.cross0and2_acc_what(si);
    Exp3_Behavior_table.cross1_cross0and2_acc_whatwhen(si) = Exp3_Behavior_table.select_acc_whatwhen(si) - Exp3_Behavior_table.cross0and2_acc_whatwhen(si);
    Exp3_Behavior_table.cross1_cross0and2_acc_where(si) = Exp3_Behavior_table.select_acc_where(si) - Exp3_Behavior_table.cross0and2_acc_where(si);
    Exp3_Behavior_table.cross1_cross0and2_acc_wherewhen(si) = Exp3_Behavior_table.select_acc_wherewhen(si) - Exp3_Behavior_table.cross0and2_acc_wherewhen(si);
    Exp3_Behavior_table.cross1_cross0and2_acc_whatwhere(si) = Exp3_Behavior_table.select_acc_whatwhere(si) - Exp3_Behavior_table.cross0and2_acc_whatwhere(si);
    Exp3_Behavior_table.cross1_cross0and2_acc_fullem(si) = Exp3_Behavior_table.select_acc_fullem(si) - Exp3_Behavior_table.cross0and2_acc_fullem(si);
        
    Exp3_Behavior_table.cross1and2_cross0_acc_what(si) = Exp3_Behavior_table.cross1and2_acc_what(si) - Exp3_Behavior_table.cross0_acc_what(si);
    Exp3_Behavior_table.cross1and2_cross0_acc_whatwhen(si) = Exp3_Behavior_table.cross1and2_acc_whatwhen(si) - Exp3_Behavior_table.cross0_acc_whatwhen(si);
    Exp3_Behavior_table.cross1and2_cross0_acc_where(si) = Exp3_Behavior_table.cross1and2_acc_where(si) - Exp3_Behavior_table.cross0_acc_where(si);
    Exp3_Behavior_table.cross1and2_cross0_acc_wherewhen(si) = Exp3_Behavior_table.cross1and2_acc_wherewhen(si) - Exp3_Behavior_table.cross0_acc_wherewhen(si);
    Exp3_Behavior_table.cross1and2_cross0_acc_whatwhere(si) = Exp3_Behavior_table.cross1and2_acc_whatwhere(si) - Exp3_Behavior_table.cross0_acc_whatwhere(si);
    Exp3_Behavior_table.cross1and2_cross0_acc_fullem(si) = Exp3_Behavior_table.cross1and2_acc_fullem(si) - Exp3_Behavior_table.cross0_acc_fullem(si);
        
    Exp3_Behavior_table.cross1_cross2_acc_what(si) = Exp3_Behavior_table.select_acc_what(si) - Exp3_Behavior_table.cross2_acc_what(si);
    Exp3_Behavior_table.cross1_cross2_acc_whatwhen(si) = Exp3_Behavior_table.select_acc_whatwhen(si) - Exp3_Behavior_table.cross2_acc_whatwhen(si);
    Exp3_Behavior_table.cross1_cross2_acc_where(si) = Exp3_Behavior_table.select_acc_where(si) - Exp3_Behavior_table.cross2_acc_where(si);
    Exp3_Behavior_table.cross1_cross2_acc_wherewhen(si) = Exp3_Behavior_table.select_acc_wherewhen(si) - Exp3_Behavior_table.cross2_acc_wherewhen(si);
    Exp3_Behavior_table.cross1_cross2_acc_whatwhere(si) = Exp3_Behavior_table.select_acc_whatwhere(si) - Exp3_Behavior_table.cross2_acc_whatwhere(si);
    Exp3_Behavior_table.cross1_cross2_acc_fullem(si) = Exp3_Behavior_table.select_acc_fullem(si) - Exp3_Behavior_table.cross2_acc_fullem(si);
    

    Exp3_Behavior_table.cross1_cross0_Chunk_acc_what(si) = Exp3_Behavior_table.select_Chunk_acc_what(si) - Exp3_Behavior_table.cross0_Chunk_acc_what(si);
    Exp3_Behavior_table.cross1_cross0_Chunk_acc_whatwhen(si) = Exp3_Behavior_table.select_Chunk_acc_whatwhen(si) - Exp3_Behavior_table.cross0_Chunk_acc_whatwhen(si);
    Exp3_Behavior_table.cross1_cross0_Chunk_acc_where(si) = Exp3_Behavior_table.select_Chunk_acc_where(si) - Exp3_Behavior_table.cross0_Chunk_acc_where(si);
    Exp3_Behavior_table.cross1_cross0_Chunk_acc_wherewhen(si) = Exp3_Behavior_table.select_Chunk_acc_wherewhen(si) - Exp3_Behavior_table.cross0_Chunk_acc_wherewhen(si);
    Exp3_Behavior_table.cross1_cross0_Chunk_acc_whatwhere(si) = Exp3_Behavior_table.select_Chunk_acc_whatwhere(si) - Exp3_Behavior_table.cross0_Chunk_acc_whatwhere(si);
    Exp3_Behavior_table.cross1_cross0_Chunk_acc_fullem(si) = Exp3_Behavior_table.select_Chunk_acc_fullem(si) - Exp3_Behavior_table.cross0_Chunk_acc_fullem(si);
        
    Exp3_Behavior_table.cross1_cross0and2_Chunk_acc_what(si) = Exp3_Behavior_table.select_Chunk_acc_what(si) - Exp3_Behavior_table.cross0and2_Chunk_acc_what(si);
    Exp3_Behavior_table.cross1_cross0and2_Chunk_acc_whatwhen(si) = Exp3_Behavior_table.select_Chunk_acc_whatwhen(si) - Exp3_Behavior_table.cross0and2_Chunk_acc_whatwhen(si);
    Exp3_Behavior_table.cross1_cross0and2_Chunk_acc_where(si) = Exp3_Behavior_table.select_Chunk_acc_where(si) - Exp3_Behavior_table.cross0and2_Chunk_acc_where(si);
    Exp3_Behavior_table.cross1_cross0and2_Chunk_acc_wherewhen(si) = Exp3_Behavior_table.select_Chunk_acc_wherewhen(si) - Exp3_Behavior_table.cross0and2_Chunk_acc_wherewhen(si);
    Exp3_Behavior_table.cross1_cross0and2_Chunk_acc_whatwhere(si) = Exp3_Behavior_table.select_Chunk_acc_whatwhere(si) - Exp3_Behavior_table.cross0and2_Chunk_acc_whatwhere(si);
    Exp3_Behavior_table.cross1_cross0and2_Chunk_acc_fullem(si) = Exp3_Behavior_table.select_Chunk_acc_fullem(si) - Exp3_Behavior_table.cross0and2_Chunk_acc_fullem(si);
        
    Exp3_Behavior_table.cross1and2_cross0_Chunk_acc_what(si) = Exp3_Behavior_table.cross1and2_Chunk_acc_what(si) - Exp3_Behavior_table.cross0_Chunk_acc_what(si);
    Exp3_Behavior_table.cross1and2_cross0_Chunk_acc_whatwhen(si) = Exp3_Behavior_table.cross1and2_Chunk_acc_whatwhen(si) - Exp3_Behavior_table.cross0_Chunk_acc_whatwhen(si);
    Exp3_Behavior_table.cross1and2_cross0_Chunk_acc_where(si) = Exp3_Behavior_table.cross1and2_Chunk_acc_where(si) - Exp3_Behavior_table.cross0_Chunk_acc_where(si);
    Exp3_Behavior_table.cross1and2_cross0_Chunk_acc_wherewhen(si) = Exp3_Behavior_table.cross1and2_Chunk_acc_wherewhen(si) - Exp3_Behavior_table.cross0_Chunk_acc_wherewhen(si);
    Exp3_Behavior_table.cross1and2_cross0_Chunk_acc_whatwhere(si) = Exp3_Behavior_table.cross1and2_Chunk_acc_whatwhere(si) - Exp3_Behavior_table.cross0_Chunk_acc_whatwhere(si);
    Exp3_Behavior_table.cross1and2_cross0_Chunk_acc_fullem(si) = Exp3_Behavior_table.cross1and2_Chunk_acc_fullem(si) - Exp3_Behavior_table.cross0_Chunk_acc_fullem(si);
        
    Exp3_Behavior_table.cross1_cross2_Chunk_acc_what(si) = Exp3_Behavior_table.select_Chunk_acc_what(si) - Exp3_Behavior_table.cross2_Chunk_acc_what(si);
    Exp3_Behavior_table.cross1_cross2_Chunk_acc_whatwhen(si) = Exp3_Behavior_table.select_Chunk_acc_whatwhen(si) - Exp3_Behavior_table.cross2_Chunk_acc_whatwhen(si);
    Exp3_Behavior_table.cross1_cross2_Chunk_acc_where(si) = Exp3_Behavior_table.select_Chunk_acc_where(si) - Exp3_Behavior_table.cross2_Chunk_acc_where(si);
    Exp3_Behavior_table.cross1_cross2_Chunk_acc_wherewhen(si) = Exp3_Behavior_table.select_Chunk_acc_wherewhen(si) - Exp3_Behavior_table.cross2_Chunk_acc_wherewhen(si);
    Exp3_Behavior_table.cross1_cross2_Chunk_acc_whatwhere(si) = Exp3_Behavior_table.select_Chunk_acc_whatwhere(si) - Exp3_Behavior_table.cross2_Chunk_acc_whatwhere(si);
    Exp3_Behavior_table.cross1_cross2_Chunk_acc_fullem(si) = Exp3_Behavior_table.select_Chunk_acc_fullem(si) - Exp3_Behavior_table.cross2_Chunk_acc_fullem(si);
    


    Exp3_Behavior_table.cross1_cross0_MBD_acc_what(si) = Exp3_Behavior_table.select_MBD_acc_what(si) - Exp3_Behavior_table.cross0_MBD_acc_what(si);
    Exp3_Behavior_table.cross1_cross0_MBD_acc_whatwhen(si) = Exp3_Behavior_table.select_MBD_acc_whatwhen(si) - Exp3_Behavior_table.cross0_MBD_acc_whatwhen(si);
    Exp3_Behavior_table.cross1_cross0_MBD_acc_where(si) = Exp3_Behavior_table.select_MBD_acc_where(si) - Exp3_Behavior_table.cross0_MBD_acc_where(si);
    Exp3_Behavior_table.cross1_cross0_MBD_acc_wherewhen(si) = Exp3_Behavior_table.select_MBD_acc_wherewhen(si) - Exp3_Behavior_table.cross0_MBD_acc_wherewhen(si);
    Exp3_Behavior_table.cross1_cross0_MBD_acc_whatwhere(si) = Exp3_Behavior_table.select_MBD_acc_whatwhere(si) - Exp3_Behavior_table.cross0_MBD_acc_whatwhere(si);
    Exp3_Behavior_table.cross1_cross0_MBD_acc_fullem(si) = Exp3_Behavior_table.select_MBD_acc_fullem(si) - Exp3_Behavior_table.cross0_MBD_acc_fullem(si);
        
    Exp3_Behavior_table.cross1_cross0and2_MBD_acc_what(si) = Exp3_Behavior_table.select_MBD_acc_what(si) - Exp3_Behavior_table.cross0and2_MBD_acc_what(si);
    Exp3_Behavior_table.cross1_cross0and2_MBD_acc_whatwhen(si) = Exp3_Behavior_table.select_MBD_acc_whatwhen(si) - Exp3_Behavior_table.cross0and2_MBD_acc_whatwhen(si);
    Exp3_Behavior_table.cross1_cross0and2_MBD_acc_where(si) = Exp3_Behavior_table.select_MBD_acc_where(si) - Exp3_Behavior_table.cross0and2_MBD_acc_where(si);
    Exp3_Behavior_table.cross1_cross0and2_MBD_acc_wherewhen(si) = Exp3_Behavior_table.select_MBD_acc_wherewhen(si) - Exp3_Behavior_table.cross0and2_MBD_acc_wherewhen(si);
    Exp3_Behavior_table.cross1_cross0and2_MBD_acc_whatwhere(si) = Exp3_Behavior_table.select_MBD_acc_whatwhere(si) - Exp3_Behavior_table.cross0and2_MBD_acc_whatwhere(si);
    Exp3_Behavior_table.cross1_cross0and2_MBD_acc_fullem(si) = Exp3_Behavior_table.select_MBD_acc_fullem(si) - Exp3_Behavior_table.cross0and2_MBD_acc_fullem(si);
        
    Exp3_Behavior_table.cross1and2_cross0_MBD_acc_what(si) = Exp3_Behavior_table.cross1and2_MBD_acc_what(si) - Exp3_Behavior_table.cross0_MBD_acc_what(si);
    Exp3_Behavior_table.cross1and2_cross0_MBD_acc_whatwhen(si) = Exp3_Behavior_table.cross1and2_MBD_acc_whatwhen(si) - Exp3_Behavior_table.cross0_MBD_acc_whatwhen(si);
    Exp3_Behavior_table.cross1and2_cross0_MBD_acc_where(si) = Exp3_Behavior_table.cross1and2_MBD_acc_where(si) - Exp3_Behavior_table.cross0_MBD_acc_where(si);
    Exp3_Behavior_table.cross1and2_cross0_MBD_acc_wherewhen(si) = Exp3_Behavior_table.cross1and2_MBD_acc_wherewhen(si) - Exp3_Behavior_table.cross0_MBD_acc_wherewhen(si);
    Exp3_Behavior_table.cross1and2_cross0_MBD_acc_whatwhere(si) = Exp3_Behavior_table.cross1and2_MBD_acc_whatwhere(si) - Exp3_Behavior_table.cross0_MBD_acc_whatwhere(si);
    Exp3_Behavior_table.cross1and2_cross0_MBD_acc_fullem(si) = Exp3_Behavior_table.cross1and2_MBD_acc_fullem(si) - Exp3_Behavior_table.cross0_MBD_acc_fullem(si);
        
    Exp3_Behavior_table.cross1_cross2_MBD_acc_what(si) = Exp3_Behavior_table.select_MBD_acc_what(si) - Exp3_Behavior_table.cross2_MBD_acc_what(si);
    Exp3_Behavior_table.cross1_cross2_MBD_acc_whatwhen(si) = Exp3_Behavior_table.select_MBD_acc_whatwhen(si) - Exp3_Behavior_table.cross2_MBD_acc_whatwhen(si);
    Exp3_Behavior_table.cross1_cross2_MBD_acc_where(si) = Exp3_Behavior_table.select_MBD_acc_where(si) - Exp3_Behavior_table.cross2_MBD_acc_where(si);
    Exp3_Behavior_table.cross1_cross2_MBD_acc_wherewhen(si) = Exp3_Behavior_table.select_MBD_acc_wherewhen(si) - Exp3_Behavior_table.cross2_MBD_acc_wherewhen(si);
    Exp3_Behavior_table.cross1_cross2_MBD_acc_whatwhere(si) = Exp3_Behavior_table.select_MBD_acc_whatwhere(si) - Exp3_Behavior_table.cross2_MBD_acc_whatwhere(si);
    Exp3_Behavior_table.cross1_cross2_MBD_acc_fullem(si) = Exp3_Behavior_table.select_MBD_acc_fullem(si) - Exp3_Behavior_table.cross2_MBD_acc_fullem(si);
    



    % boundary 전 후 RT는 나중에
    %     Behavior_table.rt_befBoundary(si) = NaN;
    %     Behavior_table.rt_aftBoundary(si) = NaN;
    %
    %
    %     response1 = []; response2 = []; respond_av1 = NaN; respond_av2 = NaN;
    %     if sum(ismember(Trial_Data(si).main.boundary_cat, [1, 4]))
    %         response1 = Trial_Data(si).main.respondRT(ismember(Trial_Data(si).main.boundary_cat, [1, 4]),:);
    %         a1 = length(response1); remainders = mod([1:1:a1], 3);
    %
    %     elseif sum(ismember(Trial_Data(si).main.boundary_cat, [3, 6]))
    %         response2 = Trial_Data(si).main.respondRT(ismember(Trial_Data(si).main.boundary_cat, [3, 6]),:);
    %         nanmean(Trial_Data(si).main.locationRT);
    %
    %     end



end
