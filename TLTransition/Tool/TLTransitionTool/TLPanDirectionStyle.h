//
//  TLPanDirectionStyle.h
//  zhuanchang
//
//  Created by Mac on 2019/1/28.
//  Copyright © 2019年 tanglei. All rights reserved.
//

#ifndef TLPanDirectionStyle_h
#define TLPanDirectionStyle_h

//位移枚举
typedef NS_ENUM(NSInteger,TLPanDirectionType){
    TLPanDirectionNone          = 0,                //不增加滑动手势
    TLPanDirectionEdgeLeft      = 1 << 0,           //响应右滑手势
    TLPanDirectionEdgeRight     = 1 << 1,           //响应左滑手势
    TLPanDirectionEdgeUp        = 1 << 2,           //响应下滑手势
    TLPanDirectionEdgeDown      = 1 << 3            //响应上滑手势
};

#endif /* TLPanDirectionStyle_h */
