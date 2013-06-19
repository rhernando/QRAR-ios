//
//  ELARScanView.h
//  AeZxing
//
//  Created by Rubén Hernando Martín on 25/02/13.
//  Copyright (c) 2013 Rub√©n Hernando Mart√≠n. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OverlayView.h"
#import <MediaPlayer/MediaPlayer.h>

@interface ELARScanView : OverlayView{
    NSMutableData *fileData;
    NSNumber *totalFileSize;
    NSString *filename;
    
    MPMoviePlayerController *player;
    UIActivityIndicatorView *activityView;

}

@property (nonatomic, retain) MPMoviePlayerController *player;

- (void)colocarImagen:(CGPoint)point1 pont2:(CGPoint)point2 pont3:(CGPoint)point3 url:(NSString*)url;
- (void)colocarVideo:(CGPoint)point1 pont2:(CGPoint)point2 pont3:(CGPoint)point3 url:(NSString*)url filename:(NSString*)name;
- (void)popupAlert:(NSString*)titulo texto:(NSString*)texto delegate: (id) delegating;

@end
