//
//  XNMorePersonCell.m
//  LifeDocument
//
//  Created by 许楠 on 15/12/15.
//  Copyright © 2015年 camelot. All rights reserved.
//

#import "XNMorePersonCell.h"
#import <UIImageView+WebCache.h>
#import "HWAccount.h"
#import "HWAccountTool.h"

@interface XNMorePersonCell()

@property (nonatomic, weak) UIImageView *imgView;
@property (nonatomic, weak) UILabel *nameLabel;

@end

@implementation XNMorePersonCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // 箭头
        UIImageView *iconView = [[UIImageView alloc] init];
        [self addSubview:iconView];
        self.iconView = iconView;
        
        HWAccount *account = [HWAccountTool account];
        // 图片
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.layer.masksToBounds = YES;
        imgView.layer.cornerRadius = 30;
        [imgView sd_setImageWithURL:[NSURL URLWithString:account.profile_image_url] placeholderImage:[UIImage imageNamed:@"settings_photo"]];
        [self addSubview:imgView];
        self.imgView = imgView;
        
        // 标题
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = [UIFont systemFontOfSize:17];
        nameLabel.textColor = rgb(100, 100, 100);
        if (account.name == nil) {
            nameLabel.text = @"请登录";
        } else {
            nameLabel.text = account.name;
        }
        [self addSubview:nameLabel];
        self.nameLabel = nameLabel;

    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
     HWAccount *account = [HWAccountTool account];
    self.imgView.frame = CGRectMake(10, 10, 60, 60);
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:account.profile_image_url] placeholderImage:[UIImage imageNamed:@"settings_photo"]];
    self.nameLabel.frame = CGRectMake(80, 30, Width - 100, 20);
    
    // 图片
    self.iconView.frame = CGRectMake(Width -24, 28, 17, 24);
}



+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellName = @"personCell";
    XNMorePersonCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[XNMorePersonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
@end
