//
//  FullVideoCollectionViewCell.h
//  libWeexSjhMonitor
//
//  Created by chenjintao on 2020/8/6.
//  Copyright © 2020 DCloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThirdPartHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface FullVideoCollectionViewCell : UICollectionViewCell
//
@property (strong, nonatomic) UIImageView *playImageView;
- (void)updateWithHandle:(VideoListHandle *)handle;
@end

NS_ASSUME_NONNULL_END
