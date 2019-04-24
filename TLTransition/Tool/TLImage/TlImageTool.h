//
//  TlImageTool.h
//  TLTransition
//
//  Created by hello on 2019/4/16.
//  Copyright © 2019 tanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TlImageTool : NSObject

+ (void)asyncImageWithImageName:(NSString *)imageName block:(void(^)(UIImage *image))block;
@end

NS_ASSUME_NONNULL_END
