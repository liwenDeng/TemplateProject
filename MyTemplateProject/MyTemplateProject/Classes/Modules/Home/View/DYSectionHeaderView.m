//
//  DYSectionHeaderView.m
//  MyTemplateProject
//
//  Created by dengliwen on 16/8/3.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "DYSectionHeaderView.h"

#define kLineColor @"f3f1f4"
#define kArrowBtnTitleColor @"#8d8b8e"

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
    
    UIView *lineView = ({
        UIView *view = [[UIView alloc]init];
        [self addSubview:view];
        view.backgroundColor = [UIColor ms_colorWithHexString:kLineColor];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.equalTo(self);
            make.top.mas_equalTo(0);
            make.height.mas_equalTo(10);
        }];
        
        view;
    });
    
    _iconView = ({
        UIImageView *view = [[UIImageView alloc]init];
        [self addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.top.equalTo(lineView.mas_bottom).offset(10);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
        view.backgroundColor = [UIColor redColor];
        view;
    });
    
    _titleLabel = ({
        UILabel *view = [[UILabel alloc]init];
        [self addSubview:view];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        view.text = @"最热";
        [view sizeToFit];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_iconView.mas_right).offset(10);
            make.centerY.equalTo(_iconView);
        }];
        
        view;
    });
    
    _arrowBtn = ({
        UIButton *view = [[UIButton alloc]init];
        [self addSubview:view];
        [view setTitle:@"更多" forState:(UIControlStateNormal)];
        [view sizeToFit];
        [view setTitleColor:[UIColor ms_colorWithHexString:kArrowBtnTitleColor] forState:(UIControlStateNormal)];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-10);
            make.centerY.equalTo(_titleLabel);
        }];
        
        view;
    });
}

- (void)fillWithTagName:(NSString *)tagName {
    self.titleLabel.text = tagName;
}

+ (CGSize)sectionHeaderViewSize {
    return CGSizeMake(kSCREEN_WIDTH, 56);
}

@end
