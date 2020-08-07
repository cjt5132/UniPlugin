//
//  BasicNavigationController.h
//  XJGaming
//
//  Created by chenjintao on 2019/8/28.
//  Copyright © 2019 XJGaming. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BasicNavigationController : UINavigationController
- (instancetype)initWithRootViewController:(UIViewController *)rootViewController withBackgroundColor:(UIColor *)color titleColor:(UIColor *)titleColor;
@end

NS_ASSUME_NONNULL_END
