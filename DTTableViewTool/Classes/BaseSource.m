//
//  BaseSource.m
//
//  Created by wangluting on 2017/3/24.
//  Copyright © 2017年 wangluting. All rights reserved.
//

#import "BaseSource.h"
#import "DTTableViewBaseCell.h"

@interface BaseSource () {
    CGSize _baseSize;
    CGFloat _widthForHeight;
    double  _flexibleHeight;
}

@property (nonatomic, assign) CGSize baseSize;
@property (nonatomic, readonly) CGFloat widthForHeight;

@end

@implementation BaseSource
@synthesize baseSize = _baseSize,widthForHeight = _widthForHeight;

+ (Class)cellForClass {
    return [DTTableViewBaseCell class];
}

+ (NSString *)cellForIdentifier {
    static NSString *baseSourceIdentifier = @"baseSourceIdentifier";
    return baseSourceIdentifier;
}

- (Class)cellClass {
    return _cellClass;
}

- (UINib *)cellNib {
    if (![self loadFromNib])  return nil;
    Class cls = _cellClass;
    if (!cls)  cls = [[self class] cellForClass];
    NSString *cellName = NSStringFromClass(cls);
    return [UINib nibWithNibName:cellName bundle:[NSBundle mainBundle]];
}

- (CGFloat)heightForSource:(CGFloat)width {
    if (_widthForHeight != width) {
        _widthForHeight = width;
        _baseSize.height = 0.0f;
    }
    if (_flexibleHeight > 0.00001f)  return _flexibleHeight;
    
    return 0.0f;
}

- (void)reset {
    _baseSize = CGSizeMake(0.0f, 0.0f);
}

@end
