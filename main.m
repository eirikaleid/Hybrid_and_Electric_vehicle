aro = 1.224; % hava yoğunluğu
Cd = 0.23; % aerodinamik sürüklenme katsayısı
Area_front = 2.2; % m^2
velocity = 0:1:200; % km/h

% Yeni alpha değişkeni (radyan cinsinden)
alpha = 1; % derece
alpha_rad = deg2rad(alpha); % dereceyi radyana çevir

% Aerodinamik kuvvet hesaplaması
Aero_sabit = (0.5) * aro * Cd * Area_front; % sabit aerodinamik kuvvet çarpanı
Aerodynamic_force = ((velocity/3.6).^2) * Aero_sabit * cos(alpha_rad); % Newton cinsinden

car_mass = 2000; % kg
Rolling_resistance_Coefficient = 0.013;
Rolling_force = (9.81) * car_mass * Rolling_resistance_Coefficient; % Rolling force sabit

% Grading force hesaplaması
Grading_force = car_mass * 9.81 * sin(alpha_rad); % sabit değer

% Rolling ve Grading kuvvetlerini konsola yazdır
disp(['Sürtünme Kuvveti: ', num2str(Rolling_force), ' N']);
disp(['Grading Kuvveti: ', num2str(Grading_force), ' N']);
disp(['Grading Kuvveti: ', num2str(Rolling_force+Grading_force), ' N']);

% Grafik ayarları
figure;
hold on;
plot(velocity, Aerodynamic_force, 'Color', [0.1, 0.6, 0.9], 'LineWidth', 2.5); % Aerodinamik kuvvet
plot(velocity, Rolling_force * ones(size(velocity)), 'Color', [0.9, 0.4, 0.1], 'LineWidth', 2.5); % Sürtünme kuvveti
plot(velocity, Grading_force * ones(size(velocity)), 'Color', [0.1, 0.9, 0.1], 'LineWidth', 2.5); % Grading kuvveti

% Grafik formatlama
grid on;
xlabel("Hız (km/h)", 'FontWeight', 'bold', 'FontSize', 12);
ylabel("Kuvvet (Newton)", 'FontWeight', 'bold', 'FontSize', 12);
title("Kuvvet - Hız Grafiği", 'FontWeight', 'bold', 'FontSize', 14);
legend("Aerodinamik Kuvvet", "Sürtünme Kuvveti", "Grading Kuvveti", ...
    'Location', 'northeast', 'FontWeight', 'bold', 'FontSize', 10);
set(gca, 'FontWeight', 'bold', 'FontSize', 10);

% Eksen ayarları
xlim([0 200]);
ylim([0 max([Aerodynamic_force, Rolling_force, Grading_force]) * 1.1]); % Y eksenini dinamik ayarla

% Bilgileri sol üst köşeye ekle
annotation('textbox', [0.15, 0.75, 0.25, 0.1], ...
    'String', {sprintf('Kütle: %d kg', car_mass), ...
               sprintf('Ön Yüzey Alanı: %.2f m^2', Area_front), ...
               sprintf('Alpha: %d°', alpha)}, ...
    'FontWeight', 'bold', 'FontSize', 10, 'EdgeColor', 'none', ...
    'Color', 'k', 'BackgroundColor', [1, 1, 1, 0.7]); % Beyaz arka plan

hold off;
