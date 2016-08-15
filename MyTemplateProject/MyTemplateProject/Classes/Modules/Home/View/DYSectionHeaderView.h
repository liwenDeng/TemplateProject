//
//  DYSectionHeaderView.h
//  MyTemplateProject
//
//  Created by dengliwen on 16/8/3.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DYSectionHeaderView : UICollectionReusableView

- (void)fillWithTagName:(NSString *)tagName;

+ (CGSize)sectionHeaderViewSize;

@end
