//
//  POSAttributesViewController.h
//  POSStoryboard
//
//  Created by kobernik.u on 12/24/13.
//  Copyright (c) 2013 kobernik.u. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "POSDataSet.h"
#import "POSObjectsHelper.h"
#import "POSAttributeCell.h"
#import "POSAttributeEditViewController.h"
#import "POSHelper.h"
#import "POSAttribute.h"
#import "POSSettingsGUIHelper.h"

@interface POSAttributesViewController : UIViewController <UIAlertViewDelegate, UITableViewDelegate, UITableViewDataSource> {

@private
    id __currentCell;
    
}


@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *buttonAddNewAttribute;



@end
