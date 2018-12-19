//
//  DTTableDataSource.m
//  HN-Nniu
//
//  Created by wangluting on 2017/3/24.
//  Copyright © 2017年 wangluting. All rights reserved.
//

#import "DTTableDataSource.h"
#import "DTTableViewBaseCell.h"
#import "BaseSource.h"

const float headerHeight = 22.0f;
const float rowHeight = 60.0f;

@interface DTTableDataSource ()

@property (nonatomic, strong) NSMutableDictionary *classActionArray;

@end

@implementation DTTableDataSource

@synthesize sections = _sections, rows = _rows;
@synthesize delegate = _delegate;
@synthesize sectionCount = _sectionCount;

- (instancetype)init {
    if (self = [super init]) {
        _classActionArray = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)dealloc {
    _delegate = nil;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)heightForHeaderInSection:(NSInteger)section {
    if (_sections.count || self.sectionCount > 0) {
        return self.sectionHeaderHeight > 0?self.sectionHeaderHeight:headerHeight;
    }
    return 0.0f;
}

- (CGFloat)heightForFooterInSection:(NSInteger)section {
    if (_sections.count || self.sectionCount > 0) {
        return self.sectionFootHeight > 0?self.sectionFootHeight:0.0f;
    }
    return 0.0f;
}

//#if __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_8_0
///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    BaseSource *source = nil;
    if(_sections.count || self.sectionCount > 0) {
        NSArray* rowArray = [_rows objectAtIndex:indexPath.section];
        if(rowArray.count < indexPath.row){
            source = [rowArray objectAtIndex:rowArray.count - 1];
            if ([source isKindOfClass:[BaseSource  class]]) {
                return [source heightForSource:tableView.bounds.size.width];
            }
        }
        source = [rowArray objectAtIndex:indexPath.row];
        if ([source isKindOfClass:[BaseSource  class]]) {
            return [source heightForSource:tableView.bounds.size.width];
        }
    }
    if (row < self.rows.count && [[self.rows objectAtIndex:row] isKindOfClass:[BaseSource class]]) {
        BaseSource *source = [self.rows objectAtIndex:row];
        return [source heightForSource:tableView.bounds.size.width];
    }
    return rowHeight;
}

//#endif

///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIView *)viewForHeaderInSection:(NSInteger)section {
    return  [[UIView alloc] initWithFrame:CGRectZero];
}

- (UIView *)viewForFooterInSection:(NSInteger)section {
    return  [[UIView alloc] initWithFrame:CGRectZero];
}

- (NSString*)tableView:(UITableView*)tableView titleOfHeaderAtSection:(NSInteger)section {
    if(_sections.count || self.sectionCount > 0) return [_sections objectAtIndex:section];
    
    return nil;
}

- (Class)DTTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BaseSource *baseSource = nil;
    if (_sections.count || self.sectionCount > 0) {
        NSArray* rowArray = [_rows objectAtIndex:indexPath.section];
        baseSource = [rowArray objectAtIndex:indexPath.row];
    } else {
        baseSource =  [self.rows objectAtIndex:indexPath.row];
    }
    Class cls = [baseSource cellClass];
    if (!cls) return [[baseSource class] cellForClass];
    
    return cls;
}

- (id)tableView:(UITableView*)tableView itemForRowAtIndexPath:(NSIndexPath*)indexPath {
    if(_sections.count || self.sectionCount > 0) {
        NSArray* rowArray = [_rows objectAtIndex:indexPath.section];
        if(rowArray.count < indexPath.row){
            return [rowArray objectAtIndex:rowArray.count - 1];
        }
        return [rowArray objectAtIndex:indexPath.row];
    }
    if(_rows.count < indexPath.row)return nil;
    return [_rows objectAtIndex:indexPath.row];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(_sections.count || self.sectionCount > 0) {
        NSArray* rowArray = [_rows objectAtIndex:section];
        return [rowArray count];
    }
    return [_rows count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionCount > 0 ? self.sectionCount:MAX([_sections count], 1);
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id baseSource = [self tableView:tableView
              itemForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row
                                                       inSection:indexPath.section]];
    Class class = nil;
    NSString* identifier = nil;
    UITableViewCell* cell = nil;
    UINib *nib = nil;
    if ([baseSource respondsToSelector:@selector(cellNib)]){
        nib = [baseSource cellNib];
    }
    if(nil != nib){
        class = [baseSource cellClass];;//
        if (!class)  class = [[baseSource class] cellForClass];
        identifier = NSStringFromClass(class);
        [tableView registerNib:nib forCellReuseIdentifier:identifier];
        cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    } else {
        class = [self DTTableView:tableView cellForRowAtIndexPath:indexPath];
        if (nil != class) {
            identifier = NSStringFromClass(class);
            if (baseSource) {
                identifier = [identifier stringByAppendingFormat:@".%@", NSStringFromClass([baseSource class])];
            }
            cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil) {
                cell = [[class alloc] initWithStyle:UITableViewCellStyleDefault
                                    reuseIdentifier:identifier];
            }
        }
    }
#ifdef DEBUG
    assert(cell != NULL);
#endif
    if([cell isKindOfClass:[DTTableViewBaseCell class]]) {
        
        [self tableView:tableView willDisplayCell:cell AtIndexPath:indexPath];
        [(DTTableViewBaseCell*)cell setIndexPath:indexPath];
        [(DTTableViewBaseCell*)cell updateCellWithSource:baseSource];
        if ([self hasActionForClass:class]) {
            [(DTTableViewBaseCell*)cell setAction:[self actionForClass:class]];
        }
        [(DTTableViewBaseCell*)cell setHightedItem:[self hightedValueAtIndexPath:indexPath]];
    }
    return cell;
}

- (DTHightedItem*)hightedValueAtIndexPath:(NSIndexPath*)indexPath {
    return nil;
}

- (NSArray*)sectionIndexTitlesForTableView:(UITableView*)tableView {
    return nil;
}

- (void)DTTableView:(UITableView *)tableView
    willDisplayCell:(DTTableViewBaseCell *)cell
  forRowAtIndexPath:(NSIndexPath *)indexPath{
    [cell viewWillDisplay];
}

- (void)DTTableView:(UITableView *)tableView didEndDisplayingCell:(DTTableViewBaseCell *)cell
  forRowAtIndexPath:(NSIndexPath*)indexPath {
    [cell viweEndDisplaying];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger)tableView:(UITableView*)tableView sectionForSectionIndexTitle:(NSString*)title
               atIndex:(NSInteger)sectionIndex {
    NSUInteger index = [_sections indexOfObject:title];
    if(index == NSNotFound)return 0;
    return index;
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell*)cell
      AtIndexPath:(NSIndexPath *)indexPath {
    if([cell isKindOfClass:[DTTableViewBaseCell class]]) {
        [(DTTableViewBaseCell*)cell setDelegate:self.delegate];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.canEdit;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if (self.deleteBlock) {
            id object = [self tableView:tableView itemForRowAtIndexPath:indexPath];
            self.deleteBlock(object , self , indexPath);
        }
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}
//
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (void)beginSearch:(NSString*)text {}

- (void)endSearch {}

- (BaseSource *)sourceAtIndexPath:(NSIndexPath *)indexPath {
    BaseSource *source = nil;
    NSInteger row = indexPath.row;
    if(_sections.count || self.sectionCount > 0) {
        NSArray* rowArray = [_rows objectAtIndex:indexPath.section];
        if(rowArray.count < indexPath.row){
            source = [rowArray objectAtIndex:rowArray.count - 1];
        }
        source = [rowArray objectAtIndex:indexPath.row];
    }
    if (row < self.rows.count && [[self.rows objectAtIndex:row] isKindOfClass:[BaseSource class]]) {
        source = [self.rows objectAtIndex:row];
    }
    return source;
}

//TODO 兼容section 问题
- (NSIndexPath *)indexPathWidthSource:(BaseSource *)source {
    NSIndexPath * indexPath = nil;
    int index = 0;
    for (BaseSource *current in self.rows) {
        if (current == source) {
            indexPath = [NSIndexPath indexPathForRow:index inSection:0];
            break;
        }
        index++;
    }
    return indexPath;
}

- (void)attachClass:(Class)cls detailBlock:(DTActionBlock)detailBlock {
    DTBaseAction *action = [self actionForClass:cls];
    action.detailBlock = detailBlock;
}

- (void)attachClass:(Class)cls tapBlock:(DTActionBlock)tapBlock {
    DTBaseAction *action = [self actionForClass:cls];
    action.tapBlock = tapBlock;
}

- (void)attachClass:(Class)cls otherBlock:(DTActionBlock)otherBlock {
    DTBaseAction *action = [self actionForClass:cls];
    action.otherBlock = otherBlock;
}

- (void)attachClass:(Class)cls navagationBlock:(DTActionBlock)navagationBlock {
    DTBaseAction *action = [self actionForClass:cls];
    action.navagationBlock = navagationBlock;
}

- (void)attachClass:(Class)cls deleteBlock:(DTActionBlock)deleteBlock {
    self.deleteBlock = deleteBlock;
}

- (DTBaseAction *)actionForClass:(Class)cls {
    DTBaseAction* action = [self.classActionArray objectForKey:cls];
    if (nil == action) {
        action = [[DTBaseAction alloc] init];
        [self.classActionArray setObject:action forKey:(id<NSCopying>)cls];
    }
    return action;
}

- (BOOL)hasActionForClass:(Class)cls {
    if (![self.classActionArray objectForKey:cls])  return NO;
    
    return YES;
}

@end
