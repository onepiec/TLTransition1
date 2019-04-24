//
//  TLPushTransitionDelegate.h
//  TLTransition
//
//  Created by hello on 2019/4/12.
//  Copyright © 2019 tanglei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLPanDirectionStyle.h"
NS_ASSUME_NONNULL_BEGIN

@interface TLPushTransitionDelegate : UIPercentDrivenInteractiveTransition<UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@property (nonatomic ,weak)UIViewController *popController;
@property (nonatomic ,weak)UIScrollView *scrollView;

+ (instancetype)shareInstance;
//系统自带侧滑
- (void)addPanGestureForViewController:(UIViewController *)viewController;
//自定义全屏手势
- (void)addPanGestureForViewController:(UIViewController *)viewController directionTypes:(TLPanDirectionType)directionTypes;
@end

NS_ASSUME_NONNULL_END
