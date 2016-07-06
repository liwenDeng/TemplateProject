//
//  MSFileUtil.m
//  MyTemplateProject
//
//  Created by dengliwen on 16/7/6.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "MSFileUtil.h"

@implementation MSFileUtil

#pragma mark - FileHandle
+ (void)ms_deleteFileWithDirPath:(NSString *)dirPath extension:(NSString *)extension {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *contents = [fileManager contentsOfDirectoryAtPath:dirPath error:NULL];
    NSEnumerator *e = [contents objectEnumerator];
    NSString *filename;
    while ((filename = [e nextObject]))
    {
        if ([extension length] == 0 || [[filename pathExtension] isEqualToString:extension])
        {
            [fileManager removeItemAtPath:[dirPath stringByAppendingPathComponent:filename] error:NULL];
        }
    }
}

+ (unsigned long long)ms_fileSizeForDir:(NSString *)path {
    // 文件管理者
    NSFileManager *mgr = [NSFileManager defaultManager];
    // 文件类型
    NSDictionary *attrs = [mgr attributesOfItemAtPath:path error:nil];
    NSString *fileType = attrs.fileType;
    if ([fileType isEqualToString:NSFileTypeDirectory]) { // 文件夹
        // 获得文件夹的遍历器
        NSDirectoryEnumerator *enumerator = [mgr enumeratorAtPath:path];
        // 总大小
        unsigned long long fileSize = 0;
        // 遍历所有子路径
        for (NSString *subpath in enumerator) {
            // 获得子路径的全路径
            NSString *fullSubpath = [path stringByAppendingPathComponent:subpath];
            fileSize += [mgr attributesOfItemAtPath:fullSubpath error:nil].fileSize;
        }
        return fileSize;
    }
    // 文件
    return attrs.fileSize;
}

+ (BOOL)ms_fileExists:(NSString*)aFilePath {
    return [[NSFileManager defaultManager] fileExistsAtPath:aFilePath];
}

+ (BOOL)ms_deleteFileWithPath:(NSString*)filePath {
    BOOL ret=YES;
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:filePath])
    {
        ret=[fm removeItemAtPath:filePath error:nil];
    }
    return ret;
}

+ (BOOL)ms_appendData:(NSData*)data path:(NSString*)path {
    BOOL ret=NO;
    
    NSFileHandle * fh = [NSFileHandle fileHandleForWritingAtPath:path];
    if (!fh)
    {
        ret=[data writeToFile:path atomically:NO];
    }
    else
    {
        [fh truncateFileAtOffset:[fh seekToEndOfFile]];
        [fh writeData:data];
        ret=YES;
    }
    
    return ret;
}
#pragma mark - FilePath
+ (NSString *)ms_docPathWithFileName:(NSString *)fileName createPathIfNotExists:(BOOL)createPathIfNotExists {
    NSString *docPath = [self ms_docDir];
    //最后一个/之前的是目录
    NSString* dirPath=fileName;
    NSRange range=[fileName rangeOfString:@"/" options:NSBackwardsSearch];
    if(range.length>0)
    {
        dirPath=[docPath stringByAppendingPathComponent:[fileName substringToIndex:range.location]];
    }
    if (createPathIfNotExists && ![[NSFileManager defaultManager] fileExistsAtPath:dirPath])
    {
        [[NSFileManager defaultManager] createDirectoryAtPath:dirPath
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:NULL];
    }
    return [docPath stringByAppendingPathComponent:fileName];
}

+ (NSString *)ms_docPathWithFileName:(NSString *)fileName {
    fileName = fileName ? : @"";
    return [[self ms_docDir] stringByAppendingPathComponent:fileName];
}

+ (NSString *)ms_cachePathWithFileName:(NSString *)filename {
    return [[self ms_cacheDir]stringByAppendingPathComponent:filename];
}

+ (NSString *)ms_tempPathWithFileName:(NSString *)filename {
    return [[self ms_tempDir]stringByAppendingPathComponent:filename];
}

+ (NSString *)ms_cacheDir {
    NSString *dir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)lastObject];
    return dir;
}

+ (NSString *)ms_docDir {
    NSString *dir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    return dir;
}

+ (NSString *)ms_tempDir {
    NSString *dir = NSTemporaryDirectory();
    return dir;
}

@end
