//
//  DTBaseAction.h
//  HN-Nniu
//
//  Created by wangluting on 2017/3/24.
//  Copyright © 2017年 wangluting. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^DTActionBlock)(id dataSource, id target, id indexPath);

@interface DTBaseAction : NSObject

@property (nonatomic, copy) DTActionBlock tapBlock;        //default action 如果是tableview didSelect
@property (nonatomic, copy) DTActionBlock detailBlock ;
@property (nonatomic, copy) DTActionBlock otherBlock  ;
@property (nonatomic, copy) DTActionBlock deleteBlock ;
@property (nonatomic, copy) DTActionBlock navagationBlock; //跳转导航

@property (nonatomic) SEL detailSel ;                      //返回一个参数object
@property (nonatomic) SEL tapSel ;
@property (nonatomic) SEL otherSel ;

@property (nonatomic, weak) id target;

- (id)initWithTarget:(id)target;

@end
