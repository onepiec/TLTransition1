//
//  TableViewCell1.h
//  TLTransition
//
//  Created by hello on 2019/4/15.
//  Copyright © 2019 tanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TableViewCell1 : UITableViewCell

@property (nonatomic ,strong)UIImageView       *contentImg;

- (void)setImageStr:(NSString *)imageStr;

@end

NS_ASSUME_NONNULL_END
