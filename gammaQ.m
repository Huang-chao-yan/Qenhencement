function output=gammaQ(image)
        I=(image)/255;
        sigma=2;
        DFT2d_I=fft2(I);
        %Calcule gaussian
        [ysize , xsize]=size(I);
        Nr = ifftshift((-fix(ysize/2):ceil(ysize/2)-1));
        Nc = ifftshift((-fix(xsize/2):ceil(xsize/2)-1));
        [Nc,Nr] = meshgrid(Nc,Nr);
        dft_gauss_kernel=exp(-2*sigma^2*pi^2*((Nr/ysize).^2+(Nc/xsize).^2)); 
        
        %Convolution gaussian (fft(I).*fft(G)) 
        DFT2d_I_convolved=DFT2d_I.*repmat(dft_gauss_kernel,[1,1]);
        I_convolved=ifft2(DFT2d_I_convolved);
        M=real(I_convolved);
        q1      =ones(ysize , xsize)*quaternion(1,1,1,1);
        mk=2.*M-q1;
        mkk0=2.^mk.w; mkk1=2.^mk.x; mkk2=2.^mk.y; mkk3=2.^mk.z;
        re = quaternion(mkk0,mkk1,mkk2,mkk3);
        output=double2q(I,-1).^(double2q(re,-1));

end
    

