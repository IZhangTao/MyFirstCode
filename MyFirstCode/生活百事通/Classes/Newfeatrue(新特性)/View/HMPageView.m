//
//  PageView.m
//  Demo
//
//  Created by apple on 15/3/26.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "HMPageView.h"
#import "HMPageModel.h"


@interface HMPageView()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *animationCons;
@property (nonatomic, weak)IBOutlet UIImageView *bg;
@property (nonatomic, weak)IBOutlet UIImageView *guide;
@property (nonatomic, weak)IBOutlet UIImageView *largeText;
@property (nonatomic, weak)IBOutlet UIImageView *smallText;
@property (nonatomic, weak)IBOutlet UIButton *startBtn;
// 记录是否是从右边做动画进入
@property (nonatomic ,assign) BOOL right;

@end
@implementation HMPageView


+ (instancetype)pageView
{
    return [[[NSBundle mainBundle]loadNibNamed:@"HMPageView" owner:nil options:nil] lastObject];
}

- (void)setModel:(HMPageModel *)model
{
    _model = model;
    
    self.bg.image = [UIImage imageNamed:_model.bgName];
    self.guide.image = [UIImage imageNamed:_model.guideName];
    self.largeText.image = [UIImage imageNamed:_model.largeTextName];
    self.smallText.image = [UIImage imageNamed:_model.smallTextName];
}

- (void)startAnimation:(BOOL)right
{
    // 判断是否需要显示按钮
    if (self.tag == self.maxCount - 1) {
        self.startBtn.hidden = NO;
    }
    // 执行动画
    self.right = right;
    NSLog(@"%f", self.animationCons.constant);
    NSLog(@"开始动画");
    [UIView animateWithDuration:0.5 animations:^{
        self.animationCons.constant = 0;
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
         NSLog(@"%f", self.animationCons.constant);
    }];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    // 处理动画, 如果当前正在做动画就不重新设置约束
    if (self.right) {
        return;
    }
    NSLog(@"%tu", self.tag);
    // 处理第一页, 如果是第一页就不重新设置约束
    if (self.tag == 0) {
        return;
    }
    // 不是执行动画
    // 设置约束等于屏幕的宽度
    self.animationCons.constant += [UIScreen mainScreen].bounds.size.width;
    
}
- (IBAction)startBtnOnClick:(id)sender
{
    // 发送通知, 通知监听者切换控制器
    [[NSNotificationCenter defaultCenter] postNotificationName:@"chooseRootViewController" object:nil];
}
@end
