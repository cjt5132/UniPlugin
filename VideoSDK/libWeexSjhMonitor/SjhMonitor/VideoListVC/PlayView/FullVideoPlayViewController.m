//
//  FullVideoPlayViewController.m
//  libWeexSjhMonitor
//
//  Created by chenjintao on 2020/8/5.
//  Copyright © 2020 DCloud. All rights reserved.
//

#import "FullVideoPlayViewController.h"
#import "FullVideoCollectionViewCell.h"

@interface FullVideoPlayViewController ()
<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>
{
    NSInteger maxCount;
}
// UICollectionView
@property (strong, nonatomic) UICollectionView *collectionView;
// 数据源
@property (strong, nonatomic) NSMutableArray *dataSource;
// NSIndexPath
@property (strong, nonatomic) NSIndexPath *indexPath;
//
@property (strong, nonatomic) NSIndexPath *currentIndexPath;
@property (strong, nonatomic) UIImageView *playImageView;
//
@property (strong, nonatomic) VideoListHandle *videoHandle;

@end


@implementation FullVideoPlayViewController


- (instancetype)initWithHandle:(VideoListHandle *)handle curIndexPath:(NSIndexPath *)indexPath dataSource:(NSMutableArray *)dataSource
{
    self = [super init];
    if (self) {
        self.currentIndexPath = indexPath;
        self.dataSource = dataSource;
        self.videoHandle = handle;
        maxCount = 1;
    }
    return self;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self commonInit];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}


- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
//    [SVProgressHUD show];
    
    
    
    [self.collectionView scrollToItemAtIndexPath:self.currentIndexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    
    PlayLiveVideoManagerHandle *playHandle = [PlayLiveVideoManagerHandle sharePlayLiveVideoManagerHandle];
    if (playHandle.isPlaying) {
        //        [playHandle updateParentView:self.playImageView];
        [playHandle stopPlay];
        //        sleep(1);
    } else {
        //
        //        [SVProgressHUD dismiss];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        FullVideoCollectionViewCell *cell = (FullVideoCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:self.currentIndexPath];
        [playHandle startPlayLiveVideo:self.videoHandle withImageView:cell.playImageView];
//        [SVProgressHUD dismiss];
    });
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    //    PlayLiveVideoManagerHandle *playHandle = [PlayLiveVideoManagerHandle sharePlayLiveVideoManagerHandle];
    //    [playHandle stopPlay];
    
    if ([self.delegate respondsToSelector:@selector(fullVidelVCWillClosed:)]) {
        [self.delegate fullVidelVCWillClosed:self.videoHandle];
    }
}

- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}


- (void)commonInit
{
    //1.初始化layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //2.初始化collectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.pagingEnabled = YES;
    self.collectionView = collectionView;
    [self.view addSubview:collectionView];
    collectionView.backgroundColor = [UIColor whiteColor];
    [collectionView registerClass:[FullVideoCollectionViewCell class] forCellWithReuseIdentifier:@"FullVideoCollectionViewCell"];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.transform = CGAffineTransformRotate(collectionView.transform, M_PI_2);
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.edges.equalTo(self.view);
        make.width.mas_equalTo(self.view.mas_height);
        make.height.mas_equalTo(self.view.mas_width);
        make.center.mas_equalTo(self.view);
    }];
    
    UIButton *closeButton =[UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:closeButton];
    [closeButton addTarget:self action:@selector(closeButtonAction) forControlEvents:UIControlEventTouchUpInside];
    UIImage *butImage = [[UIImage stringToImage:kUseClose] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    closeButton.tintColor = FlatWhite;
    [closeButton setImage:butImage forState:UIControlStateNormal];
    [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.width.height.offset(35);
    }];
}


#pragma mark ---- UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FullVideoCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FullVideoCollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = RandomFlatColor;
    
    if (indexPath.row == self.indexPath.row) {
        
        
    } else {
        
        
    }
    
    VideoListHandle *handle = self.dataSource[indexPath.row];
    [cell updateWithHandle:handle];
    
    return cell;
}

#pragma mark ---- UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = [UIScreen mainScreen].bounds.size;
    CGFloat scrWith = size.height;
    CGFloat scrheight = size.width;
    //    CGFloat manger = 5.0;
    //    CGFloat with = (scrWith - manger * (maxCount - 1)) / maxCount - manger;
    return (CGSize){scrWith,scrheight};
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.f;
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.f;
}


#pragma mark ---- UICollectionViewDelegate

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

// 点击高亮
- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    //    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    //    cell.backgroundColor = [UIColor greenColor];
}


// 选中某item
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //    self.indexPath = indexPath;
    //    [self.collectionView reloadData];
}

#pragma mark - scrollView 停止滚动监测
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    BOOL scrollToScrollStop = !scrollView.tracking
                            && !scrollView.dragging
                            && !scrollView.decelerating;
    if (scrollToScrollStop) {
           NSArray *indexPaths = [self.collectionView indexPathsForVisibleItems];
//            NSIndexPath *indexPath = indexPaths.firstObject;
            // 将collectionView在控制器view的中心点转化成collectionView上的坐标
            CGPoint pInView = [self.view convertPoint:self.collectionView.center toView:self.collectionView];
        //    // 获取这一点的indexPath
            NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:pInView];
            self.indexPath = indexPath;

        PlayLiveVideoManagerHandle *playHandle = [PlayLiveVideoManagerHandle sharePlayLiveVideoManagerHandle];
        if (playHandle.isPlaying) {
            //        [playHandle updateParentView:self.playImageView];
            [playHandle stopPlay];
            //        sleep(1);
        }
        
//        [SVProgressHUD show];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            FullVideoCollectionViewCell *cell = (FullVideoCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
            VideoListHandle *handle = self.dataSource[indexPath.row];
            [playHandle startPlayLiveVideo:handle withImageView:cell.playImageView];
//            [SVProgressHUD dismiss];
            self.currentIndexPath = indexPath;
        });
        
        
    }

}

- (void)closeButtonAction
{
    [self.navigationController popViewControllerAnimated:YES];
}


//
//
//- (instancetype)initWithHandle:(VideoListHandle *)handle
//{
//    self = [super init];
//    if (self) {
//        self.videoHandle = handle;
//    }
//    return self;
//}
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor blackColor];
//
//    [self commonInit];
//}

//
//- (void)commonInit
//{
//    UIImageView *imageView = [[UIImageView alloc] init];
//    [self.view addSubview:imageView];
////    imageView.backgroundColor = FlatRed;
//    self.playImageView = imageView;
//    imageView.transform = CGAffineTransformRotate(imageView.transform, M_PI_2);
//    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.edges.equalTo(self.view);
//        make.width.mas_equalTo(self.view.mas_height);
//        make.height.mas_equalTo(self.view.mas_width);
//        make.center.mas_equalTo(self.view);
//    }];
//

//
//
//}

//
////- (BOOL)shouldAutorotate
////{
////     return YES;
////}
////
//////- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
//////    return UIInterfaceOrientationMaskPortrait;
//////}
////- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
////    return UIInterfaceOrientationMaskLandscapeLeft;  //支持横向
////}
//
//

@end
