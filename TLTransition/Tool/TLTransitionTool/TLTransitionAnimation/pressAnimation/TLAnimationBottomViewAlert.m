//
//  TLAnimationBottomViewAlert.m
//  zhuanchang
//
//  Created by Mac on 2019/1/29.
//  Copyright © 2019年 tanglei. All rights reserved.
//

#define TLTransitionTime 0.5

#import "TLAnimationBottomViewAlert.h"

@implementation TLAnimationBottomViewAlertPress

- (void)viewWithcornerRadius:(CGFloat)radius view:(UIView *)view{
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = view.bounds;
    maskLayer.path = path.CGPath;
    view.layer.mask = maskLayer;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    return TLTransitionTime;
}
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController * fromVC =
    [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    //设置锚点在屏幕底部以供旋转，中间的会跃层
    fromVC.view.layer.position = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height);
    fromVC.view.layer.anchorPoint = CGPointMake(0.5, 1);
    
    UIViewController * toVC =
    [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    toVC.view.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, toVC.view.frame.size.width, TLTransitionPressHeight);
    [[transitionContext containerView] addSubview:toVC.view];
    
    [self viewWithcornerRadius:8 view:toVC.view];
    [[UIApplication sharedApplication] keyWindow].backgroundColor = [UIColor blackColor];
    
    CATransform3D rotate = CATransform3DIdentity;
    rotate.m34 = -1.0 / 1200;//旋转的立体效果
    rotate = CATransform3DRotate(rotate, 1 * M_PI/180.0, 1, 0, 0);//沿着X轴旋转，正数表上面往里
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        fromVC.view.layer.transform = rotate;
        fromVC.view.alpha = 0.8;
        
        toVC.view.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - TLTransitionPressHeight, toVC.view.frame.size.width, TLTransitionPressHeight);
    } completion:^(BOOL finished) {
        
        
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}
@end


@implementation TLAnimationBottomViewAlertDiss

- (void)viewWithcornerRadius:(CGFloat)radius view:(UIView *)view{
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = view.bounds;
    maskLayer.path = path.CGPath;
    view.layer.mask = maskLayer;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{

    return TLTransitionTime;
}
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    UIViewController * toVC =
    [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIViewController * fromVC =
    [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    [UIView animateWithDuration:TLTransitionTime delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        toVC.view.alpha = 1;
        toVC.view.layer.transform = CATransform3DIdentity;
        
        fromVC.view.frame = CGRectMake(fromVC.view.frame.origin.x, [UIScreen mainScreen].bounds.size.height, fromVC.view.frame.size.width, fromVC.view.frame.size.height);
        
    } completion:^(BOOL finished) {
        
        if (!transitionContext.transitionWasCancelled) {
            
            toVC.view.layer.anchorPoint = CGPointMake(0.5, 0.5);
            toVC.view.layer.position = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2);
            
            [self viewWithcornerRadius:0 view:fromVC.view];
            [[UIApplication sharedApplication] keyWindow].backgroundColor = [UIColor whiteColor];
        }
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];

    }];

}
@end
