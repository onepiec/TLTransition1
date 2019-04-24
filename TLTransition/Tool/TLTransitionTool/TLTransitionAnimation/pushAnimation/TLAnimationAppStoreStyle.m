//
//  TLAnimationAppStoreStyle.m
//  appStore
//
//  Created by hello on 2019/4/10.
//  Copyright © 2019 tanglei. All rights reserved.
//
#define TLTransitionTimePush 0.8
#define TLTransitionTimePop 0.8

#import "TLAnimationAppStoreStyle.h"
#import "UIViewController+TLTransition.h"

@implementation TLAnimationAppStoreStylePush

- (UIImage *)imageFromView:(UIView *)snapView {
    
    UIGraphicsBeginImageContextWithOptions(snapView.frame.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [snapView.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    return TLTransitionTimePush;
}
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *toView = toVC.view;
    toView.alpha = 0;
    toView.userInteractionEnabled = NO;
    [[transitionContext containerView] addSubview:toView];
    
    NSArray *fromSubViews = [fromVC tl_transitionUIViewFrameViews];
    NSArray *toSubViews = [toVC tl_transitionUIViewFrameViews];
    
    //将fromVC需要动画的Views拷贝并加载到[transitionContext containerView]上
    NSMutableArray *fromSubViewCopyArr = [[NSMutableArray alloc]init];
    
    for (UIView *fromSubView in fromSubViews) {
        
        NSMutableArray *subViewArr = [NSMutableArray new];
        
        for (UIView *subView in fromSubView.subviews) {
            [subViewArr addObject:subView];
            subView.hidden = !subView.hidden;
        }
        //将fromVC的Views的cornerRadius归为0
        CGFloat corner = fromSubView.layer.cornerRadius;
        fromSubView.layer.cornerRadius = 0;
        UIImage *image = [self imageFromView:fromSubView];
        fromSubView.layer.cornerRadius = corner;
        
        CGRect rect = [fromSubView convertRect:fromSubView.bounds toView:TLKeyWindow];
        UIImageView *fromSubViewCopy = [[UIImageView alloc]initWithImage:image];
        fromSubViewCopy.layer.cornerRadius = corner;
        fromSubViewCopy.frame = rect;
        [[transitionContext containerView] addSubview:fromSubViewCopy];
        [fromSubViewCopyArr addObject:fromSubViewCopy];
        
        for (UIView *subView in subViewArr) {
            subView.hidden = !subView.hidden;
        }
    }
    
    //将toVC最后一个View放入fromVC第一个View的下面，高度为0
    UIImageView *fromSubViewCopy0 = fromSubViewCopyArr[0];
    fromSubViewCopy0.image = [UIImage imageNamed:[fromVC tl_transitionUIViewImage]];
    fromSubViewCopy0.contentMode = UIViewContentModeCenter;
    fromSubViewCopy0.layer.masksToBounds = YES;
    
    UIView *lastView = [toSubViews lastObject];
    UIImage *lastImage = [self imageFromView:lastView];
    CGRect newRect = [lastView convertRect:lastView.bounds toView:TLKeyWindow];
    CGFloat height = newRect.size.height;
    UIImageView *lastViewCopy = [[UIImageView alloc]initWithImage:lastImage];
    lastViewCopy.frame = CGRectMake(newRect.origin.x, CGRectGetMaxY(fromSubViewCopy0.frame), newRect.size.width, 0);
    [[transitionContext containerView] addSubview:lastViewCopy];

    [UIView animateWithDuration:TLTransitionTimePush delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0.2 options:UIViewAnimationOptionCurveEaseInOut animations:^{

        for (int i =0; i <fromSubViewCopyArr.count; i ++) {

            UIView *fromSubViewCopy = fromSubViewCopyArr[i];
            UIView *toSubView = toSubViews[i];
            CGRect rect = [toSubView convertRect:toSubView.bounds toView:TLKeyWindow];
            fromSubViewCopy.frame = rect;
            fromSubViewCopy.layer.cornerRadius = 0;
        }

        UIView *fromSubViewCopy0 = fromSubViewCopyArr[0];
        lastViewCopy.frame = CGRectMake(lastViewCopy.frame.origin.x, CGRectGetMaxY(fromSubViewCopy0.frame), lastViewCopy.frame.size.width, height);

    } completion:^(BOOL finished) {
        
//        NSLog(@"哈哈哈哈哈哈哈哈哈哈或");
        toView.alpha = 1;
        toView.userInteractionEnabled = YES;
        for (UIView *fromSubViewCopy in fromSubViewCopyArr) {
            [fromSubViewCopy removeFromSuperview];
        }
        [lastViewCopy removeFromSuperview];
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end


@implementation TLAnimationAppStoreStylePop

- (UIImage *)imageFromView:(UIView *)snapView {
    
    UIGraphicsBeginImageContextWithOptions(snapView.frame.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [snapView.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    return TLTransitionTimePop +0.2;
}
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    toVC.view.userInteractionEnabled = NO;
    
    [[transitionContext containerView] addSubview:toVC.view];
    
    NSArray *fromSubViews = [fromVC tl_transitionUIViewFrameViews];
    NSArray *toSubViews = [toVC tl_transitionUIViewFrameViews];
    
    //毛玻璃背景
    UIBlurEffect *blurEffect =[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *effectView =[[UIVisualEffectView alloc]initWithEffect:blurEffect];
    effectView.frame = TLKeyWindow.bounds;
    [[transitionContext containerView] addSubview:effectView];
    
    [[transitionContext containerView] addSubview:fromVC.view];
    
    //动画
    fromVC.view.clipsToBounds = YES;//单独设置cornerRadius，他的子视图不会改变cornerRadius
    [UIView animateWithDuration:0.2 animations:^{
        
        fromVC.view.layer.cornerRadius = 8;
        fromVC.view.transform = CGAffineTransformMakeScale(0.8, 0.8);
        
    } completion:^(BOOL finished) {
        
        if (!transitionContext.transitionWasCancelled) {
            
            NSMutableArray *fromSubViewCopyArr = [[NSMutableArray alloc]init];
            
            //因为fromVC的views比toVC多一个,所以减1
            for (int i =0; i <fromSubViews.count -1; i ++) {
                
                NSMutableArray *subViewArr = [NSMutableArray new];
                
                UIView *fromSubView = fromSubViews[i];
                for (UIView *subView in fromSubView.subviews) {
                    
                    [subViewArr addObject:subView];
                    subView.hidden = !subView.hidden;
                }
                UIImage *image = [self imageFromView:fromSubView];
                CGRect rect = [fromSubView convertRect:fromSubView.bounds toView:TLKeyWindow];
                UIImageView *fromSubViewCopy = [[UIImageView alloc]initWithImage:image];
                fromSubViewCopy.layer.masksToBounds = YES;
                fromSubViewCopy.frame = rect;
                [[transitionContext containerView] addSubview:fromSubViewCopy];
                [fromSubViewCopyArr addObject:fromSubViewCopy];
                
                for (UIView *subView in subViewArr) {
                    subView.hidden = !subView.hidden;
                }
            }
            
            for (UIView *toSubView in toSubViews) {
                toSubView.hidden = YES;
            }
            //将fromVC最后一个View放入fromVC第一个View的下面
            UIView *lastView = [fromSubViews lastObject];
            UIImage *image = [self imageFromView:lastView];
            CGRect newRect = [lastView convertRect:lastView.bounds toView:TLKeyWindow];
            UIImageView *lastViewCopy = [[UIImageView alloc]initWithImage:image];
            lastViewCopy.frame = newRect;
            [[transitionContext containerView] addSubview:lastViewCopy];
            
            UIImageView *fromSubViewCopy0 = fromSubViewCopyArr[0];
            fromSubViewCopy0.image = [UIImage imageNamed:[fromVC tl_transitionUIViewImage]];
            fromSubViewCopy0.contentMode = UIViewContentModeCenter;
            fromSubViewCopy0.layer.masksToBounds = YES;
            
            [UIView animateWithDuration:TLTransitionTimePop delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0.2 options:UIViewAnimationOptionCurveEaseOut animations:^{
                
                for (int i =0; i <fromSubViewCopyArr.count; i ++) {
                    
                    UIView *fromSubViewCopy = fromSubViewCopyArr[i];
                    UIView *toSubView = toSubViews[i];
                    CGRect rect = [toSubView convertRect:toSubView.bounds toView:TLKeyWindow];
                    fromSubViewCopy.frame = rect;
                    fromSubViewCopy.layer.cornerRadius = toSubView.layer.cornerRadius;
                }
                
                UIImageView *fromSubViewCopy0 = fromSubViewCopyArr[0];
                lastViewCopy.frame = CGRectMake(fromSubViewCopy0.frame.origin.x, CGRectGetMaxY(fromSubViewCopy0.frame), fromSubViewCopy0.frame.size.width, 0);
                lastViewCopy.alpha = 0;
                effectView.alpha = 0;
                                
            } completion:^(BOOL finished) {
                
                for (UIView *fromSubViewCopy in fromSubViewCopyArr) {
                    [fromSubViewCopy removeFromSuperview];
                }
                for (UIView *toSubView in toSubViews) {
                    toSubView.hidden = NO;
                }
                [lastViewCopy removeFromSuperview];
                toVC.view.userInteractionEnabled = YES;
                [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
            }];
            
        }
        [effectView removeFromSuperview];
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        
    }];

}

@end
