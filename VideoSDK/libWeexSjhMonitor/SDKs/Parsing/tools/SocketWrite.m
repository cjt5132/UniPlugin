//
//  SocketRequest.m
//  BWJY
//
//  Created by YueAndy on 16/8/26.
//  Copyright © 2016年 YueAndy. All rights reserved.
//

#import "SocketWrite.h"
#import "RtpSendDefine.h"

@implementation SocketWrite

static SocketWrite *instance = nil;

+( instancetype ) shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once ( &onceToken, ^ {
        instance=[[super allocWithZone:NULL] init] ;
        
    } );
    return instance;
}

+(id) allocWithZone:(struct _NSZone *)zone {
    if(instance == nil){
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            instance = [super allocWithZone:zone];
        });
    }
    return instance ;
}

//socket发送登陆数据
- (void)sendLoginWithUid:(NSString *)devId{
    struct TMSG_HEADER header;
    header.cMsgID = MSG_VIEWLOGIN;
    header.session = CMDSESSION;
    
    struct TMSG_CAPLOGIN login;
    login.header = header;
    
    const char *UID =[devId UTF8String];
    
    strcpy(login.password, "88888");
    strcpy(login.SxtID, UID);
    
    
    char *v_szSendBuf = (char *)&login;
    
    int v_iSendLen = sizeof(login);
    
    char szSendBuf[12*1024 + 218] = {0};
    
    int iDataLen = v_iSendLen + 2;
    int iSendLen = 0;
    
    memcpy(szSendBuf, &iDataLen, sizeof(iDataLen));
    iSendLen += 4;
    iSendLen ++;
    
    memcpy(szSendBuf + iSendLen, v_szSendBuf, v_iSendLen);
    iSendLen += v_iSendLen;
    iSendLen ++;
    
    //把Str转成NSData(网络传输都是二进制)
    NSData *data = [NSData dataWithBytes: szSendBuf  length:iSendLen];
    [self.sock writeData:data withTimeout:-1 tag:0];
}

// 发送音频数据
- (void)sendAudioData:(NSData *)audioData{
    NSLog(@"对讲数据");
    struct TMSG_HEADER header;
    header.cMsgID = MSG_AUDIODATAGSM;
    header.session = SZYAUDIO_EX;
    
    char *tempBuf = (char *)&header;
    int tempLen = sizeof(header);
    
    
    NSMutableData *allData = [[NSMutableData alloc]init];
    
    [allData appendBytes:tempBuf length:tempLen];
    
    [allData appendBytes:[audioData bytes] length:audioData.length];
    
    
    char *v_szSendBuf = (char *)[allData bytes];
    
    int v_iSendLen = (int)allData.length;
    
    char szSendBuf[12*1024 + 218] = {0};
    
    int iDataLen = v_iSendLen + 2;
    int iSendLen = 0;
    
    memcpy(szSendBuf, &iDataLen, sizeof(iDataLen));
    iSendLen += 4;
    iSendLen ++;
    
    memcpy(szSendBuf + iSendLen, v_szSendBuf, v_iSendLen);
    iSendLen += v_iSendLen;
    iSendLen ++;
    
    NSData *sendData = [NSData dataWithBytes: szSendBuf  length:iSendLen];
    
    if(sendData.length>100){
        [self.sock writeData:sendData withTimeout:-1 tag:4];
    }
}


// 云台操作
- (void)sendOperateData:(int)direction{
    
    struct TMSG_HEADER header;
    header.cMsgID = MSG_PTZCOMMAND;
    header.session = CMDSESSION;
    
    struct TMSG_PTZCOMMAND ptzcommand;
    ptzcommand.header = header;
    
    //云台移动速度：speed [0,63]
    //    上：(7,1,speed)
    //    下：(7,2,speed)
    //    左：(7,3,speed)
    //    右：(7,6,speed)
    //    旋转停止:(7,0,0)
    
    NSLog(@"云台操作");
    
    ptzcommand.m_nFunc=7;
    ptzcommand.m_nCtl=direction;
    ptzcommand.m_nSpeed=(char)200;
    if(direction>100){
        ptzcommand.m_nFunc=10;
        ptzcommand.m_nCtl=direction-100;
        ptzcommand.m_nSpeed=0;
    }
    
    char *v_szSendBuf = (char *)&ptzcommand;
    
    int v_iSendLen = sizeof(ptzcommand);
    
    char szSendBuf[12*1024 + 218] = {0};
    
    int iDataLen = v_iSendLen + 2;
    int iSendLen = 0;
    
    memcpy(szSendBuf, &iDataLen, sizeof(iDataLen));
    iSendLen += 4;
    iSendLen ++;
    
    memcpy(szSendBuf + iSendLen, v_szSendBuf, v_iSendLen);
    iSendLen += v_iSendLen;
    iSendLen ++;
    
    //把Str转成NSData(网络传输都是二进制)
    NSData *data = [NSData dataWithBytes: szSendBuf  length:iSendLen];
    
    [self.sock writeData:data withTimeout:-1 tag:3];
}

//开始对讲
- (void)sendAudioRequest:(int)bJion{
    
    struct TMSG_HEADER header;
    header.cMsgID = MSG_AUDIODREQ;
    header.session = CMDSESSION;
    
    struct TMSG_AUDIODREQ audiodreq;
    audiodreq.header = header;
    audiodreq.bJoin = bJion;
    
    
    char *v_szSendBuf = (char *)&audiodreq;
    
    int v_iSendLen = sizeof(audiodreq);
    
    char szSendBuf[12*1024 + 218] = {0};
    
    int iDataLen = v_iSendLen + 2;
    int iSendLen = 0;
    
    memcpy(szSendBuf, &iDataLen, sizeof(iDataLen));
    iSendLen += 4;
    iSendLen ++;
    
    memcpy(szSendBuf + iSendLen, v_szSendBuf, v_iSendLen);
    iSendLen += v_iSendLen;
    iSendLen ++;
    
    //把Str转成NSData(网络传输都是二进制)
    NSData *data = [NSData dataWithBytes: szSendBuf  length:iSendLen];
    
    //tag=5,表示讲话请求
    if(bJion == 0){
        [self.sock writeData:data withTimeout:-1 tag:6];
    }else{
        [self.sock writeData:data withTimeout:-1 tag:5];
    }
}

//停止对讲
- (void)audioStopRequest:(int)bJion{
    
    struct TMSG_HEADER header;
    header.cMsgID = 11;
    header.session = CMDSESSION;
    
    struct TMSG_AUDIODREQ audioStop;
    audioStop.header = header;
    audioStop.bJoin = bJion;
    
    
    char *v_szSendBuf = (char *)&audioStop;
    
    int v_iSendLen = sizeof(audioStop);
    
    char szSendBuf[12*1024 + 218] = {0};
    
    int iDataLen = v_iSendLen + 2;
    int iSendLen = 0;
    
    memcpy(szSendBuf, &iDataLen, sizeof(iDataLen));
    iSendLen += 4;
    iSendLen ++;
    
    memcpy(szSendBuf + iSendLen, v_szSendBuf, v_iSendLen);
    iSendLen += v_iSendLen;
    iSendLen ++;
    
    //把Str转成NSData(网络传输都是二进制)
    NSData *data = [NSData dataWithBytes: szSendBuf  length:iSendLen];
    
    //tag=5,表示讲话请求
    if(bJion == 0){
        [self.sock writeData:data withTimeout:-1 tag:7];
    }else{
        [self.sock writeData:data withTimeout:-1 tag:8];
    }
}


//清晰度
- (void)videoResolutionRequest:(int)resolution{
    
    struct TMSG_HEADER header;
    header.cMsgID = 7;
    header.session = CMDSESSION;
    
    struct TMSG_AUDIODREQ videoResolution;
    videoResolution.header = header;
    videoResolution.bJoin = resolution;
    
    
    char *v_szSendBuf = (char *)&videoResolution;
    
    int v_iSendLen = sizeof(videoResolution);
    
    char szSendBuf[12*1024 + 218] = {0};
    
    int iDataLen = v_iSendLen + 2;
    int iSendLen = 0;
    
    memcpy(szSendBuf, &iDataLen, sizeof(iDataLen));
    iSendLen += 4;
    iSendLen ++;
    
    memcpy(szSendBuf + iSendLen, v_szSendBuf, v_iSendLen);
    iSendLen += v_iSendLen;
    iSendLen ++;
    
    //把Str转成NSData(网络传输都是二进制)
    NSData *data = [NSData dataWithBytes: szSendBuf  length:iSendLen];
    
    //tag=5,表示讲话请求;1--高清，2---VGA
    if(resolution == 1){
        [self.sock writeData:data withTimeout:-1 tag:9];
    }else{
        [self.sock writeData:data withTimeout:-1 tag:10];
    }
}

//视频录制
- (void)recordRequest:(int)startOrEnd{
    
    struct TMSG_HEADER header;
    header.cMsgID = 50;
    header.session = CMDSESSION;
    
    struct TMSG_STARTRECORD record;
    record.header = header;
    record.startRecord = startOrEnd;
    
    char *v_szSendBuf = (char *)&record;
    
    int v_iSendLen = sizeof(record);
    
    char szSendBuf[12*1024 + 218] = {0};
    
    int iDataLen = v_iSendLen + 2;
    int iSendLen = 0;
    
    memcpy(szSendBuf, &iDataLen, sizeof(iDataLen));
    iSendLen += 4;
    iSendLen ++;
    
    memcpy(szSendBuf + iSendLen, v_szSendBuf, v_iSendLen);
    iSendLen += v_iSendLen;
    iSendLen ++;
    
    //把Str转成NSData(网络传输都是二进制)
    NSData *data = [NSData dataWithBytes: szSendBuf  length:iSendLen];
    
    //tag=5,表示讲话请求
    if(startOrEnd == 0){
        [self.sock writeData:data withTimeout:-1 tag:11];
    }else{
        [self.sock writeData:data withTimeout:-1 tag:12];
    }
}

//设置机器音量
- (void)setVolume:(int)volume{
    struct TMSG_HEADER header;
    header.cMsgID = 39;
    header.session = CMDSESSION;
    
    struct TMSG_AUDIODREQ audiodreq;
    audiodreq.header = header;
    audiodreq.bJoin = volume;
    
    char *v_szSendBuf = (char *)&audiodreq;
    int v_iSendLen = sizeof(audiodreq);
    char szSendBuf[12*1024 + 218] = {0};
    int iDataLen = v_iSendLen + 2;
    int iSendLen = 0;
    
    memcpy(szSendBuf, &iDataLen, sizeof(iDataLen));
    iSendLen += 4;
    iSendLen ++;
    
    memcpy(szSendBuf + iSendLen, v_szSendBuf, v_iSendLen);
    iSendLen += v_iSendLen;
    iSendLen ++;
    
    //把Str转成NSData(网络传输都是二进制)
    NSData *data = [NSData dataWithBytes: szSendBuf  length:iSendLen];
    
    //tag=5,表示讲话请求
    [self.sock writeData:data withTimeout:-1 tag:39];
}

//获取机器音量
- (void)getVolume {
    struct TMSG_HEADER header;
    header.cMsgID = 40;
    header.session = CMDSESSION;
    
    char *v_szSendBuf = (char *)&header;
    
    int v_iSendLen = sizeof(header);
    
    char szSendBuf[12*1024 + 218] = {0};
    
    int iDataLen = v_iSendLen + 2;
    int iSendLen = 0;
    
    memcpy(szSendBuf, &iDataLen, sizeof(iDataLen));
    iSendLen += 4;
    iSendLen ++;
    
    memcpy(szSendBuf + iSendLen, v_szSendBuf, v_iSendLen);
    iSendLen += v_iSendLen;
    iSendLen ++;
    
    //把Str转成NSData(网络传输都是二进制)
    NSData *data = [NSData dataWithBytes: szSendBuf  length:iSendLen];
    
    //tag=5,表示讲话请求
    [self.sock writeData:data withTimeout:-1 tag:40];
}

@end
