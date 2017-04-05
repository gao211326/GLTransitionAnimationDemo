//
//  CircleRectSpreadFromViewController.m
//  GLTransitionAnimationDemo
//
//  Created by 高磊 on 2017/3/27.
//  Copyright © 2017年 高磊. All rights reserved.
//

#import "CircleRectSpreadFromViewController.h"
#import "CircleRectSpreadToViewController.h"
#import "UIViewController+GLTransition.h"
#import "GLCircleRectSpreadAnimation.h"

@interface CircleRectSpreadFromViewController ()

@property (nonatomic,strong) UIButton *animationButton;

@end

@implementation CircleRectSpreadFromViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.animationButton];
}



#pragma mark == event response
- (void)animationButtonClick:(UIButton *)sender
{
    GLCircleRectSpreadAnimation *circleSpreadAnimation = [[GLCircleRectSpreadAnimation alloc] initWithStartPoint:self.animationButton.center];
    circleSpreadAnimation.duration = 0.5;
    
    CircleRectSpreadToViewController *secondVc = [[CircleRectSpreadToViewController alloc] init];
    
    [self gl_presentViewControler:secondVc withAnimation:circleSpreadAnimation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark == 懒加载
- (UIButton *)animationButton
{
    if (nil == _animationButton)
    {
        _animationButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _animationButton.frame = CGRectMake((self.view.frame.size.width - 60)/2.0, self.view.frame.size.height-120, 60, 60);
        _animationButton.layer.cornerRadius = 30;
        [_animationButton addTarget:self action:@selector(animationButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_animationButton setImage:[UIImage imageNamed:@"加"] forState:UIControlStateNormal];
        _animationButton.adjustsImageWhenHighlighted = NO;
    }
    return _animationButton;
}

@end
