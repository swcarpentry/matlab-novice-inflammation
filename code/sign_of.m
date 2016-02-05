
% Demo script to illustrate use of conditionals

    if num > 0
        sign_of_num = 1;

    elseif num == 0
        sign_of_num = 0;

    else
        sign_of_num = -1;
    end
    
    disp(strcat('Sign of num = ',num2str(sign_of_num)))