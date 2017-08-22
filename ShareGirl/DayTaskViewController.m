//
//  DayTaskViewController.m
//  YouGuo
//
//  Created by 姜鸥人 on 2017/7/6.
//  Copyright © 2017年 HeiCoder_OR. All rights reserved.
//

#import "DayTaskViewController.h"
#import "DayTaskCell.h"
@interface DayTaskViewController ()
@property(nonatomic,strong)DayTaskCell * cell;
@property (nonatomic, assign) NSInteger row;
@end

@implementation DayTaskViewController
static NSString * const DayTaskCell_id = @"DayTaskCell";
- (void)viewDidLoad {
    [super viewDidLoad];
 self.navigationItem.title = @"我的收益";
     self.tableView.showsVerticalScrollIndicator = NO;
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(backViewUp)];
    [self.navigationItem setLeftBarButtonItem:leftButton];
    
    
    self.row = -1;
}
-(void)backViewUp{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    self.cell = [tableView dequeueReusableCellWithIdentifier:DayTaskCell_id];
    if (self.cell == nil) {
        self.cell = [[DayTaskCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:DayTaskCell_id];
    }
    // 判断当前row是否被点击, 是就显示backView, 不是就隐藏
//    if (indexPath.row != self.row) {
//        self.cell.backView.hidden = YES;
//    } else {
//        self.cell.backView.hidden = NO;
//    }
    self.cell.selectionStyle =UITableViewCellSelectionStyleNone;
    return self.cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // 记录当前被点击的row
    self.row = indexPath.row;
    [tableView reloadData];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        return 60;
}

@end
