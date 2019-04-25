//
//  UIViewController+TLTransition.m
//  zhuanchang
//
//  Created by Mac on 2019/1/28.
//  Copyright © 2019年 tanglei. All rights reserved.
//

#import "UIViewController+TLTransition.h"
#import "BaseNavigationController.h"
#import <objc/runtime.h>
#import "TLPushTransitionDelegate.h"
#import "TLPressTransitionDelegate.h"

static char * const animationTypeKey = "animationTypeKey";
static char * const panDirectionTypesKey = "panDirectionTypesKey";

#pragma mark UIViewController
@implementation UIViewController (TLTransition)


- (void)setAnimationType:(TLAnimationType)animationType{
    objc_setAssociatedObject(self, animationTypeKey, @(animationType), OBJC_ASSOCIATION_ASSIGN);
}
- (TLAnimationType)animationType{
    return [objc_getAssociatedObject(self, animationTypeKey) integerValue];
}

- (void)setPanDirectionTypes:(TLPanDirectionType)panDirectionTypes{
    objc_setAssociatedObject(self, panDirectionTypesKey, @(panDirectionTypes), OBJC_ASSOCIATION_ASSIGN);
}
- (TLPanDirectionType)panDirectionTypes{
    return [objc_getAssociatedObject(self, panDirectionTypesKey) integerValue];
}


+ (void)load{
    Class class = [self class];

    SEL originalSelector = @selector(presentViewController:animated:completion:);
    SEL swizzledSelector = @selector(swizzPresentViewController:animated:completion:);
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    BOOL didAddMethod =
    class_addMethod(class,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    }else{
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
    
    SEL originalSelector1 = @selector(viewWillAppear:);
    SEL swizzledSelector1 = @selector(tlViewWillAppear:);
    
    Method originalMethod1 = class_getInstanceMethod(class, originalSelector1);
    Method swizzledMethod1 = class_getInstanceMethod(class, swizzledSelector1);
    
    BOOL didAddMethod1 =
    class_addMethod(class,
                    originalSelector1,
                    method_getImplementation(swizzledMethod1),
                    method_getTypeEncoding(swizzledMethod1));
    
    if (didAddMethod1) {
        class_replaceMethod(class,
                            swizzledSelector1,
                            method_getImplementation(originalMethod1),
                            method_getTypeEncoding(originalMethod1));
    }else{
        method_exchangeImplementations(originalMethod1, swizzledMethod1);
    }
}
- (void)tlViewWillAppear:(BOOL)animated{
    
    
    if (TLAnimationUIViewFrame == self.animationType || TLAnimationWindowScale == self.animationType || TLAnimationAppStore == self.animationType) {
        
        self.navigationController.interactivePopGestureRecognizer.delegate = [TLPushTransitionDelegate shareInstance];
        self.navigationController.delegate = [TLPushTransitionDelegate shareInstance];
        [TLPushTransitionDelegate shareInstance].popController = self;
    }else{

    }
    [self tlViewWillAppear:animated];
}
- (void)swizzPresentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^ __nullable)(void))completion{
    
    //防止UIModalPresentationCustom模式pre,dis变形
    if (UIModalPresentationCustom == self.modalPresentationStyle) {
        viewControllerToPresent.modalPresentationStyle = UIModalPresentationOverFullScreen;
    }
    [self swizzPresentViewController:viewControllerToPresent animated:YES completion:completion];
}
- (void)tlPresentViewController:(UIViewController *)vc tlAnimationType:(TLAnimationType)tlAnimationType animated:(BOOL)animated completion:(void (^__nullable)(void))completion{
    
    if (TLAnimationBottomViewAlert == tlAnimationType) {
        
        //注意顺序
        vc.transitioningDelegate = [TLPressTransitionDelegate shareInstance];
        [TLPressTransitionDelegate shareInstance].disMissController = vc;
        [[TLPressTransitionDelegate shareInstance] addPanGestureForViewController:vc directionTypes:TLPanDirectionEdgeLeft | TLPanDirectionEdgeUp];
        vc.animationType = tlAnimationType;
        vc.modalPresentationStyle = UIModalPresentationCustom;//自定义Present
    }
   
    [self presentViewController:vc animated:animated completion:completion];
}
- (void)setContainScrollView:(UIScrollView *)scrollView isPush:(BOOL)isPush{
    if (isPush) {
        [TLPushTransitionDelegate shareInstance].scrollView = scrollView;
    }else{
        [TLPressTransitionDelegate shareInstance].scrollView = scrollView;
    }
}

- (NSArray *_Nonnull)tl_transitionUIViewFrameViews{
    return nil;
}
- (NSString *_Nonnull)tl_transitionUIViewImage{
    return nil;
}
@end

static char * const hideNavBarKey = "hideNavBar";
static char * const indexKey = "indexKey";
#pragma mark UINavigationController
@interface UINavigationController ()

@end
@implementation UINavigationController (TLTransition)

- (void)setHideNavBar:(BOOL)hideNavBar{
    objc_setAssociatedObject(self, hideNavBarKey, @(hideNavBar), OBJC_ASSOCIATION_ASSIGN);
}
- (BOOL)hideNavBar{
    return [objc_getAssociatedObject(self, hideNavBarKey) integerValue];
}

- (void)setIndex:(NSInteger)index{
    objc_setAssociatedObject(self, indexKey, @(index), OBJC_ASSOCIATION_ASSIGN);
}
- (NSInteger)index{
    return [objc_getAssociatedObject(self, indexKey) integerValue];
}

+ (void)load{
    Class class = [self class];
    
    SEL originalSelector0 = @selector(initWithRootViewController:);
    SEL swizzledSelector0 = @selector(swizzInitWithRootViewController:);

    Method originalMethod0 = class_getInstanceMethod(class, originalSelector0);
    Method swizzledMethod0 = class_getInstanceMethod(class, swizzledSelector0);

    BOOL didAddMethod0 =
    class_addMethod(class,
                    originalSelector0,
                    method_getImplementation(swizzledMethod0),
                    method_getTypeEncoding(swizzledMethod0));

    if (didAddMethod0) {
        class_replaceMethod(class,
                            swizzledSelector0,
                            method_getImplementation(originalMethod0),
                            method_getTypeEncoding(originalMethod0));
    }else{
        method_exchangeImplementations(originalMethod0, swizzledMethod0);
    }

}

- (instancetype)swizzInitWithRootViewController:(UIViewController *)rootViewController{
    
    self.interactivePopGestureRecognizer.delegate = [TLPushTransitionDelegate shareInstance];
    self.delegate = [TLPushTransitionDelegate shareInstance];
    return [self swizzInitWithRootViewController:rootViewController];
    
}

- (void)tlPushViewController:(UIViewController *)vc tlAnimationType:(TLAnimationType)tlAnimationType{
    
    if (TLAnimationUIViewFrame == tlAnimationType) {
        
        [TLPushTransitionDelegate shareInstance].popController = vc;
        [[TLPushTransitionDelegate shareInstance] addPanGestureForViewController:vc];
        vc.animationType = tlAnimationType;
        
        
    }else if (TLAnimationWindowScale == tlAnimationType){
        [TLPushTransitionDelegate shareInstance].popController = vc;
        [[TLPushTransitionDelegate shareInstance] addPanGestureForViewController:vc];
        vc.animationType = tlAnimationType;
        
    }else if (TLAnimationAppStore == tlAnimationType){
        
        [TLPushTransitionDelegate shareInstance].popController = vc;
        [[TLPushTransitionDelegate shareInstance] addPanGestureForViewController:vc directionTypes:TLPanDirectionEdgeLeft |TLPanDirectionEdgeUp];
        vc.animationType = tlAnimationType;
    }else{
        
        BaseNavigationController *nav = (BaseNavigationController *)self;
        self.interactivePopGestureRecognizer.delegate = nav;
        self.delegate = nav;
    }
    
    [self pushViewController:vc animated:YES];
}

@end
