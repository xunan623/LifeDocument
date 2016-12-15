//
//  XNRentPlayCell.m
//  LifeDocument
//
//  Created by 许楠 on 15/12/14.
//  Copyright © 2015年 camelot. All rights reserved.
//

#import "XNRentPlayCell.h"
#import <UIImageView+WebCache.h>


@interface XNRentPlayCell()
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UIImageView *imgView;
@property (nonatomic, weak) UILabel *timeLabel;
@property (nonatomic, weak) UILabel *numLabel;
@end

@implementation XNRentPlayCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 图片
        UIImageView *imgView = [[UIImageView alloc] init];
        [self addSubview:imgView];
        self.imgView = imgView;
        
        // 标题
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.font = [UIFont systemFontOfSize:18];
        [self addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        // 时长
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.font = [UIFont systemFontOfSize:14];
        timeLabel.textColor = rgb(100, 100, 100);
        [self addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        // 播放次数
        UILabel *numLabel = [[UILabel alloc] init];
        numLabel.font = [UIFont systemFontOfSize:14];
        numLabel.textColor = rgb(100, 100, 100);
        [self addSubview:numLabel];
        self.numLabel = numLabel;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 图片
    self.imgView.frame = CGRectMake(10, 10, 100, 70);
    
    // 标题
    self.titleLabel.frame = CGRectMake(120, 15, Width - 120, 20);
    
    // 时长
    self.timeLabel.x = 120;
    self.timeLabel.y = 55;
    self.timeLabel.height = 20;
    [self.timeLabel sizeToFit];
    
    // 播放次数
    self.numLabel.x = self.timeLabel.x + self.timeLabel.width +20;
    self.numLabel.y = self.timeLabel.y;
    self.numLabel.height = self.timeLabel.height;
    [self.numLabel sizeToFit];
    
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellName = @"recentView";
    XNRentPlayCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[XNRentPlayCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
