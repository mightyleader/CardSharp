//
//  RSAppDelegate.h
//  CardSharp
//
//  Created by Robert Stearn on 03.03.12.
//  Copyright (c) 2012 Cocoadelica. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) RSPackofCards *referenceDeck;
@property (strong, nonatomic) NSMutableArray *shuffledDeckReference;

- (void)newDeal;

@end
