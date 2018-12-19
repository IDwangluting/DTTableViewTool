//
//  FLSettingItemLogoutCell.m
//  Flipped
//
//  Created by luting on 2018/4/25.
//  Copyright © 2018年 zyb. All rights reserved.
//

#import "FLSettingItemLogoutCell.h" 

@interface FLSettingItemLogoutCell ()

@property (weak, nonatomic) IBOutlet UIButton *logoutBtn;

@end

@implementation FLSettingItemLogoutCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _logoutBtn.clipsToBounds = YES;
}

- (void)updateCellWithSource:(BaseSource *)source {
    [self.logoutBtn setTitle:@"退出登录" forState:UIControlStateNormal];
}

- (IBAction)logout:(id)sender {
   self.action.detailBlock(@YES, self, self.indexPath);
}

+ (CGFloat)cellHeight {
    return  106 ;
}

@end
