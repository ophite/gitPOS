//
//  POSBasketOpenViewController.m
//  POSStoryboard
//
//  Created by kobernik.u on 12/17/13.
//  Copyright (c) 2013 kobernik.u. All rights reserved.
//
#import "POSBasketOpenViewController.h"


@interface POSBasketOpenViewController ()

@end


@implementation POSBasketOpenViewController


@synthesize tableBasket = _tableBasket;


#pragma mark - ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName: nibNameOrNil bundle: nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


NSMutableArray *_objectArray;
NSString *_filterName;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // init data
    [objectsHelperInstance.dataSet basketsGet];
    _objectArray = [[NSMutableArray alloc] init];
    
//    [self.tableBasket setSeparatorInset:UIEdgeInsetsMake(10, 0, 10, 0)];

    if (1 == 1) {
        
        _filterName = @"client";
        for (POSBasket *basket in objectsHelperInstance.dataSet.baskets) {
            
            if ([_objectArray indexOfObject:basket.client] == NSNotFound) {
                
                [_objectArray addObject:basket.client];
            }
        }
    }
    else {
        
        _filterName = @"tst";
        for (POSBasket *basket in objectsHelperInstance.dataSet.baskets) {
            
            if ([_objectArray indexOfObject:basket.tst] == NSNotFound) {
                
                [_objectArray addObject:basket.tst];
            }
        }
    }
    
    // gui
    self.tableBasket.dataSource = self;
    self.tableBasket.delegate = self;

	// Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _objectArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"POSOrderEditCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSString *title = (NSString *)[_objectArray objectAtIndex:indexPath.row];
    
//    NSString *strf = [NSString stringWithFormat:@"%@ = %@", _filterName, title];
//    NSLog(strf);
//    NSString *strf2 = [NSString stringWithFormat:@"client = %@", title];
//    NSLog(strf2);
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%@ = %@" argumentArray: @[_filterName, title]];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"client = %@", title];
    NSArray *array = [objectsHelperInstance.dataSet.baskets filteredArrayUsingPredicate:predicate];
    NSMutableArray *mutableArray = [[NSMutableArray alloc] initWithArray:array];
    
    POSOrderEditCell *orderEditCell = (POSOrderEditCell *)cell;
    orderEditCell.labelTitle.text = title;
    orderEditCell.objectsArray = mutableArray;
    
    return orderEditCell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    NSString *title = (NSString *)[_objectArray objectAtIndex:indexPath.row];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"client = %@", title];
    NSArray *array = [objectsHelperInstance.dataSet.baskets filteredArrayUsingPredicate:predicate];
    CGFloat rowHeight = self.tableBasket.rowHeight * (array.count > 0 ? array.count : 1);
    
    return rowHeight;
}


- (void)textViewDidChange:(UITextView *)textView{
    
    [self.tableBasket beginUpdates];
    //    height = textView.contentSize.height;
    [self.tableBasket endUpdates];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    objectsHelperInstance.currentBasketID = [[objectsHelperInstance.dataSet.baskets objectAtIndex:[indexPath row]] ID];
    [self readBasketData: objectsHelperInstance.currentBasketID];
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)readBasketData:(int)doc_ID {
    
    if (![dbWrapperInstance openDB])
        return;
    
    [objectsHelperInstance.dataSet.orders removeAllObjects];
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    NSString * query = [NSString stringWithFormat:@"SELECT  item_id, quantity \
                                                    FROM    document_line \
                                                    WHERE   document_id = %d; ", doc_ID];
    
    void (^blockGetOrder)(id rows) = ^(id rows) {
        
        POSOrder* order = [[POSOrder alloc] init];
        order.itemID = [dbWrapperInstance getCellInt:0];
        order.quantity = [[NSString alloc] initWithFormat:@"%d", [dbWrapperInstance getCellInt:1]];
        [((NSMutableArray *)rows) addObject:order];
    };
    
    [dbWrapperInstance fetchRows: query
              andForeachCallback: blockGetOrder
                         andRows: objectsHelperInstance.dataSet.orders];
    
    
    for(int i = 0; i<[objectsHelperInstance.dataSet.orders count]; i++) {
        
        POSOrder *order = [objectsHelperInstance.dataSet.orders objectAtIndex:i];
        query = [NSString stringWithFormat:@"SELECT p.name, c.name, p.price_buy, i.asset \
                                             FROM   product p, collection c, image i \
                                             WHERE  p.id = %d AND c.id = p.collection_id AND i.object_id = p.id", order.itemID];
        
        
        void (^blockExtractOrderValues)() = ^() {
            
            order.name = [dbWrapperInstance getCellText:0];
            order.category  = [dbWrapperInstance getCellText:1];
            order.price     = [dbWrapperInstance getCellText:2];
            order.codeItem  = @"001";
            
            const unsigned char* asset = [dbWrapperInstance getCellChar:3];
            if (asset != nil) {
                
                NSURL* assetUrl = [[NSURL alloc] initWithString:[[NSString alloc] initWithUTF8String:(const char *) asset]];
                
                [library assetForURL: assetUrl
                         resultBlock: ^(ALAsset *asset) {
                    
                             order.image = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullResolutionImage]];
                         }
                        failureBlock: ^(NSError* error) {
                            
                            NSLog(@"%@", error.description);
                        }
                 ];
            }
        };
        
        [dbWrapperInstance extractMultipleValues: query
                              andForeachCallback: blockExtractOrderValues];
    }
    
    [dbWrapperInstance closeDB];
}


#pragma mark - Actions
// 
//- (IBAction)onSave:(id)sender {
//    
//    NSIndexPath *indexPath = [self.tableBasket indexPathForSelectedRow];
//    objectsHelperInstance.currentBasketID = [[objectsHelperInstance.dataSet.baskets objectAtIndex:[indexPath row]] ID];
//    [self readBasketData: objectsHelperInstance.currentBasketID ];
//    [self.navigationController popViewControllerAnimated:YES];
//}
//
//
//- (IBAction)onCancel:(id)sender {
//    
//    [self.navigationController popViewControllerAnimated:YES];
//}


@end
