//
//  CDChatConfirmController.h
//  AVOSChatDemo
//
//  Created by Qihe Bian on 8/6/14.
//  Copyright (c) 2014 AVOS. All rights reserved.
//

#import "CDBaseController.h"
#import "CDSessionManager.h"

@interface CDChatConfirmController : CDBaseController
@property (nonatomic, strong) NSString *otherId;
@property (nonatomic) CDMsgRoomType type;
@end
