%% Import and sort data

% Import data into a table with the playernames as row names and the
% variables as the column names
T = readtable('CompiledStatistics.xlsx') 
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
T1.CumSum = cumsum(T1.occurrences) %Calculate cumulative sum 

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

for i=1:height(T) %strcmp doens't work on its own, NEEDS 'I' 
    if strcmp(T.Position(i),GK);
        T.GoalP(i) = T.Goals(i)*6;
        T.CleanSheetP(i) = T.CleanSheet(i)*4;
        T.saveP(i) = T.AvShotP(i)*1;
        T.ConcededP(i) = round(T.Appearances(i)*T.PercentageOver2(i)*(-1));
    elseif strcmp(T.Position(i),DF);
        T.GoalP(i) = T.Goals(i)*6;    
        T.CleanSheetP(i) = T.CleanSheet(i)*4;
        T.saveP(i) = T.AvShotP(i)*0;
        T.ConcededP(i) = round(T.Appearances(i)*T.PercentageOver2(i)*(-1));
    elseif strcmp(T.Position(i),MF);
        T.GoalP(i) = T.Goals(i)*5;
        T.CleanSheetP(i) = T.CleanSheet(i)*1;
        T.saveP(i) = T.AvShotP(i)*0;
        T.ConcededP(i) = T.Appearances(i)*T.PercentageOver2(i)*0;
    else strcmp(T.Position(i),FW);
        T.GoalP(i) = T.Goals(i)*4;
        T.CleanSheetP(i) = T.CleanSheet(i)*0;
        T.saveP(i) = T.AvShotP(i)*0;
        T.ConcededP(i) = T.Appearances(i)*T.PercentageOver2(i)*0;
    end;
    %Minutes per game: Less than 60 - 1 point / More than 60 - 2 points
    if T.MinutesPerGame(i) > 60
        T.MinuteP(i) = T.Appearances(i)*2;
    else T.MinutesPerGame(i) < 60;
        T.MinuteP(i) = T.Appearances(i)*1;
    end
end

%Only thing left to do is penalty misses, but these are all for forwards 
% and at the moment these haven't been done
%%
for h = size(T,1):1
    if T.Points(h)<
        T(h,:)=[]
    end
end


%% Sum and create new table with key variables

%Add Penalty Misses
T.Points = T.MinuteP+T.ConcededP+T.saveP+T.CleanSheetP+T.GoalP+...
    T.AvShotP+T.YellowCardP+T.AssistP+T.PenaltyP+T.RedCardP...
    +T.OwnGoalP
%%
rowstodelete=T.Points<50
T(rowstodelete,:)=[]

T1 = T(:,{'Player','Club','Position','Value','Points'}); %Creates sub-table
% with the important data types. 

T1vector=table2cell(T1); %turns T1 into a cell
points=cell2mat(T1vector(:,5)); %Extracts points column from cell and turns it into a column vector
value=cell2mat(T1vector(:,4)); %Extracts value column from cell and turns it into a column vector
Avpoint=points./value; %Divides points vector by value vector element by element
T2=array2table(Avpoint);
T1=[T1 T2];



%% Sort into separate tables according to position

GK1 = strcmp(T1.Position,GK); %Create index of all GK
GKTABLE = T1(GK1,:); % Use that index to extract all rows
DF1 = strcmp(T1.Position,DF);
DFTABLE = T1(DF1,:); %The same applied to DF, MF and FW
MF1 = strcmp(T1.Position,MF);
MFTABLE = T1(MF1,:);
FW1 = strcmp(T1.Position,FW);
FWTABLE = T1(FW1,:);

%% Generate base table
for x = 1:2 % 2 GKS
finalteam(x,:) = GKTABLE(randi(height(GKTABLE)),:);
end
for y = 3:7 % 5 DFs
finalteam(y,:) = DFTABLE(randi(height(DFTABLE)),:);
end  
for z = 8:12 % 5 MFs
finalteam(z,:) = MFTABLE(randi(height(MFTABLE)),:);
end
for w = 13:15 % 3 FWs
finalteam(w,:) = FWTABLE(randi(height(FWTABLE)),:);
end

%% OPTIMISATION
for i = 1:1000000
    while 1 % Create a team from each table
        for x = 1:2
        tempteam(x,:) = GKTABLE(randi(height(GKTABLE)),:);
        end
        for y = 3:7
        tempteam(y,:) = DFTABLE(randi(height(DFTABLE)),:);
        end  
        for z = 8:12
        tempteam(z,:) = MFTABLE(randi(height(MFTABLE)),:);
        end
        for w = 13:15
        tempteam(w,:) = FWTABLE(randi(height(FWTABLE)),:);
        end
            if sum(tempteam.Value)<100 && sum(tempteam.Points)>sum(finalteam.Points) %if it's too expensive or not better, find another team
                break
            end
    end
    clubnames = unique(tempteam.Club);
        for j = 1:size(clubnames,1)
            if sum(strcmp(finalteam.Club,clubnames(j)))>3; % Count occurences of each team, if it's greater break and create a new team
                break 
            end
            if j == size(clubnames,1)
                finalteam = tempteam;  %If it reaches the final iteration without breaking, rename the tempteam the finalteam
            end
        end 
i = i+1
finalteam
FinalPoints = sum(finalteam.Points)
FinalValue = sum(finalteam.Value)
end
finalteam
FinalPoints = sum(finalteam.Points)

%% To Do 
% Get rid of rows with NaN points if there are any
% Get rid of some others (low appearances, very low point - we need to
% manually narrow it down fairly extensively otherwise the programme is just
% going to take too long to run!
% Delete rows by setting them equal to []

%% One by one attempt 
% This needs the tables narrowing down before it has any chance of working
combgk = combntns(1:size(GKTABLE,1),2);
combdf = combntns(1:size(DFTABLE,1),5);
combmf = combntns(1:size(MFTABLE,1),5);
combfw = combntns(1:size(FWTABLE,1),5);
%% Meticulously finding team
for l = 1:length(combgk)
    tempteam(1,:) = GKTABLE(combgk(l,1),:);
    tempteam(2,:) = GKTABLE(combgk(l,2),:);
        for m = 1:length(combdf)
        tempteam(3,:) = DFTABLE(combdf(m,1),:);
        tempteam(4,:) = DFTABLE(combdf(m,2),:);
        tempteam(5,:) = DFTABLE(combdf(m,3),:);
        tempteam(6,:) = DFTABLE(combdf(m,4),:);
        tempteam(7,:) = DFTABLE(combdf(m,5),:);
            for n = 1:length(combmf)
            tempteam(8,:) = MFTABLE(combmf(n,1),:);
            tempteam(9,:) = MFTABLE(combmf(n,2),:);
            tempteam(10,:) = MFTABLE(combmf(n,3),:);
            tempteam(11,:) = MFTABLE(combmf(n,4),:);
            tempteam(12,:) = MFTABLE(combmf(n,5),:);
                for o = 1:length(combfw)
                tempteam(13,:) = FWTABLE(combfw(o,1),:);
                tempteam(14,:) = FWTABLE(combfw(o,2),:);
                tempteam(15,:) = FWTABLE(combfw(o,3),:);
                
                if sum(tempteam.Value)<100 && sum(tempteam.Points)>sum(finalteam.Points) %if it's too expensive or not better, find another team
                continue
                clubnames = unique(tempteam.Club);
                    for j = 1:size(clubnames,1)
                       if sum(strcmp(finalteam.Club,clubnames(j)))>3; % Count occurences of each team, if it's greater break and create a new team
                            break
                            continue
                        end
                        if j == size(clubnames,1)
                            finalteam = tempteam;  %If it reaches the final iteration without breaking, rename the tempteam the finalteam
                        end
                    end 
                end
        end
        end
        end
end
                
%% There is another way of doing the above:

T1.avpoints1 = T1.Points./T1.Value

% Change the name of the column if you want but this gives the same figures

%% Define constraints
% Maximum number of players strictly equal to 15
 %sorts for position 
T2=sortrows(T1,'Points','descend'); %Sorts for Points
T3=sortrows(T2,'Position'); %Once sorted for points sorts by position 

%In order to get correct format GK DF MF FW  rename Position Data Variables 
for k=1:174 
    T3.Position{k}='B'; 
end 

for l=175:290
    T3.Position{l}='D';
end

for m=291:337
    T3.Position{m}='A';
end
for n=338:550
 T3.Position{n}='C';   
end

T4 = sortrows(T3,'Position'); % Then sort position  in alphabetical order

%Players from the top two teams, based on points
T5 = T4([1:4,49:58,222:231,435:440], :); %CHANGE THIS TO TOP TEAM

%THINGS TO DOS:
%Order table according to number of points   
%Trying to Optimise for number of points s.t. budget
% Create tables of all players sorted by position and points
% Create Sub Tables of Position sorted by points
%Create Unconstrained top 15  
%Break tables into Matrices or if you can sum Tables do so
% use while loop to run until budget constraint of 15 is under 100
% use if loop to determine which position has the lowest avpoint delete and
% add next highest points (NOT AVPOINTS)- HARD!"!!!
% Once complete - budget is satisfied - look for club constraint -
% shouldn't be voliated 
% Then displayed in Total Points = x , Player - Position - Club



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

%% This method will work for the scrape
T2=sortrows(T1,'Points','descend'); %Sorts for Points
T3=sortrows(T2,'Position'); %Once sorted for points sorts by position 

for i=1:height(T3)
    if strcmp(T3.Position(i),GK);
        T3.Position1(i) = 'A';
    elseif strcmp(T3.Position(i),DF);
        T3.Position1(i) = 'B';
    elseif strcmp(T3.Position(i),MF);
        T3.Position1(i) = 'C';
    else strcmp(T3.Position(i),FW);
        T3.Position1(i) = 'D';
    end
end
T4 = T3(:,{'Club','Value','Points','avpoints1'})
T4.Position=T3.Position1

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
