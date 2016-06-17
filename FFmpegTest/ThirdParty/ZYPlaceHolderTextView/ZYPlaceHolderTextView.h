//
//  ZYPlaceHolderTextView.h
//  
//
//  Created by zhaoyuan on 16/6/16.
//  Copyright © 2016年 times. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface ZYPlaceHolderTextView : UITextView

@property (nonatomic, retain) IBInspectable NSString *placeholder;
@property (nonatomic, retain) IBInspectable UIColor *placeholderColor;
//@property (nonatomic, assign) IBInspectable int maxLength;


-(void)textChanged:(NSNotification*)notification;




@end
