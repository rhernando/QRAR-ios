//
//  ELARScanView.m
//  AeZxing
//
//  Created by Rubén Hernando Martín on 25/02/13.
//  Copyright (c) 2013 Rub√©n Hernando Mart√≠n. All rights reserved.
//

#import "ELARScanView.h"

@implementation ELARScanView

- (id)initWithFrame:(CGRect)frame
{
    
    cancelButtonTitle = @"Cancelar";
    
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    displayedMessage = @"";
    
    [super drawRect:rect];

}


- (void)colocarImagen:(CGPoint)point1 pont2:(CGPoint)point2 url:(NSString*)url
{
   // [map ];
    
    CGPoint punto =[self map:point1];
    CGPoint punto2 =[self map:point2];
    CGRect rect = CGRectMake(punto.x,punto.y, fabs(punto.x - punto2.x), fabs(punto.y - punto2.y));
    NSLog(@"decode tamano..... %f",  fabs(point1.x - point2.x));
    //fabs(p1.y - p2.y));
    //CGRect rect = CGRectMake(0, 0, 240, 200);
    
    UIImageView *qrOverlayImageView  = [[UIImageView alloc] initWithFrame:(rect)];
    
    
    NSData* theData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    if (theData == nil){
        return;
    }
    UIImage *img = [[UIImage alloc] initWithData:theData];

    
    //qrOverlayImageView.image = [UIImage imageNamed:@"IMG_0242_sec_00213.png"];
    qrOverlayImageView.image = img;
    
    qrOverlayImageView.contentMode = UIViewContentModeScaleAspectFit;
   // qrOverlayImageView.backgroundColor = [UIColor redColor];
    
    [self addSubview:qrOverlayImageView];
    
    NSLog(@"decode croprect..... %@", NSStringFromCGRect(cropRect));

}

- (void)popupAlert:(NSString *)titulo texto:(NSString *)texto{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:titulo message:texto delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:nil, nil];
    [alert show];
    
}

- (CGPoint)map:(CGPoint)point {
    CGPoint center;
    center.x = cropRect.size.width/2;
    center.y = cropRect.size.height/2;
    float x = point.x - center.x;
    float y = point.y - center.y;
    int rotation = 90;
    switch(rotation) {
        case 0:
            point.x = x;
            point.y = y;
            break;
        case 90:
            point.x = -y;
            point.y = x;
            break;
        case 180:
            point.x = -x;
            point.y = -y;
            break;
        case 270:
            point.x = y;
            point.y = -x;
            break;
    }
    point.x = point.x + center.x;
    point.y = point.y + center.y;
    return point;
}


@end
