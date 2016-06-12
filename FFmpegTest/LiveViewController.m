//
//  LiveViewController.m
//  FFmpegTest
//
//  Created by zhaoyuan on 16/6/9.
//  Copyright © 2016年 times. All rights reserved.
//

#import "LiveViewController.h"
#import "ZYLivePreview.h"
#import "CommentView.h"

#import <POP.h>



@interface LiveViewController ()

@end

@implementation LiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ZYLivePreview *liveview =[[ZYLivePreview alloc] initWithFrame:self.view.bounds];
    liveview.close = ^(){
        
        [self.navigationController popViewControllerAnimated:YES];
        
    };
    
    [self.view addSubview:liveview];
    
    CommentView *commentview =[CommentView initView];
    commentview.frame = self.view.bounds;
    [self.view addSubview:commentview];

//    UIImageView  *room_start_1=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
//    [room_start_1 setImage:[ UIImage imageNamed:@"room_start_1"]];
//    room_start_1.tag = 10001;
//    [self.view addSubview:room_start_1];
//    
//    UIImageView  *room_start_2=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
//    [room_start_2 setImage:[ UIImage imageNamed:@"room_start_2"]];
//    room_start_2.tag = 10002;
//    
//    [self.view addSubview:room_start_2];
//    
//    
//    UIImageView  *room_start_3=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150, 150)];
//    [room_start_3 setImage:[ UIImage imageNamed:@"room_start_3"]];
//    room_start_3.tag = 10003;
//    
//    [self.view addSubview:room_start_3];
//    
//    
//    room_start_1.center = room_start_2.center = room_start_3.center =self.view.center;
//    [self performSelector:@selector(start) withObject:nil afterDelay:2];
    
}


-(void)start{    
    POPSpringAnimation *springAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerBounds];
    springAnimation.springSpeed         = 0;                    // 设置动画速度(常用)
    springAnimation.springBounciness    = 20;                   // 设置弹性大小(常用)
    springAnimation.dynamicsFriction    = 10;                // 设置阻止弹性的阻力(选用)
    springAnimation.dynamicsTension     = 100;               // 设置弹性的张力(可以理解为每次变大的程度, 选用)
    springAnimation.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 0, 0)];
    // 添加动画
    [[self.view viewWithTag:10003].layer pop_addAnimation:springAnimation forKey:nil];
    [[self.view viewWithTag:10003].layer pop_addAnimation:springAnimation forKey:nil];
    [[self.view viewWithTag:10003].layer pop_addAnimation:springAnimation forKey:nil];
    
}


- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
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
