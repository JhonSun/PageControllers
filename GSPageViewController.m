//
//  GSPageViewController.m
//  GreatSupervision
//
//  Created by lianditech on 2017/11/18.
//  Copyright © 2017年 lianditech. All rights reserved.
//

#import "GSPageViewController.h"

@interface GSPageViewController ()<UIPageViewControllerDelegate, UIPageViewControllerDataSource>

@property (nonatomic, strong) UIViewController *currentChildVC;

@end

@implementation GSPageViewController

- (instancetype)initWithTransitionStyle:(UIPageViewControllerTransitionStyle)style navigationOrientation:(UIPageViewControllerNavigationOrientation)navigationOrientation options:(NSDictionary<NSString *,id> *)options childVCArray:(NSArray *)childVCArray {
    self = [super initWithTransitionStyle:style navigationOrientation:navigationOrientation options:options];
    if (self) {
        self.childVCArray = childVCArray;
        self.dataSource = self;
        self.delegate = self;
        if (self.childVCArray.count > 0) {
            [self setViewControllers:@[[self.childVCArray firstObject]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - set
- (void)setSelectIndex:(NSInteger)selectIndex {
    _selectIndex = selectIndex;
    if (_selectIndex >= self.childVCArray.count) {
        NSLog(@"你设置的子控制器数量不对");
        return ;
    }
    [self setViewControllers:@[[self.childVCArray objectAtIndex:_selectIndex]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
}

#pragma mark - UIPageViewControllerDataSource
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSInteger index = [self.childVCArray indexOfObject:viewController];
    if (index == 0 || index == NSNotFound) return nil;
    index--;
    if (index < 0) return nil;
    //    NSLog(@"前翻第%i页", index);
    return [self.childVCArray objectAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSInteger index = [self.childVCArray indexOfObject:viewController];
    if (index == NSNotFound) return nil;
    index++;
    if (index >= self.childVCArray.count) return nil;
    //    NSLog(@"后翻第%i页", index);
    return [self.childVCArray objectAtIndex:index];
}

#pragma mark - UIPageViewControllerDelegate
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers {
    //将要滑动到的vc
    self.currentChildVC = [pendingViewControllers firstObject];
    //    NSLog(@"要滑动的viewController:%@", pendingViewControllers);
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    //是否滑动到另外一页
    if (completed) {
        NSInteger index = [self.childVCArray indexOfObject:self.currentChildVC];
        _selectIndex = index;
        if (self.scrollBlock) self.scrollBlock(index);
        //        NSLog(@"滑动之前的viewController:%@", previousViewControllers);
        //        NSLog(@"所有viewController:%@", self.childVCArray);
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
