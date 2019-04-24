//
//  ViewController3.m
//  TLTransition
//
//  Created by hello on 2019/4/9.
//  Copyright © 2019 tanglei. All rights reserved.
//

#import "ViewController3.h"
#import "ViewController31.h"
#import "TableViewCell3.h"
#import "BaseNavigationController.h"
@interface ViewController3 ()<UITableViewDelegate ,UITableViewDataSource>

@property (nonatomic ,strong)UITableView        *tableView;
@property (nonatomic ,copy  )NSMutableArray     *dataArr;


@end

@implementation ViewController3

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray new];
        for (int i =0; i <5; i ++) {
            [_dataArr addObject:[NSString stringWithFormat:@"奥特曼%d",i]];
        }
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"仿照抖音评论";
    self.hideNavBar = NO;
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(10, 0, TLDeviceWidth -20, TLDeviceHeight -TabBarHeight) style:UITableViewStyleGrouped];
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = YES;
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 50;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *bgView = [[UIView alloc]init];
    bgView.frame = CGRectMake(0, 0, TLDeviceWidth -20, 50);
    
    UILabel *lab = [[UILabel alloc]init];
    lab.frame = bgView.bounds;
    lab.text = @"仿照抖音评论";
    lab.font = [UIFont systemFontOfSize:15];
    [bgView addSubview:lab];
    return bgView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return [[UIView alloc]initWithFrame:CGRectMake(0, 0, TLDeviceWidth -20, 0.01)];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return TLDeviceWidth -20 +10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * const cellID = @"TableViewCell3";
    TableViewCell3 * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[TableViewCell3 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    [cell setImageStr:self.dataArr[indexPath.row]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ViewController31 *vc = [ViewController31 new];
    [self tlPresentViewController:vc tlAnimationType:TLAnimationBottomViewAlert animated:YES completion:nil];
    
}


@end
