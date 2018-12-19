//
//  ViewController.m
//  DTTableViewToolExmaple
//
//  Created by luting on 2018/12/19.
//  Copyright © 2018 luting. All rights reserved.
//

#import "ViewController.h"
#import "FLSettingViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor brownColor];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.navigationController pushViewController:[FLSettingViewController new] animated:YES];
}

@end
