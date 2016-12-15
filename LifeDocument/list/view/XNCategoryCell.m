//
//  XNRentPlayCell.m
//  LifeDocument
//
//  Created by 许楠 on 15/12/14.
//  Copyright © 2015年 camelot. All rights reserved.
//

#import "XNCategoryCell.h"
#import <UIImageView+WebCache.h>
#import "NSString+Extension.h"


@interface XNCategoryCell()
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UIImageView *imgView;
@property (nonatomic, weak) UILabel *descLabel;
@property (nonatomic, weak) UILabel *nameLabel;

@end

@implementation XNCategoryCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 图片
        UIImageView *imgView = [[UIImageView alloc] init];
        [self addSubview:imgView];
        self.imgView = imgView;
        
        // 标题
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = [UIFont systemFontOfSize:18];
        [self addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        // 时长
        UILabel *descLabel = [[UILabel alloc] init];
        descLabel.font = [UIFont systemFontOfSize:14];
        descLabel.textColor = rgb(100, 100, 100);
        [self addSubview:descLabel];
        self.descLabel = descLabel;
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 图片
    self.imgView.frame = CGRectMake(10, 10, 70, 100);
    
    // 标题
    self.nameLabel.frame = CGRectMake(90, 10, Width - 110, 20);
    
    // 时长
    self.descLabel.x = 90;
    self.descLabel.y = 40;
    self.descLabel.height = 70;
    self.descLabel.width = self.width - 100;
    self.descLabel.numberOfLines = 0;
    [self.descLabel sizeToFit];
    
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellName = @"XNCategoryCell";
    XNCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[XNCategoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
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
    self.nameLabel.text = _model.name;
    
    // 副标题
    self.descLabel.text = _model.desc;
    

}

@end
