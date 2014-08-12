//
//  ViewController.m
//  PopupCalView
//
//  Created by R. Sharma on 8/7/14.
//  Copyright (c) 2014 AgileMobileDev. All rights reserved.
//

#import "ViewController.h"
#import "CircleView.h"
#import "LSAlert.h"


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

    CalView *view=[[CalView alloc] initWithFrame:CGRectMake(110, 130,370, 300)];
   
    [view setBackgroundColor:[UIColor darkGrayColor]];
    view.datasource=self;
    // [view design];
    [self.view addSubview:view];
    
    
}

-(NSArray *)alertArrayForCalWeekView
{
    LSAlert *alert=[[LSAlert alloc] init];
    alert.date=[NSDate date];
    
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:(NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit|NSWeekOfMonthCalendarUnit|NSWeekdayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit) fromDate:alert.date];
    dateComponents.day=1;
    
    LSAlert *alert1=[[LSAlert alloc] init];
    alert1.date=[[NSCalendar currentCalendar] dateFromComponents:dateComponents];
    
    
    NSArray *arrAlers=[[NSArray alloc] initWithObjects:alert,alert1 ,nil];
    
    return arrAlers;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
