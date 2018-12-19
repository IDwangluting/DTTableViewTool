//
//  FLSettingViewController.m
//  Flipped
//
//  Created by luting on 2018/4/19.
//  Copyright © 2018年 zyb. All rights reserved.
//

#import "FLSettingViewController.h"
#import "FLSettingItemTableViewCell.h"
#import "FLSettingItemLogoutCell.h"
#import "NSObject+YYModel.h"
#import "MLSafe.h"
#import "UIView+Frame.h"
#import <YYCategories.h>

@interface FLSettingViewController ()<UITabBarControllerDelegate>

@end

@implementation FLSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configBase];
    [self loadSubView];
    [self viewAction];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.navigationController setNavigationBarHidden:false animated:NO];
}

- (void)configBase {
    self.title = @"设置";

    UITabBarController  * tabBarController = (id)[UIApplication sharedApplication].keyWindow.rootViewController;
    tabBarController.delegate = self ;
}

- (NSArray *)loadLocalData {
    NSArray * loadLocalData = @[
#if DEBUG
                                @{@"title"      :@"小工具",
                                  @"detail"     :@"",
                                  @"funcType"   :@(FLSettingFuncTypeUtil),
                                  @"params"     :@""},
                                @{@"title"      :@"清除缓存",
                                  @"detail"     :SafeForString([self fileSize]),
                                  @"funcType"   :@(FLSettingFuncTypeClearDiskData),
                                  @"params"     :@""},
#endif
                                @{@"title"      :@"用户协议",
                                  @"detail"     :@"",
                                  @"funcType"   :@(FLSettingFuncTypeUserAgreement),
                                  @"params"     :@""},
#if DEBUG
                                @{@"title"      :@"浣熊学堂体验版",
                                  @"detail"     :@"",
                                  @"funcType"   :@(FLSettingFuncTypeAppTest),
                                  @"params"     :@""}
#endif
                                ];
    return [NSArray yy_modelArrayWithClass:[FLSimpleModel class] json:loadLocalData];
}

- (void)loadSubView {
    for (NSObject * item in [self loadLocalData]) {
        ADD_CELL(FLSettingItemTableViewCell,item);
    }
    ADD_CELL(FLSettingItemLogoutCell,nil);
    [self reloadDataSource];
#if DEBUG
    [self versionView];
#endif
    [self testView];
}

- (void)reloadTableView {
    if (self.rows > 0) [self.rows removeAllObjects];
    [self loadSubView];
}

- (NSString *)fileSize{
    NSUInteger size = 1133;
    if (size < 1024) {// 小于1k
        return @"";
    }else if (size < 1024 * 1024){// 小于1m
        return [NSString stringWithFormat:@"%.0fK",size/1024.0];
    }else if (size < 1024 * 1024 * 1024){// 小于1G
        return [NSString stringWithFormat:@"%.1fM",size/(1024 * 1024.0)];
    }else{
        return [NSString stringWithFormat:@"%.1fG",size/(1024*1024*1024.0)];
    }
}

- (void)viewAction {
    __weak typeof(self)weakSelf = self;
    void(^userAgreementmBlock)(NSString * url) = ^(NSString * url){
       
        [weakSelf.navigationController pushViewController:[UIViewController new] animated:YES];
    };
    
    DTTableDataSource *source = (DTTableDataSource *)self.dataSource;
    @weakify(self);
    [source attachClass:[FLSettingItemTableViewCell class]
        navagationBlock:^(FLSimpleModel * item, id target, NSIndexPath *indexPath) {
            @strongify(self);
            switch (item.funcType) {
                case FLSettingFuncTypeClearDiskData:
                    [self clearDiskData];
                    break;
                case FLSettingFuncTypeUserAgreement:
                    userAgreementmBlock(SafeForString(item.params));
                    break;
                case FLSettingFuncTypeAppTest:
                    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:SafeForString(item.params)]];
                    break;
                case FLSettingFuncTypeUtil:
//                    [[UIApplication sharedApplication] pushViewController:[FLUtilViewController new]];
                    break;
                default:
                    break;
            }
    }];
    
    [source attachClass:[FLSettingItemLogoutCell class]
            detailBlock:^(NSNumber * object, id target, NSIndexPath *indexPath) {
                if ([object boolValue] == false) {}
    }];
}

- (void)clearDiskData {
 
}

- (void)refreshAfterLogin {
    [self.tableView reloadData];
}

- (void)refreshAfterLoginOut {
    [self.tableView reloadData];
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UINavigationController *)viewController {
    if (viewController.topViewController == self)  [self.tableView reloadData];
}

- (void)versionView {
    UIImage * image = [UIImage imageNamed:@"AppName_icon"];
    UIImageView * appNameView = [[UIImageView alloc]initWithImage:image];
    appNameView.size = image.size;
    appNameView.bottom = self.view.height - 108 - 20 - 55;
    appNameView.centerX = self.view.centerX;
    [self.view addSubview:appNameView];
    
    UILabel * versionLabel = [[UILabel alloc]init];
    versionLabel.origin = CGPointMake(0, appNameView.bottom);
    versionLabel.size = CGSizeMake(self.view.width, 16);
    versionLabel.textColor = [UIColor colorWithRGB:0xE6E6E6];
    versionLabel.textAlignment = NSTextAlignmentCenter;
    NSString * version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    versionLabel.text = [NSString stringWithFormat:@"VERSION:%@",version];
    [self.view addSubview:versionLabel];
}

- (void)testView {
    CGRect rect = CGRectMake(0, self.view.bottom - 180, self.view.width, 70);
    UILabel * testLabel = [[UILabel alloc]initWithFrame:rect];
    testLabel.userInteractionEnabled = YES ;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id sender) {
    }];
    tap.numberOfTapsRequired = 6;
    [testLabel addGestureRecognizer:tap];
    testLabel.text = @"调试控制器";
    testLabel.textColor = [UIColor whiteColor];
    testLabel.backgroundColor = testLabel.textColor;
#if DEBUG
    testLabel.backgroundColor = [UIColor grayColor];
#endif
    testLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:testLabel];
}

@end
