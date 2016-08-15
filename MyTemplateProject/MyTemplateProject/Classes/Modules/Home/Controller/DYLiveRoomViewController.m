//
//  DYLiveRoomViewController.m
//  MyTemplateProject
//
//  Created by dengliwen on 16/8/15.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "DYLiveRoomViewController.h"
//#import <WebKit/WebKit.h>
@interface DYLiveRoomViewController ()

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation DYLiveRoomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"直播";
    //http://www.douyu.com/441868
    self.webView = [[UIWebView alloc]init];
    [self.view addSubview:self.webView];
    self.webView.backgroundColor = [UIColor grayColor];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self);
        make.width.equalTo(self);
        make.height.equalTo(self.webView.mas_height).multipliedBy(kSCREEN_WIDTH/kSCREENH_HEIGHT);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
