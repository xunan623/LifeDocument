//
//  XNRecentMovieModel.h
//  LifeDocument
//
//  Created by 许楠 on 15/12/14.
//  Copyright © 2015年 camelot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XNRecentMovieModel : NSObject


@property (nonatomic, copy) NSString *url;

@property (nonatomic, copy) NSString *img;

@property (nonatomic, assign) NSInteger id;

@property (nonatomic, copy) NSString *created_at;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *duration;

@property (nonatomic, copy) NSString *num;

@property (nonatomic, assign) NSInteger zan;

@property (nonatomic, copy) NSString *reposts;

@property (nonatomic ,copy)NSString *name;

@property (nonatomic ,copy)NSString *desc;

@end

