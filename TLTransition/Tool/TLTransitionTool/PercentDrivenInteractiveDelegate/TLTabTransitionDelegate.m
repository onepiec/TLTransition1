//
//  TLTabTransitionDelegate.m
//  TLTransition
//
//  Created by hello on 2019/4/12.
//  Copyright © 2019 tanglei. All rights reserved.
//

#import "TLTabTransitionDelegate.h"
#import "TLAnimationTabScrollStyle.h"

@implementation TLTabTransitionDelegate

+ (instancetype)shareInstance{
    
    static TLTabTransitionDelegate *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [TLTabTransitionDelegate new];
    });
    return _instance;
}
- (nullable id <UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController animationControllerForTransitionFromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    
    return [TLAnimationTabScrollStyle new];
}

@end
