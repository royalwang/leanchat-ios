//
//  User.m
//  AVOSChatDemo
//
//  Created by lzw on 14-10-22.
//  Copyright (c) 2014年 AVOS. All rights reserved.
//

#import "User.h"

@implementation User

@dynamic friends;
@dynamic avatar;

+ (NSString *)parseClassName {
    return @"_User";
}

+(NSString*)curUserId{
    return [User currentUser].objectId;
}

-(NSString*)getAvatarUrl{
    if([self avatar]!=nil){
        return [self avatar].url;
    }
    return nil;
}

@end
