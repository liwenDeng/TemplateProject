//
//  DYLiveRoomViewController.m
//  MyTemplateProject
//
//  Created by dengliwen on 16/8/15.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "DYLiveRoomViewController.h"
//#import <IJKMediaFramework/IJKMediaFramework.h>
#import "OCGumbo+Query.h"
#import "OCGumbo.h"

#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

@interface DYLiveRoomViewController () <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;
//尝试解析videoSrc的此时，当尝试超过3次后，显示webView代替原生player
@property (nonatomic, assign) NSInteger tryParseCount;

@property (atomic, strong) NSURL *url;
//@property (atomic, retain) id <IJKMediaPlayback> player;
@property (weak, nonatomic) UIView *playerView;

@property (nonatomic,strong)AVPlayer *avPlayer;

@end

@implementation DYLiveRoomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"直播";
    self.tryParseCount = 0;
    
    [self setupWebView];
    [self setupPlayerHolderView];
}

- (void)setupWebView {
    //http://www.douyu.com/441868
    self.webView = [[UIWebView alloc]init];
    [self.view addSubview:self.webView];
    self.webView.backgroundColor = [UIColor grayColor];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.webView.hidden = YES;
    
    NSString *urlString = [NSString stringWithFormat:@"http://m.douyu.com/%@",self.roomId];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [self.webView loadRequest:request];
    self.webView.delegate = self;
}

/**
 *  播放器的占位图
 */
- (void)setupPlayerHolderView {
    UIView *displayView = [[UIView alloc] init];
    self.playerView = displayView;
    self.playerView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.playerView];
    
    [self.playerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuideBottom);
        make.left.width.equalTo(self.view);
        make.height.equalTo(self.playerView.mas_width).multipliedBy(kSCREEN_WIDTH/kSCREENH_HEIGHT);
    }];
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    NSLog(@"webViewStart");
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"webViewLoadFinished");
    
    [self performSelector:@selector(parsePlayerUrl) withObject:nil afterDelay:0.5];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"webViewFailed");
}

/**
 *  解析html中的video元素
 */
- (void)parsePlayerUrl {
    
    self.tryParseCount++;
    BOOL ret = false;
    
    //尝试三次解析，解析失败则显示webView
    NSString *htmlStr = [self.webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('html')[0].innerHTML"];
    NSLog(@"current--->htmlStr:%@",htmlStr);
    //解析,需要对每一个节点判断是否为nil,否则可能会导致崩溃
    OCGumboDocument *document = [[OCGumboDocument alloc]initWithHTMLString:htmlStr];
    OCGumboElement *videoElememt = document.Query(@"body").find(@"#dy-video-player").firstObject;
    if (videoElememt) {
        NSString *src = videoElememt.attr(@"src");
        if (src) {
            NSLog(@"videoUrl:%@",src);
            [self.webView stopLoading];
            ret = YES;
            //获取到了videoSrc
//            [self loadPlayerWithVideoSrc:src];
            [self loadAVPlayer:src];
        }
    }
    
    if (self.tryParseCount > 3) {
        //解析失败，显示webView
        self.webView.hidden = NO;
        return;
    }
    
    if (!ret) {
        [self performSelector:@selector(parsePlayerUrl) withObject:nil afterDelay:0.5];
    }
}

//- (void)loadPlayerWithVideoSrc:(NSString *)src {
//    self.url = [NSURL URLWithString:src];
//    _player = [[IJKFFMoviePlayerController alloc] initWithContentURL:self.url withOptions:nil];
//    
//    UIView *playerView = [self.player view];
//    
//    playerView.frame = self.playerView.bounds;
//    playerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    
//    [self.playerView insertSubview:playerView atIndex:1];
//    [_player setScalingMode:IJKMPMovieScalingModeAspectFill];
//    
//    if (![self.player isPlaying]) {
//        [self.player prepareToPlay];
//    }
//}

- (void)loadAVPlayer:(NSString *)src {
    NSURL *url = [NSURL URLWithString:src];
    //设置播放的项目
    AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:url];
    self.avPlayer = [[AVPlayer alloc] initWithPlayerItem:item];
    AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:self.avPlayer];
    
    layer.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 300);
    layer.backgroundColor = [UIColor cyanColor].CGColor;
    layer.videoGravity = AVLayerVideoGravityResizeAspect;
    //添加播放视图到self.view
    [self.view.layer addSublayer:layer];
    
    [self.avPlayer play];
    
    
}

@end
