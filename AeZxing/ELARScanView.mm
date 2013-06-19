//
//  ELARScanView.m
//  AeZxing
//
//  Created by Rubén Hernando Martín on 25/02/13.
//  Copyright (c) 2013 Rub√©n Hernando Mart√≠n. All rights reserved.
//

#import "ELARScanView.h"

@implementation ELARScanView


@synthesize player;


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


- (void)colocarImagen:(CGPoint)point1 pont2:(CGPoint)point2 pont3:(CGPoint)point3 url:(NSString*)url
{
    
    CGPoint punto =[self map:point1];
    CGPoint punto2 =[self map:point2];
    CGPoint punto3 =[self map:point3];
    
    NSLog(@"punto 1 %@, punto 2 %@, punto 3 %@", NSStringFromCGPoint(punto), NSStringFromCGPoint(punto2), NSStringFromCGPoint(punto3));
    
    CGRect rect = CGRectMake(punto.x,punto.y, fabs(punto.x - punto2.x), fabs(punto.y - punto3.y));
    NSLog(@"decode tamano..... %f",  fabs(point1.x - point2.x));
    //fabs(p1.y - p2.y));
    //CGRect rect = CGRectMake(0, 0, 240, 200);
    
    UIImageView *qrOverlayImageView  = [[UIImageView alloc] initWithFrame:(rect)];
    //qrOverlayImageView.backgroundColor = [UIColor redColor];
    
    NSData* theData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    if (theData == nil){
        return;
    }
    UIImage *img = [[UIImage alloc] initWithData:theData];

    
    //qrOverlayImageView.image = [UIImage imageNamed:@"IMG_0242_sec_00213.png"];
    qrOverlayImageView.image = img;
    qrOverlayImageView.tag = 77;
    
    
    qrOverlayImageView.contentMode = UIViewContentModeScaleAspectFit;
   // qrOverlayImageView.backgroundColor = [UIColor redColor];
    
    [self addSubview:qrOverlayImageView];
    
    NSLog(@"decode croprect..... %@", NSStringFromCGRect(cropRect));

}

- (void)colocarVideo:(CGPoint)point1 pont2:(CGPoint)point2 pont3:(CGPoint)point3 url:(NSString*)url filename:(NSString*)name
{
    NSLog(@"streaming video from %@", url);
    
    NSURL *fileURL = [NSURL URLWithString:url];
    
    NSURLRequest *req = [NSURLRequest requestWithURL:fileURL];
    NSURLConnection *connection = [NSURLConnection connectionWithRequest:req delegate:self];
    if(connection) {
        fileData = [[NSMutableData alloc] init];
        filename = name;
    } else {
        NSLog(@"connection failed");
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"%@", response);
    activityView=[[UIActivityIndicatorView alloc]     initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
   
    activityView.center=self.center;
    
    [activityView startAnimating];
    
    [self addSubview:activityView];
    
    [fileData setLength:0];
    totalFileSize = [NSNumber numberWithLongLong:[response expectedContentLength]];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{

    [fileData appendData:data];
    //NSLog(@"%@", fileData);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{

    NSArray *dirArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,    NSUserDomainMask, YES);
    NSLog(@"%@", [dirArray objectAtIndex:0]);
    
    NSString *path = [NSString stringWithFormat:@"%@/%@", [dirArray objectAtIndex:0], filename];
    NSLog(@"ff %@", path);
    NSError * error = nil;
   // NSLog(@"data %@", fileData);

    [activityView stopAnimating];

    if (![fileData writeToFile:path options:NSAtomicWrite error:&error]) {
        NSLog(@"writeToFile failed: %@", error);
    }
    else {
        NSLog(@"Written!");
        NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@",[dirArray objectAtIndex:0], filename]];
        
         player =
         [[MPMoviePlayerController alloc] initWithContentURL: url];
        player.controlStyle=MPMovieControlStyleFullscreen;

         
         [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayBackStop:) name:MPMoviePlayerLoadStateDidChangeNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(moviePlayBackDidFinish:)
                                                     name:MPMoviePlayerPlaybackDidFinishNotification
                                                   object:player];
          [player prepareToPlay];
          [player.view setFrame: self.bounds];  // player's frame must match parent's
          [self addSubview: player.view];
        // ...
          [player play];
    }
    
    
}


- (void) moviePlayBackStop:(NSNotification*)notification {
    NSError *error = [[notification userInfo] objectForKey:@"error"];
    if (error) {
        NSLog(@"Did finish with error: %@", error);
    }
}

- (void) moviePlayBackDidFinish:(NSNotification*)notification {
    NSError *error = [[notification userInfo] objectForKey:@"error"];
    if (error) {
        NSLog(@"Did finish with error: %@", error);
    }
    [player.view removeFromSuperview];
}


- (void)popupAlert:(NSString *)titulo texto:(NSString *)texto delegate: (id) delegating{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:titulo message:texto delegate:delegating cancelButtonTitle:@"Aceptar" otherButtonTitles:nil, nil];
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
