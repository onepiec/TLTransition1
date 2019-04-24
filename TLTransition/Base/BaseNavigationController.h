//
//  BaseNavigationController.h
//  TLTransition
//
//  Created by hello on 2019/4/18.
//  Copyright © 2019 tanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseNavigationController : UINavigationController<UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@property (nonatomic ,assign)BOOL   hideNavBar;

@end

NS_ASSUME_NONNULL_END
