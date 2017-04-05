//
//  OpenDoorToViewController.m
//  GLTransitionAnimationDemo
//
//  Created by 高磊 on 2017/3/30.
//  Copyright © 2017年 高磊. All rights reserved.
//

#import "OpenDoorToViewController.h"
#import "UIViewController+GLTransition.h"

@interface OpenDoorToViewController ()

@end

@implementation OpenDoorToViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view.layer setContents:(id)[UIImage imageNamed:@"00"].CGImage];

    __weak typeof(self)weakSelf = self;
    [self gl_registerBackInteractiveTransitionWithDirection:GLPanEdgeLeft eventBlcok:^{
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
