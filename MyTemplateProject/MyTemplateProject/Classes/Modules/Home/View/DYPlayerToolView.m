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

@property (nonatomic, assign) UIEdgeInsets imageEdge;

@end

@implementation DYToolBtn

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.imageEdge = UIEdgeInsetsMake(4, 4, 4, 4);
    }
    return self;
}

- (UIEdgeInsets)imageEdgeInsets {
    return self.imageEdge;
}

@end

@interface DYPlayerNomalSizeToolView ()

@property (nonatomic, strong) DYToolBtn *pauseBtn;//暂停
@property (nonatomic, strong) DYToolBtn *fullSizeBtn;//全屏
@property (nonatomic, strong) DYToolBtn *backButton;

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

    self.backButton = ({
        DYToolBtn *btn = [[DYToolBtn alloc]init];
        [self addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10);
            make.top.equalTo(self).offset(10);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
        
        [btn setBackgroundColor:[UIColor blackColor]];
        btn.layer.cornerRadius = 15;
        btn.alpha = 0.8;
        [btn setImage:[UIImage imageNamed:@"back"] forState:(UIControlStateNormal)];
        [btn addTarget:self action:@selector(backBtnClicked:) forControlEvents:(UIControlEventTouchUpInside)];

        
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
        
        [btn setBackgroundColor:[UIColor blackColor]];
        btn.layer.cornerRadius = 15;
        btn.alpha = 0.8;
        [btn setImage:[UIImage imageNamed:@"fullscreen"] forState:(UIControlStateNormal)];
        
        [btn addTarget:self action:@selector(fullScreenBtnClicked:) forControlEvents:(UIControlEventTouchUpInside)];
        btn;
    });
    
    self.pauseBtn = ({
        DYToolBtn *btn = [[DYToolBtn alloc]init];
        [self addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-10);
            make.bottom.equalTo(self.fullSizeBtn.mas_top).offset(-20);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
        
        [btn setBackgroundColor:[UIColor blackColor]];
        btn.layer.cornerRadius = 15;
        btn.alpha = 0.8;
        [btn setImage:[UIImage imageNamed:@"pause"] forState:(UIControlStateNormal)];
        [btn setImage:[UIImage imageNamed:@"play"] forState:(UIControlStateSelected)];
        
        [btn addTarget:self action:@selector(pauseBtnClicked:) forControlEvents:(UIControlEventTouchUpInside)];
        
        btn;
    });
}

- (void)pauseBtnClicked:(DYToolBtn *)btn {
    btn.selected = !btn.selected;
    if ([self.delegate respondsToSelector:@selector(normalToolView:willPlay:)]) {
        [self.delegate normalToolView:self willPlay:!btn.selected];
    }
}

- (void)fullScreenBtnClicked:(DYToolBtn *)btn {
    if ([self.delegate respondsToSelector:@selector(normalToolViewClickedFullScreenBtn:)]) {
        [self.delegate normalToolViewClickedFullScreenBtn:self];
    }
}

- (void)backBtnClicked:(DYToolBtn *)btn {
    if ([self.delegate respondsToSelector:@selector(normalToolViewClickedBackBtn:)]) {
        [self.delegate normalToolViewClickedBackBtn:self];
    }
}

@end

@interface DYPlayerFullScreenSizeToolView ()

@property (nonatomic, strong) DYToolBtn *pauseBtn;//暂停
@property (nonatomic, strong) DYToolBtn *refreshBtn;//刷新
@property (nonatomic, strong) DYToolBtn *backButton;//返回到非全屏状态

@end

@implementation DYPlayerFullScreenSizeToolView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    self.backButton = ({
        DYToolBtn *btn = [[DYToolBtn alloc]init];
        [self addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10);
            make.top.equalTo(self).offset(10);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
        
        [btn setBackgroundColor:[UIColor blackColor]];
        btn.layer.cornerRadius = 15;
        btn.alpha = 0.8;
        [btn setImage:[UIImage imageNamed:@"back"] forState:(UIControlStateNormal)];
        [btn addTarget:self action:@selector(backBtnClicked:) forControlEvents:(UIControlEventTouchUpInside)];
        
        
        btn;
    });
    
    self.pauseBtn = ({
        DYToolBtn *btn = [[DYToolBtn alloc]init];
        [self addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.backButton);
            make.bottom.equalTo(self.mas_bottom).offset(-10);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
        
        [btn setBackgroundColor:[UIColor blackColor]];
        btn.layer.cornerRadius = 15;
        btn.alpha = 0.8;
        [btn setImage:[UIImage imageNamed:@"pause"] forState:(UIControlStateNormal)];
        [btn setImage:[UIImage imageNamed:@"play"] forState:(UIControlStateSelected)];
        
        [btn addTarget:self action:@selector(pauseBtnClicked:) forControlEvents:(UIControlEventTouchUpInside)];
        
        btn;
    });
    
    self.refreshBtn = ({
        DYToolBtn *btn = [[DYToolBtn alloc]init];
        btn.imageEdge = UIEdgeInsetsMake(4, 4, 4, 4);
        [self addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.pauseBtn.mas_right).offset(20);
            make.centerY.equalTo(self.pauseBtn);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
        
        [btn setBackgroundColor:[UIColor blackColor]];
        btn.layer.cornerRadius = 15;
        btn.alpha = 0.8;
        [btn setImage:[UIImage imageNamed:@"refresh"] forState:(UIControlStateNormal)];
        
        [btn addTarget:self action:@selector(refreshBtnClicked:) forControlEvents:(UIControlEventTouchUpInside)];
        
        btn;
    });
}

- (void)backBtnClicked:(DYToolBtn *)btn {

}

- (void)pauseBtnClicked:(DYToolBtn *)btn {
    btn.selected = !btn.selected;

}

- (void)refreshBtnClicked:(DYToolBtn *)btn {
    
}

@end

