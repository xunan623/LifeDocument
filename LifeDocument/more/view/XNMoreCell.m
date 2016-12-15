//
//  XNMoreCell.m
//  LifeDocument
//
//  Created by 许楠 on 15/12/15.
//  Copyright © 2015年 camelot. All rights reserved.
//

#import "XNMoreCell.h"

@interface XNMoreCell()


@end

@implementation XNMoreCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 图片
        UIImageView *iconView = [[UIImageView alloc] init];
        [self addSubview:iconView];
        self.iconView = iconView;
        
        // 副标题
        UILabel *detailLabel = [[UILabel alloc] init];
        detailLabel.font = [UIFont systemFontOfSize:14];
        detailLabel.textAlignment = NSTextAlignmentRight;
        detailLabel.textColor = rgb(100, 100, 100);
        [self addSubview:detailLabel];
        self.detailLabel = detailLabel;
        self.textLabel.textColor = rgb(40, 40, 40);
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 图片
    self.iconView.frame = CGRectMake(Width -24, 10, 17, 24);
    
    // 副标题
    self.detailLabel.frame = CGRectMake(Width -200, 13, 200 - 34, 20);
    
    
}


@end
