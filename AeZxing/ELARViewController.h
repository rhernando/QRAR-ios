//
//  ELARViewController.h
//  AeZxing
//
//  Created by Rubén Hernando Martín on 20/02/13.
//  Copyright (c) 2013 Rubén Hernando Martín. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXingWidgetController.h"
#import "QRCodeReader.h"
#import "AztecReader.h"
#import "ELARScanController.h"
#import "ELARScanView.h"
#import "ELARConfiController.h"


@interface ELARViewController : UIViewController <ZXingDelegate>
{
    
    
}

- (IBAction) configButtonTapped;
- (IBAction) showButtonTapped;

@end
