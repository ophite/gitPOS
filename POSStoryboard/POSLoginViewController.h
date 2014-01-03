//
//  POSLoginViewController.h
//  POSStoryboard
//
//  Created by kobernik.u on 12/6/13.
//  Copyright (c) 2013 kobernik.u. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "POSTest.h"
#import "POSObjectsHelper.h"


@interface POSLoginViewController : UIViewController<UITextFieldDelegate> {
    
@private
    BOOL __remeberChecked;
    
}


@property (weak, nonatomic) IBOutlet UIButton *buttonRememberMe;
@property (weak, nonatomic) IBOutlet UITextField *textEmail;
@property (weak, nonatomic) IBOutlet UITextField *textPassword;


- (BOOL)isUserHasCorrectPassword;
- (IBAction)onRememberMe:(id)sender;


@end
