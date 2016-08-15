//
//  DYRoomCell.m
//  MyTemplateProject
//
//  Created by dengliwen on 16/8/3.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "DYRoomCell.h"


@interface DYRoomCell ()

@end

@implementation DYRoomCell

//- (instancetype)initWithFrame:(CGRect)frame {
//    if (self = [super initWithFrame:frame]) {
//        [self updateSubViews];
//    }
//    return self;
//}

- (void)updateSubViews {
    self.titleLabel.text = @"微笑：寒冰女刀 无限上分";
    [self.titleLabel sizeToFit];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.bottom.equalTo(self.contentView).offset(-15);
        make.right.equalTo(self.contentView.mas_right).offset(-2);
    }];

    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.contentView);
        make.top.equalTo(self.contentView);
        make.bottom.equalTo(self.titleLabel.mas_top).offset(-5);
    }];
    //设置圆角
    [self.iconView zy_cornerRadiusAdvance:10 rectCornerType:(UIRectCornerAllCorners)];

}

- (void)fillWithRoomModel:(DYRoomModel *)roomModel adIndexPath:(NSIndexPath *)indexPath {
    self.titleLabel.text = roomModel.room_name;
    [self.titleLabel sizeToFit];
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:roomModel.room_src]];
}

+ (CGSize)cellSize {
    return CGSizeMake(kItemWidth, kItemHeight);
}

@end
