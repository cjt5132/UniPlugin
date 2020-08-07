//
//  SocketRequest.h
//  BWJY
//
//  Created by YueAndy on 16/8/26.
//  Copyright © 2016年 YueAndy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCDAsyncSocket.h"

@interface SocketWrite : NSObject

+( instancetype ) shareInstance;

@property (nonatomic,strong)GCDAsyncSocket *sock;

//通过设备id和密码向服务器发送登陆数据
- (void)sendLoginWithUid:(NSString *)devId;
// 发送音频数据
- (void)sendAudioData:(NSData *)audioData;
// 云台操作
- (void)sendOperateData:(int)direction;

- (void)sendAudioRequest:(int)bJion;

//是否接收音频数据
- (void)audioStopRequest:(int)bJion;

//视频清晰度
- (void)videoResolutionRequest:(int)resolution;

//视频录制
- (void)recordRequest:(int)startOrEnd;

//设置机器音量
- (void)setVolume:(int)volume;

- (void)getVolume;


@end
