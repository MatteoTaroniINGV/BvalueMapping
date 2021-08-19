% Script for B-value mapping using the complete catalogue and using the
% nighttime catalogue (Figure 1 in the Reply to Comment to Taroni et al.
% 2021).

% Load the catalog in ZMAP format, with the completeness magnitude in the
% last column (11-th column)
% !!! This catalogue must contain only events above the completeness
Catalog = load( 'Catalog_Final_Mc.txt' ) ;

% Load the matrix with Longitude and Latitude of each point of the spatial
% grid (it is a two column matrix)
LongLat = load( 'LongLat_InsideItaly.txt' ) ;

% Parameters for the estimation
ColumnMagn  = 6 ;     % column of the magnitude (in ZMAP format is the 6-th column)
ColumnMC    = 11 ;    % column of the completeness magnitude
MagnBin     = 0.01 ;  % binning for the magnitudes (usually 0.1 for ML and 0.01 for Mw)
SigmaKernel = 30 ;    % sigma of the Gaussian kernel (in km)



%%%%%%% b-value computation and mapping %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% compute the b-value and sigma maps
[ BvalueMap , SigmaMap ] = BvalueMappingWLEstimationMCvariation( Catalog , ColumnMagn , ColumnMC , MagnBin , LongLat , SigmaKernel ) ;

% compute the b-value of the whole catalog
[ Bvalue , NumEv , Sigma ] =  BvalueEstimationMCvariation( Catalog , ColumnMagn , ColumnMC , MagnBin ) ;

% parameter of the confidence interval;
% 1.96 correspond to the 95% confidence interval
Param = 1.96 ;

% preallocation of the seleected b-values
BvalueSelMap = BvalueMap ;

% loop 'for' to selection the b-values
for i = 1 : size( BvalueMap , 1 )
    
    % assign NaN value to the cell of the grid
    BvalueSelMap( i , 3 ) = NaN ;
    
    % if the value is outside the confidence intervall it is ok
    if Bvalue < BvalueMap( i , 3 ) - Param*SigmaMap( i , 3 ) | ...
       Bvalue > BvalueMap( i , 3 ) + Param*SigmaMap( i , 3 )
   
       % assign the b-value to the cell of the grid
       BvalueSelMap( i , 3 ) = BvalueMap( i , 3 ) ;
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%% plot of the results %%%%%%%%%%%%%%%%%%%%%%%

% b-value interval for the colorbar 
BvalueInterval = [ 0.6 , 1.4 ] ;

subplot( 1 , 2 , 1 )

% plot of the map
MapModel_fun( BvalueMap , BvalueInterval )

% plot specifications
box on
xlabel('Long')
ylabel('Lat' )
title( 'B-value' )

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Load the catalog in ZMAP format, with the completeness magnitude in the
% last column (11-th column)
% !!! This catalogue must contain only events above the completeness
Catalog = load( 'Catalog_Final_Mc_NightTime.txt' ) ;

% Load the matrix with Longitude and Latitude of each point of the spatial
% grid (it is a two column matrix)
LongLat = load( 'LongLat_InsideItaly.txt' ) ;

% Parameters for the estimation
ColumnMagn  = 6 ;     % column of the magnitude (in ZMAP format is the 6-th column)
ColumnMC    = 11 ;    % column of the completeness magnitude
MagnBin     = 0.01 ;  % binning for the magnitudes (usually 0.1 for ML and 0.01 for Mw)
SigmaKernel = 30 ;    % sigma of the Gaussian kernel (in km)



%%%%%%% b-value computation and mapping %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% compute the b-value and sigma maps
[ BvalueMap , SigmaMap ] = BvalueMappingWLEstimationMCvariation( Catalog , ColumnMagn , ColumnMC , MagnBin , LongLat , SigmaKernel ) ;

% compute the b-value of the whole catalog
[ Bvalue , NumEv , Sigma ] =  BvalueEstimationMCvariation( Catalog , ColumnMagn , ColumnMC , MagnBin ) ;

% parameter of the confidence interval;
% 1.96 correspond to the 95% confidence interval
Param = 1.96 ;

% preallocation of the seleected b-values
BvalueSelMap = BvalueMap ;

% loop 'for' to selection the b-values
for i = 1 : size( BvalueMap , 1 )
    
    % assign NaN value to the cell of the grid
    BvalueSelMap( i , 3 ) = NaN ;
    
    % if the value is outside the confidence intervall it is ok
    if Bvalue < BvalueMap( i , 3 ) - Param*SigmaMap( i , 3 ) | ...
       Bvalue > BvalueMap( i , 3 ) + Param*SigmaMap( i , 3 )
   
       % assign the b-value to the cell of the grid
       BvalueSelMap( i , 3 ) = BvalueMap( i , 3 ) ;
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%% plot of the results %%%%%%%%%%%%%%%%%%%%%%%

% b-value interval for the colorbar 
BvalueInterval = [ 0.6 , 1.4 ] ;

subplot( 1 , 2 , 2 )

% plot of the map
MapModel_fun( BvalueMap , BvalueInterval )

% plot specifications
box on
xlabel('Long')
ylabel('Lat' )
title( 'B-value' )

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

