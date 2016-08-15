//
//  DYFaceRoomCell.m
//  MyTemplateProject
//
//  Created by dengliwen on 16/8/12.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "DYFaceRoomCell.h"

#define kTitleLabelFont 14.0f
#define kCityLabelFont 12.0f

@interface DYFaceRoomCell ()

@property (nonatomic, strong) UILabel* cityLabel;

@end

@implementation DYFaceRoomCell

- (void)updateSubViews {
    
    self.cityLabel = ({
        UILabel *label = [[UILabel alloc]init];
        label.font = [UIFont systemFontOfSize:kCityLabelFont];
        [label setTextColor:[UIColor grayColor]];
        [self.contentView addSubview:label];
        label.text = @"成都市";
        label;
    });
    
    self.titleLabel.text = @"微笑：寒冰女刀 无限上分";
    self.titleLabel.font = [UIFont systemFontOfSize:kTitleLabelFont];
    [self.titleLabel sizeToFit];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.top.equalTo(self.iconView.mas_bottom).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-2);
    }];
    
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.contentView);
        make.top.equalTo(self.contentView);
        make.height.equalTo(self.iconView.mas_width);
    }];
    
    [self.cityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_lessThanOrEqualTo(self.contentView);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
    }];
    
    //设置圆角
    [self.iconView zy_cornerRadiusAdvance:10 rectCornerType:(UIRectCornerAllCorners)];
    [self.iconView setContentMode:(UIViewContentModeScaleAspectFit)];
}

- (void)fillWithRoomModel:(DYRoomModel *)roomModel adIndexPath:(NSIndexPath *)indexPath {
    self.titleLabel.text = roomModel.room_name;
    [self.titleLabel sizeToFit];
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:roomModel.vertical_src]];
}

+ (CGSize)cellSize {
    return CGSizeMake(kItemWidth, kItemWidth + 35 + kTitleLabelFont + kCityLabelFont);
}

@end
