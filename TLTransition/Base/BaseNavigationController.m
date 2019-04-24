//
//  BaseNavigationController.m
//  TLTransition
//
//  Created by hello on 2019/4/18.
//  Copyright © 2019 tanglei. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    [self setNavigationBarHidden:self.hideNavBar animated:YES];
}
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (viewController == navigationController.viewControllers[0]){
        
        self.interactivePopGestureRecognizer.enabled = NO;
    }else {
        self.interactivePopGestureRecognizer.enabled = YES;
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
