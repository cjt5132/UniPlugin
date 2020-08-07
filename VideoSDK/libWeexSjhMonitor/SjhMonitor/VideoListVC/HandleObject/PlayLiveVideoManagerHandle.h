//
//  PlayLiveVideoManagerHandle.h
//  libWeexSjhMonitor
//
//  Created by chenjintao on 2020/8/5.
//  Copyright © 2020 DCloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ThirdPartHeader.h"
NS_ASSUME_NONNULL_BEGIN

@interface PlayLiveVideoManagerHandle : NSObject
//
@property (strong, nonatomic) Parsing *liveHandleParsing;

//
@property (assign, nonatomic) BOOL isPlaying;

+ (instancetype)sharePlayLiveVideoManagerHandle;

- (UIImage *)getLiveVideoThumbImage;

- (void)startPlayLiveVideo:(VideoListHandle *)handle withImageView:(UIImageView *)playImageView;

- (void)updateParentView:(UIImageView *)playImageView;
- (void)reconnect;
- (void)stopPlay;

@end

NS_ASSUME_NONNULL_END
