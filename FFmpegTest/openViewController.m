//
//  openViewController.m
//  FFmpegTest
//
//  Created by zhaoyuan on 16/6/5.
//  Copyright © 2016年 times. All rights reserved.
//
#define MAX_LENGTH 20
#import "openViewController.h"
#import "LiveViewController.h"

@interface openViewController ()<UITextViewDelegate>


@end

@implementation openViewController


-(void)viewWillAppear:(BOOL)animated{
    
    [self.titlefiled becomeFirstResponder];
    
}


- (IBAction)close:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
    

    
}





- (IBAction)openLiveAction:(id)sender {
   
    LiveViewController* VC  = [[LiveViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationController setNavigationBarHidden:YES animated:YES];

    [[UIApplication sharedApplication] setStatusBarHidden:YES];
            
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWasShown:)
     
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWillBeHidden:)
     
                                                 name:UIKeyboardWillHideNotification object:nil];
    
    self.titlefiled.delegate = self;
    
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.text.length >= MAX_LENGTH && range.length == 0)
    {
        return NO; // return NO to not change text
    }
    else
    {return YES;}
}


- (void)keyboardWasShown:(NSNotification*)aNotification{
    
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    [self begainMoveUpAnimation:kbSize.height];
    
}


- (void)keyboardWillBeHidden:(NSNotification*)aNotification{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    [self begainMoveUpAnimation:-kbSize.height];
    
    
}


- (void)begainMoveUpAnimation:(CGFloat )keyboardhight{
    //do something
//    [UIView beginAnimations:@"Animation" context:nil];
//    [UIView setAnimationDuration:0.3f];
//    [UIView setAnimationBeginsFromCurrentState: YES];
//    self.startbtn.frame = CGRectMake(self.startbtn.frame.origin.x, self.startbtn.frame.origin.y - keyboardhight, self.startbtn.frame.size.width, self.startbtn.frame.size.height);
//    [UIView commitAnimations];
    
    
}

    




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
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
