//
//  DYPlayerToolView.h
//  MyTemplateProject
//
//  Created by dengliwen on 16/8/17.
//  Copyright © 2016年 dengliwen. All rights reserved.
//
/**
 *  播放器的工具栏
 */
#import <UIKit/UIKit.h>

@class DYPlayerNomalSizeToolView;
@class DYPlayerFullScreenSizeToolView;

@protocol DYPlayerNomalSizeToolViewDelegate <NSObject>

// 点击暂停/播放 按钮
- (void)normalToolView:(DYPlayerNomalSizeToolView *)toolView willPlay:(BOOL)willPlay;
// 点击全屏
- (void)normalToolViewClickedFullScreenBtn:(DYPlayerNomalSizeToolView *)toolView;
// 点击返回
- (void)normalToolViewClickedBackBtn:(DYPlayerNomalSizeToolView *)toolView;

@end

@protocol DYPlayerFullScreenSizeToolViewDelegate <NSObject>

// 点击暂停/播放 按钮
- (void)fullSizeToolView:(DYPlayerFullScreenSizeToolView *)toolView willPlay:(BOOL)willPlay;
// 点击返回非全屏
- (void)fullSizeToolViewClickedBackBtn:(DYPlayerFullScreenSizeToolView *)toolView;
// 点击刷新按钮
- (void)fullSizeToolViewClickedRefreshBtn:(DYPlayerFullScreenSizeToolView *)toolView;

@end

/**
 *  竖屏下的工具条
 */
@interface DYPlayerNomalSizeToolView : UIView

@property (nonatomic, weak) id<DYPlayerNomalSizeToolViewDelegate> delegate;

@end

/**
 *  横屏下的工具条 (全屏)
 */
@interface DYPlayerFullScreenSizeToolView : UIView

@property (nonatomic, weak) id<DYPlayerFullScreenSizeToolViewDelegate> delegate;

@end
