//
//  PageView.h
//  Demo
//
//  Created by apple on 15/3/26.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HMPageModel, HMPageView;

/*
 // 由于需要传递的层次过于复杂, 不建议使用代理
@protocol PageViewDelegate <NSObject>

- (void)pageView:(HMPageView *)pageView didStartBtn:(UIButton *)btn;

@end
 */

@interface HMPageView : UIView

/**
 *  接收需要展示的数据模型
 */
@property(nonatomic, strong)HMPageModel *model;

// 总页码
@property (nonatomic ,assign) NSUInteger maxCount;

//@property(nonatomic, weak)id<PageViewDelegate> delegate;

/**
 *  快速创建xib中的view
 */
+ (instancetype)pageView;
/**
 *  开始执行动画
 */
- (void)startAnimation:(BOOL)right;
@end
