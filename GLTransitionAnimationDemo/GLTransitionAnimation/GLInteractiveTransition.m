//
//  GLInteractiveTransition.m
//  GLTransitionAnimationDemo
//
//  Created by 高磊 on 2017/3/24.
//  Copyright © 2017年 高磊. All rights reserved.
//  手势转场控制类

#import "GLInteractiveTransition.h"

@interface GLInteractiveTransition ()

/**
 保存添加手势的view
 */
@property (nonatomic,strong) UIView *gestureView;

/**
 屏幕侧滑手势
 */
@property (nonatomic,strong) UIScreenEdgePanGestureRecognizer *panGesture;

//@property (nonatomic,assign) GLInteractiveTransitionType transitionType;

@end

@implementation GLInteractiveTransition

- (void)addEdgePageGestureWithView:(UIView *)view direction:(GLEdgePanGestureDirection)direction
{
    UIScreenEdgePanGestureRecognizer *popRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePopRecognizer:)];
    switch (direction) {
        case GLPanEdgeLeft:
        {
            popRecognizer.edges = UIRectEdgeLeft;
        }
            break;
        case GLPanEdgeTop:
        {
            popRecognizer.edges = UIRectEdgeTop;
        }
            break;
        case GLPanEdgeBottom:
        {
            popRecognizer.edges = UIRectEdgeBottom;
        }
            break;
        case GLPanEdgeRight:
        {
            popRecognizer.edges = UIRectEdgeRight;
        }
            break;
        default:
            break;
    }
    
    self.gestureView = view;
    [self.gestureView addGestureRecognizer:popRecognizer];
}

- (void)handlePopRecognizer:(UIPanGestureRecognizer*)recognizer {
    // 计算用户手指划了多远
    
    CGFloat progress = fabs([recognizer translationInView:self.gestureView].x) / (self.gestureView.bounds.size.width * 1.0);
    progress = MIN(1.0, MAX(0.0, progress));
        
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
        {
            _isPanGestureInteration = YES;
            
            if (self.eventBlcok) {
                self.eventBlcok();
            }
            
            // 创建过渡对象，弹出viewController
//            
//            UIViewController *fromVc = [self gl_viewController];
//            
//            switch (self.transitionType) {
//                case GLInteractiveTransitionPush:
//                {
//                    
//                }
//                    break;
//                case GLInteractiveTransitionPop:
//                {
//                    if (fromVc.navigationController) {
//                        [fromVc.navigationController popViewControllerAnimated:YES];
//                    }
//                }
//                    break;
//                case GLInteractiveTransitionPresent:
//                {
//                    
//                }
//                    break;
//                case GLInteractiveTransitionDismiss:
//                {
//                    [fromVc dismissViewControllerAnimated:YES completion:nil];
//                }
//                    break;
//                default:
//                    break;
//            }
            break;
        }
        case UIGestureRecognizerStateChanged:
        {
            // 更新 interactive transition 的进度
            [self updateInteractiveTransition:progress];
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        {
//            NSLog(@" 打印信息:%f",progress);
            // 完成或者取消过渡
            if (progress > 0.5) {
                [self finishInteractiveTransition];
            }
            else {
                [self cancelInteractiveTransition];
            }
            
            _isPanGestureInteration = NO;
            break;
        }
        default:
            break;
    }
}


//- (UIViewController *)gl_viewController {
//    UIResponder *nextResponder =  self.gestureView;
//    do
//    {
//        nextResponder = [nextResponder nextResponder];
//        
//        if ([nextResponder isKindOfClass:[UIViewController class]])
//            return (UIViewController*)nextResponder;
//        
//    } while (nextResponder != nil);
//    
//    return nil;
//}

@end
