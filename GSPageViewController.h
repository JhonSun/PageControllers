//
//  GSPageViewController.h
//  GreatSupervision
//
//  Created by lianditech on 2017/11/18.
//  Copyright © 2017年 lianditech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GSPageViewController : UIPageViewController

@property (nonatomic, assign) NSInteger selectIndex;//外部控制选中哪一页
@property (nonatomic, copy) void (^scrollBlock)(NSInteger);
@property (nonatomic, strong) NSArray *childVCArray;//列表

- (instancetype)initWithTransitionStyle:(UIPageViewControllerTransitionStyle)style navigationOrientation:(UIPageViewControllerNavigationOrientation)navigationOrientation options:(NSDictionary<NSString *,id> *)options childVCArray:(NSArray *)childVCArray;

@end
