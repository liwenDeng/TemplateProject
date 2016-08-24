//
//  MSNetworking.m
//  MyTemplateProject
//
//  Created by dengliwen on 16/6/28.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "MSNetworking.h"
#import "NSString+Code.h"
#import "OCGumbo+Query.h"
#import "OCGumbo.h"
#import <AFNetworking.h>

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
+ (NSURLSessionDataTask *)getDouyuBigDataInfos:(MSSuccessBlock)success failure:(MSFailureBlock)failure {
    
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
+ (NSURLSessionDataTask *)getDouyuFaceInfos:(MSSuccessBlock)success failure:(MSFailureBlock)failure {
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
+ (NSURLSessionDataTask *)getDouyuHotCateListInfos:(MSSuccessBlock)success failure:(MSFailureBlock)failure {
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

+(NSURLSessionDataTask *)getDouyuRoomLiveInfo:(NSString *)roomId success:(MSSuccessBlock)success failure:(MSFailureBlock)failure {
//    获取auth 的算法变了，获取不到数据，这里通过对应房间的web地址来获取
//    NSString *baseURL = @"http://capi.douyucdn.cn/api/v1/room/";
//    NSString *urlMid = @"?aid=ios&client_sys=ios&ne=1&support_pwd=1&time=";
//    NSInteger time = ceil([[NSDate date] timeIntervalSince1970]);
//    
//    NSString *Secret = @"bLFlashflowlad92";
//    
//    NSString *auth = [NSString stringWithFormat:@"%@%@%ld",roomId,Secret,time/60000];//[NSString stringWithFormat:@"room/%@%@%ld1231",roomId,urlMid,(long)time];
//    NSString *authMd5 = [auth ms_md5];
//    NSString *requestString = [NSString stringWithFormat:@"%@%@%@%ld&auth=%@",baseURL,roomId,urlMid,(long)time,authMd5];
//    
//    ZCApiAction *action = [[ZCApiAction alloc]initWithURL:requestString];
//    
//    return [[ZCApiRunner sharedInstance] runAction:action success:^(id object) {
//        success(object);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
//
    
//    NSString *user_agent = @"Mozilla/5.0";
    
    //http://www.douyu.com/swf_api/room/{0}?cdn=&nofan=yes&_t={1}&sign={2}
//    NSString *swf_url = @"http://www.douyu.com/swf_api/room/";
//    NSString *swf_secret = @"bLFlashflowlad92";
    
    
    //http://www.douyu.com/lapi/live/getPlay/{0}
//    NSString *lap_url = @"http://www.douyu.com/lapi/live/getPlay/";
//    NSString *lap_secret = @"A12Svb&%1UUmf@hC";//A12Svb&%1UUmf@hC
    
//================
//    NSInteger ts = ceil([[NSDate date]timeIntervalSince1970] / (60));
//    NSString *uid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
//    NSMutableString *did = [NSMutableString stringWithString:uid];
//    [did replaceOccurrencesOfString:@"-" withString:@"" options:(NSCaseInsensitiveSearch) range:NSMakeRange(0, did.length)];
//    NSString *did = @"C986B5FEF7D141FEBE63938C54E17DD1";
    
//    NSString *swf_sign = [NSString stringWithFormat:@"%@%@%ld",roomId,swf_secret,ts].ms_md5;
//    NSString *l_sign = [NSString stringWithFormat:@"%@%@%@%ld",roomId,did,lap_secret,ts].ms_md5;
    

//    NSString *sign = [NSString stringWithFormat:@"%@%@%@%ld",roomId,uuid,s,(long)time].ms_md5;
    
    // swf request http://www.douyu.com/swf_api/room/{0}?cdn=&nofan=yes&_t={1}&sign={2}
//    NSString *swf_requestUrl = [NSString stringWithFormat:@"%@%@?cdn=&nofan=yes&_t=%ld&sign=%@",swf_url,roomId,ts,swf_sign];
//    ZCApiAction *action = [[ZCApiAction alloc]initWithURL:swf_requestUrl];
//    [action setHeaders:@{@"User-Agent":user_agent}];
//    
////    [action setHttpMethod:HttpPost];
//     [[ZCApiRunner sharedInstance] runAction:action success:^(id object) {
//        success(object);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
    
    // lap_request http://www.douyu.com/lapi/live/getPlay/{0}
    
//    NSString *lap_requestUrl = [NSString stringWithFormat:@"%@%@",lap_url,roomId];
    
    
//    ZCApiAction *action1 = [[ZCApiAction alloc]initWithURL:lap_requestUrl];
//    [action1 setHeaders:@{@"cdn":@"tct",@"rate":@"0",@"tt":@(ts),@"did":did,@"sign":l_sign}];
//    action1.showLog = YES;
//    action1.params[@"cdn"] = @"ws";
//    action1.params[@"rate"] = @"0";
//    action1.params[@"tt"] = @(ts);
//    action1.params[@"did"] = @"C986B5FEF7D141FEBE63938C54E17DD1";
//    action1.params[@"sign"] = l_sign;
    
//    action1.headers = @{@"User-Agent":user_agent};
//    [action1.headers setValue:user_agent forKey:@"User-Agent"];
//    [action1 setHttpMethod:HttpPost];
//    [[ZCApiRunner sharedInstance] addValue:user_agent forHeaderKey:@"User-Agent"];
    
//    [[ZCApiRunner sharedInstance] runAction:action1 success:^(id object) {
//        success(object);
//    } failure:^(NSError *error) {
//        failure(error);
//    }];
    
    NSString *lap_url = @"http://www.douyu.com/lapi/live/getPlay/";
    NSString *lap_secret = @"A12Svb&%1UUmf@hC";//A12Svb&%1UUmf@hC
    NSString *did = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSInteger ts = ceil([[NSDate date]timeIntervalSince1970] / (60));
    NSString *l_sign = [NSString stringWithFormat:@"%@%@%@%ld",roomId,did,lap_secret,ts].ms_md5;
    NSString *lap_requestUrl = [NSString stringWithFormat:@"%@%@",lap_url,roomId];
    NSDictionary *params = @{@"cdn":@"ws",
                             @"rate":@"0",
                             @"tt":[NSString stringWithFormat:@"%ld",ts],
                             @"did":did,
                             @"sign":l_sign};
    
    
//    [[AFHTTPSessionManager manager].requestSerializer setValue:user_agent forHTTPHeaderField:@"User-Agent"];
    return [[AFHTTPSessionManager manager]POST:lap_requestUrl parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error");
    }];

    
    /**
     获取video 的地址 id = dy-video-player
     <video id="dy-video-player" class="video-js" type="application/x-mpegURL" src="http://hls1a.douyucdn.cn/live/453751rDVflbZEym_550/playlist.m3u8?wsSecret=940351d9905a4acced23eaa4bd450240&amp;wsTime=1471316312" style="margin-top: -10000px;">
     <p>您的浏览器不支持 video 标签</p>
     </video>
    
     OCGumboDocument使用： http://www.jianshu.com/p/029a5ef4e86a
     
     */
    
//    NSString *urlString = [NSString stringWithFormat:@"http://m.douyu.com/%@",roomId];
//    NSURL *url = [NSURL URLWithString:urlString];
//    NSError *err = nil;
//    NSString *str = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&err];
//    if (err == nil)
//    {
//        NSLog(@"%@",str);
//        //解析,需要对每一个节点判断是否为nil,否则可能会导致崩溃
//        OCGumboDocument *document = [[OCGumboDocument alloc]initWithHTMLString:str];
//        OCGumboElement *videoElememt = document.Query(@"body").find(@"#dy-video-player").firstObject;
//        if (videoElememt) {
//            NSString *src = videoElememt.attr(@"src");
//            NSDictionary *dic = @{@"videoSource":src};
//            success(dic);
//        } else {
//            failure(nil);
//        }
//    }
//    else
//    {
//        NSLog(@"读取失败");
//        NSLog(@"%@",err.localizedDescription);
//        failure(err);
//    }
//    
//    return nil;
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