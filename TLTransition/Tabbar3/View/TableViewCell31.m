//
//  TableViewCell31.m
//  TLTransition
//
//  Created by hello on 2019/4/15.
//  Copyright © 2019 tanglei. All rights reserved.
//

#import "TableViewCell31.h"

@implementation TableViewCell31

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}
- (void)createUI{
    
    self.contentLab = [UILabel new];
    self.contentLab.text = @"奥特曼很棒棒啊";
    self.contentLab.textColor = [UIColor blackColor];
    self.contentLab.font = [UIFont systemFontOfSize:12];
    self.contentLab.frame = CGRectMake(0, 0, TLDeviceWidth, 30);
    [self.contentView addSubview:self.contentLab];
    
    self.lineView = [UIView new];
    self.lineView.frame = CGRectMake(0, 0, TLDeviceWidth, 0.5);
    self.lineView.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:self.lineView];
}

@end
