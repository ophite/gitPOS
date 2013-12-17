//
//  POSBasketOpenViewController.h
//  POSStoryboard
//
//  Created by kobernik.u on 12/17/13.
//  Copyright (c) 2013 kobernik.u. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "POSObjectsHelper.h"

@interface POSBasketOpenViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>


@property NSMutableArray*                           basketArray;
@property (weak, nonatomic) IBOutlet UIButton       *btnSave;
@property (weak, nonatomic) IBOutlet UIButton       *btnCancel;
@property (weak, nonatomic) IBOutlet UITableView    *tableBasket;

-(void)readBasketsList;
-(void) readBasketData: (int) doc_ID;

- (IBAction)onSave:(id)sender;
- (IBAction)onCancel:(id)sender;


@end