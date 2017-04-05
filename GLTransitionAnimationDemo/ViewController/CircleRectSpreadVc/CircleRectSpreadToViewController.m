//
//  CircleRectSpreadToViewController.m
//  GLTransitionAnimationDemo
//
//  Created by 高磊 on 2017/3/27.
//  Copyright © 2017年 高磊. All rights reserved.
//

#import "CircleRectSpreadToViewController.h"
#import "UIViewController+GLTransition.h"



@interface CircleRectSpreadToViewController ()

@property (nonatomic,strong) UIButton *animationButton;

@end

@implementation CircleRectSpreadToViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = UICOLOR_FROM_RGB_OxFF(0x4876FF);
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, self.view.frame.size.width, 50)];
    lable.font = [UIFont systemFontOfSize:40];
    lable.textColor = [UIColor whiteColor];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.text = @"Hello World!";
    [self.view addSubview:lable];
    
    [self.view addSubview:self.animationButton];
}

#pragma mark == event response
- (void)animationButtonClick:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
        [_animationButton setImage:[UIImage imageNamed:@"叉"] forState:UIControlStateNormal];
        _animationButton.adjustsImageWhenHighlighted = NO;
    }
    return _animationButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
