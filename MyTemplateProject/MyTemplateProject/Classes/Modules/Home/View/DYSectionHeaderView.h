//
//  DYSectionHeaderView.h
//  MyTemplateProject
//
//  Created by dengliwen on 16/8/3.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DYSectionHeaderView;
@protocol DYSectionHeaderViewDelegate <NSObject>

- (void)dySectionHeaderView:(DYSectionHeaderView *)sectionHeaderView clickedMoreButtonAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface DYSectionHeaderView : UICollectionReusableView

@property (nonatomic, weak) id<DYSectionHeaderViewDelegate> delegate;

- (void)fillWithTagName:(NSString *)tagName atIndexPath:(NSIndexPath *)indexPath;

+ (CGSize)sectionHeaderViewSize;

@end
