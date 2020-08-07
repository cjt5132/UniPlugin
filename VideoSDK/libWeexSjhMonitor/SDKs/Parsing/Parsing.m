//
//  Parsing.m
//  VideoParsing
//
//  Created by yqs on 2019/12/21.
//  Copyright © 2019 yqs. All rights reserved.
//

#import "Parsing.h"
#import "GCDAsyncSocket.h"
#import "SocketWrite.h"
#import "RtpSendDefine.h"
#import "H264HwDecoderImpl.h"

@interface Parsing()<GCDAsyncSocketDelegate,H264HwDecoderImplDelegate>
{
    //视频显示
    //视频解码出来的img
    UIImage *img;
    //数据长度
    int len;
    
    enum SOCKETSTATE1 sockState;
    
    int vedioWidth;
    
    NSData *lastAudioData;
}
//音频解码播放
//@property (strong,nonatomic)PlayAACFile *playAACFile;
@property (nonatomic,strong) GCDAsyncSocket *socket;
@property (strong,nonatomic) SocketWrite *socketWrite;
@property(nonatomic,strong)NSString *ipaddress;
@property(nonatomic,assign)int mport;
@property(nonatomic,strong)NSString *devId;
@property(nonatomic,strong)UIImageView *imgv;
@property(nonatomic,strong)H264HwDecoderImpl *h264Decoder;

@end

static Parsing *parser = nil;

@implementation Parsing

+(instancetype)shareParser {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        parser = [[self alloc]init];
        [parser initDecoder];
    });
    return parser;
}

+(id)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        parser = [super allocWithZone:zone];
    });
    return parser;
}

-(void)initWithIp:(NSString *)ip port:(int)port devId:(NSString*)devId  imgv:(UIImageView *)imgv{
    if(ip==nil || devId == nil || imgv == nil){
        NSLog(@"设置的初始化参数不能为空");
        return;
    }
    self.devId = devId;
    self.imgv = imgv;
    self.ipaddress = ip;
    self.mport = port;
}
-(void)start{
    //    NSLog(@"开始连接");
    //    self.playLayer.parentView = _imgv;
    self.playLayer.backgroundColor = [UIColor blackColor].CGColor;
    [self.playLayer updateParentViewLayer:_imgv];
    [_imgv.layer addSublayer:self.playLayer];
    [self connectToHost:_ipaddress port:_mport];
}

/// 断线重连
-(void)Reconnection{
    [self.socket disconnect];
    sockState = SOCKETCUT;
    [self connectToHost:_ipaddress port:_mport];
}
/// 结束连接
-(void)end{
    _playLayer = nil;
    [self.socket disconnect];
    sockState = SOCKETCUT;
}

- (void)updateParentView:(UIImageView *)imageView
{
    //    [self.playLayer updateParentViewLayer:imageView];
    self.playLayer.frame = imageView.bounds;
    [imageView.layer insertSublayer:self.playLayer atIndex:0];
}

//初始化解码器,录音  音频解码播放初始化
- (void)initDecoder {
    self.h264Decoder.delegate = self;
    
    lastAudioData = [NSData new];
    
    
    sockState = SOCKETOFF;
}

-(H264HwDecoderImpl *)h264Decoder{
    if(_h264Decoder == nil){
        _h264Decoder = [[H264HwDecoderImpl alloc] init];
    }
    return _h264Decoder;
}
//懒加载
-(AAPLEAGLLayer*)playLayer{
    if(_playLayer == nil){
        _playLayer = [[AAPLEAGLLayer alloc] init];
    }
    return _playLayer;
}
//懒加载socket
-(GCDAsyncSocket *)socket{
    if(_socket==nil){
        _socket = [[GCDAsyncSocket alloc]initWithDelegate:self delegateQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
    }
    return _socket;
}

#pragma mark socket相关操作
- (void)connectToHost:(NSString *)host port:(uint16_t)port{
    
    //设置读写超时时间
    [self.socket readDataWithTimeout:3 tag:0];
    _socketWrite = [SocketWrite shareInstance];
    _socketWrite.sock = self.socket;
    //    [Recorder sharedInstance].socketWrite = _socketWrite;
    //    _count = 0;
    NSError *err = nil;
    [self.socket connectToHost:host onPort:port error:&err];
}

/**
 socket连接成功回调,并发起登陆请求
 */
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port{
    
    //    [AFAPIClient sharedClient].isLiveVideo = 1;
    //
    //    _playAACFile.isSuccess = YES;
    
    //    if(_devNow.devId != nil){
    //        [_socketWrite sendLoginWithUid:_devNow.devId];
    //    }else{
    //        [_socketWrite sendLoginWithUid:@""];
    //    }
    
    //写入设备id
    [_socketWrite sendLoginWithUid:self.devId];
}

/**
 socket断线回调方法
 
 @param sock 断线的socke
 @param err 错误描述
 */
- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err{
    NSLog(@"err:%@",err);
    // 断线重连
    //    _count++;
    if(sockState == SOCKETCUT){
        
        return;
    }else{
        
        // 连接失败
        if ([self.delegate respondsToSelector:@selector(parsingPlayError)]) {
            [self.delegate parsingPlayError];
        }
        
        sockState = SOCKETOFF;
        [NSThread sleepForTimeInterval:0.5];
        [self.socket connectToHost:_ipaddress onPort:_mport error:&err];
        
    }
}

//当数据发送成功的话也会回调GCDAsyncSocketDelegate里面的方法：这个的话就可以选择性重发数据
-(void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag{
    if(tag == 3){
        NSLog(@"云台控制--------------------------------------------------------------------------------");
    }
    if(tag == 4){
        NSLog(@"语音对讲");
    }
    if(tag == 5)//讲话请求
    {
        NSLog(@"对讲请求");
    }
    if(tag == 6){
        NSLog(@"对讲结束");
    }
    //tag = 0表示接收前四个字节的数据长度 + 一个字节的0
    if(tag == 0){
        [sock readDataToLength:4 withTimeout:3 tag:0];
    }
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    
    if(tag == 0){
        if([data length]>=4){//tag = 0表示接收前四个字节的数据长度 + 一个字节的0，如果读取的数据长度不是4的情况
            [data getBytes:&len range:NSMakeRange(0, 4)];
            //            NSLog(@"数据的长度%d",len);
            if(len>1000000 || len < 1){
                //                NSLog(@"数据的长度%d",len);
                [sock disconnect];
                return;
            }else{
                //tag = 1 表示接收数据
                [sock readDataToLength:len withTimeout:3 tag:1];
            }
        }else{
            [sock disconnect];
            return;
        }
    }
    if(tag ==1){
        NSData *tempData = [data subdataWithRange:NSMakeRange(1, data.length-1)];
        struct TMSG_HEADER *head;
        head = (struct TMSG_HEADER *)[tempData bytes];
        if(head->session == CMDSESSION){
            struct TMSG_LOGINRET *loginret =(struct TMSG_LOGINRET *)[tempData bytes];
            int msgIDStr = head->cMsgID;
            
            if(msgIDStr==40){
                dispatch_async(dispatch_get_main_queue(), ^{
                });
            }
        }
        else if(head->session == YRVIDEO){
            RTP_HDR_T rtp_hdp_t;
            [tempData getBytes:&rtp_hdp_t length:sizeof(rtp_hdp_t)];
            sockState = SOCKETON;
            _h264Decoder.outputWidth = rtp_hdp_t.w;
            _h264Decoder.outputHeight = rtp_hdp_t.h;
            
            if(rtp_hdp_t.w != vedioWidth){
                _h264Decoder.changeTheResolution = @"changeTheResolution";
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if(rtp_hdp_t.w != vedioWidth){
                    vedioWidth = rtp_hdp_t.w;
                }
            });
            
            @try {
                if(tempData.length >= rtp_hdp_t.dataLen+28){
                    NSData *h264Data = [tempData subdataWithRange:NSMakeRange(28, rtp_hdp_t.dataLen)];
                    
                    if(rtp_hdp_t.k == 1){
                        //                        NSLog(@"关键帧：%d",rtp_hdp_t.k);
                        NSMutableArray *letArr = [NSMutableArray array];
                        uint8_t *bytes = (uint8_t *)[h264Data bytes];
                        
                        unsigned i;
                        for(i = 0;i<h264Data.length-4;i++){
                            if(bytes[i] == 0 && bytes[i+1] == 0 && bytes[i+2] == 0 && bytes[i+3] == 1){
                                NSNumber *len = [NSNumber numberWithInteger:i];
                                [letArr addObject:len];
                            }
                        }
                        for (int i = 0; i< letArr.count; i++) {
                            NSRange range;
                            if(letArr.count == 1){
                                range = NSMakeRange(0, h264Data.length);
                            }else{
                                if(i == 0){
                                    range = NSMakeRange([letArr[i] integerValue], [letArr[i+1] integerValue]);
                                }else if(i == letArr.count-1){
                                    range = NSMakeRange([letArr[i] integerValue], h264Data.length - [letArr[i] integerValue]);
                                }else{
                                    range = NSMakeRange([letArr[i] integerValue], [letArr[i+1] integerValue]-[letArr[i] integerValue]);
                                }
                            }
                            NSData *nalData = [h264Data subdataWithRange:range];
                            [_h264Decoder decodeNalu:(uint8_t *)[nalData bytes] withSize:(uint32_t)nalData.length];
                        }
                    }else{
                        [_h264Decoder decodeNalu:(uint8_t *)[h264Data bytes] withSize:(uint32_t)h264Data.length];
                    }
                }
            }
            @catch (NSException *exception) {
                NSLog(@"视频解析出错：%@",exception);
            }
        }
        
        [sock readDataToLength:4 withTimeout:3 tag:0];
        
        tempData = nil;
    }
    
    if(tag == 40){
        
    }
}

- (UIImage *)cvsamplebufferrefToimage:(CVImageBufferRef)imageBuffer
{
    CVPixelBufferLockBaseAddress(imageBuffer, 0);
    void *baseAddress = CVPixelBufferGetBaseAddress(imageBuffer);
    size_t width = CVPixelBufferGetWidth(imageBuffer);
    size_t height = CVPixelBufferGetHeight(imageBuffer);
    size_t bufferSize = CVPixelBufferGetDataSize(imageBuffer);
    size_t bytesPerRow = CVPixelBufferGetBytesPerRowOfPlane(imageBuffer, 0);
    // Create a device-dependent gray color space
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    // Create a bitmap graphics context with the sample buffer data

    CGContextRef context = CGBitmapContextCreate(baseAddress, width, height, 8, bytesPerRow, colorSpace, kCGImageAlphaNone);
    // Create a Quartz image from the pixel data in the bitmap graphics context
    CGImageRef quartzImage = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    UIImage *image = [UIImage imageWithCGImage:quartzImage];
    return image;
}

- (UIImage *)getLiveVideoThumbImage
{
//    @synchronized (self) {
        UIImage *image = [self cvsamplebufferrefToimage:self.playLayer.pixelBuffer];
        return image;
//    }
}

#pragma mark -  H264解码回调  H264HwDecoderImplDelegate delegare
- (void)displayDecodedFrame:(CVImageBufferRef )imageBuffer {
    if(imageBuffer){
        dispatch_async(dispatch_get_main_queue(), ^{
            self.playLayer.pixelBuffer = imageBuffer;
            CVPixelBufferRelease(imageBuffer);
            
            //            NSLog(@"-=-=-");
        });
    }
}
@end
