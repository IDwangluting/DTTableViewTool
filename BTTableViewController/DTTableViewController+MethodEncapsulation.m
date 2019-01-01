//
//  DTTableViewController+MethodEncapsulation.m
//  DTTableViewToolExmaple
//
//  Created by luting on 2019/1/1.
//  Copyright © 2019 luting. All rights reserved.
//

#import "DTTableViewController+MethodEncapsulation.h"
#import "DTTableViewBaseCell.h"
#import "BaseSource.h"

@implementation DTTableViewController (MethodEncapsulation)

- (void)popToLeft  {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)cleanSectionDataSource {
    [self.rows removeAllObjects];
    DTTableDataSource *dataSource = [[DTTableDataSource alloc] init];
    self.dataSource = dataSource  ;
}

- (void)scrollToTop:(BOOL)animation {
    [self.tableView setContentOffset:CGPointZero animated:animation];
}

- (void)initCellForClass:(Class)className
                    data:(id)data {
    BaseSource *source = [self configCellForClass:className data:data];
    [self.rows addObject:source];
}

- (void)initCellForClasses:(NSArray *)classNames datas:(NSArray *)datas{
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:4];
    for (int i = 0; datas.count > i; i++) {
        BaseSource *source = [self configCellForClass:[classNames objectAtIndex:i]
                                                 data:[datas objectAtIndex:i]];
        [array addObject:source];
    }
    [self.rows addObject:array];
}

- (void)insertCellForClass:(Class)className
                dataSource:(id)dataSource
                 insertRow:(NSInteger)insertRow {
    BaseSource *source = [self configCellForClass:className
                                             data:dataSource];
    if (insertRow < 0 && self.rows.count >= insertRow) {
        NSLog(@"参数有误：class:%@   row = %ld", self.class, (long) insertRow);
        return;
    }
    if (self.rows.count - 1 == insertRow || self.rows.count == 0) {
        [self.rows addObject:source];
    } else if (self.rows.count - 1 > insertRow) {
        [self.rows insertObject:source atIndex:insertRow];
    }
}

- (void)insertCellsForClasss:(NSArray <Class> *)classNames
                       datas:(NSArray <id> *)datas
                  insertRows:(NSArray <NSNumber *> *)insertRows {
    if (classNames.count != datas.count ||classNames.count != insertRows.count) return ;
    
    for (int i = 0; insertRows.count > 0; i++) {
        [self insertCellForClass:[classNames objectAtIndex:i]
                      dataSource:[datas objectAtIndex:i]
                       insertRow:[[insertRows objectAtIndex:i] integerValue]];
    }
}

- (BaseSource *)configCellForClass:(Class)className data:(id)data {
    BaseSource *source = [[BaseSource alloc] init];
    source.userData = data ;
    source.cellClass = className ;
    source.flexibleHeight = [className cellHeight];
    source.loadFromNib = YES;
    return source;
}

- (void)reloadDataSource {
    DTTableDataSource *dataSource = [[DTTableDataSource alloc] init];
    dataSource.rows = self.rows;
    self.dataSource = dataSource;
}

- (void)reloadSectionsDataSource {
    DTTableDataSource * dataSource = [[DTTableDataSource alloc] init];
    dataSource.rows = self.rows;
    dataSource.sectionCount = self.rows.count;
    self.dataSource = dataSource;
}

- (void)insertRowsAtIndexPaths:(NSArray *)indexPaths
                       animate:(UITableViewRowAnimation)animate {
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:animate];
    [self.tableView endUpdates];
}

@end
