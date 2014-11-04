//
//  CDUserInfoController.m
//  AVOSChatDemo
//
//  Created by lzw on 14-10-23.
//  Copyright (c) 2014年 AVOS. All rights reserved.
//

#import "CDUserInfoController.h"
#import "AddRequestService.h"
#import "CDChatRoomController.h"
#import "CloudService.h"

@interface CDUserInfoController (){
    BOOL isFriend;
}

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *actionBtn;
@end



@implementation CDUserInfoController

#pragma lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"详情";
    _nameLabel.text=_user.username;
    CDSessionManager* man=[CDSessionManager sharedInstance];
    isFriend=[[man friends] containsObject:_user];
    [_actionBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    if(isFriend){
        [_actionBtn setTitle:@"开始聊天" forState:UIControlStateNormal];
    }else{
        [_actionBtn setTitle:@"添加好友" forState:UIControlStateNormal];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma actions

-(void)btnClicked:(UIButton*)button{
    if(isFriend){
        CDChatRoomController *controller = [CDChatRoomController messagesViewController];
        controller.chatUser = self.user;
        controller.type = CDMsgRoomTypeSingle;
        UINavigationController* nav=[[UINavigationController alloc] initWithRootViewController:controller];
        [self presentViewController:nav animated:YES completion:nil];
    }else{
        [CloudService tryCreateAddRequest:_user callback:^(id object, NSError *error) {
            NSString *info;
            if(error==nil){
                info=@"请求成功";
            }else{
                info=[error localizedDescription];
            }
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:NULL message:info delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }];
    }
}

@end
