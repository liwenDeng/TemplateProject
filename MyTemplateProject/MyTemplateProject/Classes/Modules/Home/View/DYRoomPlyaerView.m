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
#import <IJKMediaFramework/IJKMediaFramework.h>

#import "DYPlayerToolView.h"

#define kUseIJKMedia YES

@interface DYRoomPlyaerView ()

// IJKKMedia
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) id <IJKMediaPlayback> IJKPlayer;
@property (nonatomic, weak) UIView *IJKMediaPlayerView;

//AVPlayer
@property (nonatomic, strong) AVPlayer *avPlayer;
@property (nonatomic, strong) AVPlayerLayer *avPlayerLayer;

@property (nonatomic, strong) DYPlayerNomalSizeToolView *nomalToolView;

@end

@implementation DYRoomPlyaerView

- (void)dealloc {
    NSLog(@"playerview dealloc");
    [self.IJKPlayer shutdown];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    self.backgroundColor = [UIColor redColor];
    self.nomalToolView = [[DYPlayerNomalSizeToolView alloc]init];
    [self addSubview:self.nomalToolView];
    [self.nomalToolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
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
    self.url = [NSURL URLWithString:src];
    self.IJKPlayer = [[IJKFFMoviePlayerController alloc] initWithContentURL:self.url withOptions:nil];

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
    //    self.avPlayerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    //添加播放视图到self.view
    [self.layer addSublayer:self.avPlayerLayer];
    [self.avPlayer play];
}


@end
