clear;
clc;
flag=0;
gs=double(imread('p5.jpg'));

[h,w,d]=size(gs);
hsv=rgb2hsv(gs);
%hue is the color
%value is darkness
%saturation is lightness
huegram=zeros(1,361);
hue=round(hsv(:,:,1)*360);
sat=(hsv(:,:,2));
val=(hsv(:,:,3));
s1=zeros(400,400,3);

for y=1:h
    for x=1:w
        if hsv(y,x,2)>0.3 && hsv(y,x,3)>50 %&& hsv(y,x,3)<256 
        huegram(1,hue(y,x)+1)=huegram(1,hue(y,x)+1)+1;
        end
    end
end

temp=1:36;
blockfreq=zeros(2,36);


for i=1:size(temp,2)
    [blockfreq(1,i),blockfreq(2,i)]=max(huegram(((i-1)*10)+1:i*10));
    blockfreq(2,i)=((i-1)*10)+blockfreq(2,i);
end

[max_vals, max_ids] = sort(blockfreq(1,:), 'descend');
    

row=round(h/2);
col=round(w/2);

k=10;
% 
for p=1:k
   for y=1:h
      for x=1:w
         if hsv(y,x,2)>0.3 && hsv(y,x,3)>50 %&& hsv(y,x,3)<256
         if hue(y,x)==blockfreq(2,max_ids(p))-1
            % disp('aaya');
            if auth(y,x,hue)<10 
             %disp(blockfreq(2,max_ids(p))-1);
             %disp(y);
             %disp(x);
             %disp('next')
             row=y;
             col=x;
             flag=1;
             break;       % one possibility is to find not one but all such hue pixels.
            end
         end              % can possibly also apply averaging filters
         end
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
 subplot(1,k,p),imshow(uint8(s1)),title(p);
end
figure,imshow(uint8(gs));