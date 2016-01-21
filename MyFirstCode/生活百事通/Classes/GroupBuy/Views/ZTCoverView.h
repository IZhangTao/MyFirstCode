//
//  ZTCoverView.h
//  生活百事通
//
//  Created by zhangtao on 15/12/17.
//  Copyright © 2015年 张涛. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZTCoverView : UIView
+ (id)cover;
+ (id)coverWithTarget:(id)target action:(SEL)action;

- (void)reset;
@end
