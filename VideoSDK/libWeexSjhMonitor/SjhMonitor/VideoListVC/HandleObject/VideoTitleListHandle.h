//
//  VideoTitleListHandle.h
//  SLDropdownMenu
//
//  Created by chenjintao on 2020/8/7.
//  Copyright © 2020 WSonglin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
//"className":"全部",
// "classIds":[
//     "2bc38a653892218b49868d0b43dadea9",
//     "2bc38a653892218b49868d0b43dadea9",
//     "2bc38a653892218b49868d0b43dadea9"
// ]
@interface VideoTitleListHandle : NSObject
//
@property (copy, nonatomic) NSString *className;
//
@property (strong, nonatomic) NSArray *classIds;

@end

NS_ASSUME_NONNULL_END
