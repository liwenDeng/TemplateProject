//
//  DYRoomPlyaerView.m
//  MyTemplateProject
//
//  Created by dengliwen on 16/8/17.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "DYRoomPlyaerView.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import "IJKMediaFramework/IJKMediaFramework.h"

#import "DYPlayerToolView.h"

#define kUseIJKMedia YES

@interface DYRoomPlyaerView () <DYPlayerNomalSizeToolViewDelegate,DYPlayerFullScreenSizeToolViewDelegate>

// IJKKMedia
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) id <IJKMediaPlayback> IJKPlayer;
@property (nonatomic, weak) UIView *IJKMediaPlayerView;

//AVPlayer
@property (nonatomic, strong) AVPlayer *avPlayer;
@property (nonatomic, strong) AVPlayerLayer *avPlayerLayer;

//toolView
@property (nonatomic, strong) DYPlayerNomalSizeToolView *nomalToolView;
@property (nonatomic, strong) DYPlayerFullScreenSizeToolView *fullToolView;

@end

@implementation DYRoomPlyaerView

- (void)dealloc {
    NSLog(@"playerview dealloc");
    if (kUseIJKMedia) {
        [self.IJKPlayer pause];
        [self.IJKPlayer shutdown];
    }
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubViews];
        self.rotateState = PlayerViewRotateNomalSize;
        self.lockState = PlayerViewUnLocked;
    }
    return self;
}

- (void)setupSubViews {
    //toolview
    self.nomalToolView = ({
        DYPlayerNomalSizeToolView *view = [[DYPlayerNomalSizeToolView alloc]init];
        [self addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        view.delegate = self;
        view;
    });

    
    self.fullToolView = ({
        DYPlayerFullScreenSizeToolView *view = [[DYPlayerFullScreenSizeToolView alloc]init];
        [self addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        view.delegate = self;
        view;
    });
    
    self.fullToolView.hidden = YES;
    self.nomalToolView.hidden = NO;
    
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(playerViewTaped:)];
    [self addGestureRecognizer:tap];
}

- (void)playWithVideoSrc:(NSString *)src {
    if (kUseIJKMedia) {
        [self setupIJKPlayerWithVideoSrc:src];
    }else {
        [self setupAVPlayerWithVideoSrc:src];
    }
}

- (void)layoutSubviews {
    if (kUseIJKMedia) {
        self.IJKMediaPlayerView.frame = self.bounds;
    }
    else {
        self.avPlayerLayer.frame = self.bounds;
    }
}

- (void)setupIJKPlayerWithVideoSrc:(NSString *)src {
    
    if (self.IJKPlayer) {
        [self.IJKPlayer pause];
        [self.IJKPlayer shutdown];
        self.IJKPlayer = nil;
        [self.IJKMediaPlayerView removeFromSuperview];
    }
    self.url = [NSURL URLWithString:src];
    self.IJKPlayer = [[IJKFFMoviePlayerController alloc] initWithContentURL:self.url withOptions:nil];
    self.IJKPlayer.scalingMode = IJKMPMovieScalingModeAspectFit;
    
    self.IJKMediaPlayerView = [self.IJKPlayer view];
    self.IJKMediaPlayerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.IJKMediaPlayerView.frame = self.bounds;

    [self insertSubview:self.IJKMediaPlayerView belowSubview:self.nomalToolView];
    
    [self.IJKPlayer setScalingMode:IJKMPMovieScalingModeAspectFill];
    if (![self.IJKPlayer isPlaying]) {
        [self.IJKPlayer prepareToPlay];
    }
}

- (void)setupAVPlayerWithVideoSrc:(NSString *)src {
    NSURL *url = [NSURL URLWithString:src];
    //设置播放的项目
    AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:url];
    self.avPlayer = [[AVPlayer alloc] initWithPlayerItem:item];
    self.avPlayerLayer = [AVPlayerLayer playerLayerWithPlayer:self.avPlayer];
    
    self.avPlayerLayer.frame = self.bounds;
    self.avPlayerLayer.backgroundColor = [UIColor blackColor].CGColor;
    self.avPlayerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    //添加播放视图到self.view
    [self.layer insertSublayer:self.avPlayerLayer atIndex:0];

    [self.avPlayer play];
}

- (void)playerViewTaped:(UITapGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateEnded) {
        if (self.rotateState == PlayerViewRotateFullScreenSize) {
            self.fullToolView.hidden = !self.fullToolView.hidden;
        }else {
            self.nomalToolView.hidden = !self.nomalToolView.hidden;
        }
    }
}

- (void)showNomalToolView:(BOOL)show {
    [self.nomalToolView setHidden:!show];
    [self.fullToolView setHidden:show];
    self.rotateState = show ? PlayerViewRotateNomalSize : PlayerViewRotateFullScreenSize;
}

#pragma mark - DYPlayerNomalSizeToolViewDelegate
- (void)normalToolView:(DYPlayerNomalSizeToolView *)toolView willPlay:(BOOL)willPlay {
    if (willPlay) {
        if (kUseIJKMedia) {
            [self.IJKPlayer play];
        }else {
            [self.avPlayer play];
        }
    }else {
        if (kUseIJKMedia) {
            [self.IJKPlayer pause];
        }else {
            [self.avPlayer pause];
        }
    }
}

- (void)normalToolViewClickedBackBtn:(DYPlayerNomalSizeToolView *)toolView {
    if ([self.delegate respondsToSelector:@selector(dyPlayerViewBackButtonClicked:)]) {
        [self.delegate dyPlayerViewBackButtonClicked:self];
    }
}

- (void)normalToolViewClickedFullScreenBtn:(DYPlayerNomalSizeToolView *)toolView {
    if (self.rotateState == PlayerViewRotateNomalSize) {
        self.rotateState = PlayerViewRotateFullScreenSize;
        self.nomalToolView.hidden = YES;
        self.fullToolView.hidden = NO;
    }else {
        self.rotateState = PlayerViewRotateNomalSize;
    }
    if ([self.delegate respondsToSelector:@selector(dyPlayerView:rotateState:)]) {
        [self.delegate dyPlayerView:self rotateState:self.rotateState];
    }
}

#pragma mark - DYPlayerFullScreenSizeToolViewDelegate
- (void)fullSizeToolViewClickedRefreshBtn:(DYPlayerFullScreenSizeToolView *)toolView {
    if ([self.delegate respondsToSelector:@selector(dyPlayerViewRefreshButtonClicked:)]) {
        [self.delegate dyPlayerViewRefreshButtonClicked:self];
    }
}

- (void)fullSizeToolView:(DYPlayerFullScreenSizeToolView *)toolView willPlay:(BOOL)willPlay {
    if (willPlay) {
        if (kUseIJKMedia) {
            [self.IJKPlayer play];
        }else {
            [self.avPlayer play];
        }
    }else {
        if (kUseIJKMedia) {
            [self.IJKPlayer pause];
        }else {
            [self.avPlayer pause];
        }
    }
}

- (void)fullSizeToolViewClickedBackBtn:(DYPlayerFullScreenSizeToolView *)toolView {
    if (self.rotateState == PlayerViewRotateFullScreenSize) {
        self.rotateState = PlayerViewRotateNomalSize;
        self.nomalToolView.hidden = NO;
        self.fullToolView.hidden = YES;
    }else {
        self.rotateState = PlayerViewRotateNomalSize;
    }
    if ([self.delegate respondsToSelector:@selector(dyPlayerView:rotateState:)]) {
        [self.delegate dyPlayerView:self rotateState:self.rotateState];
    }
}

@end
