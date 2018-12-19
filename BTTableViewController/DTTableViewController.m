//
//  DTTableViewController.m
//  HN-Nniu
//
//  Created by wangluting on 2017/3/24.
//  Copyright © 2017年 wangluting. All rights reserved.
//

#import "DTTableViewController.h"
#import "DTTableViewBaseCell.h"
#import "DTBaseAction.h"
#import "UIView+Frame.h"

@interface DTTableViewController () <UITableViewDelegate> {
    CGPoint _contentOffset;
    CGSize _contentSize;
    UITableView *_tableView;
}
@end

@implementation DTTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadTableView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tableView.scrollEnabled = YES;
}

- (void)loadTableView {
    _tableView = [[UITableView alloc] initWithFrame:self.view.frame] ;
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth ;
    _tableView.separatorStyle   = UITableViewCellSeparatorStyleSingleLine ;
    _tableView.separatorInset   = UIEdgeInsetsZero ;
    _tableView.tableFooterView  = [[UIView alloc] initWithFrame:CGRectZero] ;
    _tableView.backgroundColor  = [UIColor clearColor];
    [self.view addSubview:_tableView];
}

#pragma mark - UITableViewCellSeparatorInsets
- (void)viewDidLayoutSubviews {
    if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
    id<DTTableDataSource> source = (id<DTTableDataSource>)tableView.dataSource;
    if([source respondsToSelector:@selector(DTTableView:willDisplayCell:forRowAtIndexPath:)]){
        [source DTTableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath*)indexPath {
    id<DTTableDataSource> source = (id<DTTableDataSource>)tableView.dataSource;
    if([source respondsToSelector:@selector(DTTableView:didEndDisplayingCell:forRowAtIndexPath:)]){
        [source DTTableView:tableView didEndDisplayingCell:cell forRowAtIndexPath:indexPath];
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setDataSource:(id<DTTableDataSource>)dataSource {
    if (dataSource != _dataSource ) {
        _dataSource = dataSource ;
        self.tableView.dataSource = nil;
        self.tableView.dataSource = dataSource;
        self.tableView.delegate = self;
        [self.tableView reloadData];
    }
}

#pragma mark - UITableViewDelegate

//#if __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_8_0
///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    id<DTTableDataSource> source = (id<DTTableDataSource>)tableView.dataSource;
    if([source respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)]){
        return [source tableView:tableView heightForRowAtIndexPath:indexPath];
    }
    return 0.0f;
}
//#endif

///////////////////////////////////////////////////////////////////////////////////////////////////
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    id<DTTableDataSource> source = (id<DTTableDataSource>)tableView.dataSource;
    if([source respondsToSelector:@selector(heightForHeaderInSection:)]){
        return [source heightForHeaderInSection:section];
    }
    return 0.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    id<DTTableDataSource> source = (id<DTTableDataSource>)tableView.dataSource;
    if([source respondsToSelector:@selector(heightForFooterInSection:)]){
        return [source heightForFooterInSection:section];
    }
    return 0.0f;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    id<DTTableDataSource> source = (id<DTTableDataSource>)tableView.dataSource;
    if([source respondsToSelector:@selector(viewForHeaderInSection:)]){
        return [source viewForHeaderInSection:section];
    }
    return  [[UIView alloc] initWithFrame:CGRectZero];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    id<DTTableDataSource> source = (id<DTTableDataSource>)tableView.dataSource;
    if([source respondsToSelector:@selector(viewForFooterInSection:)]){
        return [source viewForFooterInSection:section];
    }
    return  [[UIView alloc] initWithFrame:CGRectZero];
}

// custom view for footer. will be adjusted to default or specified footer height
///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    id tempSource = (id<DTTableDataSource>)tableView.dataSource;
    DTTableDataSource *source = tempSource ;
    if ([source respondsToSelector:@selector(DTTableView:cellForRowAtIndexPath:)]) {
        Class class = [source DTTableView:tableView cellForRowAtIndexPath:indexPath];
        if ([source hasActionForClass:class]) {
            DTBaseAction *action = [source actionForClass:class];
            if (!action)  return ;
            
            BaseSource *model = [source sourceAtIndexPath:indexPath];
            if (action.tapBlock) {
                action.tapBlock(model , action.target , indexPath);
            }else if(action.tapSel && [action.target respondsToSelector:action.tapSel]) {
                IMP imp = [action.target methodForSelector:action.tapSel];
                if (!imp)  return ;
                
                void (*func)(id, SEL, id) = (void *)imp;
                if (func)  func(action.target, action.tapSel, model);
            }
        }
    }
}

#pragma mark -
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)restoreContentOffset {
    CGSize contentSize = self.tableView.contentSize;
    _contentOffset.y += contentSize.height - _contentSize.height;
    CGSize size = self.tableView.bounds.size;
    if (_contentOffset.y + size.height > contentSize.height) {
        _contentOffset.y = contentSize.height - size.height;
    }
    if (_contentOffset.y < 0) _contentOffset.y = 0;
    
    [self.tableView setContentOffset:_contentOffset animated:NO];
}

- (void)reloadTableViewAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView beginUpdates];
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                          withRowAnimation:UITableViewRowAnimationNone];
    [self.tableView endUpdates];
}

- (void)saveContentOffset {
    _contentOffset = self.tableView.contentOffset;
    _contentSize = self.tableView.contentSize;
}

- (void)scrollToBottom:(BOOL)animation {
    CGSize  contentSize = self.tableView.contentSize;
    if (contentSize.height + self.tableView.contentInset.top > self.tableView.height) {
        CGPoint offset = CGPointMake(0, contentSize.height - self.tableView.height);
        [self.tableView setContentOffset:offset animated:animation];
    }
}

- (void)willMoveToParentViewController:(UIViewController*)parent{
    [super willMoveToParentViewController:parent];
    self.tableView.scrollEnabled = NO;
}

@end
