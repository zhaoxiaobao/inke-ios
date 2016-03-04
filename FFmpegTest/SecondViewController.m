//
//  SecondViewController.m
//  FFmpegTest
//
//  Created by zhaoyuan on 16/2/2.
//  Copyright © 2016年 times. All rights reserved.
//

#import "SecondViewController.h"

#import "TitlePagerView.h"

#import "HotViewController.h"
#import "GZViewController.h"
#import "NewViewController.h"




@interface SecondViewController ()<ViewPagerDataSource, ViewPagerDelegate, TitlePagerViewDelegate>

@property (nonatomic, strong) GZViewController *newestTopicListVC;
@property (nonatomic, strong) HotViewController *hotsTopicListVC;
@property (nonatomic, strong) NewViewController *jobTopicListVC;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) TitlePagerView *pagingTitleView;

@property(nonatomic, strong) UITableView *tableView;





@end



@implementation SecondViewController

- (void)viewDidLoad {
    
    self.dataSource = self;
    self.delegate = self;
    NSLog(@"%@",self.view);
    
    // Do not auto load data
    self.manualLoadData = YES;
    
    self.currentIndex = 0;
    
//    self.contentViewBackgroundColor=orange;
    
    [super viewDidLoad];
    
    
    self.view.backgroundColor=[UIColor whiteColor];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self initNav];
    
    [self reloadData];
    
    
}

-(void)initNav{
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 64)];
    backView.backgroundColor=navigationBarColor;
    [self.view addSubview:backView];
    
    self.pagingTitleView.center=backView.center;
    self.pagingTitleView.y+=10;
    [backView addSubview:self.pagingTitleView];
    
    
}






- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    //    [[NSNotificationCenter defaultCenter] removeObserver:self name:DidTapStatusBar object:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statusBarTappedAction:) name:DidTapStatusBar object:nil];
}

- (void)statusBarTappedAction:(NSNotification*)notification {
    //    if (self.currentIndex == 0 && self.newestTopicListVC) {
    //        [self.newestTopicListVC.tableView setContentOffset:CGPointZero animated:YES];
    //    } else if (self.currentIndex == 1 && self.hotsTopicListVC) {
    //        [self.hotsTopicListVC.tableView setContentOffset:CGPointZero animated:YES];
    //    } else if (self.currentIndex == 2 && self.jobTopicListVC) {
    //        [self.jobTopicListVC.tableView setContentOffset:CGPointZero animated:YES];
    //    }
}

#pragma mark - ViewPagerDataSource
- (NSUInteger)numberOfTabsForViewPager:(ViewPagerController *)viewPager {
    return 3;
}

- (UIViewController *)viewPager:(ViewPagerController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index {
    if (index == 0) {
        return [self createNewestVC];
    } else if (index == 1) {
        return [self createHotsVC];
    } else {
        return [self createJobVC];
    }
}

- (UIViewController *)createNewestVC {
    self.newestTopicListVC = [[GZViewController alloc] init];
    return self.newestTopicListVC;
}

- (UIViewController *)createHotsVC {
    self.hotsTopicListVC = [[HotViewController alloc] init];
    //    self.hotsTopicListVC.topicListType = TopicListTypeHots;
    //    self.hotsTopicListVC.isFromTopicContainer = YES;
    return self.hotsTopicListVC;
}

- (UIViewController *)createJobVC {
    self.jobTopicListVC = [[NewViewController alloc] init];
    //    self.jobTopicListVC.topicListType = TopicListTypeJob;
    //    self.jobTopicListVC.isFromTopicContainer = YES;
    return self.jobTopicListVC;
}

- (void)viewPager:(ViewPagerController *)viewPager didChangeTabToIndex:(NSUInteger)index {
    self.currentIndex = index;
}

- (TitlePagerView *)pagingTitleView {
    if (!_pagingTitleView) {
        self.pagingTitleView = [[TitlePagerView alloc] init];
        self.pagingTitleView.frame = CGRectMake(0, 0, 0, 40);
        self.pagingTitleView.font = [UIFont systemFontOfSize:15];
        NSArray *titleArray = @[@"最新", @"热门", @"关注"];
        self.pagingTitleView.width = [TitlePagerView calculateTitleWidth:titleArray withFont:self.pagingTitleView.font];
        [self.pagingTitleView addObjects:titleArray];
        self.pagingTitleView.delegate = self;
    }
    return _pagingTitleView;
}


- (void)didTouchBWTitle:(NSUInteger)index {
    //    NSInteger index;
    UIPageViewControllerNavigationDirection direction;
    
    if (self.currentIndex == index) {
        return;
    }
    
    if (index > self.currentIndex) {
        direction = UIPageViewControllerNavigationDirectionForward;
    } else {
        direction = UIPageViewControllerNavigationDirectionReverse;
    }
    
    UIViewController *viewController = [self viewControllerAtIndex:index];
    
    if (viewController) {
        __weak typeof(self) weakself = self;
        [self.pageViewController setViewControllers:@[viewController] direction:direction animated:YES completion:^(BOOL finished) {
            weakself.currentIndex = index;
        }];
    }
}

- (void)setCurrentIndex:(NSInteger)index {
    _currentIndex = index;
    [self.pagingTitleView adjustTitleViewByIndex:index];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat contentOffsetX = scrollView.contentOffset.x;
    
    if (self.currentIndex != 0 && contentOffsetX <= screen_width * 2) {
        contentOffsetX += screen_width * self.currentIndex;
    }
    
    [self.pagingTitleView updatePageIndicatorPosition:contentOffsetX];
}

- (void)scrollEnabled:(BOOL)enabled {
    self.scrollingLocked = !enabled;
    
    for (UIScrollView *view in self.pageViewController.view.subviews) {
        if ([view isKindOfClass:[UIScrollView class]]) {
            view.scrollEnabled = enabled;
            view.bounces = enabled;
        }
    }
}
@end