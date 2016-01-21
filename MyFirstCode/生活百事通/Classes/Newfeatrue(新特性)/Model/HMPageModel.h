//
//  PageModel.h
//  Test
//
//  Created by 李南江 on 15/3/25.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMPageModel : NSObject
// 背景图片名称
@property (nonatomic ,copy) NSString *bgName;
// 大图名称
@property (nonatomic ,copy) NSString *guideName;
// 大文本图片名称
@property (nonatomic ,copy) NSString *largeTextName;
// 小文本图片名称
@property (nonatomic ,copy) NSString *smallTextName;
@end
