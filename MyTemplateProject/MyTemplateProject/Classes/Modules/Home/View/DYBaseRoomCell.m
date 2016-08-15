//
//  DYBaseRoomCell.m
//  MyTemplateProject
//
//  Created by dengliwen on 16/8/12.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "DYBaseRoomCell.h"

@implementation DYBaseRoomCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
        [self updateSubViews];
    }
    return self;
}

- (void)setupViews {
    
    _titleLabel = ({
        UILabel *view = [[UILabel alloc]init];
        view.font = [UIFont systemFontOfSize:kTitleLabelFont];
        [self addSubview:view];
        view;
    });
    
    _iconView = ({
        UIImageView *view = [[UIImageView alloc]init];
        [self.contentView addSubview:view];
        view;
    });
    
}

- (void)updateSubViews {}

- (void)fillWithRoomModel:(DYRoomModel *)roomModel adIndexPath:(NSIndexPath *)indexPath {}

+ (CGSize)cellSize {
    return CGSizeZero;
}
@end
