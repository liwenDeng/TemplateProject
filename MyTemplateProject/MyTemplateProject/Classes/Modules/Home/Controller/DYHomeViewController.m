//
//  DYHomeViewController.m
//  MyTemplateProject
//
//  Created by dengliwen on 16/8/2.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "DYHomeViewController.h"
#import "DYFaceRoomModel.h"
#import "DYRoomModel.h"
#import "DYRoomModelList.h"

@interface DYHomeViewController ()

@end

@implementation DYHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)requestData {
    [MSNetworking getDouyuHomeHotInfos:^(NSDictionary *object) {
        DYRoomModel *model = [DYRoomModel yy_modelWithDictionary:object];
    } failure:^(NSError *error) {
        
    }];
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
