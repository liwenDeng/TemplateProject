//
//  DYRoomPlyaerView.h
//  MyTemplateProject
//
//  Created by dengliwen on 16/8/17.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 锁屏状态
 */
typedef enum : NSUInteger {
    PlayerViewLocked,
    PlayerViewUnLocked,
} PlayerViewLockState;

typedef enum : NSUInteger {
    PlayerViewRotateNomalSize,//普通大小
    PlayerViewRotateFullScreenSize,//全屏
} PlayerViewRotateState;

@interface DYRoomPlyaerView : UIView

@property (nonatomic, assign) PlayerViewLockState lockState;//锁屏状态
@property (nonatomic, assign) PlayerViewRotateState rotateState;  //是否全屏

- (void)playWithVideoSrc:(NSString *)src;

@end
