//
//  DTBaseTableViewCell.m
//  Flipped
//
//  Created by luting on 2018/2/5.
//  Copyright © 2018年 zyb. All rights reserved.
//

#import "DTBaseTableViewCell.h"

@implementation DTBaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

+ (CGFloat)cellHeight {
    return  50 ;
}

@end
