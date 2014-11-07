//
//  CDGroupDetailController.m
//  AVOSChatDemo
//
//  Created by lzw on 14/11/6.
//  Copyright (c) 2014年 AVOS. All rights reserved.
//

#import "CDGroupDetailController.h"
#import "CDImageLabelCollectionCell.h"
#import "UserService.h"
#import "CDSessionManager.h"
#import "Utils.h"

@interface CDGroupDetailController (){
    NSArray* groupMembers;
    CDSessionManager* sessionManager;
}
@end

@implementation CDGroupDetailController

static NSString * const reuseIdentifier = @"Cell";


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    self.title=[self.chatGroup getTitle];
    NSString* nibName=NSStringFromClass([CDImageLabelCollectionCell class]);
    NSLog(@"nibName=%@",nibName);
    [self.collectionView registerNib:[UINib nibWithNibName:nibName bundle:nil]  forCellWithReuseIdentifier:reuseIdentifier];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    sessionManager=[CDSessionManager sharedInstance];
    [sessionManager cacheUsersWithIds:self.chatGroup.m callback:^(NSArray *objects, NSError *error) {
        [Utils filterError:error callback:^{
            groupMembers=self.chatGroup.m;
            [self.collectionView reloadData];
        }];
    }];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [groupMembers count];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CDImageLabelCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    int labelTag=1;
    int imageTag=2;
    
    NSString* userId=[groupMembers objectAtIndex:indexPath.row];
    User* user=[sessionManager lookupUser:userId];
    
    UILabel* label=(UILabel*)[cell viewWithTag:labelTag];
    UIImageView* imageView=(UIImageView*)[cell viewWithTag:imageTag];
    
    [UserService displayAvatar:user avatarView:imageView];
    label.text=user.username;
    
    
    //[cell setBackgroundColor:[UIColor greenColor]];

//    CDTestCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
//    [cell setBackgroundColor:[UIColor greenColor]];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(90, 90);
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
