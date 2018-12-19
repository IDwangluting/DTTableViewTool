//
//  MLSafe.h
//  homework
//
//  Created by luting on 2018/2/9.
//  Copyright © 2018年 zyb. All rights reserved.
//

#ifndef MLSafe_h
#define MLSafe_h

//safe
#define SafeForString(string)         ((string && [string isKindOfClass:[NSString class]]) ? string : @"")
#define SafeForDictionary(dictionary) ((dictionary && [dictionary isKindOfClass:[NSDictionary class]]) ? dictionary : @{})
#define SafeForArray(array)           ((array && [array isKindOfClass:[NSArray class]]) ? array : @[])

#endif /* MLSafe_h */
