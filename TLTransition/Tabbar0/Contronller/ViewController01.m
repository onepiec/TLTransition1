//
//  ViewController01.m
//  TLTransition
//
//  Created by hello on 2019/4/9.
//  Copyright © 2019 tanglei. All rights reserved.
//

#import "ViewController01.h"
#import "ViewController02.h"

@interface ViewController01 ()

@property (nonatomic ,strong)UIScrollView*scrollView;
@property (nonatomic ,strong)UIImageView *contentImgView;
@property (nonatomic ,strong)UILabel        *titleLab;
@property (nonatomic ,strong)UILabel        *infLab;

@property (nonatomic ,strong)UILabel     *contentLab;
@property (nonatomic ,strong)UIVisualEffectView    *closeView;
@property (nonatomic ,strong)UIVisualEffectView    *pushView;

@property (nonatomic ,assign)BOOL           hideStatus;
@end

@implementation ViewController01

-(BOOL)prefersStatusBarHidden{
    
    if (self.push) {
        return YES;
    }else{
        return self.hideStatus;
    }
    
}
- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation{
    
    return UIStatusBarAnimationSlide;
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if (!self.push) {
        self.hideStatus = YES;
        [UIView animateWithDuration:0.5 animations:^{
            
            [self setNeedsStatusBarAppearanceUpdate];
        }];
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.closeView.alpha = 1;
        self.pushView.alpha = 1;
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.hideNavBar = YES;
    
    self.scrollView = [UIScrollView new];
    self.scrollView.frame = CGRectMake(0, 0, TLDeviceWidth, TLDeviceHeight);
    self.scrollView.contentSize = CGSizeMake(TLDeviceWidth, 600 +700);
    [self.view addSubview:self.scrollView];
    if (@available(iOS 11.0, *)) {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    self.contentImgView = [UIImageView new];
    self.contentImgView.image = [UIImage imageNamed:self.img];
    self.contentImgView.frame = CGRectMake(0, 0, TLDeviceWidth, 600);
    [self.scrollView addSubview:self.contentImgView];
    self.contentImgView.layer.masksToBounds = YES;
    self.contentImgView.contentMode = UIViewContentModeCenter;
    [self setContainScrollView:self.scrollView isPush:YES];
    
    self.titleLab = [UILabel new];
    self.titleLab.frame = CGRectMake(10, 40, 200, 20);
    self.titleLab.text = self.titleStr;
    self.titleLab.textColor = [UIColor whiteColor];
    [self.contentImgView addSubview:self.titleLab];
    
    self.infLab = [UILabel new];
    self.infLab.frame = CGRectMake(10, 550, 200, 20);
    self.infLab.text = self.inf;
    self.infLab.textColor = [UIColor whiteColor];
    [self.contentImgView addSubview:self.infLab];
    
    self.contentLab = [UILabel new];
    self.contentLab.backgroundColor = [UIColor whiteColor];
    self.contentLab.frame = CGRectMake(0, 600, TLDeviceWidth, 700);
    self.contentLab.numberOfLines = 0;
    [self.scrollView addSubview:self.contentLab];
    self.contentLab.text = @"大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗🐻大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗大家能发现这里面的一只熊吗";
    
    
    UIBlurEffect *closeEffect =[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *closeView =[[UIVisualEffectView alloc]initWithEffect:closeEffect];
    closeView.frame = CGRectMake(TLDeviceWidth -70, 20 +EXStatusHeight, 50, 50);
    closeView.layer.cornerRadius = 25;
    closeView.clipsToBounds = YES;
    [self.view addSubview:closeView];
    self.closeView = closeView;
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setTitle:@"X" forState:UIControlStateNormal];
    [closeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    closeBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    closeBtn.titleLabel.textAlignment = 1;
    closeBtn.frame = closeView.bounds;
    [closeView.contentView addSubview:closeBtn];
    [closeBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIBlurEffect *pushEffect =[UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *pushView =[[UIVisualEffectView alloc]initWithEffect:pushEffect];
    pushView.frame = CGRectMake(10, TLDeviceHeight -(70 +EXTabHeight), TLDeviceWidth -20, 50);
    pushView.layer.cornerRadius = 8;
    pushView.clipsToBounds = YES;
    [self.view addSubview:pushView];
    self.pushView = pushView;
    
    UIButton *pushBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [pushBtn setTitle:@"点我" forState:UIControlStateNormal];
    [pushBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    pushBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    pushBtn.titleLabel.textAlignment = 1;
    pushBtn.frame = pushView.bounds;
    [pushView.contentView addSubview:pushBtn];
    [pushBtn addTarget:self action:@selector(pushClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.closeView.alpha = 0;
    self.pushView.alpha = 0;
}
- (void)close{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)pushClick{
    
    self.push = NO;
    [self.navigationController tlPushViewController:[ViewController02 new] tlAnimationType:TLAnimationNone];
}
- (NSArray *_Nonnull)tl_transitionUIViewFrameViews{
    return @[self.contentImgView,self.titleLab,self.infLab,self.contentLab];
}
- (void)tlScrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"-------%lf",scrollView.contentOffset.y);
}
- (NSString *_Nonnull)tl_transitionUIViewImage{
    return self.img;
}
@end
