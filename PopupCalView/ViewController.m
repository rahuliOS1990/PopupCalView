//
//  ViewController.m
//  PopupCalView
//
//  Created by R. Sharma on 8/7/14.
//  Copyright (c) 2014 AgileMobileDev. All rights reserved.
//

#import "ViewController.h"
#import "CircleView.h"

#import "CalView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    

    
}

-(IBAction)btnEvent:(id)sender
{

    
    CircleView *viewCirlce=[[CircleView alloc] initWithFrame:CGRectMake(100, 100, 10, 10)];
    
       [viewCirlce setBackgroundColor:[UIColor clearColor]];
   // [self.view addSubview:viewCirlce];

    CalView *view=[[CalView alloc] initWithFrame:CGRectMake(10, 30,     371    , 300)];
   
    [view setBackgroundColor:[UIColor darkGrayColor]];
   
    [self.view addSubview:view];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
