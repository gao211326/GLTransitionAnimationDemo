//
//  ViewController.m
//  GLPushAnimationDemo
//
//  Created by 高磊 on 2017/3/8.
//  Copyright © 2017年 高磊. All rights reserved.
//

#import "CircleSpreadFromController.h"
#import "GLCircleSpreadAnimation.h"
#import "UIViewController+GLTransition.h"
#import "CircleSpreadToController.h"

@interface CircleSpreadFromController ()

@property (nonatomic,strong) UIButton *animationButton;

@end

@implementation CircleSpreadFromController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view.layer setContents:(id)[UIImage imageNamed:@"4"].CGImage];
    
    [self.view addSubview:self.animationButton];
}


- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

#pragma mark == event response
- (void)animationButtonClick:(UIButton *)sender
{
    GLCircleSpreadAnimation *circleSpreadAnimation = [[GLCircleSpreadAnimation alloc] initWithStartPoint:self.animationButton.center radius:30];
    
    CircleSpreadToController *secondVc = [[CircleSpreadToController alloc] init];
    
    [self gl_pushViewControler:secondVc withAnimation:circleSpreadAnimation];
//    [self gl_presentViewControler:secondVc withAnimation:circleSpreadAnimation];
}


#pragma mark == 懒加载
- (UIButton *)animationButton
{
    if (nil == _animationButton)
    {
        _animationButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _animationButton.frame = CGRectMake(80, 120, 60, 60);
        _animationButton.layer.cornerRadius = 30;
        [_animationButton addTarget:self action:@selector(animationButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_animationButton setImage:[UIImage imageNamed:@"运动"] forState:UIControlStateNormal];
    }
    return _animationButton;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
