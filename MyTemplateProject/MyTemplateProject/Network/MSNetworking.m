//
//  MSNetworking.m
//  MyTemplateProject
//
//  Created by dengliwen on 16/6/28.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "MSNetworking.h"

@implementation MSNetworking

+ (NSURLSessionDataTask *)requestSomethingWithSuccess:(MSSuccessBlock)success failure:(MSFailureBlock)failure {
    ZCApiAction *action = [[ZCApiAction alloc] initWithURL:@"api/api_open.php"];
    //参数
    action.params[@"a"] = @"user_login_report";
    action.params[@"appname"] = @"baisishequ";
    action.params[@"c"] = @"user";
    action.params[@"client"] = @"iphone";
    
    //可选属性
    action.showLog = YES;
    action.actionWillInvokeBlock = ^{
        NSLog(@"will start");
    };
    
    action.actionDidInvokeBlock = ^(BOOL isSuccess) {
        if (isSuccess) {
            NSLog(@"success");
        }
        else {
            NSLog(@"failure");
        }
    };
    
    return [[ZCApiRunner sharedInstance] runAction:action success:^(id object) {
        success(object);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

#pragma mark - 斗鱼API
+ (NSURLSessionDataTask *)getAllDouyuLive:(NSInteger)limit offset:(NSInteger)offset WithSuccess:(MSSuccessBlock)success failure:(MSFailureBlock)failure{
    ZCApiAction *action = [[ZCApiAction alloc]initWithURL:@"http://capi.douyucdn.cn/api/v1/live"];
    
    action.params[@"limit"] = @(limit);
    action.params[@"offset"] = @(offset);
    
    
    //可选属性
//    action.showLog = YES;
//    action.actionWillInvokeBlock = ^{
//        NSLog(@"will start");
//    };
//    
//    action.actionDidInvokeBlock = ^(BOOL isSuccess) {
//        if (isSuccess) {
//            NSLog(@"success");
//        }
//        else {
//            NSLog(@"failure");
//        }
//    };
    
    return [[ZCApiRunner sharedInstance] runAction:action success:^(id object) {
        success(object);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

+ (NSURLSessionDataTask *)getDouyuColumnList:(MSSuccessBlock)success failure:(MSFailureBlock)failure {
    ZCApiAction *action = [[ZCApiAction alloc]initWithURL:@"http://capi.douyucdn.cn/api/v1/getColumnList"];

    //可选属性
    //    action.showLog = YES;
    //    action.actionWillInvokeBlock = ^{
    //        NSLog(@"will start");
    //    };
    //
    //    action.actionDidInvokeBlock = ^(BOOL isSuccess) {
    //        if (isSuccess) {
    //            NSLog(@"success");
    //        }
    //        else {
    //            NSLog(@"failure");
    //        }
    //    };
    
    return [[ZCApiRunner sharedInstance] runAction:action success:^(id object) {
        success(object);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//1.
+ (NSURLSessionDataTask *)getDouyuHomeHotInfos:(MSSuccessBlock)success failure:(MSFailureBlock)failure {
    
    //http://capi.douyucdn.cn/api/v1/getbigDataRoom?aid=android1&client_sys=android&time=1468074120&token=5082405_b1c24e33bf3db5b4&auth=8885837426ded0275f826f300dbd6487
    ZCApiAction *action = [[ZCApiAction alloc]initWithURL:@"http://capi.douyucdn.cn/api/v1/getbigDataRoom"];
    action.params[@"aid"] = @"android1";
    action.params[@"client_sys"] = @"android";
    NSTimeInterval time = [[NSDate date]timeIntervalSince1970];
    action.params[@"time"] = [NSString stringWithFormat:@"%f",time];
    
    return [[ZCApiRunner sharedInstance] runAction:action success:^(id object) {
        success(object);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//2.
+ (NSURLSessionDataTask *)getDouyuHomeFaceInfos:(MSSuccessBlock)success failure:(MSFailureBlock)failure {
    //http://capi.douyucdn.cn/api/v1/getVerticalRoom?aid=android1&client_sys=android&limit=4&offset=0&time=1468074120&auth=461dc91817f22ef364459445078c38e5
    ZCApiAction *action = [[ZCApiAction alloc]initWithURL:@"http://capi.douyucdn.cn/api/v1/getVerticalRoom"];
    action.params[@"aid"] = @"android1";
    action.params[@"client_sys"] = @"android";
    NSTimeInterval time = [[NSDate date]timeIntervalSince1970];
    action.params[@"time"] = [NSString stringWithFormat:@"%f",time];
    action.params[@"limit"] = @"4";
    action.params[@"offset"]= @"0";
    
    return [[ZCApiRunner sharedInstance] runAction:action success:^(id object) {
        success(object);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

//3.
+ (NSURLSessionDataTask *)getDouyuHomeCategoryInfos:(MSSuccessBlock)success failure:(MSFailureBlock)failure {
    //http://capi.douyucdn.cn/api/v1/getHotCate?aid=android1&client_sys=android&time=1470127800&token=&auth=106ce60e97ada8b26345b7c7d742f8eb
    ZCApiAction *action = [[ZCApiAction alloc]initWithURL:@"http://capi.douyucdn.cn/api/v1/getHotCate"];
    action.params[@"aid"] = @"android1";
    action.params[@"client_sys"] = @"android";
    NSTimeInterval time = [[NSDate date]timeIntervalSince1970];
    action.params[@"time"] = [NSString stringWithFormat:@"%f",time];
    return [[ZCApiRunner sharedInstance] runAction:action success:^(id object) {
        success(object);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

@end

/**
 *  Use
 */
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    //在app delegate里面设置比较好,任意地点设置也没问题,不过需要在调用api之前设置
//    [[ZCApiRunner sharedInstance] startWithDebugDomain:@"http://api.budejie.com/" releaseDomain:@"http://api.budejie.com/"];
//
//    //    可以要可以不要
//    //    [self globleSettings];
//
//
//    [self nomarlActionTest];
//    //    [self uploadActionTest];
//}
//
//#pragma mark - 使用说明
//
///**
// *  一切全局的设置,可有可没有.
// 一般api会返回一个code表示api逻辑是否成功.
// 如果有设置了codekey,则需要设置成功code.当api返回时,会根据code key和success code的设置进行判定进入success还是failure回调
// 是否成功仅仅依赖success codes,不依赖warning codes.
// 对于一些全局的warning codes,可以设置handler.比如登录失效,可以设置一个handler进行登录.
// */
//- (void)globleSettings {
//    [[ZCApiRunner sharedInstance] codeKey:@"code"];
//    [[ZCApiRunner sharedInstance] successCodes:@[@"0"]];
//    [[ZCApiRunner sharedInstance] warningReturnCodes:@[@"-1"] withHandler:^(NSString *code) {
//        if ([code isEqualToString:@"-1"]) {
//            //做自己的操作,例如登录等
//        }
//    }];
//}
//
///**
// *  api from 百思不得姐,随时失效.请用有效的api进行测试
// 这是普通的api请求,获取数据.ZCApiAction中有更多的属性可以设置.
// */
//- (void)nomarlActionTest {
//    ZCApiAction *action = [[ZCApiAction alloc] initWithURL:@"api/api_open.php"];
//    //参数
//    action.params[@"a"] = @"user_login_report";
//    action.params[@"appname"] = @"baisishequ";
//    action.params[@"c"] = @"user";
//    action.params[@"client"] = @"iphone";
//
//    //可选属性
//    action.showLog = YES;
//    action.actionWillInvokeBlock = ^{
//        NSLog(@"will start");
//    };
//
//    action.actionDidInvokeBlock = ^(BOOL isSuccess) {
//        if (isSuccess) {
//            NSLog(@"success");
//        }
//        else {
//            NSLog(@"failure");
//        }
//    };
//
//    [[ZCApiRunner sharedInstance] runAction:action success:^(id object) {
//
//    } failure:^(NSError *error) {
//
//    }];
//}
//
///**
// *  没有相关的api,只能做个使用示例
// */
//- (void)uploadActionTest {
//    ZCApiUploadAction *action = [[ZCApiUploadAction alloc] initWithURL:@"xxx"];
//    //参数,同普通action一样
//    action.params[@""] = @"";
//
//    //根据上传任务调整timeout
//    action.timeout = 300;
//
//    //上传必要参数,由server端提供
//    action.data = [NSData data];
//    action.fileName = @"xxx";
//    action.uploadName = @"xxx";
//    action.mimeType = @"xxx";
//
//    /*
//     如果是多data上传(例如一个身份证上传api,需要上传身份证正反面)
//     可以使用数组形式的参数,不过单个data上传和多个data上传需要互斥
//     并且多个data上传,需要统一,也就是data/filename/uploadname/mimetype的数组数量一致
//     因为是通过index来进行匹配的.
//     */
//    //    action.dataArray = @[];
//    //    action.uploadNameArray = @[];
//    //    action.fileNameArray = @[];
//    //    action.mimeTypeArray = @[];
//
//    [[ZCApiRunner sharedInstance] uploadAction:action progress:nil success:^(id object) {
//
//    } failure:^(NSError *error) {
//
//    }];
//}