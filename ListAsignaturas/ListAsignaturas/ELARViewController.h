//
//  ELARViewController.h
//  ListAsignaturas
//
//  Created by Rubén Hernando Martín on 13/04/13.
//  Copyright (c) 2013 Rubén Hernando Martín. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ELARViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    NSArray *tableData;

    NSDictionary *tableContents;
    NSArray *sortedKeys;

}

@property (nonatomic, retain)  NSArray *tableData;
@property (nonatomic, retain)  NSDictionary *tableContents;
@property (nonatomic, retain)  NSArray *sortedKeys;


@end
