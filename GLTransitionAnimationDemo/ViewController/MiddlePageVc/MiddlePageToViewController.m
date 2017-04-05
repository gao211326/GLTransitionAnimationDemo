//
//  MiddlePageToViewController.m
//  GLTransitionAnimationDemo
//
//  Created by 高磊 on 2017/3/31.
//  Copyright © 2017年 高磊. All rights reserved.
//

#import "MiddlePageToViewController.h"
#import "UIViewController+GLTransition.h"

@interface MiddlePageToViewController ()

@end

@implementation MiddlePageToViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view.layer setContents:(id)[UIImage imageNamed:@"00"].CGImage];
    
    __weak typeof(self)weakSelf = self;
    [self gl_registerBackInteractiveTransitionWithDirection:GLPanEdgeLeft eventBlcok:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
