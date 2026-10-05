
%================
% Poryecto de Calculo: Razones Relacionadas
% ===============

clear; clc; close all;

%% PARTE 1: SOLUCIÓN SIMBÓLICA

disp("----<| Solución Matemática |>----");

% Datos proporcionados [metros y minutos]
B_fin = 0.25; % [m] Base superior
b_fin = 0.15; % [m] Base inferior
h_fin = 0.2; % [m] Altura
L_fin = 0.4; % [m] Largo
dV_dt = 0.006; % [m^3/min] Razon de llenado
h_ins = 0.12; % [m] Elevacion

% Declaración de variables symbolicas con respecto al tiempo
syms h(t)

% ----
% I. Definir Ecuaciones auxiliares
% ----
% Ancho del triangulo de extención (Semejanza de triangulos)
u = ((B_fin - b_fin) / (2 * h_fin)) * h(t);
% Base superior con respecto a h(t)
B_h = 2 * u + b_fin;
% Volumen con respecto a la h(t) y B(h)
V_h = ((B_h + b_fin) / 2) * h(t) * L_fin;

fprintf('Función del volumen respecto a la elevación: V(h) = %s\n', char(V_h));

% ----
% II. Encontrar la derivada del la altura [dh/dt] implicitamente
% ----
% Definir la derivada del volumne con el valor proporcionado
dV_dt = diff(V_h, t) == dV_dt;
% Despejar para dh/dt
dh_dt = solve(dV_dt, diff(h(t), t));

% ----
% III. Encontrar la razon de cambio de la altura proporcionada
% ----
% Sustituir con los datos proporcionados
dh_dt_ins = subs(dh_dt, h(t), h_ins);
% Convertir la fracción a número
dh_dt_num = double(dh_dt_ins);

fprintf('\n=> En el Instande donde la altura es %.2f \n', h_ins);
fprintf('La razón de cambio de la altura es de %.4f\n', dh_dt_num);

%% PARTE 2: DEMOSTRACIÓN VISUAL

figure('Name', 'Sección Transversal del Canal', 'Color', 'w', 'Position', [100 100 700 500]);
hold on; grid on; axis equal;

% I. Mostrar del canal
% Coordenadas
x_canal = [-B_fin/2, -b_fin/2, b_fin/2, B_fin/2];
y_canal = [h_fin, 0, 0, h_fin];

% Dibujar (gris)
fill(x_canal, y_canal, [0.8 0.8 0.8], 'FaceAlpha', 0.6,'EdgeColor', 'b', 'LineWidth', 1.5);

% II. Mostrar el agua
% Coordenadas
ancho_agua_inst = double(subs(B_h, h(t), h_ins));
x_agua = [-ancho_agua_inst/2, -b_fin/2, b_fin/2, ancho_agua_inst/2];
y_agua = [h_ins, 0, 0, h_ins];

% Dibujar (azul)
fill(x_agua, y_agua, [0.2 0.6 1], 'FaceAlpha', 0.6, 'EdgeColor', 'b', 'LineWidth', 1.5);

% III. Etiquetas y anotaciones
title(sprintf('Nivel del agua en h = %.2f m \n dh/dt = %.4f m/min', h_ins, dh_dt_num), ...
    'FontSize', 22, 'Color', 'k');
xlabel('Ancho (m)', 'FontSize', 18, 'Color', 'k');
ylabel('Alto (m)', 'FontSize', 18, 'Color', 'k');
xlim([-0.2, 0.2]);
ylim([-0.02, 0.25]);

% IV. Lineas indicativas
yline(h_ins, '--c', 'Nivel actual (0.12 m)', 'LabelHorizontalAlignment', 'left', 'Color', 'w', 'FontSize', 14);
yline(h_fin, '--w', 'Altura máxima (0.20 m)', 'LabelHorizontalAlignment', 'left', 'Color', 'w', 'FontSize', 14);

hold off;
