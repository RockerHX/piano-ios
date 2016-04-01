//
//  UIImage+Extrude.m
//
//  Created by linyehui on 14-8-19.
//
//

#import "UIImage+Extrude.h"

@implementation UIImage (Extrude)

+(UIImage*)scaleToSize:(UIImage *)image maxWidthOrHeight:(CGFloat)max_len
{
	if (!image || 0 == image.size.width || 0 == image.size.height) {
		return nil;
	}

	CGSize target_size;
	if (image.size.width > image.size.height) {
		target_size = CGSizeMake(max_len, max_len * image.size.height / image.size.width);
	} else {
		target_size = CGSizeMake(max_len * image.size.width / image.size.height, max_len);
	}

	// 创建一个bitmap的context
	// 并把它设置成为当前正在使用的context
	UIGraphicsBeginImageContext(target_size);
	// 绘制改变大小的图片
	[image drawInRect:CGRectMake(0, 0, target_size.width, target_size.height)];
	// 从当前context中创建一个改变大小后的图片
	UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
	// 使当前的context出堆栈
	UIGraphicsEndImageContext();
	// 返回新的改变大小后的图片
	return scaledImage;
}

/*
 *   获取拉伸处理后的图片
 *   image              -->需要拉伸的图片资源(原图显示)
 */
+(UIImage *)imageExtrude:(UIImage *)image{
    UIEdgeInsets insets = UIEdgeInsetsMake(image.size.height/2  ,image.size.width/2  ,image.size.height/2  ,image.size.width/2 );
    //    UIImage* newImage = [self antialiasedImage:image scale:[self returnScale]];
    image = [image resizableImageWithCapInsets:insets ];
    return image;
}

/**
 *  自定义拉伸处理后的图片
 *
 *  @param image      原始图像
 *  @param edgeInsets 拉伸的起始位置
 *
 */
+(UIImage *)imageExtrude:(UIImage *)image edgeInsets:(UIEdgeInsets)edgeInsets{
    image = [image resizableImageWithCapInsets:edgeInsets];
    return image;
}

/**
 *  收缩图片
 *
 *  @param image 原图
 *  @param size  目标大小
 */
+ (UIImage *)imageWithShrink:(UIImage *)image shrinkSize:(float)size{
    float scale = [[UIScreen mainScreen] scale];
    if(image.size.width < size && image.size.height < size)
        return image;
    
    float newHeight = 0.0f;
    float newWidth = 0.0f;
    //先判断收缩后是以宽为主还是以高为主
    if((image.size.height/2 - size/2) > (image.size.width/2 - size/2)){
        //先获取收缩到组件宽度后图片的高度
        newHeight = size/image.size.width * image.size.height;
        newWidth = size ;
    }else{
        //先获取收缩到组件高度后图片的宽度
        newHeight = size ;
        newWidth = size/image.size.height * image.size.width;
    }
    CGSize newSize = CGSizeMake(newWidth , newHeight );
    //按计算后的大小进行收缩
    UIGraphicsBeginImageContextWithOptions(newSize, NO, scale);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    NSLog(@"newImage.size = %@",NSStringFromCGSize(newImage.size));
    UIGraphicsEndImageContext();
    if(newImage.size.height <= size || newImage.size.width <= size)
        return newImage;
    else
        return image;
}

/**
 *  收缩图片后进行裁剪
 *
 *  @param image 原图
 *  @param size  目标大小
 *
 */
+ (UIImage *)imageWithCutImage:(UIImage *)image moduleSize:(CGSize)size{
    float scale = [[UIScreen mainScreen] scale];
    if(image.size.width < size.width && image.size.height < size.height)
        return image;
    
    float newHeight = 0.0f;
    float newWidth = 0.0f;
    //先判断收缩后是以宽为主还是以高为主
    if((image.size.height/2 - size.height/2) > (image.size.width/2 - size.width/2)){
        //先获取收缩到组件宽度后图片的高度
        newHeight = size.width/image.size.width * image.size.height;
        newWidth = size.width ;
    }else{
        //先获取收缩到组件高度后图片的宽度
        newHeight = size.height ;
        newWidth = size.height/image.size.height * image.size.width;
    }
    CGSize newSize = CGSizeMake(newWidth , newHeight );
    //按计算后的大小进行收缩
    UIGraphicsBeginImageContextWithOptions(newSize, NO, scale);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    if(newImage.size.height < size.height || newImage.size.width < size.width)
        return newImage;
    
    //如果收缩后的图片高度大于组件的高度或收缩后的图片宽度大于组件的宽度，取中间部分
    CGImageRef imageRef = newImage.CGImage;
    CGRect rect = CGRectMake(newImage.size.width/2 - size.width/2, newImage.size.height/2 - size.height/2, size.width * scale, size.height * scale );
    CGImageRef cutImageRef = CGImageCreateWithImageInRect(imageRef,rect);
    UIImage *cutImage = [UIImage imageWithCGImage:cutImageRef scale:image.scale orientation:UIImageOrientationUp];
    //    UIImage *cutImage = [[UIImage alloc] initWithCGImage:cutImageRef];
    
    return cutImage;
}

/**
 *  裁剪图片为正方形，新的图片从左上角截取
 *
 *  @param image 原图
 *
 */
+ (UIImage *)imageWithCutImageToSquare:(UIImage *)image {
	if(!image)
		return image;
	if (image.size.height == image.size.width)
		return image;

	float newX = 0.0f;
	float newY = 0.0f;
	float newHeight = 0.0f;
	float newWidth = 0.0f;
	if(image.size.height > image.size.width){
		//newY = (image.size.height - newHeight) / 2;
		newHeight = image.size.width;
		newWidth = image.size.width;
	} else {
		//newX = (image.size.width - newWidth) / 2;
		newHeight = image.size.height;
		newWidth = image.size.height;
	}
	CGSize newSize = CGSizeMake(newWidth , newHeight );
	CGImageRef imageRef = image.CGImage;
	CGRect rect = CGRectMake(newX, newY, newSize.width, newSize.height);
	CGImageRef cutImageRef = CGImageCreateWithImageInRect(imageRef, rect);
	UIImage *cutImage = [UIImage imageWithCGImage:cutImageRef scale:image.scale orientation:UIImageOrientationUp];
	//    UIImage *cutImage = [[UIImage alloc] initWithCGImage:cutImageRef];

	return cutImage;
}

/**
 *  获取当前屏幕视图的UIImage(相当屏幕截图)
 *
 *  @param view     当前视图
 *  @param frame    要截取的范围
 *
 */
+ (UIImage *)getImageFromView:(UIView *)view frame:(CGRect)frame{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    UIRectClip(frame);
    [view.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


/**
 *  截取部分图像
 *
 *  @param rect 裁剪的区域
 *
 */
-(UIImage *)getSubImage:(CGRect)rect{
    CGImageRef subImageRef = CGImageCreateWithImageInRect(self.CGImage,
														  CGRectMake(rect.origin.x,
																	 rect.origin.y,
																	 rect.size.width * self.scale,
																	 rect.size.height * self.scale));
    CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef), CGImageGetHeight(subImageRef));
    
    //UIGraphicsBeginImageContext(smallBounds.size);
    UIGraphicsBeginImageContextWithOptions(smallBounds.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef];
    UIGraphicsEndImageContext();
    
    return smallImage;
}
@end













