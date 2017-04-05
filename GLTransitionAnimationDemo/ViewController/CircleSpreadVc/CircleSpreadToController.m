//
//  SecondViewController.m
//  GLPushAnimationDemo
//
//  Created by 高磊 on 2017/3/16.
//  Copyright © 2017年 高磊. All rights reserved.
//

#import "CircleSpreadToController.h"
#import "UIViewController+GLTransition.h"
#import "GLTransitionManager.h"
#import <objc/runtime.h>

@interface CircleSpreadToController ()

@property (nonatomic,strong) GLInteractiveTransition *glInteractiveTransition;

@end

@implementation CircleSpreadToController

- (void)dealloc
{

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view.layer setContents:(id)[UIImage imageNamed:@"12"].CGImage];
    
    __weak typeof(self)weakSelf = self;
    [self gl_registerBackInteractiveTransitionWithDirection:GLPanEdgeLeft eventBlcok:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
}

- (void)btnClick:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
