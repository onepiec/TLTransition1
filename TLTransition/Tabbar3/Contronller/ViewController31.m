//
//  ViewController31.m
//  TLTransition
//
//  Created by hello on 2019/4/12.
//  Copyright © 2019 tanglei. All rights reserved.
//

#define TLTransitionPressHeight [UIScreen mainScreen].bounds.size.height *0.7

#import "ViewController31.h"
#import "TableViewCell31.h"
#import "ViewController32.h"
#import "BaseNavigationController.h"
@interface ViewController31 ()<UITableViewDelegate ,UITableViewDataSource>

@property (nonatomic ,strong)UITableView        *tableView;

@end

@implementation ViewController31

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.hideNavBar = YES;
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, TLDeviceWidth, TLTransitionPressHeight) style:UITableViewStylePlain];
    self.tableView.estimatedRowHeight = 0;
    self.tableView.estimatedSectionHeaderHeight = 0;
    self.tableView.estimatedSectionFooterHeight = 0;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];

    [self setContainScrollView:self.tableView isPush:NO];
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 50;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *bgView = [[UIView alloc]init];
    bgView.frame = CGRectMake(0, 0, TLDeviceWidth, 50);
    
    UILabel *lab = [[UILabel alloc]init];
    lab.frame = bgView.bounds;
    lab.text = @"仿照抖音评论";
    lab.textAlignment = 1;
    lab.font = [UIFont systemFontOfSize:15];
    lab.backgroundColor = [UIColor whiteColor];
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
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * const cellID = @"TableViewCell31";
    TableViewCell31 * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[TableViewCell31 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    ViewController32 *vc = [ViewController32 new];
    if (indexPath.row <=20) {
        [self presentViewController:vc animated:YES completion:nil];
    }else{
        [self tlPresentViewController:vc tlAnimationType:TLAnimationNone animated:YES completion:nil];
    }

    
}
- (void)tlScrollViewDidScroll:(UIScrollView *)scrollView{
//    NSLog(@"-------%lf",scrollView.contentOffset.y);
}
@end
