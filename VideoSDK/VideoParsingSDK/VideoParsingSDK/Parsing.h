//
//  Parsing.h
//  VideoParsing
//
//  Created by yqs on 2019/12/21.
//  Copyright © 2019 yqs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

enum SOCKETSTATE1{
    SOCKETON,//socket连接状态
    SOCKETOFF,//socket断开状态
    SOCKETCUT//socket断开并且是用户主动掐断
};

@protocol ParsingDelegate <NSObject>
// 将要开始播放
- (void)parsingStartPlay;
// 已经开始播放
- (void)parsingPlaySuccess;
// 播放失败
- (void)parsingPlayError;
// 播放失败
- (void)parsingStopPlay;

@end

@interface Parsing : NSObject

+(instancetype)shareParser;
//
@property (weak, nonatomic) id <ParsingDelegate> delegate;

/// 设置化解码需要的参数
/// @param ip 连接ip地址
/// @param port 连接的端口号
/// @param devId 连接设备的ID
/// @param imgv 用于接收画面的UIImageView控件
-(void)initWithIp:(NSString *)ip port:(int)port devId:(NSString*)devId  imgv:(UIImageView *)imgv;

/// 开始连接：1、首先设置解码需要的参数，2、开始连接设备解码
-(void)start;

/// 断线重连
-(void)Reconnection;
/// 结束连接
-(void)end;
@end

NS_ASSUME_NONNULL_END
