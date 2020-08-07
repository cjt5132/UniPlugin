//
//  UINavigationController+BasicNavVC.m
//  XJGaming
//
//  Created by chenjintao on 2019/8/30.
//  Copyright © 2019 XJGaming. All rights reserved.
//

#import "UINavigationController+BasicNavVC.h"

@implementation UINavigationController (BasicNavVC)

/**
 *  设置导航背景
 *  color  颜色
 */
- (void)setNavigationBGWithColor:(UIColor *)color
{
    
    if(self.navigationBar.translucent == NO){
        [self.navigationBar setTranslucent:NO];
    }

    UIImage *image = [self createImageWithColor:color];
    [self.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
}

- (UIImage*) createImageWithColor: (UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;

}

@end
