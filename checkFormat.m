function newPlate = checkFormat(plate)
    correct = false;
    if size(plate, 2) > 0
        letterMatrix = [1 1 0 0 1 1; 1 1 1 1 0 0; 0 0 1 1 1 1; 0 0 1 1 1 0; 0 1 1 1 0 0; 1 1 0 0 0 1];
        numberMatrix = ~letterMatrix;
        [lCorrect, index] = ismember(isPlateLetter(plate), letterMatrix, 'rows'); 
        correct = lCorrect & ismember(isstrprop(plate, 'digit'), numberMatrix, 'rows');
        if ~correct && plate(1) == 'V'
            letterVector = [0 0 0 1 1];
            numberVector = ~letterVector;
            correct = all((isPlateLetter(plate(2:6)) == letterVector) & (isstrprop(plate(2:6), 'digit') == numberVector));
            index = 7;
        end;
    end;
    newPlate = '';
    if correct
        newPlate = addBars(plate, index);
    end;
end

function bool = isPlateLetter(char)
    bool = ismember(char, 'BDFGHJKLMNPRSTVWXZ');
end

function newPlate = addBars(plate, index)
    matrix = [2 4; 2 4; 2 4; 2 5; 1 4; 2 5; 1 4];
    n = matrix(index, 1);
    m = matrix(index, 2);
    newPlate = [plate(1:n), '-', plate(n+1:m), '-', plate(m+1:6)];
end
