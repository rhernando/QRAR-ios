//
//  ELARViewController.m
//  ListAsignaturas
//
//  Created by Rubén Hernando Martín on 13/04/13.
//  Copyright (c) 2013 Rubén Hernando Martín. All rights reserved.
//

#import "ELARViewController.h"

@interface ELARViewController ()

@end

@implementation ELARViewController

@synthesize tableData;
@synthesize tableContents;
@synthesize sortedKeys;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    tableData = [NSArray arrayWithObjects:@"Cálcuo Intensivo y Manejo de datos a gran escala", @"Computación ubicua e Inteligencia Ambiental", @"Interacción Persona-Ordenador", @"Desarrollo de Software dirigido por modelos", @"Dirección y Gestión de Proyectos Científicos y Tecnológicos", @"Iniciación a la Investigación y a la Innovación", @"Redes Sociales, Colaboración en Red", @"Sistemas Adaptativos y Modelado de Usuario", @"Recuperación de Información", nil];
    
    NSArray *arrTemp1 = [[NSArray alloc] initWithObjects:@"Álgebra I", @"Análisis Matemático I", @"Metodología y Tecnología de la Programación I", nil];
    NSArray *arrTemp2 = [[NSArray alloc] initWithObjects:@"Cálcuo Intensivo y Manejo de datos a gran escala", @"Computación ubicua e Inteligencia Ambiental", @"Interacción Persona-Ordenador", nil];

    tableContents = [[NSDictionary alloc] initWithObjectsAndKeys:arrTemp1,@"Curso 1", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:14.0];
    
    return cell;
}

@end
