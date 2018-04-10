//
//  TTTextField.m
//  TataProject
//
//  Created by Lala on 15/10/23.
//  Copyright © 2015年 Lala. All rights reserved.
//

#import "TTTextField.h"

@implementation TTTextField

-(CGRect)placeholderRectForBounds:(CGRect)bounds
{
    if (self.textLeftInset) {
        if (self.clearButtonMode == UITextFieldViewModeNever) {
            return CGRectMake(self.textLeftInset, bounds.origin.y, bounds.size.width-self.textLeftInset, bounds.size.height);
        }
        else {
            return CGRectMake(self.textLeftInset, bounds.origin.y, bounds.size.width-self.textLeftInset-20, bounds.size.height);
        }
    }
    else {
        return [super placeholderRectForBounds:bounds];
    }
}

- (CGRect)textRectForBounds:(CGRect)bounds
{
    if (self.textLeftInset) {
        if (self.clearButtonMode == UITextFieldViewModeNever) {
            return CGRectMake(self.textLeftInset, bounds.origin.y, bounds.size.width-self.textLeftInset, bounds.size.height);
        }
        else {
            return CGRectMake(self.textLeftInset, bounds.origin.y, bounds.size.width-self.textLeftInset-20, bounds.size.height);
        }
    }
    else {
        return [super textRectForBounds:bounds];
    }
}

-(CGRect)editingRectForBounds:(CGRect)bounds
{
    if (self.textLeftInset) {
        if (self.clearButtonMode == UITextFieldViewModeNever) {
            return CGRectMake(self.textLeftInset, bounds.origin.y, bounds.size.width-self.textLeftInset, bounds.size.height);
        }
        else {
            return CGRectMake(self.textLeftInset, bounds.origin.y, bounds.size.width-self.textLeftInset-20, bounds.size.height);
        }
    }
    else {
        return [super editingRectForBounds:bounds];
    }
}

@end

