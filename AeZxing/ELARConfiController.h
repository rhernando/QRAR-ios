//
//  ELARConfiController.h
//  AeZxing
//
//  Created by Rubén Hernando Martín on 25/05/13.
//  Copyright (c) 2013 Rub√©n Hernando Mart√≠n. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ELARAppDelegate.h"


@interface ELARConfiController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
    NSMutableArray *finalConfig;
    NSMutableArray *idsConfig;

}

@property (nonatomic, retain) NSArray *asignaturas;
@property (nonatomic, retain) NSArray *cursos;
@property (nonatomic, retain) NSMutableDictionary *idsAsignaturas;
@property (nonatomic, retain) NSArray *finalConfig;
@property (nonatomic, retain) NSArray *idsConfig;

@property (nonatomic, retain) IBOutlet UITableView *myTableView;


- (IBAction) acceptButtonTapped;
- (IBAction) cancelButtonTapped;


@end
