//
//  TableViewCell0.h
//  TLTransition
//
//  Created by hello on 2019/4/9.
//  Copyright © 2019 tanglei. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TableViewCell0 : UITableViewCell

@property (nonatomic ,strong)UIButton       *btn;
@property (nonatomic ,strong)UILabel        *titleLab;
@property (nonatomic ,strong)UILabel        *infLab;
@property (nonatomic ,assign)BOOL           endTouchesBegan;//如果长按直接回调，否则先改变scale再回调

@property (nonatomic ,copy)void(^noScrollBlock)(void);
@property (nonatomic ,copy)void(^block)(void);

- (void)setDic:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
