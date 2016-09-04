clear;
clc;
flag=0;
%s1=zeros(400,400,3);
%dom=zeros(400,400,3);
gs=(imread('lotus.jpg'));
k=10;
[h,w,d]=size(gs);
hsv=rgb2hsv(gs);

hue=round(hsv(:,:,1)*360);
sat=(hsv(:,:,2));
val=(hsv(:,:,3));
final=hue.*sat;
final=reshape(final,h*w,1);

[idx,c]=kmeans(final,10);

pixel_labels = reshape(idx,h,w);
imshow(pixel_labels,[]), title('image labeled by cluster index');

segmented_images = cell(1,k);
rgb_label = repmat(pixel_labels,[1 1 3]);

for i = 1:k
    color = gs;
    color(rgb_label ~= i) = 0;
    segmented_images{i} = color;
end

%imshow(segmented_images{1}), title('objects in cluster 1');
