//
//  ShuJuHeVideoModule.m
//  libWeexSjhMonitor
//
//  Created by XHY on 2018/12/21.
//  Copyright © 2018 DCloud. All rights reserved.
//

#import "ShuJuHeVideoModule.h"
#import "WXUtility.h"
#import "SjhMonitorViewController.h"
#import "UIViewController+iOS13.h"
#import "VideoListTableViewController.h"
#import "VideoListViewController.h"
#import "ThirdPartHeader.h"
#import "BasicNavigationController.h"


@interface ShuJuHeVideoModule ()

@end

@implementation ShuJuHeVideoModule

@synthesize weexInstance;

WX_EXPORT_METHOD(@selector(show:callback:))
WX_EXPORT_METHOD(@selector(startPlayLive:callback:))
WX_EXPORT_METHOD(@selector(schoolVideoActivity:))

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init
{
    if (self = [super init]) {
//        /* 监听App停止运行事件，如果alert存在，调一下dismiss方法移除 */
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismiss) name:@"PDRCoreAppDidStopedKey" object:nil];
    }
    return self;
}



#pragma mark - Export Method

- (void)startPlayLive:(NSDictionary *)options callback:(WXModuleCallback)callback
{
    [self startPlayVideo:options callback:callback];
}

- (void)stopPlayLiveCallback:(NSDictionary *)options callback:(WXModuleCallback)callback
{
    
}

- (void)schoolVideoActivity:(NSString *)content
{
//    NSLog(@"content:%@",content);

    NSData *conjsonData = [content dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *contnetDic = [NSJSONSerialization JSONObjectWithData:conjsonData options:NSJSONReadingMutableContainers error:nil];
    NSString *titleJsonAry = contnetDic[@"classList"];
    NSString *videoJsonAry = contnetDic[@"camereList"];

    [self startPlayLiveVideoWithTitleJSONStr:titleJsonAry allVideoListJsonAry:videoJsonAry];
    
}

- (void)startPlayLiveVideoWithTitleJSONStr:(NSArray *)titleJSONArray allVideoListJsonAry:(NSArray *)allVideoJsonArray
{
//    // 标题转换
//    NSData *titlejsonData = [titleJSONStr dataUsingEncoding:NSUTF8StringEncoding];
//    NSArray *titlejsonArray = [NSJSONSerialization JSONObjectWithData:titlejsonData options:NSJSONReadingMutableContainers error:nil];
    NSMutableArray *titledataSource = [NSMutableArray array];
//    NSMutableArray *titleTmpArray = [NSMutableArray array];
    for (NSDictionary *dic in titleJSONArray) {
        VideoTitleListHandle *handle = [VideoTitleListHandle mj_objectWithKeyValues:dic];
        [titledataSource addObject:handle];
        
//        [titleTmpArray addObject:handle.className];
    }
    
//    // 内容转换
//    NSData *jsonData = [allVideoJSONStr dataUsingEncoding:NSUTF8StringEncoding];
//    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    NSMutableArray *dataSource = [NSMutableArray array];
    for (NSDictionary *dic in allVideoJsonArray) {
        VideoListHandle *handle = [VideoListHandle mj_objectWithKeyValues:dic];
        [dataSource addObject:handle];
    }
    
    [self startPlayLiveVideoTitleArray:titledataSource AllVideoLists:dataSource];

}

- (void)show:(NSDictionary *)options callback:(WXModuleCallback)callback
{
    NSString *titleArray = @"[{\"className\":\"全部\",\"classIds\":[\"2bc38a653892218b49868d0b43dadea9\",\"13a653892218b49868d0b43dadea9\",\"12353892218b49868d0b43dadea9\"]},{\"className\":\"测试\",\"classIds\":[\"2bc38a653892218b49868d0b43dadea9\"]},{\"className\":\"四年级\",\"classIds\":[\"13a653892218b49868d0b43dadea9\"]},{\"className\":\"五年级\",\"classIds\":[\"12353892218b49868d0b43dadea9\"]}]";
    NSData *titlejsonData = [titleArray dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *titlejsonArray = [NSJSONSerialization JSONObjectWithData:titlejsonData options:NSJSONReadingMutableContainers error:nil];
    NSMutableArray *titledataSource = [NSMutableArray array];
    NSMutableArray *titleTmpArray = [NSMutableArray array];
    for (NSDictionary *dic in titlejsonArray) {
        VideoTitleListHandle *handle = [VideoTitleListHandle mj_objectWithKeyValues:dic];
        [titledataSource addObject:handle];
    }
    
    NSString *jsonStr = @"[{\"classId\":\"2bc38a653892218b49868d0b43dadea9\",\"className\":\"314VHLY5\",\"devUid\":\"314VHLY5\",\"viewPwd\":\"88888\",\"relayServerIpAddr\":\"139.9.186.251\",\"relayServerPort\":6111},{\"classId\":\"13a653892218b49868d0b43dadea9\",\"className\":\"31B4GNDZ\",\"devUid\":\"31B4GNDZ\",\"viewPwd\":\"88888\",\"relayServerIpAddr\":\"139.9.186.251\",\"relayServerPort\":6111},{\"classId\":\"12353892218b49868d0b43dadea9\",\"className\":\"31BCXKHA\",\"devUid\":\"31BCXKHA\",\"viewPwd\":\"88888\",\"relayServerIpAddr\":\"139.9.186.251\",\"relayServerPort\":6111}]";
    NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    NSMutableArray *dataSource = [NSMutableArray array];
    for (NSDictionary *dic in jsonArray) {
        VideoListHandle *handle = [VideoListHandle mj_objectWithKeyValues:dic];
        [dataSource addObject:handle];
    }
//    [self startPlayVideoLists:dataSource callback:callback];
    [self startPlayLiveVideoTitleArray:titledataSource AllVideoLists:dataSource];
    
}

- (void)startPlayLiveVideoTitleArray:(NSArray *)titleArray AllVideoLists:(NSMutableArray *)videoArray
{
    UIViewController *manVC = [self findVisibleVC];
    VideoListViewController *listVC = [[VideoListViewController alloc] initWithDataSource:videoArray titleArray:titleArray];
    BasicNavigationController *nav = [[BasicNavigationController alloc] initWithRootViewController:listVC withBackgroundColor:[UIColor colorWithHexString:@"7dd1c9"] titleColor:[UIColor whiteColor]];
    
    nav.modalPresentationStyle = UIModalPresentationFullScreen;
    [manVC presentViewController:nav animated:YES completion:^{
    }];
}

- (void)startPlayVideo:(NSDictionary *)dic callback:(WXModuleCallback)callback
{
    UIViewController *manVC = [self findVisibleVC];
//    SjhMonitorViewController *liveVC = [[SjhMonitorViewController alloc] initWithDic:dic];
    VideoListViewController *listVC = [[VideoListViewController alloc] init];
    BasicNavigationController *nav = [[BasicNavigationController alloc] initWithRootViewController:listVC];
    nav.modalPresentationStyle = UIModalPresentationFullScreen;
    [manVC presentViewController:nav animated:YES completion:^{
        callback(@"开始播放监控");
    }];
}


// 获取栈顶 UIViewController
- (UIViewController *)findVisibleVC {
    UIViewController *visibleVc = nil;
    UIWindow *visibleWindow = nil;
    NSArray *windows = [[UIApplication sharedApplication] windows];
    for (UIWindow *window in windows) {
        if (!window.hidden && !visibleWindow) {
            visibleWindow = window;
        }
        if ([UIWindow instancesRespondToSelector:@selector(rootViewController)]) {
            if ([window rootViewController]) {
                visibleVc = window.rootViewController;
                break;
            }
        }
    }

    return visibleVc ?: [[UIApplication sharedApplication].delegate window].rootViewController;
}


@end
