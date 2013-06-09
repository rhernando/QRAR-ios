//
//  ELARScanView.h
//  AeZxing
//
//  Created by Rubén Hernando Martín on 25/02/13.
//  Copyright (c) 2013 Rub√©n Hernando Mart√≠n. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OverlayView.h"

@interface ELARScanView : OverlayView


- (void)colocarImagen:(CGPoint)point1 pont2:(CGPoint)point2 url:(NSString*)url;
- (void)popupAlert:(NSString*)titulo texto:(NSString*)texto;

@end
