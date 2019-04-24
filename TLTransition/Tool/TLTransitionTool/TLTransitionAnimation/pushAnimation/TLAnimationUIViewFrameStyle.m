//
//  TLAnimationUIViewScale.m
//  zhuanchang
//
//  Created by Mac on 2019/1/28.
//  Copyright © 2019年 tanglei. All rights reserved.
//

#define TLTransitionTime 0.5

#import "TLAnimationUIViewFrameStyle.h"
#import "UIViewController+TLTransition.h"

@implementation TLAnimationUIViewFrameStyle

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    return TLTransitionTime;
}
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *fromView = fromVC.view;
    UIView *toView = toVC.view;
    toView.alpha = 0;
    
    NSArray *fromSubViews = [fromVC tl_transitionUIViewFrameViews];
    NSArray *toSubViews = [toVC tl_transitionUIViewFrameViews];
    
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:toView];
    
    NSMutableArray *fromSubViewCopyArr = [[NSMutableArray alloc]init];
    for (int i =0; i <fromSubViews.count; i ++) {
        
        UIView *fromSubView = fromSubViews[i];
        
        //YES，代表视图的属性改变渲染完毕后截屏，参数为NO代表立刻将当前状态的视图截图
        UIView *fromSubViewCopy = [fromSubView snapshotViewAfterScreenUpdates:NO];
        CGRect rect = [fromSubView convertRect:fromSubView.bounds toView:TLKeyWindow];
        fromSubViewCopy.frame = rect;
        [containerView addSubview:fromSubViewCopy];
        
        [fromSubViewCopyArr addObject:fromSubViewCopy];
    }
    
    
    //设置动画前的各个控件的状态
    for (UIView *toSubView in toSubViews) {
        toSubView.hidden = YES;
    }
    
    //开始做动画
    [UIView animateWithDuration:TLTransitionTime animations:^{
        
        fromView.alpha = 0;
        toView.alpha = 1;
        for (int i =0; i <fromSubViewCopyArr.count; i ++) {
            
            UIView *fromSubViewCopy = fromSubViewCopyArr[i];
            UIView *toSubView = toSubViews[i];
            CGRect rect = [toSubView convertRect:toSubView.bounds toView:TLKeyWindow];
            fromSubViewCopy.frame = rect;
        }
        
    } completion:^(BOOL finished) {
        
        if (!transitionContext.transitionWasCancelled) {
            
            fromView.alpha = 1;
            for (UIView *toSubView in toSubViews) {
                toSubView.hidden = NO;
            }
        }
        for (UIView *fromSubViewCopy in fromSubViewCopyArr) {
            [fromSubViewCopy removeFromSuperview];
        }
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}
@end

