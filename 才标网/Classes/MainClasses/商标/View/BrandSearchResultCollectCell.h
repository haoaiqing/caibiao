//
//  BrandSearchResultCollectCell.h
//  才标网
//
//  Created by caohouhong on 17/3/24.
//  Copyright © 2017年 李强. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BrandSearchModel.h"
typedef void(^favBlock)(BOOL isFavour, BrandSearchModel *model);

@interface BrandSearchResultCollectCell : UICollectionViewCell

@property (nonatomic, copy) favBlock block;

@property (nonatomic, strong) UIView *dividerLine4;
@property (nonatomic, strong) BrandSearchModel *model;
@end
