//
//  FLSimpleModel.h
//  Flipped
//
//  Created by luting on 2018/11/13.
//  Copyright © 2018年 zyb. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, FLSettingFuncType) {
    FLSettingFuncTypeUtil = 0,
    FLSettingFuncTypeClearDiskData,
    FLSettingFuncTypeUserAgreement,
    FLSettingFuncTypeAppTest
};

@interface FLSimpleModel : NSObject

@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *detail;
@property (nonatomic,copy)id params;
@property (nonatomic)FLSettingFuncType funcType;

@end
NS_ASSUME_NONNULL_END
