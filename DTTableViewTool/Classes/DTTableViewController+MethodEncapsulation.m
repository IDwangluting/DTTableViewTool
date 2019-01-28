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
    DTTableDataSource * dataSource = [[DTTableDataSource alloc] init];
    self.dataSource = dataSource ;
}

- (void)scrollToTop:(BOOL)animation {
    [self.tableView setContentOffset:CGPointZero animated:animation];
}

- (void)initCellForClass:(Class)className
                    data:(id)data
                  useNib:(BOOL)useNib {
    [self.rows addObject:[self configCellForClass:className
                                             data:data
                                           useNib:useNib]];
}

- (void)initCellForClasses:(NSArray *)classNames
                     datas:(NSArray *)datas {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:datas.count];
    [datas enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [array addObject:[self configCellForClass:[classNames objectAtIndex:idx]
                                             data:obj
                                           useNib:YES]];
    }];
    [self.rows addObject:array];
}

- (void)insertCellForClass:(Class)className
                dataSource:(id)dataSource
                 insertRow:(NSInteger)insertRow {
    BaseSource *source = [self configCellForClass:className
                                             data:dataSource
                                           useNib:YES];
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
    if ( classNames.count != datas.count || classNames.count != insertRows.count) return ;
    
    [insertRows enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self insertCellForClass:[classNames objectAtIndex:idx]
                      dataSource:[datas objectAtIndex:idx]
                       insertRow:[obj integerValue]];
    }];
}

- (BaseSource *)configCellForClass:(Class)className
                              data:(id)data
                            useNib:(BOOL)useNib {
    BaseSource *source = [[BaseSource alloc] init];
    source.userData = data ;
    source.cellClass = className ;
    source.flexibleHeight = [[className new]cellHeight];
    source.loadFromNib = useNib;
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
