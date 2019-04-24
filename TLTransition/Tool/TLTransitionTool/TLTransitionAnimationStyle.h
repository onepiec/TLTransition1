//
//  TLTransitionAnimationStyle.h
//  zhuanchang
//
//  Created by Mac on 2019/1/28.
//  Copyright © 2019年 tanglei. All rights reserved.
//

#ifndef TLTransitionAnimationStyle_h
#define TLTransitionAnimationStyle_h


typedef NS_ENUM(NSUInteger, TLAnimationType) {
    
    TLAnimationNone = 0,
    //push
    TLAnimationUIViewFrame,//视图移动
    TLAnimationWindowScale,//视图稍微放大缩小
    TLAnimationAppStore,//视图稍微放大缩小
    
    //press
    TLAnimationBottomViewAlert,//视图从底部弹出
    
    
    //tab
    TLAnimationTabScroll    //tabbar点击滚动
};

#endif /* TLTransitionAnimationStyle_h */
