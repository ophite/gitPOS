//
//  POSBasketsViewController.m
//  POSStoryboard
//
//  Created by kobernik.u on 1/27/14.
//  Copyright (c) 2014 kobernik.u. All rights reserved.
//

#import "POSBasketsViewController.h"

@interface POSBasketsViewController ()

@end

@implementation POSBasketsViewController


@synthesize tableBasket = _tableBasket;

const int CELL_FIRST_MODE = 0;
const int CELL_SECOND_HEADER = 1;
const int CELL_THIRD_DETAIL = 2;

NSMutableArray *_objectArray;
NSString *_filterName;

#pragma mark - ViewController

- (id)initWithStyle:(UITableViewStyle)style {
    
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
//    
//    return (interfaceOrientation == UIInterfaceOrientationPortrait);
//}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    int rowsCount = 0;
    
    switch (section) {
        case CELL_FIRST_MODE:{
            
            rowsCount = 1;
            break;
        }
        case CELL_SECOND_HEADER: {
            
            rowsCount = 1;
            break;
        }
        case CELL_THIRD_DETAIL: {
            
            rowsCount = _objectArray.count;
            break;
        }
        default:
            break;
    }
    
    return rowsCount;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell;
    
    switch (indexPath.section) {
            
        case CELL_FIRST_MODE: {
            
            static NSString *CellIdentifier = @"BasketsCell_First_Mode";
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
            break;
        }
        case CELL_SECOND_HEADER: {
            
            static NSString *CellIdentifier = @"BasketsCell_Second_Header";
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
            break;
        }
        case CELL_THIRD_DETAIL: {
            
            static NSString *CellIdentifier = @"POSOrderEditCell";
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
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
            
            break;
        }
        default:
            break;
    }
    
    // Configure the cell...
    
    return cell;
}

- (void)textViewDidChange:(UITextView *)textView{
    
    [self.tableBasket beginUpdates];
    //    height = textView.contentSize.height;
    [self.tableBasket endUpdates];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat cellHeight = [super tableView:self.tableBasket heightForRowAtIndexPath:indexPath];
    
    switch (indexPath.section) {
            
        case CELL_FIRST_MODE: {
        
            cellHeight = 45;
            break;
        }
        case CELL_SECOND_HEADER: {
            
            cellHeight = 25;
            break;
        }
        case CELL_THIRD_DETAIL: {
            
            NSString *title = (NSString *)[_objectArray objectAtIndex:indexPath.row];
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"client = %@", title];
            NSArray *array = [objectsHelperInstance.dataSet.baskets filteredArrayUsingPredicate:predicate];
            cellHeight = 111 - cellHeight + cellHeight * (array.count > 0 ? array.count : 1);
            break;
        }
        default:
            break;
    }
    
    return cellHeight;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    objectsHelperInstance.currentBasketID = [[objectsHelperInstance.dataSet.baskets objectAtIndex:[indexPath row]] ID];
    [self readBasketData: objectsHelperInstance.currentBasketID];
    [self.navigationController popViewControllerAnimated:YES];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

#pragma mark - Methods

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
