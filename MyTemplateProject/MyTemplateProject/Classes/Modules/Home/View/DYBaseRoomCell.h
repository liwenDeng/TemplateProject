//
//  DYBaseRoomCell.h
//  MyTemplateProject
//
//  Created by dengliwen on 16/8/12.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+CornerRadius.h"
#import "DYRoomModel.h"

#define kItemWidth (kSCREEN_WIDTH - 30 ) / 2.0
#define kItemHeight (kItemWidth * 7.0 / 9.0)
#define kTitleLabelFont 12.0f

@interface DYBaseRoomCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *arrowBtn;

- (void)updateSubViews;
- (void)fillWithRoomModel:(DYRoomModel *)roomModel adIndexPath:(NSIndexPath *)indexPath;

+ (CGSize)cellSize;

@end
