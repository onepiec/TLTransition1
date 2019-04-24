//
//  BaseViewController.m
//  DCC
//
//  Created by Mac on 2019/1/22.
//  Copyright © 2019年 tanglei. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.extendedLayoutIncludesOpaqueBars = YES;
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.hideNavBar = self.hideNavBar;
    
}



@end
