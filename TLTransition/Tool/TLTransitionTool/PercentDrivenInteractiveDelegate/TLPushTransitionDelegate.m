//
//  TLPushTransitionDelegate.m
//  appStore
//
//  Created by hello on 2019/4/12.
//  Copyright © 2019 tanglei. All rights reserved.
//

#import "TLPushTransitionDelegate.h"

#import "UIViewController+TLTransition.h"
#import "TLAnimationUIViewFrameStyle.h"
#import "TLAnimationWindowScaleStyle.h"
#import "TLAnimationAppStoreStyle.h"

@interface TLPushTransitionDelegate ()

@property (nonatomic, assign) BOOL isInteraction;
@property (nonatomic, assign) BOOL isPop;
@property (nonatomic, assign) CGFloat edgeLeftBeganFloat;//侧滑距离

@property (nonatomic, assign) TLPanDirectionType startDirection;//监测开始的手势,由上下滑转左右滑，还是按照上下为基础
@property (nonatomic, assign) CGFloat lastPercentComplete;//改变手势方向时刷新转场进度

@end

@implementation TLPushTransitionDelegate

+ (instancetype)shareInstance{
    
    static TLPushTransitionDelegate *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [TLPushTransitionDelegate new];
    });
    return _instance;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    
//    return NO;
    if ([gestureRecognizer isMemberOfClass:[UIScreenEdgePanGestureRecognizer class]]) {
        
        if ([otherGestureRecognizer isMemberOfClass:[UIScreenEdgePanGestureRecognizer class]]) {
            return NO;
        }
        if ([otherGestureRecognizer isMemberOfClass:[UIPanGestureRecognizer class]]) {
            return NO;
        }
    }
    if ([gestureRecognizer isMemberOfClass:[UIPanGestureRecognizer class]]) {
        if ([otherGestureRecognizer isMemberOfClass:[UIScreenEdgePanGestureRecognizer class]]) {
            return NO;
        }
    }
    return YES;
}
#pragma mark 系统手势
- (void)addPanGestureForViewController:(UIViewController *)viewController{
    
    UIScreenEdgePanGestureRecognizer *edgePan = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(doInteractiveTypePop:)];
    edgePan.edges = UIRectEdgeLeft;
    [viewController.view addGestureRecognizer:edgePan];
    
}
- (void)doInteractiveTypePop:(UIPanGestureRecognizer *)gesture{
    
    CGPoint  translation = [gesture translationInView:gesture.view];
    CGFloat percentComplete = 0.0;
    
    //左右滑动的百分比
    percentComplete = translation.x / [[UIApplication sharedApplication] keyWindow].frame.size.width;
    percentComplete = fabs(percentComplete);
    
    switch (gesture.state)
    {
        case UIGestureRecognizerStateBegan:
            self.isInteraction = YES;
            [self.popController.navigationController popViewControllerAnimated:YES];
            break;
        case UIGestureRecognizerStateChanged:
            self.isInteraction = NO;
            [self updateInteractiveTransition:percentComplete];
            break;
        case UIGestureRecognizerStateEnded:
            self.isInteraction = NO;
            if (percentComplete > 0.3f)
                [self finishInteractiveTransition];
            else
                [self cancelInteractiveTransition];
            break;
        default:
            self.isInteraction = NO;
            [self cancelInteractiveTransition];
            break;
    }
}
#pragma mark 自定义手势
- (void)addPanGestureForViewController:(UIViewController *)viewController directionTypes:(TLPanDirectionType)directionTypes{
    
    if (0 == directionTypes) return;
    
    viewController.panDirectionTypes = directionTypes;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(doGestureRecognizerPop:)];
    pan.delegate = self;
    [viewController.view addGestureRecognizer:pan];
    
}

#pragma mark 交互
- (void)doGestureRecognizerPop:(UIPanGestureRecognizer *)gesture{
    
    CGFloat gestureHeight = UIScreen.mainScreen.bounds.size.height;
    
    CGPoint  translation = [gesture translationInView:gesture.view];
    CGFloat percentCompleteX = 0.0;
    CGFloat percentCompleteY = 0.0;
    CGFloat percentComplete = 0.0;
    //左右滑动的百分比
    percentCompleteX = translation.x / UIScreen.mainScreen.bounds.size.width;
    percentCompleteX = fabs(percentCompleteX);
    
    //上下滑动的百分比
    percentCompleteY = translation.y / gestureHeight;
    percentCompleteY = fabs(percentCompleteY);
    
    TLPanDirectionType panDirection = TLPanDirectionNone;
    //如果开始是左右（上下）方向，之后也是以左右（上下）为标准
    if (TLPanDirectionEdgeLeft == self.startDirection || TLPanDirectionEdgeRight == self.startDirection){
        
        if(translation.x > 0){
            
            panDirection = TLPanDirectionEdgeLeft;//右滑
        }else if(translation.x < 0){
            
            panDirection = TLPanDirectionEdgeRight;//左滑
        }
        percentComplete = percentCompleteX;
        
    }else if (TLPanDirectionEdgeUp == self.startDirection || TLPanDirectionEdgeDown == self.startDirection){
        
        if (translation.y >0) {
            panDirection = TLPanDirectionEdgeUp;//下滑
        }else if(translation.y < 0){
            
            panDirection = TLPanDirectionEdgeDown;//上滑
        }
        percentComplete = percentCompleteY;
    }else{
        if (fabs(translation.x) > fabs(translation.y)) {
            if(translation.x > 0){
                
                panDirection = TLPanDirectionEdgeLeft;//右滑
            }else if(translation.x < 0){
                
                panDirection = TLPanDirectionEdgeRight;//左滑
            }
            percentComplete = percentCompleteX;
        }else{
            if (translation.y >0) {
                panDirection = TLPanDirectionEdgeUp;//下滑
            }else if(translation.y < 0){
                
                panDirection = TLPanDirectionEdgeDown;//上滑
            }
            percentComplete = percentCompleteY;
        }
        if (TLPanDirectionNone == self.startDirection) {
            self.startDirection = panDirection;
        }
    }
    
    //当为左右滑时，不让scrollView滚动；当上下滑时，记录改变方向前的percentComplete    
    WS(weakSelf);
    [self handleScrollViewPercentComplete:percentComplete directionType:panDirection block:^(CGFloat bPercentComplete, TLPanDirectionType bPanDirection) {
        
        //转场进度动画处理
        [weakSelf handleGesture:gesture percentComplete:bPercentComplete directionType:bPanDirection];
    }];
    
}

- (void)handleScrollViewPercentComplete:(CGFloat)percentComplete directionType:(TLPanDirectionType)panDirection block:(void(^)(CGFloat bPercentComplete,TLPanDirectionType bPanDirection))block{
    
    if (self.scrollView) {
        
        if (TLPanDirectionEdgeUp == self.startDirection || TLPanDirectionEdgeDown == self.startDirection) {
            
            if (self.scrollView.contentOffset.y <= 10) {
                self.scrollView.bounces = NO;
            }else{
                self.scrollView.bounces = YES;
            }
            
            if (self.scrollView.contentOffset.y <= 0) {
                
                if (TLPanDirectionEdgeUp == panDirection) {
                    
                    self.scrollView.contentOffset = CGPointMake(0, 0);
                    percentComplete = percentComplete -self.lastPercentComplete;
                    
                }else if (TLPanDirectionEdgeDown == panDirection){
                    
                    self.lastPercentComplete = percentComplete;
                    percentComplete = 0;
                }
            }else{
                if (TLPanDirectionEdgeUp == panDirection) {
                    
                    self.lastPercentComplete = percentComplete;
                    if (self.scrollView.contentOffset.y > 0) {
                        percentComplete = 0;
                    }
                }else if (TLPanDirectionEdgeDown == panDirection){
                    
                }
            }
        }else if(TLPanDirectionEdgeLeft == self.startDirection || TLPanDirectionEdgeRight == self.startDirection){
            self.scrollView.scrollEnabled = NO;
        }
    }
    block(percentComplete ,panDirection);
}
- (void)handleGesture:(UIPanGestureRecognizer *)gesture percentComplete:(CGFloat)percentComplete directionType:(TLPanDirectionType)directionType{
    
    //对于不包含的手势禁止动画
    if (!(self.popController.panDirectionTypes &directionType)) {
        percentComplete = 0;
    }
    //向右滑动起始位置超出TLPanEdgeInside则失效
    if (TLPanDirectionEdgeLeft == directionType) {
        if (self.edgeLeftBeganFloat >TLPanEdgeInside) {
            percentComplete = 0;
        }
    }
    
    CGFloat targetFloat;
    //针对TLAnimationAppStore，滑动屏幕时,增大滑动进度,增加自动pop效果
    if (TLAnimationAppStore == self.popController.animationType) {
        targetFloat = 1;
        percentComplete = percentComplete *3;
    }else{
        targetFloat = 0.4;
    }
    
    switch (gesture.state)
    {
        case UIGestureRecognizerStateBegan:
            
            [self gestureRecognizerStateBegan:gesture];
            break;
            
        case UIGestureRecognizerStateChanged:

            [self gestureRecognizerStateChanged:gesture percentComplete:percentComplete targetFloat:targetFloat];
            break;
            
        case UIGestureRecognizerStateEnded:
            
            [self gestureRecognizerStateEnded:gesture percentComplete:percentComplete targetFloat:targetFloat directionType:directionType];
            break;
            
        default:
            self.isInteraction = NO;
            [self cancelInteractiveTransition];
            break;
    }
}
- (void)gestureRecognizerStateBegan:(UIPanGestureRecognizer *)gesture{
    
    if (self.scrollView) {
        if (self.scrollView.contentOffset.y == 0) {
            self.lastPercentComplete = 0;
        }
    }
    self.edgeLeftBeganFloat = [gesture locationInView:gesture.view].x;
    self.isInteraction = YES;
    [self.popController.navigationController popViewControllerAnimated:YES];
}
- (void)gestureRecognizerStateChanged:(UIPanGestureRecognizer *)gesture percentComplete:(CGFloat)percentComplete targetFloat:(CGFloat)targetFloat{
    
    
    //针对TLAnimationAppStore，增加自动pop功能
    if (TLAnimationAppStore == self.popController.animationType && percentComplete > targetFloat) {
        
        self.isInteraction = YES;
        [self finishInteractiveTransition];
        [self.popController.navigationController popViewControllerAnimated:YES];
    }else{
        self.isInteraction = NO;
        [self updateInteractiveTransition:percentComplete];
    }
}
- (void)gestureRecognizerStateEnded:(UIPanGestureRecognizer *)gesture percentComplete:(CGFloat)percentComplete targetFloat:(CGFloat)targetFloat directionType:(TLPanDirectionType)directionType{
    
    if ((TLPanDirectionEdgeLeft == self.startDirection || TLPanDirectionEdgeRight == self.startDirection) && [gesture velocityInView:gesture.view].x>= 250) {//左右轻扫，快速返回
        
        [self finishInteractiveTransition];
        [self.popController.navigationController popViewControllerAnimated:YES];
        
    }else if ((TLPanDirectionEdgeUp == self.startDirection || TLPanDirectionEdgeDown == self.startDirection) && self.scrollView.contentOffset.y <= 0 && TLPanDirectionEdgeUp == directionType && [gesture velocityInView:gesture.view].y>= 250) {//上下轻扫，快速返回
        
        [self finishInteractiveTransition];
        [self.popController.navigationController popViewControllerAnimated:YES];
        
    }else{//正常返回
        if (percentComplete > targetFloat){
            [self finishInteractiveTransition];
        }else{
            [self cancelInteractiveTransition];
        }
    }
    
    self.lastPercentComplete = 0;
    self.scrollView.scrollEnabled = YES;
    self.startDirection = TLPanDirectionNone;
    self.isInteraction = NO;
    
}
#pragma mark 动画
- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC{
    
    if (operation == UINavigationControllerOperationPush) {
        self.isPop = NO;
        if (TLAnimationUIViewFrame == toVC.animationType) {
            return [TLAnimationUIViewFrameStyle new];
            
        }else if (TLAnimationWindowScale == toVC.animationType){
            return [TLAnimationWindowScaleStylePush new];
            
        }else if (TLAnimationAppStore == toVC.animationType){
            return [TLAnimationAppStoreStylePush new];
        }
    }else if (operation == UINavigationControllerOperationPop){
        self.isPop = YES;
        if (TLAnimationUIViewFrame == fromVC.animationType) {
            return [TLAnimationUIViewFrameStyle new];
            
        }else if (TLAnimationWindowScale == fromVC.animationType){
            return [TLAnimationWindowScaleStylePop new];
            
        }else if (TLAnimationAppStore == fromVC.animationType){
            return [TLAnimationAppStoreStylePop new];
        }
    }
    
    return nil;
}

#pragma mark 是否返回交互
- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController{
    
    if (self.isPop) {
        return self.isInteraction ? self : nil;
    }
    return nil;
}

#pragma mark UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    [navigationController setNavigationBarHidden:navigationController.hideNavBar animated:YES];
    
    if (1 == navigationController.viewControllers.count) {

    }else if (2 == navigationController.viewControllers.count) {
        
        //消失
        CGRect tabRect = navigationController.tabBarController.tabBar.frame;
        navigationController.tabBarController.tabBar.frame = CGRectMake(tabRect.origin.x, TLDeviceHeight -tabRect.size.height, tabRect.size.width, tabRect.size.height);
        [UIView animateWithDuration:0.5 animations:^{

            navigationController.tabBarController.tabBar.frame = CGRectMake(tabRect.origin.x, TLDeviceHeight +tabRect.size.height, tabRect.size.width, tabRect.size.height);
        } completion:^(BOOL finished) {
            navigationController.tabBarController.tabBar.hidden = YES;
        }];
    }

}
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (viewController == navigationController.viewControllers[0]){
        
        navigationController.interactivePopGestureRecognizer.enabled = NO;
    }else {
        navigationController.interactivePopGestureRecognizer.enabled = YES;
    }
    
    if (1 == navigationController.viewControllers.count) {
        
        //出现
        if (navigationController.tabBarController.tabBar.hidden) {
            
            CGRect tabRect = navigationController.tabBarController.tabBar.frame;
            navigationController.tabBarController.tabBar.frame = CGRectMake(tabRect.origin.x, TLDeviceHeight +tabRect.size.height, tabRect.size.width, tabRect.size.height);
            navigationController.tabBarController.tabBar.hidden = NO;
            [UIView animateWithDuration:0.5 animations:^{
                navigationController.tabBarController.tabBar.frame = CGRectMake(tabRect.origin.x, TLDeviceHeight -tabRect.size.height, tabRect.size.width, tabRect.size.height);
            }];
            
        }
    }

}

@end
