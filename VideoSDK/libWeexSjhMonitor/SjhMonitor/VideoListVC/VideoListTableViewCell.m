//
//  VideoListTableViewCell.m
//  libWeexSjhMonitor
//
//  Created by chenjintao on 2020/8/5.
//  Copyright © 2020 DCloud. All rights reserved.
//

#import "VideoListTableViewCell.h"
#import "BottomToolView.h"
#import "Parsing.h"

@interface VideoListTableViewCell() <BottomToolViewDelegate>
//
@property (strong, nonatomic) BottomToolView *botToolView;
//
@property (strong, nonatomic) NSIndexPath *indexPath;

@property (strong, nonatomic) Parsing *parser;
//
//
@property (strong, nonatomic) UIButton *playButton;
@end

@implementation VideoListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier indexPath:(NSIndexPath *)indexPath
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = FlatWhite;
        self.indexPath = indexPath;
        [self commonInitIndexPath:indexPath];
    }
    return self;
}


- (void)commonInitIndexPath:(NSIndexPath *)indexPath
{
    UIView *backView = [[UIView alloc] init];
    [self addSubview:backView];
    backView.layer.cornerRadius = 10;
    backView.clipsToBounds = YES;
    backView.backgroundColor = [UIColor whiteColor];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(5, 10, 5, 10));
    }];
    
    BottomToolView *botToolView = [[BottomToolView alloc] initWithTag:indexPath.row];
    self.botToolView = botToolView;
    botToolView.tag = indexPath.row;
    botToolView.delegate = self;
    [backView addSubview:botToolView];
    [botToolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(backView);
        make.height.offset(40);
    }];
    
    UIImageView *playImageView = [[UIImageView alloc] init];
    self.playImageView = playImageView;
    [backView addSubview:playImageView];
    playImageView.contentMode = UIViewContentModeScaleToFill ;
    playImageView.layer.backgroundColor = FlatBlack.CGColor;
    [playImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(backView);
        make.bottom.mas_equalTo(botToolView.mas_top);
    }];
    
    UIButton *playButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backView addSubview:playButton];
    self.playButton = playButton;
//    playButton.userInteractionEnabled = NO;
    playButton.tag = indexPath.row;
    [playButton addTarget:self action:@selector(playButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIImage *image = [[UIImage stringToImage:kUsePlayImage] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    playButton.tintColor = FlatWhite;
    [playButton setImage:image forState:UIControlStateNormal];
//    playButton.backgroundColor = FlatGreen;
    [playButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.offset(60);
        make.center.mas_equalTo(self);
    }];
}

- (void)setPlayState:(BOOL)playState
{
    [self updateState:playState];
}

- (void)updateState:(BOOL)playState
{
    self.playButton.hidden = playState;
    [self.botToolView updateReflishState:playState];
}


- (void)updateWithVideoHandle:(VideoListHandle *)handle
{
    NSData *data = [NSData dataWithContentsOfFile:handle.thumbImagefilepath];
    UIImage *image = [UIImage imageWithData:data];
    self.playImageView.image = image;//[UIImage imageNamed:@"closeImage"];
    [self.botToolView updateWithVideoHandle:handle];
    [self updateState:self.playState];
}

- (void)playButtonAction:(UIButton *)button
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:button.tag inSection:0];
    if ([self.delegate respondsToSelector:@selector(playLiveVideo:cell:)]) {
        [self.delegate playLiveVideo:indexPath cell:self];
    }
}

- (void)playLiveVideoWithHandle:(VideoListHandle *)handle
{
    
}


- (void)fullButtonClick:(NSInteger)index
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    if ([self.delegate respondsToSelector:@selector(fullButtonClick:cell:)]) {
        [self.delegate fullButtonClick:indexPath cell:self];
    }
}

- (void)reflishButtonAction
{
    if ([self.delegate respondsToSelector:@selector(reflishButtonAction)]) {
        [self.delegate reflishButtonAction];
    }
}
@end
