//
//  ELARAppDelegate.m
//  AeZxing
//
//  Created by Rubén Hernando Martín on 20/02/13.
//  Copyright (c) 2013 Rubén Hernando Martín. All rights reserved.
//

#import "ELARAppDelegate.h"

#import "ELARViewController.h"

@implementation ELARAppDelegate

@synthesize appAsignaturas;
@synthesize appTitulos;
@synthesize codesAsignaturas;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    
    NSString *ipAddress = @"150.244.58.243";
    NSString *urlString = [NSString stringWithFormat:@"http://%@:3000/asignaturas/array_asignatura.json", ipAddress];
    NSURL *url = [NSURL URLWithString:urlString];
    NSLog(@"Requesting to : %@", urlString);
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
    if(connection) {
        responseData = [[NSMutableData alloc] init];
    } else {
        NSLog(@"connection failed");
    }

    
    appAsignaturas = [[NSMutableArray alloc] init];
    appTitulos = [[NSMutableArray alloc] init];
    codesAsignaturas = [[NSMutableDictionary alloc] init];


    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self.viewController = [[ELARViewController alloc] initWithNibName:@"ELARViewController_iPhone" bundle:nil];
    } else {
        self.viewController = [[ELARViewController alloc] initWithNibName:@"ELARViewController_iPhone" bundle:nil];
    }
 
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
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
    NSLog(@"data: %@", responseData);
    if(jsonArray != nil)
    {
        int tit = 0;
        for(NSDictionary *item in jsonArray) {
            NSLog(@"Item: %@", [item objectForKey:@"titulo"]);
            NSString *nombre = [item objectForKey:@"titulo"];
            
            NSArray *arrCur = [item objectForKey:@"cursos"];
            for(NSDictionary *cur in arrCur) {
                NSMutableString *stname = [NSMutableString string];
                [stname appendFormat:@"%@º %@", [cur objectForKey:@"curso"], nombre];
                [appTitulos addObject: stname];

                NSArray *asignCur = [cur objectForKey:@"asignaturas"];
                NSMutableArray *arrAs = [[NSMutableArray alloc] init];

                int numas = 0;
                for(NSDictionary *as in asignCur) {
                    [arrAs addObject: [as objectForKey:@"nombre"]];
                    [codesAsignaturas setObject:[as objectForKey:@"id"] forKey:[NSString stringWithFormat:@"%d-%d", tit, numas]];
                     numas++;
                }
                NSDictionary *diction = [NSDictionary dictionaryWithObject:arrAs forKey:@"Asignaturas"];
                [appAsignaturas addObject: diction];
                tit++;
            }
            tit++;
        }
        NSLog(@"ids %@", codesAsignaturas);
    }else{
        NSLog(@"Error parsing JSON: %@", error);
    }
    
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
