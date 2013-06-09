//
//  ELARAppDelegate.h
//  AeZxing
//
//  Created by Rubén Hernando Martín on 20/02/13.
//  Copyright (c) 2013 Rubén Hernando Martín. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ELARViewController;

@interface ELARAppDelegate : UIResponder <UIApplicationDelegate>
{
    NSMutableArray *appAsignaturas; //table view data

}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ELARViewController *viewController;

@property (nonatomic, retain) NSArray *appAsignaturas;

@end
