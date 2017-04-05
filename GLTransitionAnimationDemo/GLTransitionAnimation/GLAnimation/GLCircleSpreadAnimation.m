//
//  GLCircleSpreadAnimation.m
//  GLPushAnimationDemo
//
//  Created by 高磊 on 2017/3/16.
//  Copyright © 2017年 高磊. All rights reserved.
//

#import "GLCircleSpreadAnimation.h"

@interface GLCircleSpreadAnimation ()<CAAnimationDelegate>

//动画的中心坐标
@property (nonatomic,assign) CGPoint centerPoint;
//半径
@property (nonatomic,assign) CGFloat radius;
//保存layer在动画结束的时候 可以根据这个来获取添加的动画
@property (nonatomic,strong) CAShapeLayer *maskShapeLayer;
//保存转场动画开始时的路径 当退出动画取消的时候 保存原理的样子
@property (nonatomic, strong) UIBezierPath *startPath;

@end

@implementation GLCircleSpreadAnimation

- (id)initWithStartPoint:(CGPoint)point radius:(CGFloat)radius
{
    self = [super init];
    if (self) {
        self.centerPoint = point;
        self.radius = radius;
    }
    return self;
}

//具体实现
- (void)setToAnimation:(id<UIViewControllerContextTransitioning>)contextTransition
{
    //获取目标动画的VC
    UIViewController *toVc = [contextTransition viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [contextTransition containerView];
    [containerView addSubview:toVc.view];
    
    //创建UIBezierPath路径 作为后面动画的起始路径
    UIBezierPath *startPath = [UIBezierPath bezierPathWithArcCenter:self.centerPoint radius:self.radius startAngle:0 endAngle:2*M_PI clockwise:YES];
    
    //创建结束UIBezierPath
    //首先我们需要得到后面路径的半径  半径应该是距四个角最远的距离
    CGFloat x = self.centerPoint.x;
    CGFloat y = self.centerPoint.y;
    //取出其中距屏幕最远的距离 来求围城矩形的对角线 即我们所需要的半径
    CGFloat radius_x = MAX(x, containerView.frame.size.width - x);
    CGFloat radius_y = MAX(y, containerView.frame.size.height - y);
    //补充下 sqrtf求平方根   double pow(double x, double y); 求 x 的 y 次幂（次方）
    //通过勾股定理算出半径
    CGFloat endRadius = sqrtf(pow(radius_x, 2) + pow(radius_y, 2));
    
    UIBezierPath *endPath = [UIBezierPath bezierPathWithArcCenter:self.centerPoint radius:endRadius startAngle:0 endAngle:2*M_PI clockwise:YES];
    
//    self.endPath = endPath;
    
    //创建CAShapeLayer 用以后面的动画
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = endPath.CGPath;
    toVc.view.layer.mask = shapeLayer;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.fromValue = (__bridge id _Nullable)(startPath.CGPath);
    animation.duration = self.duration;
    animation.delegate = (id)self;
//    animation.removedOnCompletion = NO;//执行后移除动画
    //保存contextTransition  后面动画结束的时候调用
    [animation setValue:contextTransition forKey:@"pathContextTransition"];
    [shapeLayer addAnimation:animation forKey:nil];
    
    self.maskShapeLayer = shapeLayer;
}

- (void)setBackAnimation:(id<UIViewControllerContextTransitioning>)contextTransition
{
    //将tovc的view放到最下面一层
    UIViewController *toVc = [contextTransition viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIViewController *fromVc = [contextTransition viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *containerView = [contextTransition containerView];
    [containerView insertSubview:toVc.view atIndex:0];
    
    //push前的 startPath 作为endPath
    UIBezierPath *endPath = [UIBezierPath bezierPathWithArcCenter:self.centerPoint radius:self.radius startAngle:0 endAngle:2*M_PI clockwise:YES];
    
    CAShapeLayer *shapeLayer = (CAShapeLayer *)fromVc.view.layer.mask;
    self.maskShapeLayer = shapeLayer;
    //将pop后的 path作为startPath
    UIBezierPath *startPath = [UIBezierPath bezierPathWithCGPath:shapeLayer.path];
    self.startPath = startPath;
    shapeLayer.path = endPath.CGPath;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.fromValue = (__bridge id _Nullable)(startPath.CGPath);
    animation.toValue = (__bridge id _Nullable)(endPath.CGPath);
    animation.duration = self.duration;
    animation.delegate = (id)self;
//    animation.removedOnCompletion = NO;//执行后移除动画
    //保存contextTransition  后面动画结束的时候调用
    [animation setValue:contextTransition forKey:@"pathContextTransition"];
    [shapeLayer addAnimation:animation forKey:nil];
}


#pragma mark == CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    id<UIViewControllerContextTransitioning> contextTransition = [anim valueForKey:@"pathContextTransition"];
    
    //取消的时候 将动画还原到之前的路径  
    if (contextTransition.transitionWasCancelled) {
        self.maskShapeLayer.path = self.startPath.CGPath;
    }
    // 声明过渡结束
    [contextTransition completeTransition:!contextTransition.transitionWasCancelled];
}

@end
