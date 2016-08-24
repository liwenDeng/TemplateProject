//
//  DYLiveRoomViewController.m
//  MyTemplateProject
//
//  Created by dengliwen on 16/8/15.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "DYLiveRoomViewController.h"
#import "OCGumbo+Query.h"
#import "OCGumbo.h"

#import "DYRoomPlyaerView.h"

@interface DYLiveRoomViewController () <UIWebViewDelegate,DYRoomPlyaerViewDelegate>

@property (nonatomic, strong) UIWebView *webView;
//尝试解析videoSrc的此时，当尝试超过3次后，显示webView代替原生player
@property (nonatomic, assign) NSInteger tryParseCount;
@property (nonatomic, strong) DYRoomPlyaerView *playerView;

@end

@implementation DYLiveRoomViewController

- (void)dealloc {
    NSLog(@"room dealloc");
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"直播";
    self.tryParseCount = 0;
    
    self.navigationItem.hidesBackButton = YES;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id) self;
    
    self.view.backgroundColor = [UIColor whiteColor];

    //创建播放器占位图
    [self setupPlayerHolderView];
    [self requestRoomVideoSrc];

}

// 获取播放信息
- (void)requestRoomVideoSrc {
    // 获取video source
    [MSNetworking getDouyuRoomLiveInfo:self.roomModel.room_id success:^(NSDictionary *object) {
        NSString *rtmp_live = object[@"data"][@"rtmp_live"];
        NSString *url = object[@"data"][@"rtmp_url"];
        NSString *src = [NSString stringWithFormat:@"%@/%@",url,rtmp_live];
        NSLog(@"video src:%@",src);
        [self loadPlayer:src];
    } failure:^(NSError *error) {
        
    }];
}

//// 设置状态栏
//- (UIStatusBarStyle)preferredStatusBarStyle {
//    return UIStatusBarStyleLightContent;
//}

- (void)setupWebView {
    //http://www.douyu.com/441868
    self.webView = [[UIWebView alloc]init];
    [self.view addSubview:self.webView];
    self.webView.backgroundColor = [UIColor grayColor];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.webView.hidden = YES;
    
    NSString *urlString = [NSString stringWithFormat:@"http://m.douyu.com/%@",self.roomModel.room_id];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [self.webView loadRequest:request];
    self.webView.delegate = self;
}

/**
 *  播放器的占位图
 */
- (void)setupPlayerHolderView {

    self.playerView = [[DYRoomPlyaerView alloc]init];
    self.playerView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.playerView];
    if (self.roomModel.isVertical) {
        [self.playerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }else {
        [self.playerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_topLayoutGuideBottom);
            make.left.width.equalTo(self.view);
            make.height.equalTo(self.playerView.mas_width).multipliedBy(kSCREEN_WIDTH/kSCREENH_HEIGHT);
        }];
    }
    self.playerView.delegate = self;
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
            [self loadPlayer:src];
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

- (void)loadPlayer:(NSString *)src {
    [self.playerView playWithVideoSrc:src];

}

#pragma mark - DYRoomPlyaerViewDelegate
- (void)dyPlayerView:(DYRoomPlyaerView *)view rotateState:(PlayerViewRotateState)state {
    self.playerView.backgroundColor = [UIColor grayColor];
    switch (state) {
        case PlayerViewRotateFullScreenSize:
        {
            //http://www.jianshu.com/p/fd7f30de5d42
            NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeLeft];
            [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
            [UIViewController attemptRotationToDeviceOrientation];
        }
            break;
        case PlayerViewRotateNomalSize:
        {
            NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
            [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
            [UIViewController attemptRotationToDeviceOrientation];
        }
            break;
    }
}

- (void)dyPlayerViewRefreshButtonClicked:(DYRoomPlyaerView *)view {
    [self requestRoomVideoSrc];
}

- (void)dyPlayerViewBackButtonClicked:(DYRoomPlyaerView *)view {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 屏幕旋转时，需要隐藏toolView
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        [self.playerView showNomalToolView:NO];
    } else {
        [self.playerView showNomalToolView:YES];
    }
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    //当前支持的旋转类型
    if (self.roomModel.isVertical) {
        return UIInterfaceOrientationMaskPortrait;
    }
    return UIInterfaceOrientationMaskAll;
}

- (BOOL)shouldAutorotate
{
    // 是否支持旋转
    if (self.roomModel.isVertical) {
        return NO;
    }
    return YES;
}

@end
