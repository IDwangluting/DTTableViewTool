// Copyright (c) 2008 Loren Brichter
// 
// Permission is hereby granted, free of charge, to any person
// obtaining a copy of this software and associated documentation
// files (the "Software"), to deal in the Software without
// restriction, including without limitation the rights to use,
// copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the
// Software is furnished to do so, subject to the following
// conditions:
// 
// The above copyright notice and this permission notice shall be
// included in all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
// OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
// HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
// WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
// OTHER DEALINGS IN THE SOFTWARE.
//
//  DTTableViewBaseCell.m
//  HN-Nniu
//
//  Created by wangluting on 2017/3/24.
//  Copyright © 2017年 wangluting. All rights reserved.
//

#import "DTTableViewBaseCell.h"

@interface DTTableViewBaseCellView : UIView
@end

@implementation DTTableViewBaseCellView

@end

@implementation DTHightedItem

@synthesize highlightedRange = _hightedRange, highlightedString = _hightedString;

@end

@implementation DTTableViewBaseCell

@synthesize subContentView;
@synthesize hightedItem = _hightedItem;
@synthesize delegate = _delegate;
@synthesize action = _action;
@synthesize indexPath = _indexPath;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellAccessoryNone;
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellAccessoryNone;
}

- (void)drawContentView:(CGRect)r {
    // subclasses should implement this
}

- (void)viewWillDisplay {}

- (void)updateCellWithSource:(id)source {}

- (void)viweEndDisplaying {}

#pragma mark baseCell
+ (Class)cellForClass {
    return [DTTableViewBaseCell class];
}

+ (CGFloat)tableView:(UITableView*)tableView rowHeightForSource:(id)source {
    return 60.0f;
}

- (void)dealloc {
}

+ (DTTableViewBaseCell *)newCell {
    NSString *cellName = NSStringFromClass([self class]);
    if ([cellName isEqualToString:@"DTTableViewBaseCell"])  return nil;
    
    return [[[NSBundle mainBundle] loadNibNamed:cellName
                                          owner:self options:nil] lastObject];
}

+ (CGFloat)cellHeight {
    return 0.0f;
}

- (CGFloat)cellHeight {
    return 0.0f;
}

@end
