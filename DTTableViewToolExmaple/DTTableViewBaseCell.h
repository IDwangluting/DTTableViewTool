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
//  DTTableViewBaseCell.h
//  HN-Nniu
//
//  Created by wangluting on 2017/3/24.
//  Copyright © 2017年 wangluting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DTBaseAction.h"
#import "BaseSource.h"

@protocol DTTableViewCellDelegate <UITableViewDelegate>

@optional
- (void)didClickedDetail:(BaseSource *)baseSource;

@end

@interface DTHightedItem : NSObject{
    NSRange _hightedRange;
    NSString *_hightedString;
}

@property (nonatomic, assign) NSRange highlightedRange;
@property (nonatomic, copy) NSString* highlightedString;

@end

@interface DTTableViewBaseCell : UITableViewCell {
    UIView *subContentView;
    CGRect _displayRect;
    DTHightedItem *_hightedItem;
}

@property (nonatomic, readonly)UIView *subContentView;
@property (nonatomic, retain) DTHightedItem *hightedItem;
@property (nonatomic, weak) id<DTTableViewCellDelegate>delegate;
@property (nonatomic, retain) DTBaseAction *action;
@property (nonatomic, retain) NSIndexPath *indexPath;

- (void)drawContentView:(CGRect)r; // subclasses should implement
//根据source更新cell

- (void)viewWillDisplay;
- (void)viweEndDisplaying;

- (void)updateCellWithSource:(id)source;
+ (Class)cellForClass;

+ (DTTableViewBaseCell *)newCell;

+ (CGFloat)cellHeight;
- (CGFloat)cellHeight;

@end
