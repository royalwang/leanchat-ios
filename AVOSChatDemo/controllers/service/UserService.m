//
//  UserService.m
//  AVOSChatDemo
//
//  Created by lzw on 14-10-22.
//  Copyright (c) 2014年 AVOS. All rights reserved.
//

#import "UserService.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation UserService

+(void)findFriendsWithCallback:(AVArrayResultBlock )block{
    User *user=[User currentUser];
    AVRelation *relation=[user relationforKey:@"friends"];
    //    //设置缓存有效期
    //    query.maxCacheAge = 4 * 3600;
    AVQuery *q=[relation query];
    q.cachePolicy=kAVCachePolicyNetworkElseCache;
    [q findObjectsInBackgroundWithBlock:block];
}

+(NSString*)getPeerIdOfUser:(User*)user{
    return user.objectId;
}

// should exclude friends
+(void)findUsersByPartname:(NSString *)partName withBlock:(AVArrayResultBlock)block{
    AVQuery *q=[User query];
    [q setCachePolicy:kAVCachePolicyNetworkElseCache];
    [q whereKey:@"username" containsString:partName];
    User *curUser=[User currentUser];
    [q whereKey:@"objectId" notEqualTo:curUser.objectId];
    [q findObjectsInBackgroundWithBlock:block];
}

+(void)findUsersByIds:(NSArray*)userIds callback:(AVArrayResultBlock)callback{
    if([userIds count]>0){
        AVQuery *q=[User query];
        [q setCachePolicy:kAVCachePolicyNetworkElseCache];
        [q whereKey:@"objectId" containedIn:userIds];
        [q findObjectsInBackgroundWithBlock:callback];
    }else{
        callback([[NSArray alloc] init],nil);
    }
}

+(void)displayAvatarOfUser:(User*)user avatarView:(UIImageView*)avatarView{
    AVFile* avatar=[user objectForKey:@"avatar"];
    if(avatar){
        [avatarView setImageWithURL:[NSURL URLWithString:avatar.url] placeholderImage:[UIImage imageNamed:@"default_user_avatar"]];
    }
}
@end
