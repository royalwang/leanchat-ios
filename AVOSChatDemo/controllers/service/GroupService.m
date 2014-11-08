//
//  GroupService.m
//  AVOSChatDemo
//
//  Created by lzw on 14/11/6.
//  Copyright (c) 2014年 AVOS. All rights reserved.
//

#import "GroupService.h"
#import "User.h"
#import "ChatGroup.h"

@implementation GroupService

+(void)findGroups:(AVArrayResultBlock)callback{
    User* user=[User currentUser];
    AVQuery* q=[ChatGroup query];
    [q includeKey:@"owner"];
    [q setCachePolicy:kAVCachePolicyNetworkElseCache];
    [q whereKey:@"m" equalTo:user.objectId];
    [q orderByDescending:@"createdAt"];
    [q findObjectsInBackgroundWithBlock:callback];
}

@end
