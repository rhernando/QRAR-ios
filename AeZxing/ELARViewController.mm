//
//  ELARViewController.m
//  AeZxing
//
//  Created by Rubén Hernando Martín on 20/02/13.
//  Copyright (c) 2013 Rubén Hernando Martín. All rights reserved.
//

#import "ELARViewController.h"

@interface ELARViewController ()

@end

@implementation ELARViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction) showButtonTapped
{
    NSLog(@"boton");
    ELARScanController *widController = [[ELARScanController alloc]  initWithDelegate:self showCancel:YES OneDMode:NO];
    ELARScanView *vista = [[ELARScanView alloc] initWithFrame:[UIScreen mainScreen].bounds
                         cancelEnabled:widController.overlayView.cancelEnabled
                              oneDMode:widController.overlayView.oneDMode
                           showLicense:NO];
    [vista setDelegate:widController];
    
    [widController setOverlayView:vista];
    
    NSMutableSet *readers = [[NSMutableSet alloc ] init];
    
    
    QRCodeReader* qrcodeReader = [[QRCodeReader alloc] init];
    [readers addObject:qrcodeReader];
    
   
    widController.readers = readers;
    
    
    [self presentViewController:widController animated:YES completion:nil];

}

-(void)zxingController:(ZXingWidgetController *)controller didScanResult:(NSString *)result{
    NSLog(@"did scan!!! %@", result);
   // [self dismissViewControllerAnimated:NO completion:nil];
    
    
}


- (IBAction)configButtonTapped  {
    ELARConfiController *listconfig = [[ELARConfiController alloc] initWithNibName:@"config_list" bundle:nil];
    
    
    [self presentViewController:listconfig animated:YES completion:nil];

}


- (void)zxingControllerDidCancel:(ZXingWidgetController*)controller {
    NSLog(@"Exit");
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
