//
//  XNHotPlayCell.m
//  LifeDocument
//
//  Created by 许楠 on 15/12/14.
//  Copyright © 2015年 camelot. All rights reserved.
//

#import "XNHotPlayCell.h"
#import <UIImageView+WebCache.h>

@interface XNHotPlayCell()

@property (nonatomic, weak) UIImageView *imgView;
@property (nonatomic, weak) UILabel *timeLabel;
@property (nonatomic, weak) UILabel *numLabel;
@property (nonatomic, weak) UILabel *titleLabel;
@end

@implementation XNHotPlayCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 图片
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetWidth(self.frame))];
        imgView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        imgView.clipsToBounds = YES;
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:imgView];
        self.imgView = imgView;
        
        // 标题
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(self.imgView.frame)-40, CGRectGetMaxX(self.imgView.frame) -5, 20)];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = [UIFont systemFontOfSize:16];
        [self addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        // 时间
        UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(self.imgView.frame)-20, 80 , 20)];
        timeLabel.textColor = [UIColor whiteColor];
        timeLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        // 播放
        UILabel *numLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.frame) -105 , CGRectGetMaxY(self.imgView.frame) -20, 100 , 20)];
        numLabel.textAlignment = NSTextAlignmentRight;
        numLabel.textColor = [UIColor whiteColor];
        numLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:numLabel];
        self.numLabel = numLabel;
        
        
    }
    return self;
}


+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView NSIndexPath:(NSIndexPath*)indexPath
{
    static NSString *identify = @"XNHotPlayCell";
    XNHotPlayCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    [cell sizeToFit];
    if (!cell) {
        NSLog(@"无法创建CollectionViewCell时打印，自定义的cell就不可能进来了。");
    }
    
    
    return cell;
}

-(void)setModel:(XNRecentMovieModel *)model
{
    _model = model;
    // 图片
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:_model.img] placeholderImage:[UIImage imageNamed:@"TabBarBackground"]];
    
    // 标题
    self.titleLabel.text = _model.title;
    
    // 时长
    self.timeLabel.text = [NSString stringWithFormat:@"时长:%@",_model.duration];
    
    // 播放次数
    self.numLabel.text = [NSString stringWithFormat:@"播放:%@",_model.num];
}

@end
