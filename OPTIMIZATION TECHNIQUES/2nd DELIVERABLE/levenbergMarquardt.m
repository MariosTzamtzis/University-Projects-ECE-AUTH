function [k, gammas, xs, xmin, dist] = levenbergMarquardt(epsilon, x0, f, option)
    % Input Arguments:
    %   epsilon: Convergence tolerance.
    %   x0: Initial guess for the minimum.
    %   f: Symbolic expression representing the objective function.
    %   option: Optimization method ('optimal', 'constant', or 'armijo').

    syms x1 x2;

    % Initialize variables
    xk = [x0(1), x0(2)];
    f1 = inline(f);
    fx = @(x) f1(x(:,1), x(:,2));

    jac = inline(jacobian(f));
    jacx = @(x) jac(x(:,1), x(:,2));

    hess = inline(hessian(f));
    hessx = @(x) hess(x(:,1), x(:,2));

    k = 1;
    xs = [xk];
    gammas = [];
    mk = 1e-7;

    % Main optimization loop
    while (norm(jacx(xk)) > epsilon)
        % Modify the Hessian matrix with a regularization term
        I = eye(2);
        mkI = mk * I;
        A = hessx(xk) + mkI;

        % Check positive definiteness of the modified Hessian matrix
        isposdef = all(eig(A) > 0);
        while ~isposdef
            mk = mk * 2; % Increase regularization parameter until positive definite
            mkI = mk * I;
            A = hessx(xk) + mkI;
            isposdef = all(eig(A) > 0);
        end

        % Solve the linear system for the update
        dk = - jacx(xk) / A;

        % Choose step size based on the selected option
        if option == 'optimal'
            [gamma] = optimalGamma(xk, dk, f);
        elseif option == 'constant'
            gamma = 0.5;
        else
            [gamma] = armijo(10, 0.01, 0.2, xk, dk, f);
        end

        % Update current iterate
        xk = double(xk + gamma * dk);

        % Store results
        xs = [xs; xk];
        gammas = [gammas; gamma];
        k = k + 1;
    end

    % Display which step size strategy was used
    if option == 'optimal'
        disp('Optimal Gamma was used');
    elseif option == 'constant'
        disp('Constant Gamma was used');
    else
        disp('Armijo Rule was used');
    end

    % Find minimum using fminsearch
    xmin = fminsearch(fx, x0);

    % Calculate distance between the minimum found and the final iterate
    dist = norm(xmin - xk);
end
