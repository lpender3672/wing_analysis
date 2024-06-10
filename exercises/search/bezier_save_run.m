function filename = save_run(caseref, name)
%SAVE_RUN Summary of this function goes here
%   Detailed explanation goes here


%    foil.m
%
%  Script to analyse an aerofoil section using potential flow calculation
%  and boundary layer solver.
%


global Re_L

%  Read in the parameter file
parfile = ['Parfiles/' caseref '.txt'];
fprintf(1, '%s\n\n', ['Reading in parameter file: ' parfile])
[section np Re_L alpha] = par_read(parfile);
nalph = length(alpha);

Cl_s = zeros(1, nalph);
Cd_s = zeros(1, nalph);
ilnt_s = zeros(1, nalph);
ills_s = zeros(1, nalph);
iltr_s = zeros(1, nalph);
ilts_s = zeros(1, nalph);
iunt_s = zeros(1, nalph);
iuls_s = zeros(1, nalph);
iutr_s = zeros(1, nalph);
iuts_s = zeros(1, nalph);
cp_s = zeros(np+1, nalph); 
sl_s = {};
delstarl_s = {};
thetal_s = {};
lowerbl_s = {};
su_s = {};
delstaru_s = {};
thetau_s = {};
upperbl_s = {};
cpl_s = {};
cpu_s = {};

%  Read in the section geometry
secfile = ['Geometry/' section '.surf'];

[xs ys] = textread ( secfile, '%f%f' );

%  Assemble the lhs of the equations for the potential flow calculation
A = build_lhs ( xs, ys );
Am1 = inv(A);

%  Loop over alpha values
for i = 1:length(alpha)

%    rhs of equations
  alfrad = pi * alpha(i)/180;
  b = build_rhs ( xs, ys, alfrad );

%    solve for surface vortex sheet strength
  gam = Am1 * b;
  
  %    calculate cp distribution and overall circulation
  [cp circ] = potential_op ( xs, ys, gam );
  

%    locate stagnation point and calculate stagnation panel length
  [ipstag fracstag] = find_stag(gam);
  dsstag = sqrt((xs(ipstag+1)-xs(ipstag))^2 + (ys(ipstag+1)-ys(ipstag))^2);

%    upper surface boundary layer calc

%    first assemble pressure distribution along bl
  clear su cpu
  su(1) = fracstag*dsstag;
  cpu(1) = cp(ipstag);
  for is = ipstag-1:-1:1
    iu = ipstag - is + 1;
    su(iu) = su(iu-1) + sqrt((xs(is+1)-xs(is))^2 + (ys(is+1)-ys(is))^2);
    cpu(iu) = cp(is);
  end

%    check for stagnation point at end of stagnation panel
  if fracstag < 1e-6
    su(1) = 0.01*su(2);    % go just downstream of stagnation
    uejds = 0.01 * sqrt(1-cpu(2));
    cpu(1) = 1 - uejds^2;
  end

%    boundary layer solver
   [iunt iuls iutr iuts delstaru thetau] = bl_solv ( su, cpu );

%    lower surface boundary layer calc

%    first assemble pressure distribution along bl
  clear sl cpl
  sl(1) = (1-fracstag) * dsstag;
  cpl(1) = cp(ipstag+1);
  for is = ipstag+2:np+1
    il = is - ipstag;
    sl(il) = sl(il-1) + sqrt((xs(is-1)-xs(is))^2 + (ys(is-1)-ys(is))^2);
    cpl(il) = cp(is);
  end

%    check for stagnation point at end of stagnation panel
  if fracstag > 0.999999
    sl(1) = 0.01*sl(2);    % go just downstream of stagnation
    uejds = 0.01 * sqrt(1-cpl(2));
    cpl(1) = 1 - uejds^2;
  end

%    boundary layer solver
  [ilnt ills iltr ilts delstarl thetal] = bl_solv ( sl, cpl );

%    lift and drag coefficients
  [Cl Cd] = forces ( circ, cp, delstarl, thetal, delstaru, thetau );

%    copy Cl and Cd into arrays for alpha sweep plots

%    screen output

  %disp ( sprintf ( '\n%s%5.3f%s', ...
  %                 'Results for alpha = ', alpha(i), ' degrees' ) )

  %disp ( sprintf ( '\n%s%5.3f', '  Lift coefficient: ', Cl ) )
  %disp ( sprintf ( '%s%7.5f', '  Drag coefficient: ', Cd ) )
  %disp ( sprintf ( '%s%5.3f\n', '  Lift-to-drag ratio: ', Cl/Cd ) )

  %upperbl = sprintf ( '%s', '  Upper surface boundary layer:' );
  if iunt~=0
    is = ipstag + 1 - iunt;
    %upperbl = sprintf ( '%s\n%s%5.3f', upperbl, ... 
    %                    '    Natural transition at x = ', xs(is) );
  end
  if iuls~=0
    is = ipstag + 1 - iuls;
    %upperbl = sprintf ( '%s\n%s%5.3f', upperbl, ... 
    %                    '    Laminar separation at x = ', xs(is) );
    if iutr~=0
      is = ipstag + 1 - iutr;
      %upperbl = sprintf ( '%s\n%s%5.3f', upperbl, ... 
      %                    '    Turbulent reattachment at x = ', xs(is) );
    end
  end
  if iuts~=0
    is = ipstag + 1 - iuts;
    %upperbl = sprintf ( '%s\n%s%5.3f', upperbl, ... 
    %                    '    Turbulent separation at x = ', xs(is) );
  end
  %upperbl = sprintf ( '%s\n', upperbl );
  %disp(upperbl)

  %lowerbl = sprintf ( '%s', '  Lower surface boundary layer:' );
  if ilnt~=0
    is = ipstag + ilnt;
    %lowerbl = sprintf ( '%s\n%s%5.3f', lowerbl, ... 
    %                    '    Natural transition at x = ', xs(is) );
  end
  if ills~=0
    is = ipstag + ills;
    %lowerbl = sprintf ( '%s\n%s%5.3f', lowerbl, ... 
    %                    '    Laminar separation at x = ', xs(is) );
    if iltr~=0
      is = ipstag + iltr;
      %lowerbl = sprintf ( '%s\n%s%5.3f', lowerbl, ... 
      %                    '    Turbulent reattachment at x = ', xs(is) );
    end
  end
  if ilts~=0
    is = ipstag + ilts;
    %lowerbl = sprintf ( '%s\n%s%5.3f', lowerbl, ... 
    %                    '    Turbulent separation at x = ', xs(is) );
  end
  %lowerbl = sprintf ( '%s\n', lowerbl );
  %disp(lowerbl)

%    save data for this alpha

    Cl_s(i) = Cl;
    Cd_s(i) = Cd;
    ilnt_s(i) = ilnt;
    ills_s(i) = ills;
    iltr_s(i) = iltr;
    ilts_s(i) = ilts;

    iunt_s(i) = iunt;
    iuls_s(i) = iuls;
    iutr_s(i) = iutr;
    iuts_s(i) = iuts;
    cp_s(:,i) = cp;
    sl_s{end+1} = sl;
    delstarl_s{end+1} = delstarl;
    thetal_s{end+1} = thetal;
    %lowerbl_s{end+1} = lowerbl;
    su_s{end+1} = su;
    delstaru_s{end+1} = delstaru;
    thetau_s{end+1} = thetau;
    %upperbl_s{end+1} = upperbl;
    cpl_s{end+1} = cpl;
    cpu_s{end+1} = cpu;
  
end

%  save alpha sweep data in summary file

lovdswp = Cl_s ./ Cd_s;

filename = ['Data/' name '.mat'];
save ( filename, 'xs', 'ys',  'alpha', 'Cl_s', 'Cd_s', 'lovdswp', ...
        'ilnt_s', 'ills_s', 'iltr_s', 'ilts_s',...
        'iunt_s', 'iuls_s', 'iutr_s', 'iuts_s', ...
        'cp_s', 'sl_s', 'delstarl_s', 'thetal_s', ...
        'su_s', 'delstaru_s', 'thetau_s', ...
        'cpl_s', 'cpu_s')

end

