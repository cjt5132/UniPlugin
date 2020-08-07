//
//  ShuJuHeVideoProxy.m
//  libWeexSjhMonitor
//
//  Created by 4Ndf on 2018/12/24.
//  Copyright © 2018年 DCloud. All rights reserved.
//

#import "ShuJuHeVideoProxy.h"
#import "WXSDKEngine.h"
#import "ThirdPartHeader.h"

@implementation ShuJuHeVideoProxy
-(void)onCreateUniPlugin{
    NSLog(@"TestPlugin 有需要初始化的逻辑可以放这里！");    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    NSLog(@"TestPlugin 有需要didFinishLaunchingWithOptions可以放这里！");

    [application setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];

    
    return YES;
}

@end


