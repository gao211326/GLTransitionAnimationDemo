//
//  MiddlePageFromViewController.m
//  GLTransitionAnimationDemo
//
//  Created by 高磊 on 2017/3/31.
//  Copyright © 2017年 高磊. All rights reserved.
//

#import "MiddlePageFromViewController.h"
#import "MiddlePageToViewController.h"

#import "UIViewController+GLTransition.h"
#import "GLMiddlePageAnimation.h"

@interface MiddlePageFromViewController ()

@end

@implementation MiddlePageFromViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view.layer setContents:(id)[UIImage imageNamed:@"b"].CGImage];
    
    __weak typeof(self)weakSelf = self;
    [self gl_registerToInteractiveTransitionWithDirection:GLPanEdgeRight eventBlcok:^{
        
        MiddlePageToViewController *middlePageToVc = [[MiddlePageToViewController alloc] init];
        GLMiddlePageAnimation *middlePageAnimation = [[GLMiddlePageAnimation alloc] init];
        middlePageAnimation.duration = 1;
        
        [weakSelf gl_pushViewControler:middlePageToVc withAnimation:middlePageAnimation];
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
