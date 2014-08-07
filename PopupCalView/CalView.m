//
//  CalView.m
//  PopupCalView
//
//  Created by R. Sharma on 8/7/14.
//  Copyright (c) 2014 AgileMobileDev. All rights reserved.
//

#import "CalView.h"

@interface CalView ()
{
    BOOL isDraw;
    NSDate *strtDate;
    NSDateComponents *dC;
    NSCalendar *gregorian;
    /*
    IBOutlet UILabel *lblMon;
    IBOutlet UILabel *lblTue;
    IBOutlet UILabel *lblTue;
    IBOutlet UILabel *lblTue;
    IBOutlet UILabel *lblTue;
    IBOutlet UILabel *lblTue;
    IBOutlet UILabel *lblTue;
    */
    
}


@end

@implementation CalView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
              // Initialization code
        
        

        collectionView.pagingEnabled=YES;
        
    
        
        NSArray *arrObjects=[[NSBundle mainBundle] loadNibNamed:@"CalView" owner:self options:nil];
        self=[arrObjects objectAtIndex:0];
        
        [collectionView registerNib:[UINib nibWithNibName:@"CalCollectionCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"CalViewCollectionCell"];
    

        
        [self design];
    }
    return self;
}


-(void)design
{
    /*
    NSDate *date = [NSDate date];
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [gregorian components:(NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit) fromDate:date];
    NSInteger month = [dateComponents month];
    
    NSInteger week=[dateComponents week];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init] ;
    NSString *monthName = [[df monthSymbols] objectAtIndex:(month-1)];
    UIFont *fontMonth=[UIFont fontWithName:@"AvenirNext-Medium" size:15.0f];
    NSDictionary *attr = @{NSFontAttributeName: fontMonth};
    
    NSString *strWeek=[[df weekdaySymbols] objectAtIndex:(week-1)];
    
    NSLog(@"week no, %d ster week %@",week,strWeek);
    
    
    
    CGRect frameMonth=[monthName boundingRectWithSize:CGSizeMake(3000, 20) options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil];
    NSLog(@"frame monteh %@",NSStringFromCGRect(frameMonth));
    isDraw=YES;
    //[self drawRect:frameMonth];
    
    CGRect backgroundLabel=frameMonth;
    backgroundLabel.size.width+=10;
    
           // Draw whatever you like
        UIBezierPath *ballBezierPath = [UIBezierPath bezierPathWithRect:backgroundLabel];
        [[UIColor whiteColor] setStroke];
        [[UIColor greenColor] setFill]; // Green here to show the black area
        [ballBezierPath stroke];
        [ballBezierPath fill];
 
    frameMonth.origin.x+=8;
    
    UILabel *lbl=[[UILabel alloc] initWithFrame:frameMonth];
    lbl.text=monthName;
    lbl.font=fontMonth;
    lbl.textColor=[UIColor whiteColor];
    [self addSubview:lbl];
    
    
   // CGRect box = CGRectInset(self.bounds, self.bounds.size.width * 0.1f, self.bounds.size.height * 0.1f);
   
    
    */

    
    NSDate *date = [NSDate date];
    gregorian = [NSCalendar currentCalendar];
    [gregorian setTimeZone:[NSTimeZone defaultTimeZone]];
    

    NSDateComponents *dateComponents = [gregorian components:(NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit|NSWeekOfMonthCalendarUnit|NSWeekdayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit) fromDate:date];
    NSInteger month = [dateComponents month];
    
    NSInteger week=[dateComponents weekOfMonth];
    
    
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init] ;
    NSString *monthName = [[df monthSymbols] objectAtIndex:(month-1)];
    UIFont *fontMonth=[UIFont fontWithName:@"AvenirNext-Medium" size:15.0f];
    NSDictionary *attr = @{NSFontAttributeName: fontMonth};
    
    
    
    NSInteger day=[dateComponents weekday];
    
    NSString *strday=[[df weekdaySymbols] objectAtIndex:(day-1)];
    
    NSLog(@"week no, %d ster week %@",week,strday);
    
    
    NSDateComponents *dateComponentStartWeek=[[NSDateComponents  alloc] init];
    [dateComponentStartWeek setWeekday:2];
    [dateComponentStartWeek setWeekOfMonth:dateComponents.weekOfMonth];
    [dateComponentStartWeek setMonth:dateComponents.month];
    [dateComponentStartWeek setYear:dateComponents.year];
    [dateComponentStartWeek setHour:dateComponents.hour];
    [dateComponentStartWeek setMinute:dateComponents.minute];
    
    
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init] ;
    
    [componentsToAdd setDay:14];
    
    NSDate *newDate2 = [gregorian dateByAddingComponents:componentsToAdd toDate:[gregorian dateFromComponents:dateComponentStartWeek] options:0];
    
    NSDateComponents *dateComponentEndWeek=[gregorian components:(NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit|NSWeekOfMonthCalendarUnit|NSWeekdayCalendarUnit) fromDate:newDate2];
    
    strtDate=[gregorian dateFromComponents:dateComponentStartWeek];
    NSLog(@"date start %@ date end %@",[gregorian dateFromComponents:dateComponentStartWeek],[gregorian dateFromComponents:dateComponentEndWeek]);
 
    [collectionView reloadData];

    
}



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code

    
    //[self design];
   
    
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (strtDate) {
      
    
    return 14;
    }
    else
        return 0;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView1 cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier=@"CalViewCollectionCell";
    UICollectionViewCell *cell=[collectionView1 dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (cell==nil) {
        
        NSArray *arrObjects=[[NSBundle mainBundle] loadNibNamed:@"CalCollectionCell" owner:self options:nil];
        cell=[arrObjects objectAtIndex:0];

                
    
    }
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:indexPath.row];
    

    // create a calendar

    
    NSDate *newDate2 = [gregorian dateByAddingComponents:components toDate:strtDate options:0];

    dC=[gregorian components:(NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit|NSWeekOfMonthCalendarUnit|NSWeekdayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit) fromDate:newDate2];
    UILabel *lbl=(UILabel*)[cell viewWithTag:110];
    lbl.text=[NSString stringWithFormat:@"%d",dC.day];
    
    NSLog(@"farame  %@  offset of frame ",NSStringFromCGRect(cell.frame));
    return cell;
    
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    int selected=indexPath.row%7;
    UILabel *lbl=[labels objectAtIndex:selected];
    NSLog(@"selected %@",lbl.text);
}
-(void)checkEventonCalendars
{
    
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    CGFloat pageWidth = collectionView.frame.size.width;
    //pageControl.currentPage = collectionView.contentOffset.x / pageWidth;
    NSLog(@"page control  %f",collectionView.contentOffset.x / pageWidth);
}



@end
