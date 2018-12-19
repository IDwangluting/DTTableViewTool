//
//  DTBaseAction.m
//  HN-Nniu
//
//  Created by wangluting on 2017/3/24.
//  Copyright © 2017年 wangluting. All rights reserved.
//

#import "DTBaseAction.h"

@implementation DTBaseAction

- (id)initWithTarget:(id)target {
    if (self = [super init]) {
        _target = target;
    }
    return self;
}

@end
