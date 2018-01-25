function newPlate = checkFormat2(plate)
    tempPlate = plate;
    tempPlate(plate == '-') = [];
    newPlate = '';
    try
        if checkFormat(tempPlate) == plate
            newPlate = plate;
        end
    catch
    end
