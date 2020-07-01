clc;
clear;
close all;
%% Problem Definition
CostFunction = @(x) TargetFunction(x); % Cost Function
%CostFunction =@dejong5fcn;
nVar=2;%5; %Number of unknown (Decision) Variables
VarSize=[1 nVar]; % Matrix size of Decision Variables
VarMin = -10; %lower Bound of Decision Variables
VarMax =10 ; %upper Bound of Decision Variables
%% Parameters of PSO
MaxIt=100; % Maximum Number of Iterations
npop=50; %population Size (Swarm Size)
w=1; %Intertia Coefficient
wdamp=0.97;  %Damping ratio of intertia Coefficient
c1=2; %personal Acceleration Coefficient
c2=2; %Social Acceleration Coefficient

%%Initialization
%particle Template
empty_particle.Position=[];
empty_particle.Velocity=[];
empty_particle.Cost=[];
empty_particle.Best.Position=[];
empty_particle.Best.Cost=[];

%Create Population Array
Particle= repmat(empty_particle,npop,1);

%Initialize Global Best
GlobalBest.Cost = inf;
%Initialize Population Members
for i=1 : npop
    %Generate Random Solution
    Particle(i).Position = unifrnd(VarMin,VarMax,VarSize);
    %Initialize Velocity
    Particle(i).Velocity= zeros(VarSize);
    %Evaluation
    Particle(i).Cost=CostFunction(Particle(i).Position);
    %Update Personal Best
    Particle(i).Best.Position= Particle(i).Position;
    Particle(i).Best.Cost= Particle(i).Cost;
        %Update Global Best
    if Particle(i).Best.Cost< GlobalBest.Cost
        GlobalBest= Particle(i).Best;
    end
end

%Array to Hold Best Cost Values on each Iteration
BestCost =zeros(MaxIt,1);

%% Main Loop of PSO
for it=1:MaxIt
    
    for i=1:npop
        %Update Velocity 
        Particle(i).Velocity=w*Particle(i).Velocity... 
                             +c1*rand(VarSize).*(Particle(i).Best.Position - Particle(i).Position)...
                             +c2*rand(VarSize).*(GlobalBest.Position - Particle(i).Position);
        %Update Position
        Particle(i).Position=Particle(i).Position+Particle(i).Velocity;
        %Evaluation
        Particle(i).Cost=CostFunction(Particle(i).Position);
        %Update Personal Best
        if Particle(i).Cost<Particle(i).Best.Cost
            Particle(i).Best.Position= Particle(i).Position;
            Particle(i).Best.Cost= Particle(i).Cost;
         %Update Global Best
         if Particle(i).Best.Cost<GlobalBest.Cost
             GlobalBest=Particle(i).Best;
         end
        end          
%Store the Best Cost Value
BestCosts(it)=GlobalBest.Cost;
%Display Iteration Information
disp(['Iteration  ', num2str(it),': Best Cost= ', num2str(BestCosts(it)) ]);
w=w*wdamp;
    end
end
%Results
figure
plot(BestCosts,'LineWidth',2);
%semilogy(BestCosts,'LineWidth',2);
xlabel('Iteration');ylabel('Best Cost');
GlobalBest.Cost
GlobalBest.Position