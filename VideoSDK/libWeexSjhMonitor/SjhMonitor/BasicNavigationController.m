//
//  BasicNavigationController.m
//  XJGaming
//
//  Created by chenjintao on 2019/8/28.
//  Copyright © 2019 XJGaming. All rights reserved.
//

#import "BasicNavigationController.h"
#import "UINavigationController+BasicNavVC.h"
#import "ThirdPartHeader.h"

@interface BasicNavigationController () <UINavigationControllerDelegate>
//
@property (strong, nonatomic) UIColor *customColor;
@end

@implementation BasicNavigationController


- (instancetype)initWithRootViewController:(UIViewController *)rootViewController withBackgroundColor:(UIColor *)color titleColor:(UIColor *)titleColor
{
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        [[UINavigationBar appearance] setTitleTextAttributes:
         [NSDictionary dictionaryWithObjectsAndKeys:color, NSForegroundColorAttributeName, [UIFont systemFontOfSize:18], NSFontAttributeName, nil]];
        
        [[UINavigationBar appearance] setTranslucent:NO];
        
        NSMutableDictionary *testAttr = [NSMutableDictionary dictionary];
        testAttr[NSForegroundColorAttributeName] = titleColor;
        testAttr[NSFontAttributeName] = [UIFont systemFontOfSize:18];
        [[UINavigationBar appearance] setTitleTextAttributes:testAttr];
        testAttr = [NSMutableDictionary dictionary];
        testAttr[NSForegroundColorAttributeName] = color;
        [[UIBarButtonItem appearance] setTitleTextAttributes:testAttr forState:UIControlStateNormal];
        [[UINavigationBar appearance] setShadowImage:[UIImage imageNamed:@""]];
        
        [[UINavigationBar appearance] setTintColor:titleColor];
        [[UINavigationBar appearance] setBarStyle:UIBarStyleDefault];
        
        self.navigationBar.translucent = NO;
        self.navigationBar.shadowImage = [[UIImage alloc] init];
        self.customColor = color;
        //设置背景色
        [self setNavigationBGWithColor:color]; //标题颜色
        

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIBarButtonItem *item = [UIBarButtonItem appearance];
//    item.tintColor = [UIColor whiteColor];
//    self.navigationBar.barTintColor = [UIColor colorWithRed:0 green:122/255.0 blue:255/255.0 alpha:1];
}


/**
 *  重写这个方法的目的:为了拦截整个push过程,拿到所有push进来的子控制器
 *
 *  @param viewController 当前push进来的子控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //    if (viewController != 栈底控制器) {
    if (self.viewControllers.count > 0) {
        
        [self setNavigationBGWithColor:self.customColor]; //标题颜色


//        // 当push这个子控制器时, 隐藏底部的工具条
//        UIColor *color = FlatWhite;
//        
//        viewController.hidesBottomBarWhenPushed = YES;
//        
//        
//        
//        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        backButton.frame = CGRectMake(0, 0, 44, 44);
////        backButton.backgroundColor = FlatGreen;
//        UIImage *image = [[UIImage imageNamed:@"leftArror"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
//        backButton.tintColor = color;
//        [backButton setImage:image forState:UIControlStateNormal];
//        [backButton setTitleColor:color forState:UIControlStateNormal];
//        [backButton setContentEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
//        backButton.adjustsImageWhenHighlighted = NO;
//        backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//        
//        backButton.titleLabel.font = [UIFont systemFontOfSize:16];
//        
//        [backButton addTarget:self action:@selector(back)
//             forControlEvents:UIControlEventTouchUpInside];
//        
//        [backButton setImageEdgeInsets:UIEdgeInsetsMake(0, 5 * BoundWidth/375, 0, 0)];
//        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        
        
    }
    
    // 将viewController压入栈中
    [super pushViewController:viewController animated:animated];
}


-(UIViewController *)popViewControllerAnimated:(BOOL)animated{
//    [SVProgressHUD dismiss];
    return [super popViewControllerAnimated:animated];
    
}



- (void)back
{
    [self popViewControllerAnimated:YES];
}

#pragma mark - <UIGestureRecognizerDelegate>
/**
 *  这个代理方法的作用:决定pop手势是否有效
 *
 *  @return YES:手势有效, NO:手势无效
 */
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return self.viewControllers.count > 1;
}

@end
