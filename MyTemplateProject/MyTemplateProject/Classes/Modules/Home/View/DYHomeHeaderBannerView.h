//
//  DYHomeHeaderBannerCell.h
//  MyTemplateProject
//
//  Created by dengliwen on 16/8/30.
//  Copyright © 2016年 dengliwen. All rights reserved.
//
/**
 *  首页顶部轮播图
 */
#import <UIKit/UIKit.h>
#import "DYBannerList.h"

@class DYHomeHeaderBannerView;

@protocol DYHomeHeaderBannerViewDelegate <NSObject>

- (void)dyHomeHeaderBanner:(DYHomeHeaderBannerView*)banner clickedAtIndex:(NSInteger)index roomId:(NSString *)roomId;

@end

@interface DYHomeHeaderBannerView : UICollectionReusableView

@property (nonatomic, weak) id<DYHomeHeaderBannerViewDelegate> delegate;

- (void)fillWithBannerModels:(NSArray *)bannerModels;

+ (CGSize)sectionHeaderViewSize;

@end
