//
//  BottomToolView.m
//  libWeexSjhMonitor
//
//  Created by chenjintao on 2020/8/5.
//  Copyright © 2020 DCloud. All rights reserved.
//

#import "BottomToolView.h"
#import "ThirdPartHeader.h"

@interface BottomToolView()
//
@property (strong, nonatomic) UILabel *titleLabel;
//
@property (strong, nonatomic) UIButton *reflishButton;
@end

@implementation BottomToolView

- (instancetype)initWithTag:(NSInteger)tag
{
    self = [super init];
    if (self) {
        self.backgroundColor = ClearColor;
        
        UIButton *reflishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:reflishButton];
        self.reflishButton = reflishButton;
        reflishButton.hidden = YES;
        [reflishButton addTarget:self action:@selector(reflishButtonAction) forControlEvents:UIControlEventTouchUpInside];
        UIImage *refImage = [[UIImage stringToImage:kUseReflish] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [reflishButton setImage:refImage forState:UIControlStateNormal];
//        playButton.backgroundColor = FlatRed;
        reflishButton.tintColor = [FlatBlack colorWithAlphaComponent:0.7];
        [reflishButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.height.width.offset(30);
            make.centerY.mas_equalTo(self);
        }];
        
        UIButton *fullButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:fullButton];
        fullButton.tag = tag;
        [fullButton addTarget:self action:@selector(fullButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        UIImage *image = [[UIImage stringToImage:kUseFullScreamImage] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [fullButton setImage:image forState:UIControlStateNormal];
        fullButton.tintColor = [FlatBlack colorWithAlphaComponent:0.7];
//        fullButton.backgroundColor = FlatRed;
        [fullButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10);
            make.height.width.offset(25);
            make.centerY.mas_equalTo(self);
        }];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        self.titleLabel = titleLabel;
        [self addSubview:titleLabel];
        titleLabel.text = @"GUKUBKLGY";
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont boldSystemFontOfSize:18];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(reflishButton.mas_right);
            make.right.mas_equalTo(fullButton.mas_left);
            make.top.bottom.mas_equalTo(self);
        }];
    }
    return self;
}


- (void)updateWithVideoHandle:(VideoListHandle *)handle
{
    self.titleLabel.text = handle.className;
}

- (void)updateReflishState:(BOOL)select
{
    self.reflishButton.hidden = !select;
}


- (void)fullButtonAction:(UIButton *)button
{
    if ([self.delegate respondsToSelector:@selector(fullButtonClick:)]) {
        [self.delegate fullButtonClick:button.tag];
    }
}

- (void)reflishButtonAction
{
    if ([self.delegate respondsToSelector:@selector(reflishButtonAction)]) {
        [self.delegate reflishButtonAction];
    }
}



@end
