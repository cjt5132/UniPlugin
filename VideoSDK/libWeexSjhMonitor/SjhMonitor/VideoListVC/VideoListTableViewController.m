//
//  VideoListTableViewController.m
//  libWeexSjhMonitor
//
//  Created by chenjintao on 2020/8/5.
//  Copyright © 2020 DCloud. All rights reserved.
//

#import "VideoListTableViewController.h"
#import "VideoListTableViewCell.h"
#import "FullVideoPlayViewController.h"

@interface VideoListTableViewController () <UITableViewDelegate,UITableViewDataSource>

@end

@implementation VideoListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.tableView registerClass:[VideoListTableViewCell class] forCellReuseIdentifier:@"VideoListTableViewCell"];
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
     
}


#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 200;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 250;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VideoListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VideoListTableViewCell"];
    if (cell == nil) {
        cell = [[VideoListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"VideoListTableViewCell" indexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    
    return cell;
}


@end
