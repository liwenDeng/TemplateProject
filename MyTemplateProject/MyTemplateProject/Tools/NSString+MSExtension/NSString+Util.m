//
//  NSString+Util.m
//  MyTemplateProject
//
//  Created by dengliwen on 16/7/6.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "NSString+Util.h"


#define kIOS8Later [UIDevice currentDevice].systemVersion.floatValue>=8.0

@implementation NSString (Util)

- (BOOL)ty_containsString:(NSString *)string {
    // ios8以后 使用contains方法
    if (kIOS8Later) {
        return [self containsString:string];
    } else {
        return [self rangeOfString:string].location == NSNotFound  ? NO : YES;
    }
}

- (CGSize)ms_sizeWithFont:(UIFont *)font
           constrainedToSize:(CGSize)size
               lineBreakMode:(NSLineBreakMode)lineBreakMode
{
    if (font == nil || ![font isKindOfClass:[UIFont class]]) {
        font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
    }
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = lineBreakMode;
    
    return [self boundingRectWithSize:size
                              options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                           attributes:@{NSFontAttributeName: font,
                                        NSParagraphStyleAttributeName: paragraphStyle}
                              context:nil].size;
}


//当用NSUTF8StringEncoding来编码时，中文和中文状态下的字符都会是三个字节，英文状态下是1个字节，最后向下取整。
- (NSInteger)ms_textLength:(NSString *)dataString
{
    float sum = 0.0;
    
    for (int i=0; i<[dataString length]; i++)
    {
        NSString *character = [dataString substringWithRange:NSMakeRange(i, 1)];
        
        if ([character lengthOfBytesUsingEncoding:NSUTF8StringEncoding] == 3)
        {
            sum++;
        }
        else
        {
            sum += 0.5;
        }
    }
    
    return ceil(sum);
}

- (NSString *)ms_stringByTrimmingWhiteSpace
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}


@end
