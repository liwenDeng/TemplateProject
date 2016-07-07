//
//  UIView+MSUtil.h
//  MyTemplateProject
//
//  Created by dengliwen on 16/7/7.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (MSUtil)
/**
 *  绘制虚线
 *
 *  @param lineFrame 虚线frame
 *  @param length    虚线中短线宽度
 *  @param spacing   虚线中短线间隔
 *  @param color     虚线颜色
 */
+ (UIView *)ms_createDashedLineWithFrame:(CGRect)lineFrame lineLength:(int)length lineSpacing:(int)spacing lineColor:(UIColor *)color;

@end
