function dydtarbi=dydtarbi_lattice_full(t,y,N,ep,sigma1,sigma2,eta,D,theta,Ap,al,p,zeta)
%xi=0.005;
dydtarbi=zeros(4*N,1);
dydtarbi(1:2:4*N-1) = y(2:2:4*N);
dydtarbi(2)         = - y(1) - 2*ep*zeta*D*y(2)- ep*D*(y(1)-y(3));
dydtarbi(4:2:4*N-2) = - y(3:2:4*N-3) - 2*ep*zeta*D*y(4:2:4*N-2)- ep*D*(y(3:2:4*N-3)-y(5:2:4*N-1)) - ep*D*(y(3:2:4*N-3)-y(1:2:4*N-5));
dydtarbi(4*N)     = - y(4*N-1) - 2*ep*zeta*D*y(4*N)- ep*D*(y(4*N-1)-y(4*N-3));
% Nonlinear Gate
dydtarbi(2*N) = - (1 + ep*sigma1)*y(2*N-1) - 2*ep*zeta*D*y(2*N) - ep*eta*al*(y(2*N-1)-y(2*N+1))^3 - ep*D*(y(2*N-1)-y(2*N-3));
dydtarbi(2*N+2) = - (1 + ep*sigma2)*y(2*N+1) - 2*ep*zeta*D*y(2*N+2)- ep*D*(y(2*N+1)-y(2*N+3)) - ep*eta*al*(y(2*N+1)-y(2*N-1))^3;
% Excitation Position
% omega = (1+ep*D+ep*sigmaf);
omega = sqrt(1+4*ep*D*sin(theta/2).^2);
dydtarbi(2*N-2*p) = dydtarbi(2*N-2*p) + 2*ep*Ap*cos(omega*t);
end