//
//  PlayLiveVideoManagerHandle.m
//  libWeexSjhMonitor
//
//  Created by chenjintao on 2020/8/5.
//  Copyright © 2020 DCloud. All rights reserved.
//

#import "PlayLiveVideoManagerHandle.h"

@interface PlayLiveVideoManagerHandle() <ParsingDelegate>

@end

@implementation PlayLiveVideoManagerHandle

+ (instancetype)sharePlayLiveVideoManagerHandle
{
    static PlayLiveVideoManagerHandle *parser = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        parser = [[self alloc]init];
//        [parser initDecoder];
    });
    return parser;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        Parsing *par = [Parsing shareParser];
        par.delegate = self;
        self.liveHandleParsing = par;
    }
    return self;
}

- (UIImage *)getLiveVideoThumbImage
{
    return [self.liveHandleParsing getLiveVideoThumbImage];
}


- (void)startPlayLiveVideo:(VideoListHandle *)handle withImageView:(UIImageView *)playImageView
{
//    if (self.isPlaying) {
//        [self.liveHandleParsing end];
//        sleep(1.0);
//    }
    [self.liveHandleParsing initWithIp:handle.relayServerIpAddr port:[handle.relayServerPort intValue] devId:handle.devUid imgv:playImageView];
    [self.liveHandleParsing start];
    
    self.isPlaying = YES;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
////         [self playButtonAction];
//    });
}

- (void)updateParentView:(UIImageView *)playImageView
{
    [self.liveHandleParsing updateParentView:playImageView];
}

- (void)reconnect
{
    [self.liveHandleParsing Reconnection];
}

- (void)stopPlay
{
    [self.liveHandleParsing end];
    self.isPlaying = NO;
}

@end
