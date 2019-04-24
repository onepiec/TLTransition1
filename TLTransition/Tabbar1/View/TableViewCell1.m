//
//  TableViewCell1.m
//  TLTransition
//
//  Created by hello on 2019/4/15.
//  Copyright © 2019 tanglei. All rights reserved.
//

#import "TableViewCell1.h"

@implementation TableViewCell1

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
    
    
}
- (void)setImageStr:(NSString *)imageStr{
    
    [TlImageTool asyncImageWithImageName:imageStr block:^(UIImage * _Nonnull image) {
        self.contentImg.image = image;
    }];
}
@end
