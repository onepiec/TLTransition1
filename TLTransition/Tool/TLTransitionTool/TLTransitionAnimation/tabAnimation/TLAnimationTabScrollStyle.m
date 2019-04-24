//
//  TLAnimationTabScrollStyle.m
//  zhuanchang
//
//  Created by Mac on 2019/2/1.
//  Copyright © 2019年 tanglei. All rights reserved.
//

#define TLTransitionTime 0.5

#import "TLAnimationTabScrollStyle.h"
#import "UIViewController+TLTransition.h"

@implementation TLAnimationTabScrollStyle


- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    return TLTransitionTime;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UINavigationController *fromVc = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UINavigationController *toVc = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *fromV = fromVc.view;
    UIView *toV = toVc.view;
    
    
    // 转场环境
    UIView *containView = [transitionContext containerView];
    
    if (toVc.index > fromVc.index) {
        
        toV.frame = CGRectMake([UIScreen mainScreen].bounds.size.width, 0, containView.frame.size.width, containView.frame.size.height);
        
        [containView addSubview:toV];
        // 动画
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            
            fromV.transform = CGAffineTransformTranslate(fromV.transform, -[UIScreen mainScreen].bounds.size.width,0);
            toV.transform = CGAffineTransformTranslate(toV.transform, -[UIScreen mainScreen].bounds.size.width, 0);
            
        } completion:^(BOOL finished) {
            
            [transitionContext completeTransition:YES];
        }];
        
        
    }else if (toVc.index < fromVc.index) {
        
        toV.frame = CGRectMake(- [UIScreen mainScreen].bounds.size.width, 0, containView.frame.size.width, containView.frame.size.height);
        
        [containView addSubview:toV];
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            
            fromV.transform = CGAffineTransformTranslate(fromV.transform, [UIScreen mainScreen].bounds.size.width,0);
            toV.transform = CGAffineTransformTranslate(toV.transform, [UIScreen mainScreen].bounds.size.width, 0);
            
        } completion:^(BOOL finished) {
            
            [fromV removeFromSuperview];
            [transitionContext completeTransition:YES];
        }];
    }
}
@end
