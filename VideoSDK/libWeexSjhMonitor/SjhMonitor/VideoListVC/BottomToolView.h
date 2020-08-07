//
//  BottomToolView.h
//  libWeexSjhMonitor
//
//  Created by chenjintao on 2020/8/5.
//  Copyright © 2020 DCloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThirdPartHeader.h"

NS_ASSUME_NONNULL_BEGIN
@protocol BottomToolViewDelegate <NSObject>
- (void)fullButtonClick:(NSInteger)index;
- (void)reflishButtonAction;
@end

@interface BottomToolView : UIView

//
@property (weak, nonatomic) id <BottomToolViewDelegate> delegate;
- (instancetype)initWithTag:(NSInteger)tag;

- (void)updateWithVideoHandle:(VideoListHandle *)handle;
- (void)updateReflishState:(BOOL)select;
@end

NS_ASSUME_NONNULL_END
