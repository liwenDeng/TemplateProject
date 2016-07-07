//
//  UIImage+MSUtil.h
//  MyTemplateProject
//
//  Created by dengliwen on 16/7/7.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (MSUtil)

#pragma mark - UIImage Shot 图片截图
/**
 *  全屏截图
 */
+ (UIImage *)ms_shotScreen;

/**
 *  截取一张View 生成图片
 */
+ (UIImage *)ms_shotWithView:(UIView *)view;

/**
 *  截取View中某个区域生成一张图片
 */
+ (UIImage *)ms_shotWithView:(UIView *)view scope:(CGRect)scope;

#pragma mark - UIImage Compress 图片压缩
/**
 *  压缩图片到指定尺寸大小
 */
+ (UIImage *)ms_compressOriginalImage:(UIImage *)image toSize:(CGSize)size;

/**
 *  压缩图片到指定文件大小
 */
+ (NSData *)ms_compressOriginalImage:(UIImage *)image toMaxDataSizeKBytes:(CGFloat)size;

@end
