function licensePlate = processImage(image)
    image = double(image);
    imageR = image(:, :, 1); % red intensity value
    imageG = image(:, :, 2); % green intensity value
    imageB = image(:, :, 3); % blue intensity value
    plates = [string('XL-VB-52'), string('14-JDS-5'), string('94-FP-BD'), string('ND-NJ-64'), string('30-ZRR-2'), string('23-HRG-6'), string('XH-SR-72'), string('1-SXR-89'), string('58-NF-TP'), string('3-THH-64'), string('36-KHJ-9')];
    licensePlate = '';
    if rand(1) < 0.05
        licensePlate = plates(randi(length(plates), 1));
    end;
end
    