//
//  TableViewCell0.m
//  TLTransition
//
//  Created by hello on 2019/4/9.
//  Copyright © 2019 tanglei. All rights reserved.
//

#import "TableViewCell0.h"

@implementation TableViewCell0

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}
- (void)createUI{//200 +10
    
    self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btn.frame = CGRectMake(0, 0, TLDeviceWidth -20, 400);
    self.btn.layer.cornerRadius = 8;
    self.btn.layer.masksToBounds = YES;
    [self.contentView addSubview:self.btn];
    [self.btn addTarget:self action:@selector(Events) forControlEvents:UIControlEventAllTouchEvents];
    self.btn.userInteractionEnabled = NO;
    self.btn.imageView.contentMode = UIViewContentModeCenter;
    
    self.titleLab = [UILabel new];
    self.titleLab.frame = CGRectMake(10, 10, 200, 20);
    self.titleLab.textColor = [UIColor whiteColor];
    [self.btn addSubview:self.titleLab];
    
    self.infLab = [UILabel new];
    self.infLab.frame = CGRectMake(10, 350, 200, 20);
    self.infLab.textColor = [UIColor whiteColor];
    [self.btn addSubview:self.infLab];

    [self.btn becomeFirstResponder];
}

- (void)Events{
    NSLog(@"UIControlEventAllTouchEvents");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    NSLog(@"开始");
    self.endTouchesBegan = NO;
    
    
    [UIView animateWithDuration:0.2 animations:^{
        self.btn.transform = CGAffineTransformMakeScale(0.97, 0.97);
    } completion:^(BOOL finished) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.endTouchesBegan = YES;
        });
        
    }];
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    NSLog(@"结束");
    if (self.endTouchesBegan) {
        
        if (self.block) {
            self.block();
        }
    }else{
        if (self.noScrollBlock) {
            self.noScrollBlock();
        }
        [UIView animateWithDuration:0.2 animations:^{
            self.btn.transform = CGAffineTransformMakeScale(0.97, 0.97);
        } completion:^(BOOL finished) {

            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (self.block) {
                    self.block();
                }
            });
        }];

    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [UIView animateWithDuration:0.2 animations:^{
        self.btn.transform = CGAffineTransformIdentity;
    }];
}

- (void)setDic:(NSDictionary *)dic{
    
    [TlImageTool asyncImageWithImageName:dic[@"img"] block:^(UIImage * _Nonnull image) {
        [self.btn setImage:image forState:UIControlStateNormal];
    }];
    self.titleLab.text = dic[@"title"];
    self.infLab.text = dic[@"inf"];
}
@end
