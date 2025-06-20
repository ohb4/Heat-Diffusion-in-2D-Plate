clear; clc;

while true
    % Main Menu
    disp('Choose what you would like to do:');
    disp('1: Test a Function');
    disp('2: Solve the Main Problem');
    choice = input('Enter the choice number: ');

    if choice == 1
        while true
            % Test Menu
            disp('Choose which function you would like to test:');
            disp('1: Gauss Elimination');
            disp('2: Gauss-Seidel');
            disp('3: Inverse Method');
            disp('4: SS eqn');
            disp('5: Plotting');
            t = input('Enter function number: ');
            testing(t);
                        
            % Ask if the user wants to test again or continue
            disp('Would you like to:');
            disp('1: Test another function');
            disp('2: Continue to the main problem');
            next = input('Enter your choice: ');
            if next == 2
                break; % Exit test loop and move on
            end
        end
    end

    % Main Problem
    fprintf('\nSteady-State Heat Distribution Solver\n');
    NorthT = input('Enter temperature North Side (°C): ');
    SouthT = input('Enter temperature South Side (°C): ');
    WestT = input('Enter temperature West Side (°C): ');
    EastT = input('Enter temperature East Side (°C): ');
    LW = input('Enter the length of one side of the plate (m): ');
    Nodes = input('Enter the number of nodes on x-direction (one side square grid): ');

    % Choose solution method
    disp('Choose a method to solve the system:');
    disp('1: Gauss Elimination');
    disp('2: Gauss-Seidel');
    disp('3: Inverse Method');
    method = input('Enter the method number: ');

    % Generate system of equations
    [PointDB, A, B] = steadyStateEq(NorthT, SouthT, WestT, EastT, LW, Nodes);

    % Solve
    switch method
        case 1
            fprintf('Solving using Gauss Elimination...\n');
            X = gaussElim(A, B);
        case 2
            Err = input('Enter the acceptable relative error (%): ');
            MaxIterations = input('Enter the maximum number of iterations: ');
            fprintf('Solving using Gauss-Seidel...\n');
            [X, relErrorEachVar, avgRelError, iterations] = gaussSeidel(A, B, Err, MaxIterations);
            fprintf('Converged in %d iterations with average error %.2f%%.\n', iterations, avgRelError);
        case 3
            fprintf('Solving using Inverse Method...\n');
            X = inverseMethod(A, B);
        otherwise
            error('Invalid method choice!');
    end

    % Display results
    fprintf('\nTemperature distribution at each point:\n');
    fprintf('Index   X (m)   Y (m)   Temperature (°C)\n');
    for i = 1:length(X)
        fprintf('%d   %.2f   %.2f   %.2f\n', PointDB(i, 1), PointDB(i, 2), PointDB(i, 3), X(i));
    end

    % Plot heat map
    heatMapPlot(X, Nodes, LW);

    % Exit or restart
    disp('Would you like to:');
    disp('1: Restart the program');
    disp('2: Exit');
    restart = input('Enter your choice: ');
    if restart == 2
        clear;clc;
        break; % Exit the whole program        
    else
        clc;
    end
end