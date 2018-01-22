function licensePlate = processImage(image)
    plate = test3(image);
    newPlate = plate;
    newPlate(plate == 'B') = '8';
    if size(checkFormat(plate), 2) == 0 && size(checkFormat(newPlate), 2) > 0
        plate = newPlate;
    else
        newPlate = plate;
    end;
    newPlate(plate == '8') = 'B';
    if size(checkFormat(plate), 2) == 0 && size(checkFormat(newPlate), 2) > 0
        plate = newPlate;
    else
        newPlate = plate;
    end;
    newPlate(plate == 'S') = '5';
    if size(checkFormat(plate), 2) == 0 && size(checkFormat(newPlate), 2) > 0
        plate = newPlate;
    else
        newPlate = plate;
    end;
    newPlate(plate == '5') = 'S';
    if size(checkFormat(plate), 2) == 0 && size(checkFormat(newPlate), 2) > 0
        plate(plate == '5') = 'S';
    else
        newPlate = plate;
    end;
    newPlate(plate == 'Z') = '2';
    if size(checkFormat(plate), 2) == 0 && size(checkFormat(newPlate), 2) > 0
        plate = newPlate;
    else
        newPlate = plate;
    end;
    newPlate(plate == '2') = 'Z';
    if size(checkFormat(plate), 2) == 0 && size(checkFormat(newPlate), 2) > 0
        plate = newPlate;
    end;
    licensePlate = checkFormat(plate);
    %licensePlate = plate;
end
    