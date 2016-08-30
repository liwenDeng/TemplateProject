//
//  DYHomeHeaderBannerCell.m
//  MyTemplateProject
//
//  Created by dengliwen on 16/8/30.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "DYHomeHeaderBannerView.h"
#import "MSCircleView.h"

static const CGFloat kBannerHeight = 120;

@interface DYHomeHeaderBannerView ()

@property (nonatomic, strong) MSCircleView *circleView;

@end

@implementation DYHomeHeaderBannerView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor redColor];
        _circleView = [MSCircleView circleViewWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kBannerHeight) urlImageArray:nil];
        _circleView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_circleView];
        [_circleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        _circleView.autoScroll = YES;
    }
    return self;
}

- (void)fillWithBannerModels:(NSArray *)bannerModels {
    NSMutableArray *urls = [NSMutableArray array];
    for (DYBannerModel *bannerModel in bannerModels) {
        [urls addObject:bannerModel.tv_pic_url];
    }
    self.circleView.imageArray = urls;
}

+ (CGSize)sectionHeaderViewSize {
    return CGSizeMake(kSCREEN_WIDTH, kBannerHeight);
}

@end
