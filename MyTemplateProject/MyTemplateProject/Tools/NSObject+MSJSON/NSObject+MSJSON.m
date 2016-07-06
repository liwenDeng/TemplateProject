//
//  NSObject+MSJSON.m
//  MyTemplateProject
//
//  Created by dengliwen on 16/7/5.
//  Copyright © 2016年 dengliwen. All rights reserved.
//


#import "NSObject+MSJSON.h"

/**
 *  JSONString <--> data 转换有两种方式
 *  1.使用 NSJSONSerialization 进行转换，则需要设置 MS_USE_JSONKIT 为YES
 *  2.使用普通的data 与 string 通过NSUTF8编码转换，则需要设置 MS_USE_JSONKIT 为NO
 */
#define MS_USE_JSONKIT NO

@implementation NSObject (MSJSON)

#pragma mark - jsonString <--> Data 相互转换
- (NSString *)ms_jsonStringFromJsonData:(NSData *)jsonData {
    NSString *jsonString;
    if (MS_USE_JSONKIT) {
        /**
         data --> jsonString 有两种方式
         1.使用 NSJSONSerialization 转换成 string，在反响转换时 也需要使用 NSJSONSerialization 的方法
         */
        NSError *error = nil;
        jsonString = [NSJSONSerialization JSONObjectWithData:jsonData options:(NSJSONReadingMutableLeaves) error:&error];
        NSAssert(!error, @"dic-->jsonString 失败");
    }else {
        //2.使用 initWithData: ,在反向转换时需要使用 dataUsingEncoding:NSUTF8StringEncoding 方法
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}

- (NSData *)ms_jsonDataFromJsonString:(NSString *)jsonString {
    NSData *data;
    if (MS_USE_JSONKIT) {
        /**
         jsonString -> data 两种方式
         */
        //1.
        NSError *error = nil;
        data = [NSJSONSerialization dataWithJSONObject:jsonString options:(NSJSONWritingPrettyPrinted) error:&error];
        NSAssert(!error, @"jsonString-->data 失败");
        
    }else {
        //2.
        data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    }
    return data;
}

#pragma mark - jsonString <--> Dictionary 相互转换
- (NSString *)ms_jsonStringFromDic:(NSDictionary *)dic {
    // dic --> data
    NSData *jsonData = [self ms_jsonDataFromDic:dic];
    
    // data->String
    NSString *jsonString = [self ms_jsonStringFromJsonData:jsonData];
    return jsonString;
}

- (NSDictionary *)ms_dicFromJsonString:(NSString *)jsonString {
    
    //jsonString-->data
    NSData *jsonData = [self ms_jsonDataFromJsonString:jsonString];
    
    //data-->dic
    NSDictionary *dic = [self ms_dicFromJsonData:jsonData];
    
    return dic;
}

#pragma mark - Dictionary <--> Data 相互转换
- (NSData *)ms_jsonDataFromDic:(NSDictionary *)jsonDic {
    if (!jsonDic) {
        return nil;
    }

    BOOL ret = [NSJSONSerialization isValidJSONObject:jsonDic];
    if (!ret) {
        NSAssert(!ret, @"不能转换成Json");
        return nil;
    }
    NSError *error = nil;
    NSData *JSONData = [NSJSONSerialization dataWithJSONObject:jsonDic options:(NSJSONWritingPrettyPrinted) error:&error];
    
    NSAssert(!error, @"Dic-->jsonData转换失败");
    
    return JSONData;
}

- (NSDictionary *)ms_dicFromJsonData:(NSData *)jsonData {
    if (!jsonData) {
        return nil;
    }
    
    NSError *error = nil;
    NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData options:(NSJSONReadingMutableContainers) error:&error];
    NSAssert(!error, @"jsonData-->Dic转换失败");
    return jsonDic;
}

@end
