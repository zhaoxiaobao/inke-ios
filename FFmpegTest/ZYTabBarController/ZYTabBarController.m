//
//  ZYTabBarController.m
//
//
//  Created by zhaoyuan on 16/6/14.
//  Copyright © 2016年 赵远. All rights reserved.
//

#import "ZYTabBarController.h"
#import "openViewController.h"

@interface ZYTabBarController ()

@end

@implementation ZYTabBarController

@synthesize tabbar;

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self addCustomElements];
//    [self.tabBar removeAllSubViews];
}

-(void)addCustomElements
{
    tabbar=[ZYTabBarView createView] ;
    tabbar.frame = CGRectMake(0, screen_height-64, screen_width, 64);
    tabbar.firstButton.tag = 101;
    tabbar.centreButton.tag = 102;
    tabbar.secondButton.tag = 103;
    [self.view addSubview:tabbar];
    [self.view bringSubviewToFront:tabbar];
    
    [tabbar.firstButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [tabbar.centreButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [tabbar.secondButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonClicked:(id)sender
{
    [self selectTab:(int)[sender tag]];
}

- (void)selectTab:(int)tabID
{
    switch(tabID)
    {
        case 101:
            [tabbar.firstButton setSelected:true];
            [tabbar.centreButton setSelected:false];
            [tabbar.secondButton setSelected:false];
            self.selectedIndex = tabID-101;
            
            break;
            
        case 102:{
            [tabbar.firstButton setSelected:false];
            [tabbar.centreButton setSelected:true];
            [tabbar.secondButton setSelected:false];
            openViewController* VC  = [[openViewController alloc] init];
            UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:VC];
            [self presentViewController:nav animated:YES completion:nil];
        }
            break;
        case 103:
            [tabbar.firstButton setSelected:false];
            [tabbar.centreButton setSelected:false];
            [tabbar.secondButton setSelected:true];
            self.selectedIndex = tabID-102;
            break;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
