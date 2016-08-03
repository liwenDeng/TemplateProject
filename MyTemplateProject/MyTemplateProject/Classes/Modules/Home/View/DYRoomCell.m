//
//  DYRoomCell.m
//  MyTemplateProject
//
//  Created by dengliwen on 16/8/3.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "DYRoomCell.h"

@interface DYRoomCell ()

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *arrowBtn;

@end

@implementation DYRoomCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    
    _titleLabel = ({
        UILabel *view = [[UILabel alloc]init];
        [self addSubview:view];
        view.text = @"微笑：寒冰女刀 无限上分";
        [view sizeToFit];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(5);
            make.bottom.equalTo(self);
            make.right.equalTo(self);
        }];
        
        view;
    });
    
    _iconView = ({
        UIImageView *view = [[UIImageView alloc]init];
        [self addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(5);
            make.top.equalTo(self);
            make.right.equalTo(self).offset(-5);
            make.bottom.equalTo(_titleLabel.mas_top);
        }];
        view.backgroundColor = [UIColor redColor];
        view;
    });
        
//    _arrowBtn = ({
//        UIButton *view = [[UIButton alloc]init];
//        [self addSubview:view];
//        [view setTitle:@"更多" forState:(UIControlStateNormal)];
//        [view sizeToFit];
//        [view mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(self).offset(-10);
//            make.top.equalTo(self);
//        }];
//        
//        view;
//    });
}

- (void)fillWithRoomModel:(DYRoomModel *)roomModel {
    self.titleLabel.text = roomModel.room_name;
    [self.titleLabel sizeToFit];
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:roomModel.room_src]];
}

@end
