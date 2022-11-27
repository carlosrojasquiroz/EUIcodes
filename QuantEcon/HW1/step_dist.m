function distp = step_dist(dist,g_a,p,m)
% find index below capital policy
    indbelow = ones(p.nzz,p.naa);
    for i=2:p.naa
        indbelow(g_a>=m.a_grid(i))=i;
    end
    indbelow = min(indbelow,p.naa-1);
    indabove = indbelow + 1;
% find weights attached to point below/above policy
    wabove = (g_a-m.a_grid(indbelow))./(m.a_grid(indbelow+1)-m.a_grid(indbelow));
    wabove = min(wabove,1); wabove = max(wabove,0); % just to be safe, should not be binding
    wbelow= 1-wabove;
% initialize future distribution
    distp = zeros(p.nzz,p.naa);
% move distribution one step forward
    for i = 1:p.naa   
        for j = 1:p.nzz
             % for any combination of productivity and capital today
             % what is the distribution over z/k tomorrow 
             distp(:,indbelow(j,i)) = distp(:,indbelow(j,i)) + dist(j,i)*wbelow(j,i)*m.Pi(j,:)';  
             distp(:,indabove(j,i)) = distp(:,indabove(j,i)) + dist(j,i)*wabove(j,i)*m.Pi(j,:)';  
        end
    end