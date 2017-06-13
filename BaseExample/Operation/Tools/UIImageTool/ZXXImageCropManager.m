//
//  ZXXImageCropManager.m
//  BaseExample
//
//  Created by zoekebi_Mac on 2017/5/21.
//  Copyright © 2017年 james. All rights reserved.
//

#import "ZXXImageCropManager.h"

#import "UIView+Layout.h"

@implementation ZXXImageCropManager

/// 裁剪框背景的处理
+ (void)overlayClippingWithView:(UIView *)view cropRect:(CGRect)cropRect containerView:(UIView *)containerView needCircleCrop:(BOOL)needCircleCrop {
    UIBezierPath *path= [UIBezierPath bezierPathWithRect:view.frame];
    CAShapeLayer *layer = [CAShapeLayer layer];
    if (needCircleCrop) { // 圆形裁剪框
        [path appendPath:[UIBezierPath bezierPathWithArcCenter:containerView.center radius:cropRect.size.width / 2 startAngle:0 endAngle: 2 * M_PI clockwise:NO]];
    } else { // 矩形裁剪框
        [path appendPath:[UIBezierPath bezierPathWithRect:cropRect]];
    }
    layer.path = path.CGPath;
    layer.fillRule = kCAFillRuleEvenOdd;
    layer.fillColor = [[UIColor blackColor] CGColor];
    layer.opacity = 0.5;
    [view.layer addSublayer:layer];
}

/// 获得裁剪后的图片
+ (UIImage *)cropImageView:(UIImageView *)imageView toRect:(CGRect)rect zoomScale:(double)zoomScale containerView:(UIView *)containerView shouldFixOrientation:(BOOL)fixOrientation{
    CGAffineTransform transform = CGAffineTransformIdentity;
    // 平移的处理
    CGRect imageViewRect = [imageView convertRect:imageView.bounds toView:containerView];
    CGPoint point = CGPointMake(imageViewRect.origin.x + imageViewRect.size.width / 2, imageViewRect.origin.y + imageViewRect.size.height / 2);
    CGFloat xMargin = containerView.tz_width - CGRectGetMaxX(rect) - rect.origin.x;
    CGPoint zeroPoint = CGPointMake((CGRectGetWidth(containerView.frame) - xMargin) / 2, containerView.center.y);
    CGPoint translation = CGPointMake(point.x - zeroPoint.x, point.y - zeroPoint.y);
    transform = CGAffineTransformTranslate(transform, translation.x, translation.y);
    // 缩放的处理
    transform = CGAffineTransformScale(transform, zoomScale, zoomScale);
    
    CGImageRef imageRef = [self newTransformedImage:transform
                                        sourceImage:imageView.image.CGImage
                                         sourceSize:imageView.image.size
                                        outputWidth:rect.size.width * [UIScreen mainScreen].scale
                                           cropSize:rect.size
                                      imageViewSize:imageView.frame.size];
    UIImage *cropedImage = [UIImage imageWithCGImage:imageRef];
    if (fixOrientation) {
        cropedImage = [self fixOrientation:cropedImage];
    }
    CGImageRelease(imageRef);
    return cropedImage;
}

+ (UIImage *)fixOrientation:(UIImage *)aImage {
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}
+ (CGImageRef)newTransformedImage:(CGAffineTransform)transform sourceImage:(CGImageRef)sourceImage sourceSize:(CGSize)sourceSize  outputWidth:(CGFloat)outputWidth cropSize:(CGSize)cropSize imageViewSize:(CGSize)imageViewSize {
    CGImageRef source = [self newScaledImage:sourceImage toSize:sourceSize];
    
    CGFloat aspect = cropSize.height/cropSize.width;
    CGSize outputSize = CGSizeMake(outputWidth, outputWidth*aspect);
    
    CGContextRef context = CGBitmapContextCreate(NULL, outputSize.width, outputSize.height, CGImageGetBitsPerComponent(source), 0, CGImageGetColorSpace(source), CGImageGetBitmapInfo(source));
    CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, outputSize.width, outputSize.height));
    
    CGAffineTransform uiCoords = CGAffineTransformMakeScale(outputSize.width / cropSize.width, outputSize.height / cropSize.height);
    uiCoords = CGAffineTransformTranslate(uiCoords, cropSize.width/2.0, cropSize.height / 2.0);
    uiCoords = CGAffineTransformScale(uiCoords, 1.0, -1.0);
    CGContextConcatCTM(context, uiCoords);
    
    CGContextConcatCTM(context, transform);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGContextDrawImage(context, CGRectMake(-imageViewSize.width/2, -imageViewSize.height/2.0, imageViewSize.width, imageViewSize.height), source);
    CGImageRef resultRef = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGImageRelease(source);
    return resultRef;
}

+ (CGImageRef)newScaledImage:(CGImageRef)source toSize:(CGSize)size {
    CGSize srcSize = size;
    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, size.width, size.height, 8, 0, rgbColorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(rgbColorSpace);
    
    CGContextSetInterpolationQuality(context, kCGInterpolationNone);
    CGContextTranslateCTM(context, size.width/2, size.height/2);
    
    CGContextDrawImage(context, CGRectMake(-srcSize.width/2, -srcSize.height/2, srcSize.width, srcSize.height), source);
    
    CGImageRef resultRef = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    return resultRef;
}

/// 获取圆形图片
+ (UIImage *)circularClipImage:(UIImage *)image {
    UIGraphicsBeginImageContextWithOptions(image.size, NO, [UIScreen mainScreen].scale);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    CGContextAddEllipseInRect(ctx, rect);
    CGContextClip(ctx);
    
    [image drawInRect:rect];
    UIImage *circleImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return circleImage;
}

@end

