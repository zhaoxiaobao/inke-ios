//
//  ZYTabBarController.m
//  
//
//  Created by zhaoyuan on 16/6/14.
//  Copyright © 2016年 赵远. All rights reserved.
//

#import "ZYTabBarController.h"
//from http://stackoverflow.com/questions/8909379/setting-a-background-image-for-a-tabbar

@interface ZYTabBarController ()

@end

@implementation ZYTabBarController

@synthesize settingsButton, infoButton, aboutUsButton;

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self addCustomElements];
}

-(void)addCustomElements
{
    UIImageView* bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tabBarBackground.png"]];
    bgView.frame = CGRectMake(0, self.view.bounds.size.height-64, self.view.bounds.size.width, 64);
    bgView.backgroundColor =[UIColor redColor];
    [self.view addSubview:bgView];
    
    UIImage *btnImage = [UIImage imageNamed:@"settings.png"];
    UIImage *btnImageSelected = [UIImage imageNamed:@"settingsSelected.png"];
    
    self.settingsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    settingsButton.frame = CGRectMake(10, 426, 100, 54);
    [settingsButton setBackgroundImage:btnImage forState:UIControlStateNormal];
    [settingsButton setBackgroundImage:btnImageSelected forState:UIControlStateHighlighted]; // Set the image for the selected state of the button
    [settingsButton setBackgroundImage:btnImageSelected forState:UIControlStateSelected]; // Set the image for the selected state of the button
    [settingsButton setBackgroundImage:btnImageSelected forState:UIControlStateDisabled];
    [settingsButton setImage:btnImageSelected forState:(UIControlStateHighlighted|UIControlStateSelected)];
    [settingsButton setTag:101]; // Assign the button a "tag" so when our "click" event is called we know which button was pressed.
    [settingsButton setSelected:true]; // Set this button as selected (we will select the others to false as we only want Tab 1 to be selected initially
    
    // Now we repeat the process for the other buttons
    btnImage = [UIImage imageNamed:@"info.png"];
    btnImageSelected = [UIImage imageNamed:@"infoSelected.png"];
    self.infoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    infoButton.frame = CGRectMake(110, 426, 100, 54);
    [infoButton setBackgroundImage:btnImage forState:UIControlStateNormal];
    [infoButton setBackgroundImage:btnImageSelected forState:UIControlStateSelected];
    [infoButton setBackgroundImage:btnImageSelected forState:UIControlStateHighlighted];
    [infoButton setImage:btnImageSelected forState:(UIControlStateHighlighted|UIControlStateSelected)];
    
    [infoButton setTag:102];
    
    btnImage = [UIImage imageNamed:@"aboutUs.png"];
    btnImageSelected = [UIImage imageNamed:@"aboutUsSelected.png"];
    self.aboutUsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    aboutUsButton.frame = CGRectMake(210, 426, 100, 54);
    [aboutUsButton setBackgroundImage:btnImage forState:UIControlStateNormal];
    [aboutUsButton setBackgroundImage:btnImageSelected forState:UIControlStateSelected];
    [aboutUsButton setBackgroundImage:btnImageSelected forState:UIControlStateHighlighted];
    [aboutUsButton setImage:btnImageSelected forState:(UIControlStateHighlighted|UIControlStateSelected)];
    
    [aboutUsButton setTag:103];
    
    // Add my new buttons to the view
    [self.view addSubview:settingsButton];
    [self.view addSubview:infoButton];
    [self.view addSubview:aboutUsButton];
    
    self.settingsButton.backgroundColor = [UIColor redColor];
    self.infoButton.backgroundColor = [UIColor yellowColor];
    self.aboutUsButton.backgroundColor = navigationBarColor;

    
    // Setup event handlers so that the buttonClicked method will respond to the touch up inside event.
    [settingsButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [infoButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [aboutUsButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
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
            [settingsButton setSelected:true];
            [infoButton setSelected:false];
            [aboutUsButton setSelected:false];
            break;
        case 102:
            [settingsButton setSelected:false];
            [infoButton setSelected:true];
            [aboutUsButton setSelected:false];
            break;
        case 103:
            [settingsButton setSelected:false];
            [infoButton setSelected:false];
            [aboutUsButton setSelected:true];
            break;
    }
    self.selectedIndex = tabID-101;
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
