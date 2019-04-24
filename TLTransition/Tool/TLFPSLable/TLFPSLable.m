//
//  TLFPSLable.m
//  WanNengDemo
//
//  Created by Mac on 2019/1/25.
//  Copyright © 2019年 tanglei. All rights reserved.
//

#import "TLFPSLable.h"

#define TLFPSLableSize CGSizeMake(55, 20)

@interface TLFPSLable ()

@property (nonatomic, strong)CADisplayLink       *link;
@property (nonatomic, assign)NSUInteger         count;
@property (nonatomic, assign)NSTimeInterval     lastTime;

@end

@implementation TLFPSLable

+ (instancetype)sharedInstance {
    static TLFPSLable *config = nil;
    static dispatch_once_t s_predicate;
    dispatch_once(&s_predicate, ^{
        config = [[TLFPSLable alloc]init];
    });
    return config;
}

+ (void)show{
    
    [[UIApplication sharedApplication].keyWindow addSubview:[TLFPSLable sharedInstance]];
}
+ (void)hide{
    [[TLFPSLable sharedInstance].link invalidate];
    [[TLFPSLable sharedInstance] removeFromSuperview];
}

- (instancetype)initWithFrame:(CGRect)frame {

    frame = CGRectMake(15, TLDeviceHeight -TabBarHeight -15 -30, 75, 30);
    self = [super initWithFrame:frame];
    
    self.layer.cornerRadius = 5;
    self.clipsToBounds = YES;
    self.textAlignment = NSTextAlignmentCenter;
    self.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.700];
    
    self.link = [CADisplayLink displayLinkWithTarget:self selector:@selector(tick:)];
    [self.link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    return self;
}

- (void)tick:(CADisplayLink *)link {
    if (_lastTime == 0) {
        _lastTime = link.timestamp;
        return;
    }
    
    _count++;
    NSTimeInterval delta = link.timestamp - _lastTime;
    if (delta < 1) return;
    _lastTime = link.timestamp;
    float fps = _count / delta;
    _count = 0;
    NSString *str = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%d FPS",(int)round(fps)]];
    
    self.textColor = [UIColor whiteColor];
    self.text = str;
}


@end
