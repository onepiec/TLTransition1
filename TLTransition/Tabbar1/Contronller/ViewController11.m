//
//  ViewController11.m
//  TLTransition
//
//  Created by hello on 2019/4/11.
//  Copyright © 2019 tanglei. All rights reserved.
//

#import "ViewController11.h"
//#import "UIViewController+TLTransition.h"

@interface ViewController11 ()

@property (nonatomic ,strong)UIImageView *contentImgView;
@property (nonatomic ,strong)UILabel     *contentLab;

@end

@implementation ViewController11

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.hideNavBar = YES;
    
    
    self.contentImgView = [UIImageView new];
    self.contentImgView.image = [UIImage imageNamed:self.img];
    self.contentImgView.frame = CGRectMake(0, 0, TLDeviceWidth, TLDeviceWidth);
    [self.view addSubview:self.contentImgView];

    
    self.contentLab = [UILabel new];
    self.contentLab.backgroundColor = [UIColor whiteColor];
    self.contentLab.frame = CGRectMake(0, TLDeviceWidth, TLDeviceWidth, TLDeviceHeight -TLDeviceWidth);
    self.contentLab.numberOfLines = 0;
    [self.view addSubview:self.contentLab];
    self.contentLab.text = @"大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗🐻大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗";
    
}
- (NSArray *_Nonnull)tl_transitionUIViewFrameViews{
    return @[self.contentImgView];
}

@end
