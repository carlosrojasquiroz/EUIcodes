function w=cumsummat(X)
    w = zeros(1,length(X));
    w(1,1) = X(1,1);
    for i=2:length(X)
        w(1,i) = w(1,i-1) + X(1,i);
    end
end