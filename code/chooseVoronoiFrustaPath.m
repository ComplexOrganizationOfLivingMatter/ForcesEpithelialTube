function [filePath, path2saveVoronoi,path2saveFrusta] = chooseVoronoiFrustaPath(SRmax,copyAdhesionA0FromGlands,path2load)

    if SRmax==4 && copyAdhesionA0FromGlands==0
       filePath = [path2load 'linearProgramingParameter_untilSR4_07-Jul-2020.mat'];
       path2saveVoronoi = [path2load 'DataForces\Voronoi\untilSR4\'];
       path2saveFrusta = [path2load 'DataForces\Frusta\untilSR4\'];
    end
    if SRmax==4 && copyAdhesionA0FromGlands==1
       filePath = [path2load 'linearProgramingParameter_untilSR4_SalGlandWT_adhesion_A0_07-Jul-2020.mat'];
       path2saveVoronoi = [path2load 'DataForces\Voronoi\untilSR4_AdhesionA0FromWTGlands\'];
       path2saveFrusta = [path2load 'DataForces\Frusta\untilSR4_AdhesionA0FromWTGlands\'];
    end
    if SRmax==1.75 && copyAdhesionA0FromGlands==0
        filePath = [path2load 'linearProgramingParameter_untilSR175_07-Jul-2020.mat'];
        path2saveVoronoi = [path2load 'DataForces\Voronoi\untilSR175\'];
        path2saveFrusta = [path2load 'DataForces\Frusta\untilSR175\'];
    end
    if SRmax==1.75 && copyAdhesionA0FromGlands==1
        filePath = [path2load 'linearProgramingParameter_untilSR175_SalGlandWT_adhesion_A0_07-Jul-2020.mat'];
        path2saveVoronoi = [path2load 'DataForces\Voronoi\untilSR175_AdhesionA0FromWTGlands\'];
        path2saveFrusta = [path2load 'DataForces\Frusta\untilSR175_AdhesionA0FromWTGlands\'];
    end


end