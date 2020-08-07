//
//  UIImage+Add.h
//  libWeexSjhMonitor
//
//  Created by chenjintao on 2020/8/5.
//  Copyright © 2020 DCloud. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Add)

+ (UIImage *)stringToImage:(NSString *)str;
// 图片转64base字符串
+ (NSString *)imageToString:(UIImage *)image;
@end

NS_ASSUME_NONNULL_END
