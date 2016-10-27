%% Import and sort data

%We may have to calculate point per game/points per minute in the excel
%file and then simply use them in Matlab
    
% Import data in the form of column vectors

T = readtable('samplematlab2.xls','ReadRowNames',true); %This creates a table with the names as the row names
    
T.MinutePoints = T.No_OfTimesLessThan60*1+T.No_OfTimesMoreThan60*2;  %Less than 60 - 1 point. More than 60 - 2 points
T.assistpoints = T.CleanSheets*3; % Goal Assist = 3
T.PenaltyPoints = T.PenaltySaves*5; %Penalty save - 5
T.PenaltyConcededPoints = T.PenaltyMisses*(-2); %Penalty Miss - (-2)
T.YellowCardPoints = T.Yellows*(-1); %Yellow Card  (-1)
T.RedCardPoints = T.Reds*(-3); %Red Card (-3)
T.OwnGoalPoints = T.OwnGoal*(-2); %Own Goal (-2)
T.ShotSavePoints = T.x3ShotSaves*1 %3 shot saves goalkeepers - 1
T.ConcPoints = T.x2GoalsConceded*(-1) % 2 goals conceded by keeper/defender - (-1)


%Clean Sheet Goalkeeper/Defender - 4
% Forward - 1
if strcmp(T.Position,'keeper');
   T.CleanSheetPoints = T.CleanSheets*4;
elseif strcmp(T.Position,'Defender');
   T.CleanSheetPoints = T.CleanSheets*4;    
elseif strcmp(T.Position,'Midfielder');
    T.CleanSheetPoints = T.CleanSheets*1;
else strcmp(T.Position,'Forward');
    T.CleanSheetPoints = T.CleanSheets*0;
end

%Goal scored by goalkeeper or defender - 6 points
% Midfielder - 5
% Forward - 4

if strcmp(T.Position,'keeper');
   T.goalpoints = T.GoalsScored*6;
elseif strcmp(T.Position,'Defender');
   T.goalpoints == T.GoalsScored*6;    
elseif strcmp(T.Position,'Midfielder');
    T.goalpoints = T.GoalsScored*5;
else strcmp(T.Position,'Forward');
    T.goalpoints = T.GoalsScored*4;
end
%Sum all calculated points
T.SumOfPoints = T.MinutePoints + T.assistpoints+T.PenaltyPoints+T.PenaltyConcededPoints+T.YellowCardPoints+T.RedCardPoints+T.OwnGoalPoints+T.ShotSavePoints+T.ConcPoints+T.goalpoints+T.CleanSheetPoints;

T1 = T(:,{'Position','Price','SumOfPoints'}) %Creates sub-table with the important data types 



%% Define constraints
%What we could do here is separate the different positions into different
%excel files - it may make it much easier if it only has to find the 
%maximum within itself and not worry about 

% Maximum number of players strictly equal to 15


% Budget £100m 


% Goalkeepers must be equal to 2


% Defenders must be equal to 5


% Midfielders must be equal to 5


% Attackers equal to 3


% Maximum 11 players


% OPTIONAL: SELECTING A CAPTAIN - SCORE DOUBLED
%This could be tricky. Essentially we would want to calculate the highest
%scoring player and override the matrix, ensuring that he is always chosen
%above and beyond anyone else and marked in some way


%% Maximising the problem


% Primary organisation
    % The most obvious way of doing this is to optimise for the best 15
    % players in each respective position although we could choose to
    % optimise for the first 12 and have the best three cheapest players 
    % make up the rest of the spots.



