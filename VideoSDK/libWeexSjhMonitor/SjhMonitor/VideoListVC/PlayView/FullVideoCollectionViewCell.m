//
//  FullVideoCollectionViewCell.m
//  libWeexSjhMonitor
//
//  Created by chenjintao on 2020/8/6.
//  Copyright © 2020 DCloud. All rights reserved.
//

#import "FullVideoCollectionViewCell.h"

@interface FullVideoCollectionViewCell()
//
@property (strong, nonatomic) UILabel *titleLable;

@end

@implementation FullVideoCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView *playImageView = [[UIImageView alloc] init];
        [self addSubview:playImageView];
        self.playImageView = playImageView;
        playImageView.backgroundColor = FlatBlack;
        [playImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(self);
            make.top.mas_equalTo(self);
        }];
        
        UILabel *titleLable = [[UILabel alloc] init];
        self.titleLable = titleLable;
        [self addSubview:titleLable];
        titleLable.font = [UIFont boldSystemFontOfSize:18];
        titleLable.textColor = [UIColor whiteColor];
        titleLable.textAlignment = NSTextAlignmentCenter;
        titleLable.backgroundColor = ClearColor;
//        titleLable.transform = CGAffineTransformRotate(titleLable.transform, M_PI_2);
        [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.left.mas_equalTo(self);
            make.height.offset(40);
            
        }];
        
        
    }
    return self;
}

- (void)updateWithHandle:(VideoListHandle *)handle
{
    self.titleLable.text = handle.className;
}

@end
