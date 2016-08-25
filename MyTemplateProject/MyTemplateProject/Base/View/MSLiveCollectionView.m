//
//  MSLiveCollectionView.m
//  MyTemplateProject
//
//  Created by dengliwen on 16/8/25.
//  Copyright © 2016年 dengliwen. All rights reserved.
//

#import "MSLiveCollectionView.h"

@interface MSLiveCollectionView () 

@end

@implementation MSLiveCollectionView

+ (instancetype)msCommonCollectionView:(CGRect)frame {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing = 0;
    layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    MSLiveCollectionView *collectionView = [[MSLiveCollectionView alloc]initWithFrame:frame collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    return collectionView;
}


@end
