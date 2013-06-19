//
//  ELARScanController.h
//  AeZxing
//
//  Created by Rubén Hernando Martín on 22/02/13.
//  Copyright (c) 2013 Rub√©n Hernando Mart√≠n. All rights reserved.
//

//#import <Cocoa/Cocoa.h>
#import <UIKit/UIKit.h>
#import "ZXingWidgetController.h"
#import "TwoDDecoderResult.h"
#import "ELARScanView.h"

@interface ELARScanController : ZXingWidgetController{
    NSMutableData *responseData;
    ELARScanView *overlay;

}


@end

