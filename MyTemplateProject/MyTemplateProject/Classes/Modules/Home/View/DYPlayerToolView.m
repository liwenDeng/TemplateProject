//
//  DYPlayerToolView.m
//  MyTemplateProject
//
//  Created by dengliwen on 16/8/17.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "DYPlayerToolView.h"
#define kBackColor @"#392e21"

@interface DYToolBtn : UIButton

@end

@implementation DYToolBtn

- (UIEdgeInsets)imageEdgeInsets {
    return UIEdgeInsetsMake(6, 4, 6, 4);
}

@end

@interface DYPlayerNomalSizeToolView ()

@property (nonatomic, strong) DYToolBtn *pauseBtn;//暂停
@property (nonatomic, strong) DYToolBtn *fullSizeBtn;//全屏

@end

@implementation DYPlayerNomalSizeToolView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    self.backgroundColor = [UIColor clearColor];
    self.pauseBtn = ({
        DYToolBtn *btn = [[DYToolBtn alloc]init];
        [self addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-10);
            make.centerY.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
        
        [btn setBackgroundColor:[UIColor ms_colorWithHexString:kBackColor]];
        btn.layer.cornerRadius = 15;
        btn.alpha = 0.6;
        [btn setImage:[UIImage imageNamed:@"pause"] forState:(UIControlStateNormal)];
        
        btn;
    });
    
    self.fullSizeBtn = ({
        DYToolBtn *btn = [[DYToolBtn alloc]init];
        [self addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-10);
            make.bottom.equalTo(self.mas_bottom).offset(-5);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
        
        [btn setBackgroundColor:[UIColor ms_colorWithHexString:kBackColor]];
        btn.layer.cornerRadius = 15;
        btn.alpha = 0.6;
        [btn setImage:[UIImage imageNamed:@"fullscreen"] forState:(UIControlStateNormal)];
        btn;
    });
}

@end


@implementation DYPlayerFullScreenSizeToolView



@end

