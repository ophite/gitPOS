//
//  POSItemsViewController.h
//  POSStoryboard
//
//  Created by kobernik.u on 12/13/13.
//  Copyright (c) 2013 kobernik.u. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "AQGridView.h"

#import "POSGridViewCell.h"
#import "POSCategory.h"
#import "POSItem.h"
#import "POSObjectsHelper.h"
#import "POSItemViewController.h"
#import "POSItemEditViewController.h"
#import "POSHelper.h"

@interface POSItemsViewController : UIViewController <AQGridViewDelegate, AQGridViewDataSource>


@property NSString *catName;
@property (nonatomic, strong)POSCategory *cat;
@property (nonatomic, strong)POSItem *item;

@property (weak, nonatomic) IBOutlet UIButton *btnChangeMode;
@property (weak, nonatomic) IBOutlet UIButton *btnAdd;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet AQGridView *gridView;


- (IBAction)onChangeMode:(id)sender;


@end
