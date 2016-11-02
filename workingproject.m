%% Import and sort data

% Import data into a table with the playernames as row names and the
% variables as the column names
T = readtable('Goalkeeper.xlsx','ReadRowNames',true); 
U = readtable('GoalsConcededPerClub.xlsx','ReadRowNames',true);

T.YellowCardP = T.YellowCards*(-1); %Yellow Card  (-1)
T.AssistP = T.Assists*3; % Goal Assist = 3
T.PenaltyP = T.PenaltiesSaved*5; %Penalty save - 5
T.RedCardP = T.RedCards*(-3); %Red Card (-3)
T.OwnGoalP = T.OwnGoals*(-2); %Own Goal (-2)

%Clean Sheet Goalkeeper/Defender - 4, Forward - 1
if strcmp(T.Position,'Goalkeeper');
   T.CleanSheetP = T.CleanSheet*4;
elseif strcmp(T.Position,'Defender');      
   T.CleanSheetP = T.CleanSheet*4;    
elseif strcmp(T.Position,'Midfielder');
    T.CleanSheetP = T.CleanSheet*1;
else strcmp(T.Position,'Forward');
    T.CleanSheetP = T.CleanSheet*0;
end;

%Goal scored by goalkeeper or defender - 6 points, Midfielder - 5 & Forward
% - 4
if strcmp(T.Position,'Goalkeeper');
   T.GoalP = T.Goals*6;
elseif strcmp(T.Position,'Defender');
   T.GoalP == T.Goals*6;    
elseif strcmp(T.Position,'Midfielder');
    T.GoalP = T.Goals*5;
else strcmp(T.Position,'Forward');
    T.GoalP = T.Goals*4;
end;

%Minutes per game: Less than 60 - 1 point / More than 60 - 2 points
if T.MinutesPerGame > 60;
   T.MinuteP = T.Appearances*2;
else T.MinutesPerGame < 60;
   T.MinuteP = T.Appearances*1;
end;

T.averageshotsaves = T.Saves/3;
T.averageshotsavesround = round(T.averageshotsaves);%Rounding the figure
if strcmp(T.Position,'Goalkeeper');
    T.saveP = T.averageshotsavesround*1;
else T.saveP = 0
end  %3 shot saves goalkeepers - 1


%% This bit doesn't actually work yet so if you want to try the code run the section above only! 
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

%This still needs work. It works for one entry however creates an array for
%more than one entry. Speak to Antonio/lab man for further advice is the
%best way to go.

if strcmp(T.Club,'Arsenal') 
    if strcmp(T.Position,'Goalkeeper')
        T.ConcededP = U1.ConcededOver2*(-1);
    elseif strcmp(T.Position,'Defender')
        T.ConcededP = U1.ConcededOver2*(-1);
    elseif strcmp(T.Position,'Midfielder')
        T.ConcededP = U1.ConcededOver2*(0);
    else trcmp(T.Position,'Forward')
        T.ConcededP = U1.ConcededOver2*(0);
    end
elseif strcmp(T.Club,'Aston Villa')
    if strcmp(T.Position,'Goalkeeper')
        T.ConcededP = U2.ConcededOver2*(-1)
    elseif strcmp(T.Position,'Defender')
        T.ConcededP = U2.ConcededOver2*(-1)
    elseif strcmp(T.Position,'Midfielder')
        T.ConcededP = U2.ConcededOver2*(0)
    else trcmp(T.Position,'Forward')
        T.ConcededP = U2.ConcededOver2*(0)
    end
elseif strcmp(T.Club,'Bournemouth')
    if strcmp(T.Position,'Goalkeeper')
        T.ConcededP = U3.ConcededOver2*(-1)
    elseif strcmp(T.Position,'Defender')
        T.ConcededP = U3.ConcededOver2*(-1)
    elseif strcmp(T.Position,'Midfielder')
        T.ConcededP = U3.ConcededOver2*(0)
    else trcmp(T.Position,'Forward')
        T.ConcededP = U3.ConcededOver2*(0)
    end
elseif strcmp(T.Club,'Chelsea')
    if strcmp(T.Position,'Goalkeeper')
        T.ConcededP = U4.ConcededOver2*(-1)
    elseif strcmp(T.Position,'Defender')
        T.ConcededP = U4.ConcededOver2*(-1)
    elseif strcmp(T.Position,'Midfielder')
        T.ConcededP = U4.ConcededOver2*(0)
    else trcmp(T.Position,'Forward')
        T.ConcededP = U4.ConcededOver2*(0)
    end
elseif  strcmp(T.Club,'Crystal Palace')
    if strcmp(T.Position,'Goalkeeper')
        T.ConcededP = U5.ConcededOver2*(-1)
    elseif strcmp(T.Position,'Defender')
        T.ConcededP = U5.ConcededOver2*(-1)
    elseif strcmp(T.Position,'Midfielder')
        T.ConcededP = U5.ConcededOver2*(0)
    else trcmp(T.Position,'Forward')
        T.ConcededP = U5.ConcededOver2*(0)
    end
elseif strcmp(T.Club,'Everton')
    if strcmp(T.Position,'Goalkeeper')
        T.ConcededP = U6.ConcededOver2*(-1)
    elseif strcmp(T.Position,'Defender')
        T.ConcededP = U6.ConcededOver2*(-1)
    elseif strcmp(T.Position,'Midfielder')
        T.ConcededP = U6.ConcededOver2*(0)
    else trcmp(T.Position,'Forward')
        T.ConcededP = U6.ConcededOver2*(0)
    end
elseif strcmp(T.Club,'Leicester City')
    if strcmp(T.Position,'Goalkeeper')
        T.ConcededP = U7.ConcededOver2*(-1)
    elseif strcmp(T.Position,'Defender')
        T.ConcededP = U7.ConcededOver2*(-1)
    elseif strcmp(T.Position,'Midfielder')
        T.ConcededP = U7.ConcededOver2*(0)
    else trcmp(T.Position,'Forward')
        T.ConcededP = U7.ConcededOver2*(0)
    end
elseif strcmp(T.Club,'Liverpool')
    if strcmp(T.Position,'Goalkeeper')
        T.ConcededP = U8.ConcededOver2*(-1)
    elseif strcmp(T.Position,'Defender')
        T.ConcededP = U8.ConcededOver2*(-1)
    elseif strcmp(T.Position,'Midfielder')
        T.ConcededP = U8.ConcededOver2*(0)
    else trcmp(T.Position,'Forward')
        T.ConcededP = U8.ConcededOver2*(0)
    end
elseif strcmp(T.Club,'Manchester City')
    if strcmp(T.Position,'Goalkeeper')
        T.ConcededP = U9.ConcededOver2*(-1)
    elseif strcmp(T.Position,'Defender')
        T.ConcededP = U9.ConcededOver2*(-1)
    elseif strcmp(T.Position,'Midfielder')
        T.ConcededP = U9.ConcededOver2*(0)
    else trcmp(T.Position,'Forward')
        T.ConcededP = U9.ConcededOver2*(0)
    end
elseif strcmp(T.Club,'Manchester United')
    if strcmp(T.Position,'Goalkeeper')
        T.ConcededP = U10.ConcededOver2*(-1)
    elseif strcmp(T.Position,'Defender')
        T.ConcededP = U10.ConcededOver2*(-1)
    elseif strcmp(T.Position,'Midfielder')
        T.ConcededP = U10.ConcededOver2*(0)
    else trcmp(T.Position,'Forward')
        T.ConcededP = U10.ConcededOver2*(0)
    end
elseif strcmp(T.Club,'Newcastle United')
    if strcmp(T.Position,'Goalkeeper')
        T.ConcededP = U11.ConcededOver2*(-1)
    elseif strcmp(T.Position,'Defender')
        T.ConcededP = U11.ConcededOver2*(-1)
    elseif strcmp(T.Position,'Midfielder')
        T.ConcededP = U11.ConcededOver2*(0)
    else strcmp(T.Position,'Forward')
        T.ConcededP = U11.ConcededOver2*(0)
    end
elseif strcmp(T.Club,'Norwich City')
    if strcmp(T.Position,'Goalkeeper')
        T.ConcededP = U12.ConcededOver2*(-1)
    elseif strcmp(T.Position,'Defender')
        T.ConcededP = U12.ConcededOver2*(-1)
    elseif strcmp(T.Position,'Midfielder')
        T.ConcededP = U12.ConcededOver2*(0)
    else strcmp(T.Position,'Forward')
        T.ConcededP = U12.ConcededOver2*(0)
    end
elseif strcmp(T.Club,'Southampton')
    if strcmp(T.Position,'Goalkeeper')
        T.ConcededP = U13.ConcededOver2*(-1)
    elseif strcmp(T.Position,'Defender')
        T.ConcededP = U13.ConcededOver2*(-1)
    elseif strcmp(T.Position,'Midfielder')
        T.ConcededP = U13.ConcededOver2*(0)
    else strcmp(T.Position,'Forward')
        T.ConcededP = U13.ConcededOver2*(0)
    end
elseif strcmp(T.Club,'Stoke City')
    if strcmp(T.Position,'Goalkeeper')
        T.ConcededP = U14.ConcededOver2*(-1)
    elseif strcmp(T.Position,'Defender')
        T.ConcededP = U14.ConcededOver2*(-1)
    elseif strcmp(T.Position,'Midfielder')
        T.ConcededP = U14.ConcededOver2*(0)
    else strcmp(T.Position,'Forward')
        T.ConcededP = U14.ConcededOver2*(0)
    end
elseif strcmp(T.Club,'Sunderland')
    if strcmp(T.Position,'Goalkeeper')
        T.ConcededP = U15.ConcededOver2*(-1)
    elseif strcmp(T.Position,'Defender')
        T.ConcededP = U15.ConcededOver2*(-1)
    elseif strcmp(T.Position,'Midfielder')
        T.ConcededP = U15.ConcededOver2*(0)
    else strcmp(T.Position,'Forward')
        T.ConcededP = U15.ConcededOver2*(0)
    end
elseif strcmp(T.Club,'Swansea City')
    if strcmp(T.Position,'Goalkeeper')
        T.ConcededP = U16.ConcededOver2*(-1)
    elseif strcmp(T.Position,'Defender')
        T.ConcededP = U16.ConcededOver2*(-1)
    elseif strcmp(T.Position,'Midfielder')
        T.ConcededP = U16.ConcededOver2*(0)
    else strcmp(T.Position,'Forward')
        T.ConcededP = U16.ConcededOver2*(0)
    end
elseif strcmp(T.Club,'Tottenham')
    if strcmp(T.Position,'Goalkeeper')
        T.ConcededP = U17.ConcededOver2*(-1)
    elseif strcmp(T.Position,'Defender')
        T.ConcededP = U17.ConcededOver2*(-1)
    elseif strcmp(T.Position,'Midfielder')
        T.ConcededP = U17.ConcededOver2*(0)
    else strcmp(T.Position,'Forward')
        T.ConcededP = U17.ConcededOver2*(0)
    end
elseif strcmp(T.Club,'Watford')
    if strcmp(T.Position,'Goalkeeper')
        T.ConcededP = U18.ConcededOver2*(-1)
    elseif strcmp(T.Position,'Defender')
        T.ConcededP = U18.ConcededOver2*(-1)
    elseif strcmp(T.Position,'Midfielder')
        T.ConcededP = U18.ConcededOver2*(0)
    else strcmp(T.Position,'Forward')
        T.ConcededP = U18.ConcededOver2*(0)
    end  
elseif strcmp(T.Club,'West Bromwich')
    if strcmp(T.Position,'Goalkeeper')
        T.ConcededP = U19.ConcededOver2*(-1)
    elseif strcmp(T.Position,'Defender')
        T.ConcededP = U19.ConcededOver2*(-1)
    elseif strcmp(T.Position,'Midfielder')
        T.ConcededP = U19.ConcededOver2*(0)
    else strcmp(T.Position,'Forward')
        T.ConcededP = U19.ConcededOver2*(0)
    end
else strcmp(T.Club,'West Ham Utd')
    if strcmp(T.Position,'Goalkeeper')
        T.ConcededP = U20.ConcededOver2*(-1)
    elseif strcmp(T.Position,'Defender')
        T.ConcededP = U20.ConcededOver2*(-1)
    elseif strcmp(T.Position,'Midfielder')
        T.ConcededP = U20.ConcededOver2*(0)
    else strcmp(T.Position,'Forward')
        T.ConcededP = U20.ConcededOver2*(0)
    end
end
          
%%

%T.averagesgoalsconceded = T.GoalsConceded/2 
%T.averagesgoalsconcededround = round(T.averagesgoalsconceded) %Rounding the figure
%if strcmp(T.Position,'Goalkeeper');
 %  T.GoalsConcededP = T.averagesgoalsconcededround*(-1);
%elseif strcmp(T.Position,'Defender');
 %  T.GoalsConcededP = T.averagesgoalsconcededround*(-1);
%elseif strcmp(T.Position,'Midfielder');
 %   T.GoalsConcededP = T.averagesgoalsconcededround*(0);
%else strcmp(T.Position,'Forward');
 %   T.GoalsConcededP = T.averagesgoalsconcededround*(0);
%end
%Sum all calculated points

T.SumOfPoints = T.MinutePoints + T.assistpoints+T.PenaltyPoints+T.PenaltyConcededPoints+T.YellowCardPoints+T.RedCardPoints+T.OwnGoalPoints+T.ShotSavePoints+T.ConcPoints+T.goalpoints+T.CleanSheetPoints;

T1 = T(:,{'Position','Price','SumOfPoints'}) %Creates sub-table with the important data types. This needs to be extended to others but this is bare bones at the moment
T.PenaltyMissP = T.PenaltyMisses*(-2); %Penalty Miss - (-2)

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



