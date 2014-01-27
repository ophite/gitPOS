//
//  POSOrder.h
//  POS
//
//  Created by Pavel Slusar on 6/1/13.
//  Copyright (c) 2013 IT Vik. All rights reserved.
//
#import <Foundation/Foundation.h>


@interface POSOrder : NSObject


@property  NSString *client;
@property  NSString *name;
@property  NSString *codeItem;
@property  NSString *category;
@property  NSString *price;
@property  NSString *quantity;
@property  UIImage *image;
@property  int itemID;


@end
