//
//  FLUserCenterSettingItemTableViewCell.m
//  Flipped
//
//  Created by luting on 2018/4/19.
//  Copyright © 2018年 zyb. All rights reserved.
//

#import "FLSettingItemTableViewCell.h"
#import <YYCategories.h>
#import "MLSafe.h"

@interface FLSettingItemTableViewCell ()

@property (weak,  nonatomic) IBOutlet UILabel *titleLabel;
@property (weak,  nonatomic) IBOutlet UILabel *contentLabel;
@property (strong,nonatomic) FLSimpleModel * model;

@end

@implementation FLSettingItemTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    @weakify(self);
    [self.contentView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        @strongify(self);
        self.action.navagationBlock(self.model, self, self.indexPath);
    }]] ;
}

- (void)updateCellWithSource:(BaseSource *)source {
    if (source == nil || source.userData == nil ||
        ![source.userData isKindOfClass:[FLSimpleModel class]]) return ;

    if (self.model == source.userData)  return ;

    self.model = source.userData ;
    _titleLabel.text = SafeForString(self.model.title);
    _contentLabel.text = SafeForString(self.model.detail);
}

+ (CGFloat)cellHeight {
    return  50 ;
}

@end
