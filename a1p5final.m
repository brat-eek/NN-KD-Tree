clear;
clc;
flag=0;
s1=zeros(400,400,3);
dom=zeros(400,400,3);
gs=double(imread('lotus.jpg'));
k=10;
[h,w,d]=size(gs);
hsv=rgb2hsv(gs);
%hue is the color
%value is darkness
%saturation is lightness
%huegram=zeros(1,361);
hue=round(hsv(:,:,1)*360);
sat=(hsv(:,:,2))*100;
val=(hsv(:,:,3));
huer=reshape(hue,h*w,1);
%satr=reshape(sat,h*w,1);
%valr=reshape(val,h*w,1);
%X=zeros(h*w,3);
%X=[hue,sat,val];

[idx,c]=kmeans(huer,k);
arr=zeros(1,k);
for i=1:k
    arr(i)=sum(idx==i);
end
[val,index]=max(arr);

row=round(h/2);
col=round(w/2);

for p=1:k
   for y=1:h
      for x=1:w
           %if hsv(y,x,2)>30 && hsv(y,x,3)>50 %&& hsv(y,x,3)<256
            if hue(y,x)<=round(c(p))+1 && hue(y,x)>=round(c(p))-1
             if auth(y,x,hue)<3
             %disp(blockfreq(2,max_ids(p))-1);
             %disp(y);
             %disp(x);
             %disp('next')
             row=y;
             col=x;
             flag=1;
             break;       % one possibility is to find not one but all such hue pixels.
             end   % one possibility is to find not one but all such hue pixels.
            end
           %end              % can possibly also apply averaging filters
      end
      if flag==1
         break;
      end
   end
flag=0;
% 
 rval=gs(row,col,1);
 gval=gs(row,col,2);
 bval=gs(row,col,3);
% 
 
 s1(:,:,1)=zeros(400,400)+rval;
 s1(:,:,2)=zeros(400,400)+gval;
 s1(:,:,3)=zeros(400,400)+bval;
 if p==index
 subplot(1,k,p),imshow(uint8(s1)),title('dominant');    
 else
 subplot(1,k,p),imshow(uint8(s1)),title(p);
 end
end
figure,imshow(uint8(gs));
