function img_gamma_uint8 = gamma_correct(img,gamma)
gamma = 2.2

% subplot(1,3,1)
% I = imshow(img);

% impixelinfo;

% size of img
s = size(img)

A(:,1) = reshape(img,[],1);

% gamma correction



% 3 channels divided to gamma correction

A_pass = (A + 0.5) ./ 255;
A_pass = A_pass .^(1 / gamma);
A_gamma = round(A_pass .* 255 - 0.5);


% format convertion
% Enhanced picture

% img_gamma_uint8 = uint8(reshape(A_gamma,s));
img_gamma_uint8 = reshape(A_gamma,s);
% subplot(1,3,2);
% imshow(img_gamma_uint8)
% impixelinfo;
end