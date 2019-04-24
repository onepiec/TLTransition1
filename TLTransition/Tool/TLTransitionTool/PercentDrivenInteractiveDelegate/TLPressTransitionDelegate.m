//
//  TLPressTransitionDelegate.m
//  TLTransition
//
//  Created by hello on 2019/4/12.
//  Copyright © 2019 tanglei. All rights reserved.
//

#import "TLPressTransitionDelegate.h"
#import "UIViewController+TLTransition.h"
#import "TLAnimationBottomViewAlert.h"

@interface TLPressTransitionDelegate ()

@property (nonatomic, assign) BOOL isInteraction;
@property (nonatomic, assign) BOOL isMiss;
@property (nonatomic, assign) CGFloat edgeLeftBeganFloat;//侧滑距离

@property (nonatomic, assign) TLPanDirectionType startDirection;//监测开始的手势,由上下滑转左右滑，还是按照上下为基础
@property (nonatomic, assign) CGFloat lastPercentComplete;//改变手势方向时刷新转场进度
@end

@implementation TLPressTransitionDelegate

+ (instancetype)shareInstance{
    
    static TLPressTransitionDelegate *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [TLPressTransitionDelegate new];
    });
    return _instance;
}
#pragma mark 是否识别多手势

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{

    return YES;
}
#pragma mark 系统手势
- (void)addEdgeLeftGestureForViewController:(UIViewController *)viewController{
    
    UIScreenEdgePanGestureRecognizer *edgePan = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(doInteractiveTypeDisMiss:)];
    edgePan.edges = UIRectEdgeLeft;
    [viewController.view addGestureRecognizer:edgePan];
    
}
- (void)doInteractiveTypeDisMiss:(UIPanGestureRecognizer *)gesture{
    
    CGPoint  translation = [gesture translationInView:gesture.view];
    CGFloat percentComplete = 0.0;
    
    //左右滑动的百分比
    percentComplete = translation.x / UIScreen.mainScreen.bounds.size.width;
    percentComplete = fabs(percentComplete);
    
    switch (gesture.state)
    {
        case UIGestureRecognizerStateBegan:
            self.isInteraction = YES;
            [self.disMissController dismissViewControllerAnimated:YES completion:nil];
            break;
        case UIGestureRecognizerStateChanged:
            self.isInteraction = NO;
            [self updateInteractiveTransition:percentComplete];
            break;
        case UIGestureRecognizerStateEnded:
            self.isInteraction = NO;
            if (percentComplete > 0.5f)
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
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(doGestureRecognizerDisMiss:)];
    pan.delegate = self;
    [viewController.view addGestureRecognizer:pan];
    
}
- (void)doGestureRecognizerDisMiss:(UIPanGestureRecognizer *)gesture{
    
    CGFloat gestureHeight = UIScreen.mainScreen.bounds.size.height;
    if (TLAnimationBottomViewAlert == self.disMissController.animationType) {
        gestureHeight = TLTransitionPressHeight;
    }
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
    if (!(self.disMissController.panDirectionTypes &directionType)) {
        percentComplete = 0;
    }
    //向右滑动起始位置超出TLPanEdgeInside则失效
    if (TLPanDirectionEdgeLeft == directionType) {
        if (self.edgeLeftBeganFloat >TLPanEdgeInside) {
            percentComplete = 0;
        }
    }
    
    switch (gesture.state)
    {
        case UIGestureRecognizerStateBegan:
            
            [self gestureRecognizerStateBegan:gesture];
            break;
        case UIGestureRecognizerStateChanged:

            
            self.isInteraction = NO;
            [self updateInteractiveTransition:percentComplete];
            break;
        case UIGestureRecognizerStateEnded:
            
            [self gestureRecognizerStateEnded:gesture percentComplete:percentComplete directionType:directionType];            
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
    [self.disMissController dismissViewControllerAnimated:YES completion:nil];
}
- (void)gestureRecognizerStateEnded:(UIPanGestureRecognizer *)gesture percentComplete:(CGFloat)percentComplete directionType:(TLPanDirectionType)directionType{
    
    if ((TLPanDirectionEdgeLeft == self.startDirection || TLPanDirectionEdgeRight == self.startDirection) && [gesture velocityInView:gesture.view].x>= 250) {//左右轻扫，快速返回
        
        [self finishInteractiveTransition];
        [self.disMissController dismissViewControllerAnimated:YES completion:nil];
        
    }else if ((TLPanDirectionEdgeUp == self.startDirection || TLPanDirectionEdgeDown == self.startDirection) && self.scrollView.contentOffset.y <= 0 && TLPanDirectionEdgeUp == directionType && [gesture velocityInView:gesture.view].y>= 250) {//上下轻扫，快速返回
        
        [self finishInteractiveTransition];
        [self.disMissController dismissViewControllerAnimated:YES completion:nil];
        
    }else{//正常返回
        if (percentComplete > 0.3f){
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
#pragma mark pres动画
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    
    self.isMiss = NO;
    if (TLAnimationBottomViewAlert == presented.animationType) {
        return [TLAnimationBottomViewAlertPress new];
    }
    
    return nil;
}
#pragma mark dis动画
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    
    self.isMiss = YES;
    if (TLAnimationBottomViewAlert == dismissed.animationType) {
        return [TLAnimationBottomViewAlertDiss new];
    }
    return nil;
}
#pragma mark 是否返回交互
- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator{
    
    if (self.isMiss) {
        return self.isInteraction ? self : nil;
    }
    return nil;
}
@end
