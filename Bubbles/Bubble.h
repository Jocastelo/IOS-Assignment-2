//
//  Bubble.h
//  Bubbles
//
//  Created by Joao Victor Castelo on 24/04/2016.
//  Copyright © 2016 Joao Victor Castelo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#define widthBubble  ((float) 40)
#define heightBubble ((float) 40)

@interface Bubble : UIButton

@property (strong, nonatomic) NSString* typeBubble;
@property (nonatomic) short pointBubble;
@property (nonatomic, readonly) float position_x;
@property (nonatomic, readonly) float position_y;


//@property (strong, nonatomic) UIButton *bubble;


-(Bubble *)initBubble: (NSString *) type with: (short) point withX: (float) position_X withY: (float) posistion_Y;
+(Bubble *) createRandomBubble:(float) Frame_widht withFrame_Height: (float) Frame_height;
+(float) randomNumberBetween: (int) min and: (int) max;
@end
