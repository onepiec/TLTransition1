//
//  ViewController21.m
//  TLTransition
//
//  Created by hello on 2019/4/12.
//  Copyright © 2019 tanglei. All rights reserved.
//

#import "ViewController21.h"

@interface ViewController21 ()

@end

@implementation ViewController21

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.hideNavBar = YES;
    
    UIImageView *contentImgView = [UIImageView new];
    contentImgView.image = [UIImage imageNamed:self.img];
    contentImgView.frame = CGRectMake(0, (TLDeviceHeight -TLDeviceWidth)/2, TLDeviceWidth, TLDeviceWidth);
    [self.view addSubview:contentImgView];
    
    
    UILabel *contentLab = [UILabel new];
    contentLab.text = @"左滑返回";
    contentLab.textColor = [UIColor whiteColor];
    contentLab.font = [UIFont boldSystemFontOfSize:20];
    contentLab.textAlignment = 1;
    contentLab.frame = CGRectMake(0, (TLDeviceHeight -30)/2, TLDeviceWidth, 30);
    contentLab.numberOfLines = 0;
    [self.view addSubview:contentLab];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
