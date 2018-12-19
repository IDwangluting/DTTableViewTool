//
//  DTTableViewController.h
//  HN-Nniu
//
//  Created by wangluting on 2017/3/24.
//  Copyright © 2017年 wangluting. All rights reserved.
//

#import "DTTableDataSource.h"

@interface DTTableViewController : UIViewController

@property (nonatomic, readonly) UITableView *tableView;

@property (nonatomic, strong) id <DTTableDataSource>dataSource;
@property (nonatomic, assign) id <UITableViewDelegate>tableDelegate;

- (void)scrollToBottom:(BOOL)animation;
- (void)saveContentOffset;
- (void)restoreContentOffset;

@end
