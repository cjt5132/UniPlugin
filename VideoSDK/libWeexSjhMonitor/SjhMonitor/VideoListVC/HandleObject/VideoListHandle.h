//
//  VideoListHandle.h
//  libWeexSjhMonitor
//
//  Created by chenjintao on 2020/8/5.
//  Copyright © 2020 DCloud. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
//classId = "";
//className = 31BCXKHA;
//devUid = 31BCXKHA;
//relayServerIpAddr = "139.9.186.251";
//relayServerPort = 6111;
//viewPwd = 88888;
@interface VideoListHandle : NSObject
//
@property (copy, nonatomic) NSString *classId;
@property (copy, nonatomic) NSString *className;
@property (copy, nonatomic) NSString *devUid;
@property (copy, nonatomic) NSString *relayServerIpAddr;
@property (copy, nonatomic) NSString *relayServerPort;
@property (copy, nonatomic) NSString *viewPwd;
//
@property (copy, nonatomic) NSString *thumbImagefilepath;
@end

NS_ASSUME_NONNULL_END
