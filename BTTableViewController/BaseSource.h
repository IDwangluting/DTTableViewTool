//
//  BaseSource.h
//
//  Created by wangluting on 2017/3/24.
//  Copyright © 2017年 wangluting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  cell 数据源
 */
@interface BaseSource : NSObject

@property (nonatomic, strong)  UIColor *backgroundColor;//cell背景颜色
@property (nonatomic, strong) id userData; 
@property (nonatomic, assign) Class cellClass;//用来绑定哪个cell
@property (nonatomic) double flexibleHeight;//cell的固定高度
@property (nonatomic) BOOL loadFromNib;//从nib 加载 default NO

+ (Class)cellForClass;
- (UINib *)cellNib;

- (CGFloat)heightForSource:(CGFloat)width;//cell动态计算高度
- (void)reset;

@end
