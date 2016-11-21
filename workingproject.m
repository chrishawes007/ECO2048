%% Import and sort data

% Import data into a table with the playernames as row names and the
% variables as the column names
T = readtable('summarystatistics.xlsx','ReadRowNames',true) 
U = readtable('GoalsConcededPerClub.xlsx','ReadRowNames',true);

%% Setting initial conditions for goalsconcededover 2
% Calculating the goals conceded over 2 
U.ConcededOver2 = U.x3Conceded+U.x4Conceded;
U.PercentOver2 = U.ConcededOver2/38
U = U.PercentOver2;

T = sortrows(T,'Club');
x = T.Club %Creates array 
[Teams,b,id] = unique(x);
occurrences = histc(id,1:max(id));
T1 = table(Teams,occurrences); %Calculates occurrences of each team
T1.CumSum = cumsum(T1.occurrences) %Calculate sum of 

%Use the cumsum of t1 to create a new matrix with 20 different numbers
%lasting the difference between cumsum 

%create matrix of ones equal to size of T1
x = size(T)
inputmatrix = ones(x(1),1)

%replace each team in a loop using U

for i=1:20
    if i == 1
        inputmatrix(1:T1.CumSum(i))=U(i)
    else
        inputmatrix(T1.CumSum(i-1):T1.CumSum(i))=U(i)
    end
end

%combine matrix with table
X = array2table(inputmatrix,'VariableNames',{'PercentageOver2'})
T = [T,X]
%%

%Set for ease
GK = 'Goalkeeper';
DF = 'Defender';
MF = 'Midfielder';
FW = 'Forward';

T.YellowCardP = T.YellowCards*(-1); %Yellow Card = (-1)
T.AssistP = T.Assists*3; % Goal Assist = 3
T.PenaltyP = T.PenaltiesSaved*5; %Penalty save = 5
T.RedCardP = T.RedCards*(-3); %Red Card = (-3)
T.OwnGoalP = T.OwnGoals*(-2); %Own Goal = (-2)

% Goalscored by GK or DF - 6 points, Midfielder - 5, Forward - 4
% Save points is 1 if gk, 0 if anything else
% 1 point scored for every three saves made.
% If GK or DF, -1 points for every 2 goals conceded, MF or FW 0 


T.averageshotsaves = T.Saves/3; % Roughly number of times three saves made
T.AvShotP = round(T.averageshotsaves);%Rounding the figure

for i=1:434 %strcmp doens't work on its own, NEEDS 'I'
    if strcmp(T.Position(i),'Goalkeeper')
        T.GoalP(i) = T.Goals(i)*6;
        T.CleanSheetP(i) = T.CleanSheet(i)*4;
        T.saveP(i) = T.averageshotsavesround(i)*1;
        T.ConcededP(i) = round(T.Appearances(i)*T.PercentageOver2(i)*(-1));
    elseif strcmp(T.Position(i),'Defender')
        T.GoalP(i) = T.Goals(i)*6;    
        T.CleanSheetP(i) = T.CleanSheet(i)*4;
        T.saveP(i) = T.averageshotsavesround(i)*0;
        T.ConcededP(i) = round(T.Appearances(i)*T.PercentageOver2(i)*(-1));
    elseif strcmp(T.Position(i),'Midfielder')
        T.GoalP(i) = T.Goals(i)*5;
        T.CleanSheetP(i) = T.CleanSheet(i)*1;
        T.saveP(i) = T.averageshotsavesround(i)*0;
        T.ConcededP(i) = T.Appearances(i)*T.PercentageOver2(i)*0;
    else strcmp(T.Position(i),'Forward')
        T.GoalP(i) = T.Goals(i)*4;
        T.CleanSheetP(i) = T.CleanSheet(i)*0;
        T.saveP(i) = T.averageshotsavesround(i)*0;
        T.ConcededP(i) = T.Appearances(i)*T.PercentageOver2(i)*0;
    end;
    %Minutes per game: Less than 60 - 1 point / More than 60 - 2 points
    if T.MinutesPerGame(i) > 60;
        T.MinuteP(i) = T.Appearances(i)*2;
    else T.MinutesPerGame(i) < 60;
        T.MinuteP(i) = T.Appearances(i)*1;
    end;
end;

%Only thing left to do is penalty misses, but these are all for forwards 
% and at the moment these haven't been done

%% Sum and create new table with key variables

%Add Penalty Misses
T.SumP = T.MinuteP+T.ConcededP+T.saveP+T.CleanSheetP+T.GoalP+...
    T.AvShotP+T.YellowCardP+T.AssistP+T.PenaltyP+T.RedCardP...
    +T.OwnGoalP

T1 = T(:,{'Club','Position','Value','SumP'}) %Creates sub-table with the important data types. This needs to be extended to others but this is bare bones at the moment
  
    
%% This doesn't do anything but may be useful
clubnames = unique(T.Club)
for i=clubnames %Splits them into clubs
    for j = 1:20
    x{j} = T(strcmp(T.Club,i{j}),:);
    end
end   

%% Alternative calculation for conceding over 2
%I may try and make this work

U1 = U(1,:);
U2 = U(2,:);
U3 = U(3,:);
U4 = U(4,:);
U5 = U(5,:);
U6 = U(6,:);
U7 = U(7,:);
U8 = U(8,:);
U9 = U(9,:);
U10 = U(10,:);
U11 = U(11,:);
U12 = U(12,:);
U13 = U(13,:);
U14 = U(14,:);
U15 = U(15,:);
U16 = U(16,:);
U17 = U(17,:);
U18 = U(18,:);
U19 = U(19,:);
U20 = U(20,:);

if strcmp(T.Club(i),'AFC Bournemouth')
    if strcmp(T.Position(i),'Goalkeeper')
        T.ConcededP(i) = U1.ConcededOver2*(-1)
    elseif strcmp(T.Position(i),'Defender')
        T.ConcededP(i) = U1.ConcededOver2*(-1)
    elseif strcmp(T.Position(i),'Midfielder')
        T.ConcededP(i) = U1.ConcededOver2*(0)
    else strcmp(T.Position(i),'Forward')
        T.ConcededP(i) = U1.ConcededOver2*(0)
    end
elseif strcmp(T.Club(i),'Arsenal') 
    if strcmp(T.Position(i),'Goalkeeper')
        T.ConcededP(i) = U2.ConcededOver2*(-1);
    elseif strcmp(T.Position(i),'Defender')
        T.ConcededP(i) = U2.ConcededOver2*(-1);
    elseif strcmp(T.Position(i),'Midfielder')
        T.ConcededP(i) = U2.ConcededOver2*(0);
    else strcmp(T.Position(i),'Forward')
        T.ConcededP(i) = U2.ConcededOver2*(0);
    end
elseif strcmp(T.Club(i),'Aston Villa')
    if strcmp(T.Position(i),'Goalkeeper')
        T.ConcededP(i) = U3.ConcededOver2*(-1)
    elseif strcmp(T.Position(i),'Defender')
        T.ConcededP(i) = U3.ConcededOver2*(-1)
    elseif strcmp(T.Position(i),'Midfielder')
        T.ConcededP(i) = U3.ConcededOver2*(0)
    else strcmp(T.Position(i),'Forward')
        T.ConcededP(i) = U3.ConcededOver2*(0)
    end
elseif strcmp(T.Club(i),'Chelsea')
    if strcmp(T.Position(i),'Goalkeeper')
        T.ConcededP(i) = U4.ConcededOver2*(-1)
    elseif strcmp(T.Position(i),'Defender')
        T.ConcededP(i) = U4.ConcededOver2*(-1)
    elseif strcmp(T.Position(i),'Midfielder')
        T.ConcededP(i) = U4.ConcededOver2*(0)
    else strcmp(T.Position(i),'Forward')
        T.ConcededP(i) = U4.ConcededOver2*(0)
    end
elseif  strcmp(T.Club(i),'Crystal Palace')
    if strcmp(T.Position(i),'Goalkeeper')
        T.ConcededP(i) = U5.ConcededOver2*(-1)
    elseif strcmp(T.Position(i),'Defender')
        T.ConcededP(i) = U5.ConcededOver2*(-1)
    elseif strcmp(T.Position(i),'Midfielder')
        T.ConcededP(i) = U5.ConcededOver2*(0)
    else strcmp(T.Position(i),'Forward')
        T.ConcededP(i) = U5.ConcededOver2*(0)
    end
elseif strcmp(T.Club(i),'Everton')
    if strcmp(T.Position(i),'Goalkeeper')
        T.ConcededP(i) = U6.ConcededOver2*(-1)
    elseif strcmp(T.Position(i),'Defender')
        T.ConcededP(i) = U6.ConcededOver2*(-1)
    elseif strcmp(T.Position(i),'Midfielder')
        T.ConcededP(i) = U6.ConcededOver2*(0)
    else strcmp(T.Position(i),'Forward')
        T.ConcededP(i) = U6.ConcededOver2*(0)
    end
elseif strcmp(T.Club(i),'Leicester City')
    if strcmp(T.Position(i),'Goalkeeper')
        T.ConcededP(i) = U7.ConcededOver2*(-1)
    elseif strcmp(T.Position(i),'Defender')
        T.ConcededP(i) = U7.ConcededOver2*(-1)
    elseif strcmp(T.Position(i),'Midfielder')
        T.ConcededP(i) = U7.ConcededOver2*(0)
    else strcmp(T.Position(i),'Forward')
        T.ConcededP(i) = U7.ConcededOver2*(0)
    end
elseif strcmp(T.Club(i),'Liverpool')
    if strcmp(T.Position(i),'Goalkeeper')
        T.ConcededP(i) = U8.ConcededOver2*(-1)
    elseif strcmp(T.Position(i),'Defender')
        T.ConcededP(i) = U8.ConcededOver2*(-1)
    elseif strcmp(T.Position(i),'Midfielder')
        T.ConcededP(i) = U8.ConcededOver2*(0)
    else strcmp(T.Position(i),'Forward')
        T.ConcededP(i) = U8.ConcededOver2*(0)
    end
elseif strcmp(T.Club(i),'Manchester City')
    if strcmp(T.Position(i),'Goalkeeper')
        T.ConcededP(i) = U9.ConcededOver2*(-1)
    elseif strcmp(T.Position(i),'Defender')
        T.ConcededP(i) = U9.ConcededOver2*(-1)
    elseif strcmp(T.Position(i),'Midfielder')
        T.ConcededP(i) = U9.ConcededOver2*(0)
    else strcmp(T.Position(i),'Forward')
        T.ConcededP(i) = U9.ConcededOver2*(0)
    end
elseif strcmp(T.Club(i),'Manchester United')
    if strcmp(T.Position(i),'Goalkeeper')
        T.ConcededP(i) = U10.ConcededOver2*(-1)
    elseif strcmp(T.Position(i),'Defender')
        T.ConcededP(i) = U10.ConcededOver2*(-1)
    elseif strcmp(T.Position(i),'Midfielder')
        T.ConcededP(i) = U10.ConcededOver2*(0)
    else strcmp(T.Position(i),'Forward')
        T.ConcededP(i) = U10.ConcededOver2*(0)
    end
elseif strcmp(T.Club(i),'Newcastle United')
    if strcmp(T.Position(i),'Goalkeeper')
        T.ConcededP(i) = U11.ConcededOver2*(-1)
    elseif strcmp(T.Position(i),'Defender')
        T.ConcededP(i) = U11.ConcededOver2*(-1)
    elseif strcmp(T.Position(i),'Midfielder')
        T.ConcededP(i) = U11.ConcededOver2*(0)
    else strcmp(T.Position(i),'Forward')
        T.ConcededP(i) = U11.ConcededOver2*(0)
    end
elseif strcmp(T.Club(i),'Norwich City')
    if strcmp(T.Position(i),'Goalkeeper')
        T.ConcededP(i) = U12.ConcededOver2*(-1)
    elseif strcmp(T.Position(i),'Defender')
        T.ConcededP(i) = U12.ConcededOver2*(-1)
    elseif strcmp(T.Position(i),'Midfielder')
        T.ConcededP(i) = U12.ConcededOver2*(0)
    else strcmp(T.Position(i),'Forward')
        T.ConcededP(i) = U12.ConcededOver2*(0)
    end
elseif strcmp(T.Club(i),'Southampton')
    if strcmp(T.Position(i),'Goalkeeper')
        T.ConcededP(i) = U13.ConcededOver2*(-1)
    elseif strcmp(T.Position(i),'Defender')
        T.ConcededP(i) = U13.ConcededOver2*(-1)
    elseif strcmp(T.Position(i),'Midfielder')
        T.ConcededP(i) = U13.ConcededOver2*(0)
    else strcmp(T.Position(i),'Forward')
        T.ConcededP(i) = U13.ConcededOver2*(0)
    end
elseif strcmp(T.Club(i),'Stoke City')
    if strcmp(T.Position(i),'Goalkeeper')
        T.ConcededP(i) = U14.ConcededOver2*(-1)
    elseif strcmp(T.Position(i),'Defender')
        T.ConcededP(i) = U14.ConcededOver2*(-1)
    elseif strcmp(T.Position(i),'Midfielder')
        T.ConcededP(i) = U14.ConcededOver2*(0)
    else strcmp(T.Position(i),'Forward')
        T.ConcededP(i) = U14.ConcededOver2*(0)
    end
elseif strcmp(T.Club(i),'Sunderland')
    if strcmp(T.Position(i),'Goalkeeper')
        T.ConcededP(i) = U15.ConcededOver2*(-1)
    elseif strcmp(T.Position(i),'Defender')
        T.ConcededP(i) = U15.ConcededOver2*(-1)
    elseif strcmp(T.Position(i),'Midfielder')
        T.ConcededP(i) = U15.ConcededOver2*(0)
    else strcmp(T.Position(i),'Forward')
        T.ConcededP(i) = U15.ConcededOver2*(0)
    end
elseif strcmp(T.Club(i),'Swansea City')
    if strcmp(T.Position(i),'Goalkeeper')
        T.ConcededP(i) = U16.ConcededOver2*(-1)
    elseif strcmp(T.Position(i),'Defender')
        T.ConcededP(i) = U16.ConcededOver2*(-1)
    elseif strcmp(T.Position(i),'Midfielder')
        T.ConcededP(i) = U16.ConcededOver2*(0)
    else strcmp(T.Position(i),'Forward')
        T.ConcededP(i) = U16.ConcededOver2*(0)
    end
elseif strcmp(T.Club(i),'Tottenham')
    if strcmp(T.Position(i),'Goalkeeper')
        T.ConcededP(i) = U17.ConcededOver2*(-1)
    elseif strcmp(T.Position(i),'Defender')
        T.ConcededP(i) = U17.ConcededOver2*(-1)
    elseif strcmp(T.Position(i),'Midfielder')
        T.ConcededP(i) = U17.ConcededOver2*(0)
    else strcmp(T.Position(i),'Forward')
        T.ConcededP(i) = U17.ConcededOver2*(0)
    end
elseif strcmp(T.Club(i),'Watford')
    if strcmp(T.Position(i),'Goalkeeper')
        T.ConcededP(i) = U18.ConcededOver2*(-1)
    elseif strcmp(T.Position(i),'Defender')
        T.ConcededP(i) = U18.ConcededOver2*(-1)
    elseif strcmp(T.Position(i),'Midfielder')
        T.ConcededP(i) = U18.ConcededOver2*(0)
    else strcmp(T.Position(i),'Forward')
        T.ConcededP(i) = U18.ConcededOver2*(0)
    end  
elseif strcmp(T.Club(i),'West Bromwich')
    if strcmp(T.Position(i),'Goalkeeper')
        T.ConcededP(i) = U19.ConcededOver2*(-1)
    elseif strcmp(T.Position(i),'Defender')
        T.ConcededP(i) = U19.ConcededOver2*(-1)
    elseif strcmp(T.Position(i),'Midfielder')
        T.ConcededP(i) = U19.ConcededOver2*(0)
    else strcmp(T.Position(i),'Forward')
        T.ConcededP(i) = U19.ConcededOver2*(0)
    end
else strcmp(T.Club(i),'West Ham Utd')
    if strcmp(T.Position(i),'Goalkeeper')
        T.ConcededP(i) = U20.ConcededOver2*(-1)
    elseif strcmp(T.Position(i),'Defender')
        T.ConcededP(i) = U20.ConcededOver2*(-1)
    elseif strcmp(T.Position(i),'Midfielder')
        T.ConcededP(i) = U20.ConcededOver2*(0)
    else strcmp(T.Position(i),'Forward')
        T.ConcededP(i) = U20.ConcededOver2*(0)
    end
end
          

%% Define constraints
% Maximum number of players strictly equal to 15


% Budget £100m 


% Goalkeepers must be equal to 2


% Defenders must be equal to 5


% Midfielders must be equal to 5


% Attackers equal to 3


% Maximum 3 players from each team


% OPTIONAL: SELECTING A CAPTAIN - SCORE DOUBLED
%This could be tricky. Essentially we would want to calculate the highest
%scoring player and override the matrix, ensuring that he is always chosen
%above and beyond anyone else and marked in some way, but this is very much
%an 'if we have time' problem


%% Maximising the problem


% The most obvious way of doing this is to optimise for the best 15
% players in each respective position although we could choose to
% optimise for the first 12 and have the best three cheapest players 
% make up the rest of the spots. There could be two options - if x = 1
% (user defined) it does one calculates best over all 15 or is x = 2 it
% does the best 11)

% Another thought. You could create a function splits the table into groups
% using 'splitapply' and then creates a random number based on the size of
% the group. Extracts the corresponding row from the table and build a new
% table of 15 players. This initial number is going to be huge, that much 
% is certain but we can then disregard some possibilities. For example, if
% the price is over 100 we can disregard the possibility straight away -
% this can easily be solved with a function. We could also disregard very 
% low numbers as well - it is impossible that 15(4.5m players) will give us
% the maximum points. From there it's just about finding a way to select 
% the group with the highest points total and displaying it. 

% We could get creative here. Using a GUI there may be a way of actually
% presenting the line-up in a pop-up, complete with pictures, but this will
% require much more research before I/we can be certain whether this is
% feasible.



