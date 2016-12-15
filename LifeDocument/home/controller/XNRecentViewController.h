//
//  XNRecentViewController.h
//  LifeDocument
//
//  Created by 许楠 on 15/12/14.
//  Copyright © 2015年 camelot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XNRecentMovieModel.h"

@interface XNRecentViewController : UIViewController

@property (nonatomic, strong) XNRecentMovieModel *recentModel;
@property (nonatomic, assign) bool isFromCate;

@end
