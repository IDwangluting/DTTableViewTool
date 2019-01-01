//
//  DTTableViewController+MethodEncapsulation.h
//  DTTableViewToolExmaple
//
//  Created by luting on 2019/1/1.
//  Copyright © 2019 luting. All rights reserved.
//

#import "DTTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

#define ADD_CELL(CLASS,OBJ)            [self initCellForClass:[CLASS class] data:OBJ]
#define ADD_CELLES(ClassArray,OBJS)    [self initCellForClasses:ClassArray datas:OBJS]
#define INSERT_CELL(CLASS,OBJ,ROW)     [self insertCellForClass:CLASS data:OBJ insertRow:ROW]
#define INSERT_CELLES(CLASS,OBJS,ROWS) [self insertCellsForClasss:CLASS datas:OBJ insertRows:ROWS]

@interface DTTableViewController (MethodEncapsulation)

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

NS_ASSUME_NONNULL_END
