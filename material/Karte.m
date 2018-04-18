function Karte(Pos, Mag, Fig) 
%KARTE zeigt die ermittelte Position auf dem Grundriss von U1.11
%
%   Karte(Pos)              
%   Karte(Pos, Mag)
%   Karte(Pos, Mag, Fig)
%
%   Pos:    berechnete Position als Vektor [x,y] (in Metern)
%   Mag:    (optional) relative Bildgröße (in Prozent, default=100)
%   Fig:    (optional) Nummer im Befehl 'figure()' (default=2)
%
%   Die Bilddatei "Karte_U111.png" muss im gleichen Verzeichnis liegen.

%% Argumente
if nargin < 3
  Fig = 2;
end
if nargin < 2
  Mag = 100;
end
if ~ isvector(Pos)
    error('Das erste Argument ''Pos'' muss ein Vektor sein');
end
if length(Pos) ~= 2
    error('Das erste Argument ''Pos'' muss ein Vektor mit 2 Komponenten sein');
end
if iscolumn(Pos)
    Pos = Pos.';
end

%% Konstanten
% Breite der Karte
% B = 1000;
% Höhe der Karte
H = 730;
% Verschiebung des Nullpunktes um NP ins Innere, um Platz für das
%   Zeichnen der Wände zu haben
NP = [30 30];

%% Kartenbild laden: 
figure(Fig); 
clf;
imshow('Karte_U111.png', 'InitialMagnification', Mag);
hold on;
A = gca;

%% Position umrechnen: 
%  Meter -> Zentimeter, Verschiebung NP, y-Achse nach unten
MapPos = 100*Pos + NP; 
x = MapPos(1);
y = H+1-MapPos(2);

if (x >= 0) && (x <= 950) && (y >= 0) && (y <= 700) % Pos. im Bereich
    plot(A, x, y, 'og', 'MarkerFaceColor', 'g', 'Markersize', 20); 
    plot(A, x, y, 'r+', 'MarkerFaceColor', 'r', 'Markersize', 20);
    PosStr = sprintf('[%.2f, %.2f]', Pos(1), Pos(2));
    if (x < 800) % Pos. rechts neben Fadenkreuz
        text(x+20, y+5, PosStr, 'FontSize', 15, 'BackgroundColor', 'yellow'); 
    else
        text(x-20, y+5, PosStr, 'FontSize', 15, ...
            'BackgroundColor', 'yellow', 'HorizontalAlignment', 'right'); 
    end
else
    PosStr = sprintf('Position [%.2f, %.2f] nicht auf der Karte', ...
        Pos(1), Pos(2));
    text(180, 630, PosStr, 'FontSize', 25, ...
        'BackgroundColor', 'yellow', 'EdgeColor', 'red', 'LineWidth', 2);
end
axis equal;
text(450, 20, 'Raum U1.11', 'FontSize', 20); 
hold off; 
end