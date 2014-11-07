//
//  CDSessionManager.h
//  AVOSChatDemo
//
//  Created by Qihe Bian on 7/29/14.
//  Copyright (c) 2014 AVOS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CDCommon.h"
#import "Msg.h"
#import "ChatGroup.h"

@interface CDSessionManager : NSObject <AVSessionDelegate, AVSignatureDelegate, AVGroupDelegate>
+ (instancetype)sharedInstance;

@property NSMutableArray* friends;

//conversation
- (NSArray *)chatRooms;
-(void)findConversations:(AVArrayResultBlock)callback;

//session
- (void)watchPeerId:(NSString *)peerId;
-(void)unwatchPeerId:(NSString*)peerId;
-(void)openSession;
-(void)closeSession;

//message
- (void)sendMessage:(NSString *)content type:(CDMsgType)type toPeerId:(NSString *)toPeerId group:(AVGroup*)group;
- (void)sendAttachment:(NSString*)objectId type:(CDMsgType)type toPeerId:(NSString *)toPeerId group:(AVGroup*)group;

- (NSArray*)getMsgsForConvid:(NSString*)convid;
+(NSString*)getConvid:(CDMsgRoomType)roomType otherId:(NSString*)otherId groupId:(NSString*)groupId;
- (void)clearData;
+(NSString*)convid:(NSString*)myId otherId:(NSString*)otherId;
+(NSString*)getPathByObjectId:(NSString*)objectId;
+(NSString*)uuid;

//histroy
- (void)getHistoryMessagesForPeerId:(NSString *)peerId callback:(AVArrayResultBlock)callback;
- (void)getHistoryMessagesForGroup:(NSString *)groupId callback:(AVArrayResultBlock)callback;

//group
- (AVGroup *)joinGroup:(NSString *)groupId;
- (void)startNewGroup:(NSString*)name callback:(AVGroupResultBlock)callback ;
-(void)inviteMembersToGroup:(ChatGroup*) chatGroup userIds:(NSArray*)userIds;

//user cache
- (void)registerUsers:(NSArray*)users;
- (void)registerUser:(User*)user;
- (User *)lookupUser:(NSString*)userId;
-(void)cacheUsersWithIds:(NSArray*)userIds callback:(AVArrayResultBlock)callback;

@end
