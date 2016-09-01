//
//  DYHomeHeaderBannerCell.m
//  MyTemplateProject
//
//  Created by dengliwen on 16/8/30.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "DYHomeHeaderBannerView.h"
#import "MSCircleView.h"

static const CGFloat kBannerHeight = 140;
static const CGFloat kPageControlHeight = 30;

@interface DYBannerCell : MSCircleBaseCell

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation DYBannerCell

- (void)setupSubviews {
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, kBannerHeight - kPageControlHeight, kSCREEN_WIDTH, kPageControlHeight)];
    [self.contentView addSubview:bgView];
    bgView.backgroundColor = [UIColor blackColor];
    bgView.alpha = 0.7;
    
    self.titleLabel = [[UILabel alloc]init];
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.height.mas_equalTo(kPageControlHeight);
        make.bottom.equalTo(self.contentView);
    }];
    self.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.textColor = [UIColor whiteColor];
    
    [self.imaView setContentMode:(UIViewContentModeScaleAspectFill)];
}

@end

@interface DYHomeHeaderBannerView ()

@property (nonatomic, strong) MSCircleView *circleView;
@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation DYHomeHeaderBannerView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor redColor];
        _circleView = [MSCircleView circleViewWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kBannerHeight) urlImageArray:nil];
        _circleView.backgroundColor = [UIColor whiteColor];
        _circleView.cellClass = [DYBannerCell class];
        
        [self addSubview:_circleView];
        [_circleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        _circleView.autoScroll = YES;
        
        _pageControl = [[UIPageControl alloc]init];
        [self addSubview:_pageControl];
        _pageControl.numberOfPages = 0;
        [_pageControl sizeToFit];
        [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self.mas_right).offset(-10);
            make.height.mas_equalTo(kPageControlHeight);
            make.bottom.equalTo(self);
        }];
        _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
        _pageControl.backgroundColor = [UIColor clearColor];
        _pageControl.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    return self;
}

- (void)fillWithBannerModels:(NSArray *)bannerModels {
    NSMutableArray *urls = [NSMutableArray array];
    for (DYBannerModel *bannerModel in bannerModels) {
        [urls addObject:bannerModel.pic_url];
    }
    self.circleView.imageArray = urls;
    
    self.pageControl.numberOfPages = urls.count;
    __weak typeof (self)weakSelf = self;
    [self.circleView addPageScrollBlock:^(NSInteger index) {
        weakSelf.pageControl.currentPage = index;
    }];
    
    [self.circleView configCustomCell:^(MSCircleBaseCell *customCell, NSInteger index) {
        DYBannerCell *cell = (DYBannerCell *)customCell;
        DYBannerModel *bannerModel = bannerModels[index];
        cell.titleLabel.text = bannerModel.title;
    }];
    
    [self.circleView addTapBlock:^(NSInteger index) {
        if ([weakSelf.delegate respondsToSelector:@selector(dyHomeHeaderBanner:clickedAtIndex:roomId:)]) {
            DYBannerModel *bannerModel = bannerModels[index];
            [weakSelf.delegate dyHomeHeaderBanner:weakSelf clickedAtIndex:index roomId:bannerModel.roomId];
        }
    }];
}

+ (CGSize)sectionHeaderViewSize {
    return CGSizeMake(kSCREEN_WIDTH, kBannerHeight);
}

@end

