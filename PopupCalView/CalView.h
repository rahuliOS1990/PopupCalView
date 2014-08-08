//
//  CalView.h
//  PopupCalView
//
//  Created by R. Sharma on 8/7/14.
//  Copyright (c) 2014 AgileMobileDev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalView : UIView<UICollectionViewDataSource,UICollectionViewDelegate>

{
 IBOutlet   UICollectionView *collectionView;
    IBOutletCollection(UILabel) NSArray *labels;
    
    IBOutlet UILabel *lblLeftWeek;
    IBOutlet UILabel *lblRightWeek;
}



-(void)design;



@end
