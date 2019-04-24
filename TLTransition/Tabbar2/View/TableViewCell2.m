//
//  TableViewCell2.m
//  TLTransition
//
//  Created by hello on 2019/4/15.
//  Copyright © 2019 tanglei. All rights reserved.
//

#import "TableViewCell2.h"

@implementation TableViewCell2

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}
- (void)createUI{
    
    self.contentImg = [UIImageView new];
    self.contentImg.frame = CGRectMake(0, 0, TLDeviceWidth -20, TLDeviceWidth -20);
    [self.contentView addSubview:self.contentImg];
    
    
    self.contentLab = [UILabel new];
    self.contentLab.text = @"点我试试";
    self.contentLab.textAlignment = 1;
    self.contentLab.textColor = [UIColor whiteColor];
    self.contentLab.font = [UIFont boldSystemFontOfSize:20];
    self.contentLab.frame = self.contentImg.bounds;
    [self.contentView addSubview:self.contentLab];
    
}
- (void)setImageStr:(NSString *)imageStr{
    
    [TlImageTool asyncImageWithImageName:imageStr block:^(UIImage * _Nonnull image) {
        self.contentImg.image = image;
    }];
}

@end
