//
//  SecondViewController.m
//  FFmpegTest
//
//  Created by zhaoyuan on 16/2/2.
//  Copyright © 2016年 times. All rights reserved.
//

#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "TitlePagerView.h"
#import "HotViewController.h"
#import "GZViewController.h"
#import "NewViewController.h"
#import "openViewController.h"
#import "ZYTabBarView.h"


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
    self.manualLoadData = YES;
    
    self.currentIndex = 0;
    
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self initNav];
    
    [self reloadData];
    
    //    UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(screen_width/2-20,screen_height-70, 40, 40)];
    //    [btn setImage:[ UIImage imageNamed:@"btn_dt_d_"] forState:UIControlStateNormal];
    //
    //    [btn addTarget:self action:@selector(addBtnTap:) forControlEvents:UIControlEventTouchUpInside];
    //    [[UIApplication sharedApplication].keyWindow addSubview:btn];
    
}


-(void)addBtnTap:(UIButton *)sender{
    
    openViewController* VC  = [[openViewController alloc] init];
    UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:VC];
    [self presentViewController:nav animated:YES completion:nil];
}

-(void)initNav{
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 64)];
    backView.backgroundColor=navigationBarColor;
    [self.view addSubview:backView];
    
    self.pagingTitleView.center=backView.center;
    self.pagingTitleView.y+=10;
    [backView addSubview:self.pagingTitleView];
    
    ZYTabBarView *_view=[ZYTabBarView createView] ;
    _view.frame = CGRectMake(0, screen_height-64, screen_width, 64);
    [_view.centreButton addTarget:self action:@selector(addBtnTap:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_view];
    
//    __weak typeof(self) _self = self;
    [_view.firstButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
        _view.firstButton.selected = YES;
        _view.secondButton.selected = NO;
        
    }];
    
    [_view.secondButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
        _view.secondButton.selected = YES;
        _view.firstButton.selected = NO;
        
//        ThirdViewController* VC  = [[ThirdViewController alloc] init];
//        [_self.navigationController pushViewController:VC animated:YES];
        
    }];

}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)statusBarTappedAction:(NSNotification*)notification {
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
        return [self createNewVC];
    }
}

- (UIViewController *)createNewestVC {
    self.newestTopicListVC = [[GZViewController alloc] init];
    return self.newestTopicListVC;
}

- (UIViewController *)createHotsVC {
    self.hotsTopicListVC = [[HotViewController alloc] init];
    return self.hotsTopicListVC;
}

- (UIViewController *)createNewVC {
    self.jobTopicListVC = [[NewViewController alloc] init];
    return self.jobTopicListVC;
}

- (void)viewPager:(ViewPagerController *)viewPager didChangeTabToIndex:(NSUInteger)index {
    self.currentIndex = index;
}

- (TitlePagerView *)pagingTitleView {
    if (!_pagingTitleView) {
        self.pagingTitleView = [[TitlePagerView alloc] init];
        self.pagingTitleView.frame = CGRectMake(0, 0, 0, 40);
        self.pagingTitleView.font = [UIFont systemFontOfSize:16];
        NSArray *titleArray = @[@"关注", @"热门", @"最新"];
        self.pagingTitleView.tintColor = [UIColor whiteColor];
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

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}





@end