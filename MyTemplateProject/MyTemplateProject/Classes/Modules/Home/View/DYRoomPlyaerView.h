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

@class DYRoomPlyaerView;
@protocol DYRoomPlyaerViewDelegate <NSObject>

/**
 *  全屏旋转
 */
- (void)dyPlayerView:(DYRoomPlyaerView*)view rotateState:(PlayerViewRotateState)state;
- (void)dyPlayerViewBackButtonClicked:(DYRoomPlyaerView *)view;
- (void)dyPlayerViewRefreshButtonClicked:(DYRoomPlyaerView *)view;

@end

@interface DYRoomPlyaerView : UIView

@property (nonatomic, assign) PlayerViewLockState lockState;//锁屏状态
@property (nonatomic, assign) PlayerViewRotateState rotateState;  //是否全屏
@property (nonatomic, weak) id<DYRoomPlyaerViewDelegate> delegate;

- (void)playWithVideoSrc:(NSString *)src;

- (void)showNomalToolView:(BOOL)show;

@end
