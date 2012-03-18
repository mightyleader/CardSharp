//
//  RSPlayingCard.m
//  CardSharp
//
//  Created by Robert Stearn on 03.03.12.
//  Copyright (c) 2012 Cocoadelica. All rights reserved.
//
// **Coding standard**
// All curly and square braces on a new line. 
// Single space between operands and operators.
// No space between braces or brackets and operands.
// #define-ed constants start with k.
// Tab-indenting, 4 spaces per tab.
// TODO: indicates outstanding task
// DEBUG: indicates code to be removed before production
// **End Coding Standard**

#import "RSPlayingCard.h"

@implementation RSPlayingCard

@synthesize suitSymbol = _suitSymbol,
            suitText = _suitText,
            cardValue = _cardValue, 
            altValue = _altValue, 
            cardText = _cardText, 
            longName = _longName;

@end
