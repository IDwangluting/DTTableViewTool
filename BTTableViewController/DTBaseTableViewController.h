//
//  LiveRoomListViewController.h
//  HN-Nniu
//
//  Created by mac on 2017/3/23.
//  Copyright © 2017年 wangluting. All rights reserved.
//

#import "DTTableViewController.h"
#import "DTTableViewBaseCell.h"

#define ADD_CELL(CLASS,OBJ)            [self initCellForClass:[CLASS class] data:OBJ]
#define ADD_CELLES(ClassArray,OBJS)    [self initCellForClasses:ClassArray datas:OBJS]
#define INSERT_CELL(CLASS,OBJ,ROW)     [self insertCellForClass:CLASS data:OBJ insertRow:ROW]
#define INSERT_CELLES(CLASS,OBJS,ROWS) [self insertCellsForClasss:CLASS datas:OBJ insertRows:ROWS]

@interface DTBaseTableViewController : DTTableViewController

@property(nonatomic, strong) NSMutableArray *rows;

- (void)scrollToTop:(BOOL)animation;

- (void)initCellForClass:(Class)className data:(id)data;

- (void)initCellForClasses:(NSArray *)classNames datas:(NSArray *)datas;

- (void)reloadDataSource;

- (void)reloadSectionsDataSource;

- (BaseSource *)configCellForClass:(Class)className data:(id)data;

- (void)insertCellForClass:(Class)className
                dataSource:(id)dataSource
                 insertRow:(NSInteger)insertRow;

- (void)insertCellsForClasss:(NSArray <Class> *)classNames
                       datas:(NSArray <id> *)datas
                  insertRows:(NSArray <NSNumber *> *)insertRows;

- (void)insertRowsAtIndexPaths:(NSArray *)indexPaths
                       animate:(UITableViewRowAnimation)animate;

@end
