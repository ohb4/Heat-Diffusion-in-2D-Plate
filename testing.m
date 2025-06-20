function[]=testing(num)
testA=[-8 1 8 5 -3; 1 0 -3 3 -1; 4 6 -2 3 1; 7 9 -1 7 -9; -1 3 4 0 1];
testB=[1;2;3;4;5];

switch num
    case 1
        disp("Test for Gauss Elimination:");
        gaussElim(testA, testB)
    case 2
        testtol = input("Enter error tolerance:");
        testmax=input("Enter maximum number of iterations:");    
        disp("Test for Gauss Seidel:");
        gaussSeidel(testA, testB, testtol, testmax)
    case 3
        disp("Test for Inverse Method:");
        inverseMethod(testA, testB)
    case 4
        disp("Test for Steady State:")
        steadyStateEq(100, 0, 75, 50, 4, 5)      
    case 5
        [PointDB, A, B] = steadyStateEq(100, 0, 75, 50, 4, 5);
        X = inverseMethod (A,B);
        disp("Test for Plotting:")
        heatMapPlot(X, 5, 4)
end

