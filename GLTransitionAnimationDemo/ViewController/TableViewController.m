//
//  TableViewController.m
//  GLTransitionAnimationDemo
//
//  Created by 高磊 on 2017/3/27.
//  Copyright © 2017年 高磊. All rights reserved.
//

#import "TableViewController.h"


@interface TableViewController ()

@property (nonatomic,copy) NSArray *dataSource;
@property (nonatomic,copy) NSArray *dataVcs;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataSource = @[@"CircleSpread",@"CircleRectSpread",@"OpenDoor",@"MiddlePage"];
    self.dataVcs = @[@"CircleSpreadFromController",@"CircleRectSpreadFromViewController",@"OpenDoorFromViewController",@"MiddlePageFromViewController"];
    self.tableView.tableFooterView = [[UIView alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"testcell" forIndexPath:indexPath];

    cell.textLabel.text = self.dataSource[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *pushVC = [[NSClassFromString(self.dataVcs[indexPath.row]) alloc] init];
    [self.navigationController pushViewController:pushVC animated:YES];
}

@end
