//
//  UIImage+Extension.m
//  0719WeiBo
//
//  Created by 洪龙通 on 16/7/19.
//  Copyright © 2016年 洪龙通. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)


+ (instancetype)imageWithName:(NSString *)imageName {
	
    if (IOS7) {
        NSString *imageStr = [NSString stringWithFormat:@"%@%@",imageName, @"_os7"];
        UIImage *image = [UIImage imageNamed:imageStr];
        if (image) {
            return image;
        }
    }
    return [UIImage imageNamed:imageName];
    
}

+ (instancetype)resizeImageWithName:(NSString *)name
{
    return [self resizeImageWithName:name leftScale:0.5 topScale:0.5];
}

+ (instancetype)resizeImageWithName:(NSString *)name leftScale:(CGFloat)left topScale:(CGFloat)top
{
    UIImage *image = [UIImage imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * left topCapHeight:image.size.height * top];
}
@end
