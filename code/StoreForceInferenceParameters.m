%store force inference data
path2Store = '..\data\';

voronoiFilesToChoose = [1,2,3,5,6,8,9,10,11,12]; 
frustaFilesToChoose = voronoiFilesToChoose;
%% --------------UNTIL SR = 4. INDEPENDENT PARAMETERS--------------- %%

%% Voronoi
voronoiFilesToChooseName = arrayfun(@(x) ['Voronoi' num2str(x)], voronoiFilesToChoose,'UniformOutput',false);
SR_Voronoi = 1:0.5:4;

contractibilitiesVoronoi = [0.028	0.012	0.004	0.001	0	0	0;
0.03	0.011	0.003	0	0	0	0;
0.02	0.01	0.005	0	0	0	0;
0.03	0.01	0.001	0	0	0	0;
0.028	0.016	0.006	0.004	0	0	0;
0.03	0.014	0.005	0.002	0	0	0;
0.022	0.014	0.004	0.001	0	0	0;
0.037	0.016	0.007	0.002	0	0	0;
0.021	0.011	0.002	0	0	0	0;
0.022	0.015	0.008	0.001	0	0	0];

adhesionVoronoi = array2table([0.023 0.031 0.029 0.038 0.017 0.015 0.023 0.012 0.03 0.014],'VariableNames',voronoiFilesToChooseName);
l_cVoronoi = array2table([166.66 163.56 170.21 173.37 164.2 175.11 166.85 169.95 166.63 166.25],'VariableNames',voronoiFilesToChooseName);
tableContractilityVoronoi = array2table([SR_Voronoi', contractibilitiesVoronoi'],'VariableNames',[{'SR'},voronoiFilesToChooseName]);

%% frusta
frustaFilesToChooseName = arrayfun(@(x) ['Frusta' num2str(x)], frustaFilesToChoose,'UniformOutput',false);
SR_Frusta = SR_Voronoi;

contractibilitiesFrusta = [0.034	0.012	0.004	0.001	0.0001	0	0;	
0.036	0.018	0.008	0.002	0	0	0;
0.029	0.014	0.007	0.002	0.0002	0	0;
0.039	0.017	0.006	0.002	0.001	0	0;
0.031	0.014	0.006	0.003	0.0004	0	0;
0.032	0.015	0.007	0.0036	0.001	0	0;
0.027	0.012	0.006	0.003	0	0	0;
0.04	0.015	0.006	0.003	0.001	0	0;					
0.026	0.014	0.005	0.002	0	0	0;
0.024	0.014	0.007	0.002	0.0001	0	0];

adhesionFrusta = array2table([0.0036 0.0016 0.004 0.004 0.0034  -0.0024 0.0033 0.0012 0.0039 0.0036] ,'VariableNames',frustaFilesToChooseName);
l_cFrusta = array2table([169.93 170.93 172.35 173.72 170.19  177.78 170.03 174.83 168.32 172.4],'VariableNames',frustaFilesToChooseName);
tableContractilityFrusta = array2table([SR_Frusta', contractibilitiesFrusta'],'VariableNames',[{'SR'},frustaFilesToChooseName]);


%Salivary gland WT
SR_WT=1:0.5:4;
glandNumberMatchingOrder = 1:20;
SalGlandWTFilesName = 1:20;
SalGlandWTFilesToChooseName = arrayfun(@(x) ['SalGlandWT' num2str(x)], SalGlandWTFilesName,'UniformOutput',false);

files = dir('..\excelsWithVertices\SalivaryGlandWT\*xls');
salGlandWTName = {files(:).name};
salGlandWTNameSorted = salGlandWTName(glandNumberMatchingOrder);

contractibilitiesSalGland_WT = [0.019	0.017	0.005	0	0	0	0;
0.013	0.02	0.008	0	0	0	0;
0.028	0.02	0.006	0	0	0	0;
0.015	0.017	0.011	0.002	0	0	0;
0.042	0.037	0.026	0.009	0	0	0;
0.029	0.031	0.028	0.017	0.005	0	0;
0.0033	0.034	0.017	0.005	0	0	0;
0.035	0.042	0.028	0.014	0.002	0	0;
0.012	0.022	0.018	0.013	0.004	0	0;
0.043	0.041	0.026	0.012	0.001	0	0.009;
0.047	0.041	0.026	0.009	0	0	0;
0.017	0.019	0.015	0.007	0	0	0;
0.035	0.032	0.021	0.005	0	0	0;
0.032	0.025	0.02	0.012	0.002	0	0;
0.019	0.038	0.024	0.013	0.001	0	0;
0.018	0.021	0.014	0.001	0	0	0;
0.015	0.026	0.032	0.027	0.011	0.003	0;
0.03	0.039	0.029	0.018	0.001	0	0;
0.018	0.029	0.022	0.015	0.004	0	0;
0.039	0.035	0.02	0.005	0	0.001	0];

adhesionSalGland_WT = array2table([0.011 0.018 0.007 0.03 -0.0007 -0.026 -0.001 -0.011 ...
    0.032 -0.024 -0.035 0.009 -0.008 -0.02 -0.006 0.031 0.007 -0.019 -0.0001 -0.011],'VariableNames',SalGlandWTFilesToChooseName);
l_cSalGlandWT = array2table([88.2 88.56 91.49 84.6 85.2 103.19 95.13 111.51 91.21 117.51 ...
111.81 100.94 106.02 88.86 95.22 74.15 106.46 103.61 94.91 96.96],'VariableNames',SalGlandWTFilesToChooseName);

tableContractilitySalGlandWT = array2table([SR_WT', contractibilitiesSalGland_WT'],'VariableNames',[{'SR'},SalGlandWTFilesToChooseName]);


save([path2Store 'linearProgramingParameter_untilSR4_' date '.mat'],'tableContractilitySalGlandWT','tableContractilityVoronoi','tableContractilityFrusta','adhesionSalGland_WT','adhesionVoronoi','adhesionFrusta','l_cSalGlandWT','l_cVoronoi','l_cFrusta');

%% --------------UNTIL SR = 4. SAL GLAND WT AVERAGE ADHESION AND A_0 PARAMETERS--------------- %%

%% Voronoi
contractibilitiesVoronoi = [0.035	0.016	0.009	0.006	0.002	0	0;
0.037	0.016	0.011	0.006	0.003	0.002	0;
0.028	0.016	0.01	0.005	0.003	0	0;
0.039	0.017	0.007	0.004	0.002	0.001	0;
0.032	0.019	0.01	0.008	0.005	0	0;
0.033	0.017	0.008	0.005	0.0009	0	0;
0.028	0.018	0.008	0.006	0.003	0	0;
0.041	0.018	0.009	0.005	0.002	0	0;
0.026	0.018	0.008	0.005	0.003	0	0;
0.024	0.017	0.01	0.003	0.001	0	0];

adhesionVoronoi = array2table([-0.001 -0.001 -0.001 -0.001 -0.001 -0.001 -0.001 -0.001 -0.001 -0.001],'VariableNames',voronoiFilesToChooseName);
l_cVoronoi = array2table([175.4 175.04 175.73 175.15 174.88 175.85 175.27 174.71 175.12 175.5],'VariableNames',voronoiFilesToChooseName);
tableContractilityVoronoi = array2table([SR_Voronoi', contractibilitiesVoronoi'],'VariableNames',[{'SR'},voronoiFilesToChooseName]);

%% frusta
frustaFilesToChoose = voronoiFilesToChoose;
frustaFilesToChooseName = arrayfun(@(x) ['Frusta' num2str(x)], frustaFilesToChoose,'UniformOutput',false);
SR_Frusta = SR_Voronoi;

contractibilitiesFrusta = [0.035	0.012	0.0051	0.003	0.0004	0	0;
0.037	0.018	0.009	0.003	0.0005	0	0;
0.028	0.014	0.007	0.003	0.0004	0	0;
0.039	0.017	0.006	0.003	0.001	0.0002	0;
0.032	0.014	0.007	0.004	0.001	0	0;
0.033	0.015	0.006	0.003	0.0008	0	0;
0.028	0.013	0.006	0.003	0.0008	0	0;
0.041	0.015	0.007	0.003	0.001	0	0;
0.026	0.014	0.007	0.003	0.0009	0	0;
0.024	0.014	0.008	0.004	0.0009	0	0];

adhesionFrusta = array2table([-0.001 -0.001 -0.001 -0.001 -0.001 -0.001 -0.001 -0.001 -0.001 -0.001],'VariableNames',frustaFilesToChooseName);
l_cFrusta = array2table([175.4 175.04 175.73 175.15 174.88 175.85 175.27 174.71 175.12 175.5],'VariableNames',frustaFilesToChooseName);
tableContractilityFrusta = array2table([SR_Frusta', contractibilitiesFrusta'],'VariableNames',[{'SR'},frustaFilesToChooseName]);

save([path2Store 'linearProgramingParameter_untilSR4_SalGlandWT_adhesion_A0_' date '.mat'],'tableContractilitySalGlandWT','tableContractilityVoronoi','tableContractilityFrusta','adhesionSalGland_WT','adhesionVoronoi','adhesionFrusta','l_cSalGlandWT','l_cVoronoi','l_cFrusta');


%% --------------UNTIL SR = 1.75 INDEPENDENT PARAMETERS--------------- %%

%% Voronoi
voronoiFilesToChoose = [1,2,3,4,5,6,8,9,10,11]; 

voronoiFilesToChooseName = arrayfun(@(x) ['Voronoi' num2str(x)], voronoiFilesToChoose,'UniformOutput',false);
SR_Voronoi = [1	1.09	1.18	1.28	1.37	1.46	1.56	1.66	1.75];

contractibilitiesVoronoi = [0.023	0.018	0.014	0.01	0.005	0.001	0	0	0;
0.022	0.017	0.013	0.009	0.005	0.001	0	0	0;
0.023	0.017	0.012	0.006	0.003	0	0	0	0;
0.021	0.018	0.014	0.01	0.006	0.002	0	0	0;
0.019	0.014	0.01	0.005	0.002	0	0	0	0;
0.019	0.014	0.01	0.007	0.004	0.0007	0	0	0;
0.0019	0.016	0.013	0.01	0.006	0.004	0.0002	0	0;
0.017	0.015	0.01	0.008	0.004	0.0008	0	0	0;
0.023	0.02	0.015	0.01	0.005	0.001	0	0	0;
0.017	0.014	0.011	0.007	0.004	0.001	0	0	0];

adhesionVoronoi = array2table([0.023 0.024 0.024 0.031 0.048 0.038 0.028 0.035 0.024 0.036],'VariableNames',voronoiFilesToChooseName);
l_cVoronoi =  array2table([126.06 126.85 127 126.15 126.34 129.38 126.16 128.85 124.5 128.2],'VariableNames',voronoiFilesToChooseName);
tableContractilityVoronoi = array2table([SR_Voronoi', contractibilitiesVoronoi'],'VariableNames',[{'SR'},voronoiFilesToChooseName]);

%% frusta
frustaFilesToChooseName = arrayfun(@(x) ['Frusta' num2str(x)], frustaFilesToChoose,'UniformOutput',false);
SR_Frusta = SR_Voronoi;

contractibilitiesFrusta = [0.024	0.018	0.013	0.008	0.005	0.002	0.0006	0	0;
0.023	0.019	0.014	0.009	0.006	0.003	0	0	0;
0.024	0.018	0.013	0.009	0.004	0.001	0	0	0;
0.024	0.02	0.015	0.011	0.007	0.004	0.001	0	0;
0.022	0.017	0.012	0.008	0.005	0.002	0.0005	0	0;
0.02	0.015	0.01	0.007	0.004	0.002	0	0	0;
0.021	0.018	0.014	0.011	0.008	0.004	0.001	0	0;
0.019	0.017	0.013	0.008	0.005	0.0009	0	0	0;
0.024	0.021	0.015	0.01	0.007	0.004	0.002	0	0;
0.017	0.014	0.011	0.007	0.003	0.0009	0	0	0];

adhesionFrusta =  array2table([0.014 0.02 0.02 0.02 0.032 0.026 0.016 0.023 0.015 0.031],'VariableNames',frustaFilesToChooseName);
l_cFrusta =  array2table([125.44 126.78 127.3 127.1 129.79 125.42 127.87 124.36 128.49 125.15],'VariableNames',frustaFilesToChooseName);
tableContractilityFrusta = array2table([SR_Frusta', contractibilitiesFrusta'],'VariableNames',[{'SR'},frustaFilesToChooseName]);

save([path2Store 'linearProgramingParameter_untilSR175_' date '.mat'],'tableContractilityVoronoi','tableContractilityFrusta','adhesionVoronoi','adhesionFrusta','l_cVoronoi','l_cFrusta');
%% --------------UNTIL SR = 1.75 SAL GLAND WT AVERAGE ADHESION AND A_0 PARAMETERS--------------- %%
%% Voronoi
voronoiFilesToChoose = [1,2,3,4,5,6,8,9,10,11]; 

voronoiFilesToChooseName = arrayfun(@(x) ['Voronoi' num2str(x)], voronoiFilesToChoose,'UniformOutput',false);
SR_Voronoi = [1	1.09	1.18	1.28	1.37	1.46	1.56	1.66	1.75];

contractibilitiesVoronoi = [0.035	0.034	0.029	0.024	0.02	0.017	0.016	0.014	0.012;
0.037	0.032	0.029	0.025	0.02	0.016	0.014	0.013	0.013;
0.028	0.029	0.027	0.023	0.02	0.017	0.014	0.013	0.012;
0.032	0.033	0.031	0.027	0.022	0.019	0.017	0.015	0.012;
0.039	0.035	0.03	0.025	0.022	0.018	0.015	0.013	0.01;
0.032	0.029	0.028	0.024	0.022	0.019	0.017	0.015	0.013;
0.033	0.029	0.026	0.022	0.019	0.018	0.016	0.014	0.013;
0.027	0.027	0.026	0.023	0.021	0.019	0.016	0.014	0.012;
0.04	0.04	0.034	0.027	0.023	0.019	0.016	0.013	0.012;
0.026	0.026	0.024	0.023	0.021	0.018	0.016	0.013	0.012];

adhesionVoronoi = array2table([-0.001	-0.001	-0.001	-0.001	-0.001	-0.001	-0.001	-0.001	-0.001	-0.001],'VariableNames',voronoiFilesToChooseName);
l_cVoronoi = array2table([175.4	175.04	175.73	174.56	175.15	174.88	175.85	175.27	174.71	175.12],'VariableNames',voronoiFilesToChooseName);
tableContractilityVoronoi = array2table([SR_Voronoi', contractibilitiesVoronoi'],'VariableNames',[{'SR'},voronoiFilesToChooseName]);

%% frusta
frustaFilesToChooseName = arrayfun(@(x) ['Frusta' num2str(x)], frustaFilesToChoose,'UniformOutput',false);
SR_Frusta = SR_Voronoi;

contractibilitiesFrusta = [0.035	0.031	0.024	0.019	0.015	0.013	0.011	0.009	0.008;
0.037	0.037	0.033	0.027	0.023	0.02	0.017	0.015	0.012;
0.028	0.026	0.024	0.02	0.017	0.015	0.012	0.01	0.009;
0.03	0.03	0.026	0.021	0.018	0.015	0.013	0.011	0.01;
0.04	0.04	0.03	0.028	0.022	0.018	0.014	0.012	0.009;
0.032	0.029	0.024	0.021	0.017	0.015	0.012	0.011	0.009;
0.033	0.032	0.027	0.023	0.019	0.016	0.013	0.011	0.01;
0.027	0.025	0.021	0.018	0.015	0.014	0.012	0.01	0.008;
0.04	0.034	0.029	0.022	0.018	0.016	0.014	0.012	0.01;
0.026	0.025	0.023	0.02	0.018	0.015	0.014	0.012	0.01];

adhesionFrusta = array2table([-0.001	-0.001	-0.001	-0.001	-0.001	-0.001	-0.001	-0.001	-0.001	-0.001],'VariableNames',frustaFilesToChooseName);
l_cFrusta = array2table([175.4	175.04	175.73	175.15	174.88	175.85	175.27	174.71	175.12	175.5],'VariableNames',frustaFilesToChooseName);
tableContractilityFrusta = array2table([SR_Frusta', contractibilitiesFrusta'],"VariableNames",[{'SR'},frustaFilesToChooseName]);

save([path2Store 'linearProgramingParameter_untilSR175_SalGlandWT_adhesion_A0_' date '.mat'],'tableContractilityVoronoi','tableContractilityFrusta','adhesionVoronoi','adhesionFrusta','l_cVoronoi','l_cFrusta');
