//
//  RSPlayingCard.h
//  CardSharp
//
//  Created by Robert Stearn on 03.03.12.
//  Copyright (c) 2012 Cocoadelica. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSPlayingCard : NSObject

@property (strong, nonatomic) NSString* suitSymbol;
@property (strong, nonatomic) NSString* suitText;
@property (strong, nonatomic) NSNumber* cardValue;
@property (strong, nonatomic) NSNumber* altValue; 
@property (strong, nonatomic) NSString* cardText;
@property (strong, nonatomic) NSString* longName;

@end
