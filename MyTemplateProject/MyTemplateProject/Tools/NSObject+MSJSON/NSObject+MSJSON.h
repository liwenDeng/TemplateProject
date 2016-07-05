//
//  NSObject+MSJSON.h
//  MyTemplateProject
//
//  Created by dengliwen on 16/7/5.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (MSJSON)

#pragma mark - jsonString <--> Dictionary 相互转换
/**
 *  字典转为json字符串
 *
 *  @param dic
 *
 *  @return json字符串
 */
- (NSString *)ms_jsonStringFromDic:(NSDictionary *)dic;

/**
 *  json字符串转为字典
 *
 *  @param jsonString
 *
 *  @return 字典
 */
- (NSDictionary *)ms_dicFromJsonString:(NSString *)jsonString;

#pragma mark - Dictionary <--> Data 相互转换
/**
 *  JSON字典 转 Data
 *
 *  @param JSONString JSON 格式的字符串
 *
 *  @return JSONData
 */
- (NSData *)ms_jsonDataFromDic:(NSDictionary *)jsonDic;

/**
 *  JsonData 转换成 字典
 *
 *  @param jsonData jsonData
 *
 *  @return 字典
 */
- (NSDictionary *)ms_dicFromJsonData:(NSData *)jsonData;

#pragma mark - jsonString <--> Data 相互转换
/**
 *  jsonData转为json字符串
 *
 *  @param jsonData
 *
 *  @return json字符串
 */
- (NSString *)ms_jsonStringFromJsonData:(NSData *)jsonData;
/**
 *  jsonString 转为 jsonData
 *
 *  @param jsonString
 *
 *  @return data
 */
- (NSData *)ms_jsonDataFromJsonString:(NSString *)jsonString;

@end
