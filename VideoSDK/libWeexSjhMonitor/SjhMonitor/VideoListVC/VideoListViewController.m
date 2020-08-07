//
//  VideoListViewController.m
//  libWeexSjhMonitor
//
//  Created by chenjintao on 2020/8/5.
//  Copyright © 2020 DCloud. All rights reserved.
//

#import "VideoListViewController.h"
#import "VideoListTableViewCell.h"
#import "FullVideoPlayViewController.h"

@interface VideoListViewController ()  <UITableViewDelegate,UITableViewDataSource,VideoListTableViewCellDelegate,FullVideoPlayViewControllerDelegate,SLDropdownMenuDelegate>
{
    NSArray * _menu2OptionTitles;
}
// tableView
@property (strong, nonatomic) UITableView *tableView;
// 数据源
@property (strong, nonatomic) NSMutableArray *dataSource;
@property (strong, nonatomic) NSMutableArray *titleDataSource;
//
@property (strong, nonatomic) NSMutableArray *titleHandleArray;
//
@property (strong, nonatomic) NSMutableArray *sourDataArray;
//
@property (strong, nonatomic) VideoListTableViewCell *currentCell;
//
@property (strong, nonatomic) NSIndexPath *currentIndexPath;

//
@property (strong, nonatomic) NSMutableDictionary *cellDic;

@property (nonatomic, strong) SLDropdownMenu *titleDropdownMenu;

@end

@implementation VideoListViewController

- (instancetype)initWithDataSource:(NSArray <VideoListHandle *>*)array titleArray:(NSArray <VideoTitleListHandle *>*)titleArray
{
    self = [super init];
    if (self) {
        self.dataSource = [NSMutableArray arrayWithArray:array];
        self.titleHandleArray = [NSMutableArray arrayWithArray:array];
        self.sourDataArray = [NSMutableArray arrayWithArray:titleArray];
        NSMutableArray *tmpTitleArray = [NSMutableArray array];
        for (VideoTitleListHandle *handle in titleArray) {
            [tmpTitleArray addObject:handle.className];
        }
        self.titleDataSource = [NSMutableArray arrayWithArray:tmpTitleArray];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = FlatWhite;
    self.title = @"监控列表";
//    [SVProgressHUD show];
    [self commonInit];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
//    [SVProgressHUD dismiss];
}

- (void)backItemAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    PlayLiveVideoManagerHandle *playHandle = [PlayLiveVideoManagerHandle sharePlayLiveVideoManagerHandle];
    [playHandle stopPlay];
}


#pragma mark - Getter
- (SLDropdownMenu *)titleDropdownMenu
{
    if (!_titleDropdownMenu) {
        _titleDropdownMenu = [[SLDropdownMenu alloc] init];
//        _titleDropdownMenu.backgroundColor = FlatRed;
        _titleDropdownMenu.accessoryImage = [UIImage stringToImage:kTringle];
        _titleDropdownMenu.delegate = self;
        _titleDropdownMenu.titleColor = [UIColor whiteColor];
        _titleDropdownMenu.dimmingViewColorAlpha = 0.3f;
        _titleDropdownMenu.popoverModel = SLPopoverViewModelBubble;
        //        _dropdownMenu.popoverViewBackgroundColor = [UIColor redColor];
        _titleDropdownMenu.bubbleStrokeColor = [UIColor grayColor];
        _titleDropdownMenu.bubbleFillColor = [UIColor blackColor];
//        _titleDropdownMenu.backgroundColor = [UIColor whiteColor];
        _titleDropdownMenu.popoverViewWidth = 90.f;
        _titleDropdownMenu.bubblePosition = SLBubblePositionLeft;
        _titleDropdownMenu.showSearchBar = NO;
    }
    return _titleDropdownMenu;
}

- (NSMutableArray *)titleHandleArray
{
    if (!_titleHandleArray) {
        _titleHandleArray = [NSMutableArray array];
    }
    return _titleHandleArray;;
}

- (NSMutableDictionary *)cellDic
{
    if (_cellDic == nil) {
        _cellDic = [NSMutableDictionary dictionary];
    }
    return _cellDic;
}


- (void)commonInit
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(backItemAction)];
    self.navigationItem.rightBarButtonItem = backItem;
    
    UITableView *tableView = [[UITableView alloc] init];
    self.tableView = tableView;
    tableView.backgroundColor = FlatWhite;
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    tableView.tableFooterView = [[UIView alloc] init];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    
    _titleDropdownMenu = nil;
    [self.titleDropdownMenu setFrame:CGRectMake(0.0f,0.f, 80.f, 40.f)];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:self.titleDropdownMenu];
    self.navigationItem.leftBarButtonItem = leftItem;
    self.titleDropdownMenu.dataSource = self.titleDataSource;
    
}

- (BOOL)prefersStatusBarHidden
{
    return NO;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 273;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleHandleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VideoListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (cell == nil) {
        cell = [[VideoListTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"VideoListTableViewCell" indexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
    }
    
    VideoListHandle *handle = self.titleHandleArray[indexPath.row];
    handle.thumbImagefilepath = [self thumbImageLocalFilepathWithImageName:handle.className];
    [cell updateWithVideoHandle:handle];
    
    if (indexPath == self.currentIndexPath) {
        PlayLiveVideoManagerHandle *playHandle = [PlayLiveVideoManagerHandle sharePlayLiveVideoManagerHandle];
        //        [playHandle updateParentView:cell.playImageView];
        if (playHandle.isPlaying) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                cell.playState = YES;
                [playHandle updateParentView:cell.playImageView];
            });
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    //    VideoListTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
}

- (void)playLiveVideo:(NSIndexPath *)indexPath cell:(VideoListTableViewCell *)cell
{
//    [SVProgressHUD show];
    
    PlayLiveVideoManagerHandle *playHandle = [PlayLiveVideoManagerHandle sharePlayLiveVideoManagerHandle];
    if (playHandle.isPlaying) {
        // 获取缩略图
        VideoListHandle *curhandle = self.titleHandleArray[self.currentIndexPath.row];
        [self imageViewToImageData:self.currentCell.playImageView filename:curhandle.className];
        
        self.currentCell.playState = NO;
        [playHandle stopPlay];
        
        [self.cellDic setObject:[NSNumber numberWithBool:NO] forKey:[NSString stringWithFormat:@"%ld",(long)self.currentIndexPath.row]];
        
        
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        VideoListHandle *handle = self.titleHandleArray[indexPath.row];
        [playHandle startPlayLiveVideo:handle withImageView:cell.playImageView];
        cell.playState = YES;
        self.currentCell = cell;
        self.currentIndexPath = indexPath;
        
        [self.cellDic setObject:[NSNumber numberWithBool:YES] forKey:[NSString stringWithFormat:@"%d",indexPath.row]];
//        [SVProgressHUD dismiss];
        [self.tableView reloadData];
    });
}

- (void)updateCurrentView:(NSIndexPath *)indexPath
{
    
}

/**
 * 全屏关闭,继续播放
 */
- (void)fullVidelVCWillClosed:(VideoListHandle *)handle
{
    PlayLiveVideoManagerHandle *playHandle = [PlayLiveVideoManagerHandle sharePlayLiveVideoManagerHandle];
    if (playHandle.isPlaying) {
        [playHandle updateParentView:self.currentCell.playImageView];
        [self.tableView reloadData];
    } else {
        [self playLiveVideo:self.currentIndexPath cell:self.currentCell];
    }
}


- (void)fullButtonClick:(NSIndexPath *)indexPath cell:(VideoListTableViewCell *)cell
{
    VideoListHandle *handle = self.titleHandleArray[indexPath.row];
    FullVideoPlayViewController *fullVC = [[FullVideoPlayViewController alloc] initWithHandle:handle curIndexPath:indexPath dataSource:self.titleHandleArray];
    fullVC.delegate = self;
    [self.navigationController pushViewController:fullVC animated:YES];
    
    [self.cellDic setObject:[NSNumber numberWithBool:YES] forKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
    self.currentCell = cell;
    self.currentIndexPath = indexPath;
}


- (void)leftButtomAction:(UIButton *)button
{
    
}


- (void)reflishButtonAction
{
    PlayLiveVideoManagerHandle *playHandle = [PlayLiveVideoManagerHandle sharePlayLiveVideoManagerHandle];
    [playHandle reconnect];
}

- (UIImage *)makeImageWithView:(UIView *)view
{
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
    //    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, [UIScreen mainScreen].scale);
    //    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:NO];
    //    UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
    //    UIGraphicsEndImageContext();
    //    return snapshotImage;
}

- (void)imageViewToImageData:(UIView *)imageView filename:(NSString *)filename
{
    //    UIImage *image = [self makeImageWithView:imageView];
    PlayLiveVideoManagerHandle *playHandle = [PlayLiveVideoManagerHandle sharePlayLiveVideoManagerHandle];
    UIImage *image = [playHandle getLiveVideoThumbImage];
    
    NSData *data = nil;
    if (UIImagePNGRepresentation(image) == nil){
        data = UIImageJPEGRepresentation(image, 1);
    } else {
        data = UIImagePNGRepresentation(image);
    }
    
    //图片保存的路径
    //这里将图片放在沙盒的documents文件夹中
    //    NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    PDRCoreAppInfo *appinfo = [PDRCore Instance].appManager.getMainAppInfo;
    NSString *DocumentsPath = appinfo.documentPath;
    
    //文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //把刚刚图片转换的data对象拷贝至沙盒中
    [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
    NSString * ImagePath = [DocumentsPath stringByAppendingString:[[NSString alloc] initWithFormat:@"/%@.png",filename]];
    BOOL isExist = [fileManager fileExistsAtPath:ImagePath];
    //    if (isExist) {
    //        [fileManager removeItemAtPath:ImagePath error:nil];
    //    }
    isExist = [fileManager createFileAtPath:ImagePath contents:data attributes:nil];
    
    NSLog(@"--");
}


- (NSString *)thumbImageLocalFilepathWithImageName:(NSString *)filename
{
    //    NSString * DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    PDRCoreAppInfo *appinfo = [PDRCore Instance].appManager.getMainAppInfo;
    NSString *DocumentsPath = appinfo.documentPath;
    NSString * ImagePath = [DocumentsPath stringByAppendingString:[[NSString alloc] initWithFormat:@"/%@.png",filename]];
    return ImagePath;
}


#pragma mark - SLDropdownMenuDelegate
- (void)dropdownMenu:(SLDropdownMenu *)menu didSelectedRow:(NSInteger)row
{
    NSLog(@"row = %ld, title = %@", (long)row, self.titleDataSource[row]);
    PlayLiveVideoManagerHandle *playHandle = [PlayLiveVideoManagerHandle sharePlayLiveVideoManagerHandle];
    [playHandle stopPlay];
    [self.cellDic setObject:[NSNumber numberWithBool:NO] forKey:[NSString stringWithFormat:@"%ld",(long)self.currentIndexPath.row]];
    self.currentCell = nil;
    self.currentIndexPath = nil;

    NSMutableArray *tempArray = [NSMutableArray array];
    NSString *title = self.titleDataSource[row];
    for (VideoTitleListHandle *titleHandle in self.sourDataArray) {
        if ([title isEqualToString:titleHandle.className]) {
            NSArray *titleArray = titleHandle.classIds;
            for (NSString *classID in titleArray) {
                for (VideoListHandle *videoHandle in self.dataSource) {
                    NSString *curclassid = videoHandle.classId;
                    if ([classID isEqualToString:curclassid]) {
                        [tempArray addObject:videoHandle];
                    }
                }
            }
            break;
        }
    }
    self.titleHandleArray = tempArray;
    [self.tableView reloadData];
}





@end
