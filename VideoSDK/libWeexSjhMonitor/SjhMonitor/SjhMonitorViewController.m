//
//  SjhMonitorViewController.m
//  libWeexSjhMonitor
//
//  Created by chenjintao on 2019/12/25.
//  Copyright © 2019 DCloud. All rights reserved.
//

#import "SjhMonitorViewController.h"
#import "Parsing.h"
#import "Masonry.h"

@interface SjhMonitorViewController () <ParsingDelegate>
// <#描述#>
@property (strong, nonatomic) UIImageView *imageView;
// <#描述#>
@property (strong, nonatomic) UIButton *playButton;
// <#描述#>
@property (strong, nonatomic) UIButton *stopButton;
// <#描述#>
@property (strong, nonatomic) UIButton *backButton;
// <#描述#>
@property (strong, nonatomic) UIActivityIndicatorView *activVC;
// <#描述#>
@property (strong, nonatomic) Parsing *parser;

// <#描述#>
@property (strong, nonatomic) NSDictionary  *dictionary;
@end

@implementation SjhMonitorViewController

- (instancetype)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.dictionary = dic;
        

        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];

        self.view.backgroundColor = [UIColor blackColor];
        UIImageView *imageView = [[UIImageView alloc] init];
        [self.view addSubview:imageView];
        self.imageView = imageView;
//        imageView.transform = CGAffineTransformRotate(imageView.transform, M_PI_2);
        
        UIButton *playButton = [[UIButton alloc] init];
        playButton.hidden = YES;
        self.playButton = playButton;
        [self.view addSubview:playButton];
//        playButton.backgroundColor = [UIColor redColor];
        [playButton setTitle:@"播放" forState:UIControlStateNormal];
        [playButton addTarget:self action:@selector(playButtonAction) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *stopButton = [[UIButton alloc] init];
        stopButton.hidden = YES;
        self.stopButton = stopButton;
        [self.view addSubview:stopButton];
//        stopButton.backgroundColor = [UIColor redColor];
        [stopButton setTitle:@"停止" forState:UIControlStateNormal];
        [stopButton addTarget:self action:@selector(stopButtonAction) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeClose];
        backButton.tintColor = [UIColor whiteColor];
        backButton.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.6];
        backButton.layer.cornerRadius = 5;
        backButton.clipsToBounds = YES;
        self.backButton = backButton;
        [self.view addSubview:backButton];
        [backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        
        UIActivityIndicatorView *activVC = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        self.activVC = activVC;
        [self.view addSubview:activVC];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    Parsing *parser = [Parsing shareParser];
    self.parser = parser;
    parser.delegate = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         [self playButtonAction];
    });
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    CGRect frame = [UIScreen mainScreen].bounds;
    self.imageView.frame = frame;
    
    self.playButton.frame = CGRectMake(20, frame.size.height - 50, 60, 44);
    self.stopButton.frame = CGRectMake(frame.size.width - 80, frame.size.height - 50, 60, 44);
    self.backButton.frame = CGRectMake(frame.size.width - 64, 20, 44, 44);
    self.activVC.center = self.view.center;
}


- (void)backAction
{
    [self stopButtonAction];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)playButtonAction
{
    NSDictionary *options = self.dictionary;
    NSString *ip = [options objectForKey:@"ip"];
    NSString *portStr = [options objectForKey:@"port"];
    int port = [portStr intValue];
    NSString *devID = [options objectForKey:@"devID"];
    
    [self.parser initWithIp:ip port:port devId:devID imgv:self.imageView];
    [self.parser start];
    
}

- (void)stopButtonAction
{
    [self.parser end];
}

#pragma mark - ParsingDelegate
// 将要开始播放
- (void)parsingStartPlay
{
    [self.activVC startAnimating];
}

// 已经开始播放
- (void)parsingPlaySuccess
{
    [self.activVC stopAnimating];
}

// 播放失败
- (void)parsingPlayError
{
//    [self.activVC stopAnimating];
}

// 停止播放
- (void)parsingStopPlay
{
//    [self.activVC stopAnimating];
}


@end
