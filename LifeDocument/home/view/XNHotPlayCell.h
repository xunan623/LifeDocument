//
//  XNHotPlayCell.h
//  LifeDocument
//
//  Created by 许楠 on 15/12/14.
//  Copyright © 2015年 camelot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XNRecentMovieModel.h"

@interface XNHotPlayCell : UICollectionViewCell

@property (nonatomic, strong) XNRecentMovieModel *model;

+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView NSIndexPath:(NSIndexPath *)indexPath;

@end
