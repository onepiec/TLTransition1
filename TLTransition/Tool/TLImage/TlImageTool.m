//
//  TlImageTool.m
//  TLTransition
//
//  Created by hello on 2019/4/16.
//  Copyright © 2019 tanglei. All rights reserved.
//

#import "TlImageTool.h"


@implementation TlImageTool

+ (void)asyncImageWithImageName:(NSString *)imageName block:(void(^)(UIImage *image))block {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        UIImage *image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        if (image) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if(block) {
                    block(image);
                }
                
            });
        }else{
            [self asyncImageWithImageName:imageName block:block];
        }
    });
}

//+ (void)asyncImageWithImageName:(NSString *)imageName block:(void(^)(UIImage *image))block {
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        @autoreleasepool{
//            UIImage *image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                if(block) {
//                    block(image);
//                }
//
//            });
//        }
//    });
//}


@end
