//
//  OpenDoorFromViewController.m
//  GLTransitionAnimationDemo
//
//  Created by 高磊 on 2017/3/30.
//  Copyright © 2017年 高磊. All rights reserved.
//

#import "OpenDoorFromViewController.h"
#import "OpenDoorToViewController.h"

#import "UIViewController+GLTransition.h"
#import "GLOpenDoorAnimation.h"

@interface OpenDoorFromViewController ()

@property (nonatomic,strong) UIButton *animationButton;

@end

@implementation OpenDoorFromViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view.layer setContents:(id)[UIImage imageNamed:@"11"].CGImage];
    
    [self.view addSubview:self.animationButton];
}


#pragma mark == event response
- (void)animationButtonClick:(UIButton *)sender
{
    GLOpenDoorAnimation *openDoorAnimation = [[GLOpenDoorAnimation alloc] init];
    openDoorAnimation.duration = 0.5;
    
    OpenDoorToViewController *openDoorToVc = [[OpenDoorToViewController alloc] init];
    [self gl_presentViewControler:openDoorToVc withAnimation:openDoorAnimation];
}

#pragma mark == 懒加载
- (UIButton *)animationButton
{
    if (nil == _animationButton)
    {
        _animationButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _animationButton.frame = CGRectMake(0, 0, 60, 60);
        _animationButton.center = self.view.center;
        _animationButton.layer.cornerRadius = 30;
        [_animationButton addTarget:self action:@selector(animationButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_animationButton setImage:[UIImage imageNamed:@"圆"] forState:UIControlStateNormal];
        _animationButton.adjustsImageWhenHighlighted = NO;
    }
    return _animationButton;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
