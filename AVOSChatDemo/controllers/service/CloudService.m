//
//  CloudService.m
//  AVOSChatDemo
//
//  Created by lzw on 14-10-24.
//  Copyright (c) 2014年 AVOS. All rights reserved.
//

#import "CloudService.h"

@implementation CloudService

+(void)callCloudRelationFn:(User*)fromUser toUser:(User*)toUser action:(NSString*)action callback:(AVIdResultBlock)callback{
    NSDictionary *dict=@{@"fromUserId":fromUser.objectId,@"toUserId":toUser.objectId};
    [AVCloud callFunctionInBackground:action withParameters:dict block:callback];
}

+(void)tryCreateAddRequest:(User*)toUser callback:(AVIdResultBlock)callback{
    User* user=[User currentUser];
    assert(user!=nil);
    NSDictionary* dict=@{@"fromUserId":user.objectId,@"toUserId":toUser.objectId};
    [AVCloud callFunctionInBackground:@"tryCreateAddRequest" withParameters:dict block:callback];
}

+(void)agreeAddRequest:(NSString*)objectId callback:(AVIdResultBlock)callback{
    NSDictionary* dict=@{@"objectId":objectId};
    [AVCloud callFunctionInBackground:@"agreeAddRequest" withParameters:dict block:callback];
}

+(void)saveChatGroup:(NSString*)groupId name:(NSString*)name callback:(AVIdResultBlock)callback{
    NSString* userId=[User curUserId];
    assert(userId!=nil);
    NSDictionary* dict=@{@"groupId":groupId,@"ownerId":userId,@"name":name};
    [AVCloud callFunctionInBackground:@"saveChatGroup" withParameters:dict block:callback];
}

@end
