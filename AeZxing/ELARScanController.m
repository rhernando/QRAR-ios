//
//  ELARScanController.m
//  AeZxing
//
//  Created by Rubén Hernando Martín on 22/02/13.
//  Copyright (c) 2013 Rub√©n Hernando Mart√≠n. All rights reserved.
//

#import "ELARScanController.h"

@interface ELARScanController ()

@end

@implementation ELARScanController


- (id)initWithDelegate:(id<ZXingDelegate>)scanDelegate showCancel:(BOOL)shouldShowCancel OneDMode:(BOOL)shouldUseoOneDMode {
    NSLog(@"init");
    return [self initWithDelegate:scanDelegate showCancel:shouldShowCancel OneDMode:shouldUseoOneDMode showLicense:NO];

}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)decoder:(Decoder *)decoder didDecodeImage:(UIImage *)image usingSubset:(UIImage *)subset withResult:(TwoDDecoderResult *)twoDResult {
    NSString *ipAddress = @"192.168.0.193";
    
    NSLog(@"decode image!!!! %@", twoDResult.text);
    NSLog(@"The content of arry is%@",[twoDResult points]);
    
    NSArray* params = [twoDResult.text componentsSeparatedByString: @"|"];
    // return if it is not an app code
    if (![[params objectAtIndex:0] isEqualToString: @"ARQEL"])
        return;
    NSString *qrid = [params objectAtIndex:1];
    NSString *qrtype = [params objectAtIndex:2];
    
    overlay =  (ELARScanView*)self.overlayView;

    for (UIView *subview in [overlay subviews]) {
        if (subview.tag == 77) {
            [subview removeFromSuperview];
        }
    }
    
    NSLog(@"Decoding type %@", qrtype);
    if ([qrtype isEqualToString: @"informacion"]){
        // retrieve array to send to server
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSMutableArray *finalConfig = [prefs objectForKey:@"idsconfig"];
        if (finalConfig == nil){
            finalConfig = [[NSMutableArray alloc] init];
        }
        NSString *urlString = [NSString stringWithFormat:@"http://%@:3000/infocodigo/%@/asign/%@.json", ipAddress, qrid, [finalConfig componentsJoinedByString:@","]];
        NSLog(@"Requesting to : %@", urlString);

        NSURL *url = [NSURL URLWithString:urlString];
        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
        NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
        if(connection) {
            responseData = [[NSMutableData alloc] init];
        } else {
            NSLog(@"connection failed");
        }
        
    }else if ([qrtype isEqualToString: @"video"]){
        NSString *url = [NSString stringWithFormat:@"http://%@:3000/imageuploaded/%@", ipAddress, qrid];

        CGPoint p1 = [[[twoDResult points] objectAtIndex:0] CGPointValue];
        CGPoint p2 = [[[twoDResult points] objectAtIndex:1] CGPointValue];
        CGPoint p3 = [[[twoDResult points] objectAtIndex:2] CGPointValue];

        [overlay colocarVideo:p1 pont2:p3 pont3:p2 url:url filename:[params objectAtIndex:4]];

        
    }else{
        
        NSString *url = [NSString stringWithFormat:@"http://%@:3000/imageuploaded/%@", ipAddress, qrid];

        CGPoint p1 = [[[twoDResult points] objectAtIndex:0] CGPointValue];
        CGPoint p2 = [[[twoDResult points] objectAtIndex:1] CGPointValue];
        CGPoint p3 = [[[twoDResult points] objectAtIndex:2] CGPointValue];
        
        
        [overlay colocarImagen: p1 pont2:p3 pont3:p2 url:url];
    
        //  NSLog(@"decode image!!!! %@", NSStringFromCGPoint(p1));
        decoding = YES;
    }
    [overlayView setPoints:nil];
    decoder.delegate = nil;


}


- (void) moviePlayBackDidFinish:(NSNotification*)notification {
    NSError *error = [[notification userInfo] objectForKey:@"error"];
    if (error) {
        NSLog(@"Did finish with error: %@", error);
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
     [responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [responseData appendData:data];
    NSError *error;
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData: responseData options: NSJSONReadingMutableContainers error: &error];

    if(jsonArray != nil)
    {
        for(NSDictionary *item in jsonArray) {
            NSLog(@"Item: %@", [item objectForKey:@"asignatura"]);
            [overlay popupAlert:[item objectForKey:@"asignatura"] texto:[item objectForKey:@"texto"] delegate:self];
        }
    }else{
        NSLog(@"Error parsing JSON: %@", error);
    }

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"ACCEPTED");
    decoding = YES;

}

- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    
    NSLog(@"connection error");
}

- (void) connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"connection success");
}

@end
