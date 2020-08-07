//
//  VideoListViewController.h
//  libWeexSjhMonitor
//
//  Created by chenjintao on 2020/8/5.
//  Copyright © 2020 DCloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThirdPartHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface VideoListViewController : UIViewController
- (instancetype)initWithDataSource:(NSArray <VideoListHandle *>*)array titleArray:(NSArray <VideoTitleListHandle *>*)titleArray;
@end

NS_ASSUME_NONNULL_END
