//
//  ViewController.m
//  MyTemplateProject
//
//  Created by dengliwen on 16/6/24.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+MSJSON.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    [self setupLocalNoti];
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeSystem)];
    [btn setTitle:@"LocalPush" forState:(UIControlStateNormal)];
    [btn sizeToFit];
    btn.center = self.view.center;
    [btn addTarget:self action:@selector(setupLocalNoti) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn];
}

- (void)setupLocalNoti {
    UILocalNotification *localNote = [[UILocalNotification alloc]init];
    localNote.fireDate = [NSDate dateWithTimeIntervalSinceNow:5];
    
    localNote.alertAction = @"alertAction:一条本地推送";
    localNote.applicationIconBadgeNumber = [UIApplication sharedApplication].applicationIconBadgeNumber ++;
    localNote.alertBody = @"body啊";
    localNote.alertTitle = @"titile啊";
    localNote.userInfo = @{@"title":@"titleValue",
                           @"body":@"bodyValue"};
    
    [[UIApplication sharedApplication]scheduleLocalNotification:localNote];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
