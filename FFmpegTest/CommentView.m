//
//  CommentView.m
//  FFmpegTest
//
//  Created by zhaoyuan on 16/6/11.
//  Copyright © 2016年 times. All rights reserved.
//



#import "CommentView.h"


@interface CommentView ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *send;
@property (weak, nonatomic) IBOutlet UITextField *textfield;

@end

@implementation CommentView

- (IBAction)send:(id)sender {
    [self endEditing:YES];
}

+(instancetype) createView{
    NSBundle *bundle=[NSBundle mainBundle];
    NSArray *objs=[bundle loadNibNamed:@"CommentView" owner:nil options:nil];
    return [objs lastObject];
}


+(instancetype) initView{
    
    CommentView *view = [self createView];
    [view config];
    return view;
}

-(void)config{
    
    self.textfield.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWasShown:)
     
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWillBeHidden:)
     
                                                 name:UIKeyboardWillHideNotification object:nil];
    
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
    [UIView beginAnimations:@"Animation" context:nil];
    [UIView setAnimationDuration:0.3f];
    [UIView setAnimationBeginsFromCurrentState: YES];
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y - keyboardhight, self.frame.size.width, self.frame.size.height);
    [UIView commitAnimations];
    

}



-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
//    [UIView beginAnimations:@"Animation" context:nil];
//    [UIView setAnimationDuration:0.20];
//    [UIView setAnimationBeginsFromCurrentState: YES];
//    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y - 190, self.frame.size.width, self.frame.size.height);
//    [UIView commitAnimations];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self endEditing:YES];
    
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
//    [UIView beginAnimations:@"Animation" context:nil];
//    [UIView setAnimationDuration:0.20];
//    [UIView setAnimationBeginsFromCurrentState: YES];
//    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y + 130, self.frame.size.width, self.frame.size.height);
//    [UIView commitAnimations];
//    
    return YES;
    
    
}


-(void)dealloc //移除通知
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}








/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
