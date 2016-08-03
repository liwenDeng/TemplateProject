//
//  DYSectionHeaderView.m
//  MyTemplateProject
//
//  Created by dengliwen on 16/8/3.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "DYSectionHeaderView.h"

@interface DYSectionHeaderView ()

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *arrowBtn;

@end

@implementation DYSectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    _iconView = ({
        UIImageView *view = [[UIImageView alloc]init];
        [self addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(5);
            make.top.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(10, 10));
        }];
        view.backgroundColor = [UIColor redColor];
        view;
    });
    
    _titleLabel = ({
        UILabel *view = [[UILabel alloc]init];
        [self addSubview:view];
        view.text = @"最热";
        [view sizeToFit];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(_iconView.mas_right).offset(10);
            make.top.equalTo(self);
        }];
        
        view;
    });
    
    _arrowBtn = ({
        UIButton *view = [[UIButton alloc]init];
        [self addSubview:view];
        [view setTitle:@"更多" forState:(UIControlStateNormal)];
        [view sizeToFit];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-10);
            make.top.equalTo(self);
        }];
        
        view;
    });
}

@end
