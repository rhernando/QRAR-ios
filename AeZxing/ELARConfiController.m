//
//  ELARConfiController.m
//  AeZxing
//
//  Created by Rubén Hernando Martín on 25/05/13.
//  Copyright (c) 2013 Rub√©n Hernando Mart√≠n. All rights reserved.
//

#import "ELARConfiController.h"

@interface ELARConfiController ()

@end

@implementation ELARConfiController

@synthesize asignaturas;
@synthesize cursos;
@synthesize idsAsignaturas;
@synthesize finalConfig;
@synthesize idsConfig;
@synthesize myTableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self.navigationController setToolbarHidden:NO];
        
        ELARAppDelegate *appDelegate = (ELARAppDelegate *)[[UIApplication sharedApplication] delegate];
        asignaturas = appDelegate.appAsignaturas;
        cursos = appDelegate.appTitulos;
        idsAsignaturas = appDelegate.codesAsignaturas;
        
    }
    [self.myTableView reloadData];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    finalConfig = [prefs objectForKey:@"asignaturasconfig"];
    if (finalConfig == nil){
        finalConfig = [[NSMutableArray alloc] init];
    }else{
        NSLog(@"The content of arry is%@",finalConfig);
        for (NSString *path in finalConfig) {
            NSArray* ind = [path componentsSeparatedByString: @"-"];
            [myTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:[[ind objectAtIndex:1] integerValue] inSection:[[ind objectAtIndex:0] integerValue]] animated:YES scrollPosition:0];

        }
    }
    idsConfig = [prefs objectForKey:@"idsconfig"];
    if (idsConfig == nil){
        idsConfig = [[NSMutableArray alloc] init];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [asignaturas count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *dictionary = [asignaturas objectAtIndex:section];
    NSArray *array = [dictionary objectForKey:@"Asignaturas"];
    return [array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.font = [UIFont systemFontOfSize:12.0];
    
    // Configure the cell.
    NSDictionary *dictionary = [asignaturas objectAtIndex:indexPath.section];
    NSArray *array = [dictionary objectForKey:@"Asignaturas"];
    NSString *cellValue = [array objectAtIndex:indexPath.row];
    cell.textLabel.text = cellValue;
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.textLabel.numberOfLines = 0;

    return cell;
}

//RootViewController.m
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [cursos objectAtIndex:section];
    switch (section) {
        case 0:
            return @"Primero Ing. Informática";
            break;
        case 1:
            return @"Segundo Ing. Informática";
            break;
        case 2:
            return @"Tercero Ing. Informática";
            break;
        case 3:
            return @"Cuarto Ing. Informática";
            break;
        case 4:
            return @"Master I2TIC";
            break;
            
        default:
            break;
    }
    return nil;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [finalConfig removeAllObjects];
    [idsConfig removeAllObjects];
    NSArray *indexes = [tableView indexPathsForSelectedRows];
    for (NSIndexPath *path in indexes) {
        NSLog(@"TOTAL sect %d, ind %d", path.section, path.row);
        [finalConfig addObject:[NSString stringWithFormat:@"%d-%d", path.section, path.row]];
        [idsConfig addObject:[idsAsignaturas objectForKey: [NSString stringWithFormat:@"%d-%d", path.section, path.row]]];
        
    }
    NSLog(@"The content of arry is%@",finalConfig);

}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [finalConfig removeAllObjects];
    NSArray *indexes = [tableView indexPathsForSelectedRows];
    for (NSIndexPath *path in indexes) {
        NSLog(@"%d-%d", path.section, path.row);
        NSLog(@"kv %@", [idsAsignaturas objectForKey: [NSString stringWithFormat:@"%d-%d", path.section, path.row]]);
        [finalConfig addObject:[NSString stringWithFormat:@"%d-%d", path.section, path.row]];
        [idsConfig addObject:[idsAsignaturas objectForKey: [NSString stringWithFormat:@"%d-%d", path.section, path.row]]];

    }
    NSLog(@"The content of arry is%@",finalConfig);

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0,tableView.frame.size.width,30)];
    headerView.backgroundColor = [UIColor redColor ];
    UILabel *headerLabel = [[UILabel alloc] initWithFrame:headerView.frame];
    
    headerLabel.font = [UIFont boldSystemFontOfSize:10];
    headerLabel.lineBreakMode = NSLineBreakByCharWrapping;
    headerLabel.text = [self tableView:tableView titleForHeaderInSection:section];
    

   // headerLabel.backgroundColor = [UIColor clearColor];
    
    [headerView addSubview:headerLabel];
    
    return headerView;
    
}

- (IBAction)acceptButtonTapped  {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    [prefs setObject:finalConfig forKey:@"asignaturasconfig"];
    [prefs setObject:idsConfig forKey:@"idsconfig"];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    NSLog(@"Save config");
    NSLog(@"The content of arry is%@",finalConfig);
    
}
- (IBAction)cancelButtonTapped  {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
