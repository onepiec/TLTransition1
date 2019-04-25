//
//  ViewController0.m
//  TLTransition
//
//  Created by hello on 2019/4/9.
//  Copyright © 2019 tanglei. All rights reserved.
//

#import "ViewController0.h"
#import "ViewController01.h"
#import "TableViewCell0.h"

@interface ViewController0 ()<UITableViewDelegate ,UITableViewDataSource>

@property (nonatomic ,strong)UITableView        *tableView;
@property (nonatomic ,copy  )NSMutableArray     *dataArr;
@property (nonatomic ,copy  )NSString           *selectImageStr;

@property (nonatomic ,weak)UIButton       *btn;
@property (nonatomic ,weak)UILabel        *titleLab;
@property (nonatomic ,weak)UILabel        *infLab;

@property (nonatomic ,assign)BOOL           userEnabled;
@property (nonatomic ,assign)BOOL           hideStatus;
@end

@implementation ViewController0

-(BOOL)prefersStatusBarHidden{

    return self.hideStatus;
}
- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation{

    return UIStatusBarAnimationSlide;
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    self.hideStatus = NO;
    [UIView animateWithDuration:0.5 animations:^{
        [self setNeedsStatusBarAppearanceUpdate];
    }];
}

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray new];
        for (int i =0; i <10; i ++) {
            
            NSDictionary *dic = @{@"title":[NSString stringWithFormat:@"海贼王标题%d",i],
                                  @"img":[NSString stringWithFormat:@"海贼王%d",i],
                                  @"inf":[NSString stringWithFormat:@"尾田荣一郎%d",i]
                                  };
            [_dataArr addObject:dic];
        }
    }
    return _dataArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view.
    self.hideNavBar = YES;
    self.userEnabled = YES;
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(10, 20 +EXStatusHeight, TLDeviceWidth -20, TLDeviceHeight -(TabBarHeight +20 +EXStatusHeight)) style:UITableViewStyleGrouped];
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
//    仿AppStore
    UILabel *lab = [[UILabel alloc]init];
    lab.frame = bgView.bounds;
    lab.text = @"仿照AppStore动画";
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
    return 400 +10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * const cellID = @"TableViewCell0";
    TableViewCell0 * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[TableViewCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    [cell setDic:self.dataArr[indexPath.row]];
    WS(weakSelf);
    __weak __typeof(&*cell)weakCell = cell;
    
    cell.block = ^{
        SS(strongSelf);
        
        if (!strongSelf.userEnabled) {
            return;
        }
        strongSelf.hideStatus = YES;
        strongSelf.userEnabled = NO;
        
        strongSelf.btn = weakCell.btn;
        strongSelf.titleLab = weakCell.titleLab;
        strongSelf.infLab = weakCell.infLab;

        ViewController01 *vc = [ViewController01 new];
        NSDictionary *dic = strongSelf.dataArr[indexPath.row];
        vc.img = dic[@"img"];
        vc.titleStr = dic[@"title"];
        vc.inf = dic[@"inf"];
        strongSelf.selectImageStr = dic[@"img"];
        vc.push = YES;

        [strongSelf.navigationController tlPushViewController:vc tlAnimationType:TLAnimationAppStore];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,(int64_t)(1.0* NSEC_PER_SEC)),dispatch_get_main_queue(),^{

            strongSelf.userEnabled = YES;
            strongSelf.btn.transform = CGAffineTransformIdentity;
        });        

    };
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"didSelect");
}
- (NSArray *_Nonnull)tl_transitionUIViewFrameViews{
    return @[self.btn,self.titleLab,self.infLab];
}
- (NSString *_Nonnull)tl_transitionUIViewImage{
    return self.selectImageStr;
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
