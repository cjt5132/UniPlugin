//
//  VideoListTableViewCell.h
//  libWeexSjhMonitor
//
//  Created by chenjintao on 2020/8/5.
//  Copyright © 2020 DCloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThirdPartHeader.h"

NS_ASSUME_NONNULL_BEGIN

@protocol VideoListTableViewCellDelegate <NSObject>
- (void)playLiveVideo:(NSIndexPath *)indexPath cell:(id)cell;
- (void)fullButtonClick:(NSIndexPath *)indexPath cell:(id)cell;
- (void)reflishButtonAction;
@end

@interface VideoListTableViewCell : UITableViewCell
//
@property (weak, nonatomic) id <VideoListTableViewCellDelegate> delegate;
@property (strong, nonatomic) UIImageView *playImageView;
//
@property (assign, nonatomic) BOOL playState;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier indexPath:(NSIndexPath *)indexPath;

- (void)updateWithVideoHandle:(VideoListHandle *)handle;

- (void)playLiveVideoWithHandle:(VideoListHandle *)handle;
@end

NS_ASSUME_NONNULL_END
