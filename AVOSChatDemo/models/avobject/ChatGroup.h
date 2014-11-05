//
//  ChatGroup.h
//  AVOSChatDemo
//
//  Created by lzw on 14/11/6.
//  Copyright (c) 2014年 AVOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface ChatGroup : AVObject<AVSubclassing>

@property NSString* name;
@property NSArray* m;
@property User*owner;

-(NSString*)getTitle;
@end
