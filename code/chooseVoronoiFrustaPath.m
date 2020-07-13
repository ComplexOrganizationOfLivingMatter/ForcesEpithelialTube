function [filePath, path2saveVoronoi,path2saveFrusta,path2loadVoronoi,path2loadFrusta] = chooseVoronoiFrustaPath(SRmax,copyAdhesionA0FromGlands,path2load)

    if SRmax==4 && copyAdhesionA0FromGlands==0
       filePath = [path2load 'linearProgramingParameter_untilSR4_08-Jul-2020.mat'];
       path2saveVoronoi = [path2load 'DataForces\Voronoi\untilSR\'];
       path2saveFrusta = [path2load 'DataForces\Frusta\untilSR4\'];
       path2loadVoronoi = [path2load 'RawExcelsWithVertices\Voronoi\SR10\'];
       path2loadFrusta = [path2load 'RawExcelsWithVertices\Frusta\SR10\'];
    end
    if SRmax==4 && copyAdhesionA0FromGlands==1
       filePath = [path2load 'linearProgramingParameter_untilSR4_SalGlandWT_adhesion_A0_08-Jul-2020.mat'];
       path2saveVoronoi = [path2load 'DataForces\Voronoi\untilSR4_AdhesionA0FromWTGlands\'];
       path2saveFrusta = [path2load 'DataForces\Frusta\untilSR4_AdhesionA0FromWTGlands\'];
       path2loadVoronoi = [path2load 'RawExcelsWithVertices\Voronoi\SR10\'];
        path2loadFrusta = [path2load 'RawExcelsWithVertices\Frusta\SR10\'];
    end
    if SRmax==1.75 && copyAdhesionA0FromGlands==0
        filePath = [path2load 'linearProgramingParameter_untilSR175_08-Jul-2020.mat'];
        path2saveVoronoi = [path2load 'DataForces\Voronoi\untilSR175\'];
        path2saveFrusta = [path2load 'DataForces\Frusta\untilSR175\'];
        path2loadVoronoi = [path2load 'RawExcelsWithVertices\Voronoi\SR175\'];
        path2loadFrusta = [path2load 'RawExcelsWithVertices\Frusta\SR175\'];
    end
    if SRmax==1.75 && copyAdhesionA0FromGlands==1
        filePath = [path2load 'linearProgramingParameter_untilSR175_SalGlandWT_adhesion_A0_08-Jul-2020.mat'];
        path2saveVoronoi = [path2load 'DataForces\Voronoi\untilSR175_AdhesionA0FromWTGlands\'];
        path2saveFrusta = [path2load 'DataForces\Frusta\untilSR175_AdhesionA0FromWTGlands\'];
        path2loadVoronoi = [path2load 'RawExcelsWithVertices\Voronoi\SR175\'];
        path2loadFrusta = [path2load 'RawExcelsWithVertices\Frusta\SR175\'];
    end

    

end