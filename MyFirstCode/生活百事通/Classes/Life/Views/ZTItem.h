//
//  ZTItem.h
//  生活百事通
//
//  Created by 张涛 on 15/4/23.
//  Copyright (c) 2015年 张涛. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZTItem : NSObject

@property (nonatomic ,copy) NSString *imageName;
@property (nonatomic ,copy) NSString *title;

@property (nonatomic, copy) NSString *icon;
// 点击cell 运行的控制器
@property (nonatomic, assign) Class destVcClass;
// 点击cell 运行block
@property (nonatomic, copy) void (^selectionHandler)();

+ (instancetype)itemWithImage:(NSString *)image title:(NSString *)title ;

+ (instancetype)itemWithImage:(NSString *)image title:(NSString *)title destVcClass:(Class) destVcClass;

+ (instancetype)itemWithImage:(NSString *)image title:(NSString *)title selectionHandler:(void (^)(id item))selectionHandler;
@end
