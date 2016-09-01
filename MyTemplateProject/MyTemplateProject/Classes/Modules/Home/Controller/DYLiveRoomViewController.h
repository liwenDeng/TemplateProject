//
//  DYLiveRoomViewController.h
//  MyTemplateProject
//
//  Created by dengliwen on 16/8/15.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "MSBaseViewController.h"
#import "DYRoomModel.h"
/**
 *  斗鱼直播VC
 */
@interface DYLiveRoomViewController : MSBaseViewController

@property (nonatomic, copy) NSString *roomId;
@property (nonatomic, strong) DYRoomModel *roomModel;

@end
