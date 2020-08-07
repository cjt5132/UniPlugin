//
//  FullVideoPlayViewController.h
//  libWeexSjhMonitor
//
//  Created by chenjintao on 2020/8/5.
//  Copyright © 2020 DCloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThirdPartHeader.h"

NS_ASSUME_NONNULL_BEGIN

@protocol FullVideoPlayViewControllerDelegate <NSObject>
- (void)fullVidelVCWillClosed:(VideoListHandle *)handle;
@end

@interface FullVideoPlayViewController : UIViewController
//
@property (weak, nonatomic) id <FullVideoPlayViewControllerDelegate> delegate;
- (instancetype)initWithHandle:(VideoListHandle *)handle curIndexPath:(NSIndexPath *)indexPath dataSource:(NSMutableArray *)dataSource;
@end

NS_ASSUME_NONNULL_END
