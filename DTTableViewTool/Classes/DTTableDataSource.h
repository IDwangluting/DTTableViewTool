//
//  DTTableDataSource.h
//  HN-Nniu
//
//  Created by wangluting on 2017/3/24.
//  Copyright © 2017年 wangluting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DTBaseAction.h"

@class DTHightedItem;

@protocol DTTableDataSource <UITableViewDataSource>

@optional

- (void)DTTableView:(UITableView *)tableView
    willDisplayCell:(UITableViewCell *)cell
  forRowAtIndexPath:(NSIndexPath *)indexPath ;

- (void)DTTableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath;

//@property (nonatomic, assign) id <UITableViewDelegate>tableDelegate;

// Variable height support
- (CGFloat)heightForHeaderInSection:(NSInteger)section;
- (CGFloat)heightForFooterInSection:(NSInteger)section;
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

// Section header & footer information. Views are preferred over title should you decide to provide both
- (UIView *)viewForHeaderInSection:(NSInteger)section;
- (UIView *)viewForFooterInSection:(NSInteger)section;

// title for section
- (NSString*)tableView:(UITableView*)tableView titleOfHeaderAtSection:(NSInteger)section;
// custom cell class
- (Class)DTTableView:(UITableView *)tableView
cellForRowAtIndexPath:(NSIndexPath *)indexPath;
// custom cell 's source
- (id)tableView:(UITableView*)tableView itemForRowAtIndexPath:(NSIndexPath*)indexPath;
/*
 * because the delegate & dataSource not together,so must call this set the cell's delegate
 * You can set the custom cell delegate so on...
 */
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell*)cell
      AtIndexPath:(NSIndexPath *)indexPath;
/*
 * when You have searchbar ,then user clicked search
 * return value  true->have search result, no->no have
 **/
//- (BOOL)beginSearch:(NSString*)text;
/*
 * return highted item when search ,inlcude range,string
 **/
- (DTHightedItem*)hightedValueAtIndexPath:(NSIndexPath*)indexPath;

//搜索回调
- (void)beginSearch:(NSString*)text;
- (void)endSearch;
/*
 * show section index title
 */
//- (void)showTitleForSection:(NSString*)title;

@end

@protocol DTTableViewCellDelegate;
@class BaseSource;

@interface DTTableDataSource : NSObject <DTTableDataSource>

@property (nonatomic, retain) NSArray *sections;
@property (nonatomic, retain) NSArray *rows;
@property (nonatomic, assign) id<DTTableViewCellDelegate>delegate;
@property (nonatomic, assign) NSInteger sectionCount;
@property (nonatomic, assign) BOOL canEdit;
@property (nonatomic, copy) DTActionBlock deleteBlock;

@property (nonatomic, assign) CGFloat sectionHeaderHeight;
@property (nonatomic, assign) CGFloat sectionFootHeight;

/**
 *  根据对应indexpath 返回source
 *
 *  @param indexPath tableview‘s indexPath
 *
 *  @return baseSource 每个cell的model
 */
- (BaseSource *)sourceAtIndexPath:(NSIndexPath *)indexPath;
- (NSIndexPath *)indexPathWidthSource:(BaseSource *)source;

//给对应的cell 绑定事件
- (void)attachClass:(Class)cls detailBlock:(DTActionBlock)detailBlock;
- (void)attachClass:(Class)cls tapBlock:(DTActionBlock)tapBlock;
- (void)attachClass:(Class)cls otherBlock:(DTActionBlock)otherBlock;
- (void)attachClass:(Class)cls navagationBlock:(DTActionBlock)navagationBlock;

- (BOOL)hasActionForClass:(Class)cls;
- (DTBaseAction *)actionForClass:(Class)cls;

@end
