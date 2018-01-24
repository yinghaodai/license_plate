function licensePlate = processImage(image)
    plate = test3(image);
%     newPlate = plate;
%     newPlate(plate == 'B') = '8';
%     if size(checkFormat(plate), 2) == 0 && size(checkFormat(newPlate), 2) > 0
%         plate = newPlate;
%     else
%         newPlate = plate;
%     end;
%     newPlate(plate == '8') = 'B';
%     if size(checkFormat(plate), 2) == 0 && size(checkFormat(newPlate), 2) > 0
%         plate = newPlate;
%     else
%         newPlate = plate;
%     end;
%     newPlate(plate == 'S') = '5';
%     if size(checkFormat(plate), 2) == 0 && size(checkFormat(newPlate), 2) > 0
%         plate = newPlate;
%     else
%         newPlate = plate;
%     end;
%     newPlate(plate == '5') = 'S';
%     if size(checkFormat(plate), 2) == 0 && size(checkFormat(newPlate), 2) > 0
%         plate(plate == '5') = 'S';
%     else
%         newPlate = plate;
%     end;
%     newPlate(plate == 'Z') = '2';
%     if size(checkFormat(plate), 2) == 0 && size(checkFormat(newPlate), 2) > 0
%         plate = newPlate;
%     else
%         newPlate = plate;
%     end;
%     newPlate(plate == '2') = 'Z';
%     if size(checkFormat(plate), 2) == 0 && size(checkFormat(newPlate), 2) > 0
%         plate = newPlate;
%     end;
    licensePlate = '';
    groups = strsplit(plate, '-');
    lonelyGroup = 0;
    if size(groups, 2) == 3
        for i = 1:3
            if size(groups{i}, 2) == 1
                lonelyGroup = i;
            end
            if ~all(isPlateLetter(groups{i})) && ~all(isstrprop(groups{i}, 'digit'))
                group = groups{i};
                group(group == 'B') = '8';
                if ~all(group == groups{i}) && all(isstrprop(group, 'digit'))
                    groups{i} = group;
                else
                    group = groups{i};
                end
                group(group == '8') = 'B';
                if ~all(group == groups{i}) && all(isPlateLetter(group))
                    groups{i} = group;
                else
                    group = groups{i};
                end
                group(group == 'S') = '5';
                if ~all(group == groups{i}) && all(isstrprop(group, 'digit'))
                    groups{i} = group;
                else
                    group = groups{i};
                end
                group(group == '5') = 'S';
                if ~all(group == groups{i}) && all(isPlateLetter(group))
                    groups{i} = group;
                else
                    group = groups{i};
                end
                group(group == 'Z') = '2';
                if ~all(group == groups{i}) && all(isstrprop(group, 'digit'))
                    groups{i} = group;
                else
                    group = groups{i};
                end
                group(group == '2') = 'Z';
                if ~all(group == groups{i}) && all(isPlateLetter(group))
                    groups{i} = group;
                end
            end
        end
        plate = strjoin(groups, '-');
        licensePlate = checkFormat2(plate);
        if lonelyGroup > 0 && size(licensePlate, 2) == 0
            switch groups{lonelyGroup}
                case 'B'
                    groups{lonelyGroup} = '8';
                case '8'
                    groups{lonelyGroup} = 'B';
                case 'S'
                    groups{lonelyGroup} = '5';
                case '5'
                    groups{lonelyGroup} = 'S';
                case 'Z'
                    groups{lonelyGroup} = '2';
                case '2'
                    groups{lonelyGroup} = 'Z';
            end
            licensePlate = checkFormat2(strjoin(groups, '-'));
        end
        %licensePlate = plate;
    end
end
    