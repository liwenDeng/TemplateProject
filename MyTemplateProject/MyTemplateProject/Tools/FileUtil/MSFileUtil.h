//
//  MSFileUtil.h
//  MyTemplateProject
//
//  Created by dengliwen on 16/7/6.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  文件工具类
 */
@interface MSFileUtil : NSObject

#pragma mark - FileHandle
/**
 *  删除目录下指定扩展名文件
 *
 *  @param dirPath   目录路径
 *  @param extension 文件扩展名
 */
+(void)ms_deleteFileWithDirPath:(NSString*)dirPath extension:(NSString*)extension;

/**
 *  计算目录下所有文件大小
 */
+ (unsigned long long)ms_folderSizeForDir:(NSString *)path;
/**
 *  计算指定路径下某个文件大小
 */
+ (unsigned long long)ms_fileSizeAtPath:(NSString *)filePath;

+ (BOOL)ms_deleteFileWithPath:(NSString*)filePath;
+ (BOOL)ms_fileExists:(NSString*)aFilePath;
+ (BOOL)ms_appendData:(NSData*)data path:(NSString*)path;

#pragma mark - FilePath
/**
 *  生成doc目录下的完整路径
 *
 *  @param aFileName             文件名 abc.txt
 *  @param createPathIfNotExists 不存在则创建
 *
 *  @return /Users/dengliwen/Library/Developer/CoreSimulator/Devices/2E59C6C2-61D3-4390-9BC7-E2D1F7C5C501/data/Containers/Data/Application/10708EDF-EF97-47D9-B0D9-688EF3B1F349/doc/abc.txt
 */
+ (NSString*)ms_docPathWithFileName:(NSString*)fileName createPathIfNotExists:(BOOL)createPathIfNotExists;

+ (NSString*)ms_docPathWithFileName:(NSString*)fileName;
+ (NSString*)ms_tempPathWithFileName:(NSString*)filename;
+ (NSString *)ms_cachePathWithFileName:(NSString*)filename;

/**
 *  生成缓存目录全路径
 */
+ (NSString *)ms_cacheDir;
/**
 *  生成文档目录全路径
 */
+ (NSString *)ms_docDir;
/**
 *  生成临时目录全路径
 */
+ (NSString *)ms_tempDir;

@end
