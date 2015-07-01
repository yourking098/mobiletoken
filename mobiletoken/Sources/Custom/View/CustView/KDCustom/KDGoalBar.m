//
//  KDGoalBar.m
//  AppearanceTest
//
//  Created by Kevin Donnelly on 1/10/12.
//  Copyright (c) 2012 -. All rights reserved.
//

#import "KDGoalBar.h"
#import "ColorHelper.h"

#define toRadians(x) ((x)*M_PI / 180.0)
#define toDegrees(x) ((x)*180.0 / M_PI)

#define divideNum 36

@implementation KDGoalBar
@synthesize allowTap, allowDragging, allowSwitching, allowDecimal, percentLabel, delegate, customText, currentGoal;

#pragma Init & Setup
- (id)init {
    if ((self = [super init])) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        [self setup];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        [self setup];
    }
    return self;
}

-(void)setup {
    self.backgroundColor = [UIColor clearColor];
    self.clipsToBounds = NO;
    
    backgroundImg = [UIImage imageNamed:@"clock-kc"];

    imageLayer = [CALayer layer];
    imageLayer.contentsScale = [UIScreen mainScreen].scale;
    imageLayer.contents = (id) backgroundImg.CGImage;
    CGFloat imgW=KSCREEN_WIDTH-60;
    CGFloat imgH=imgW;
    CGFloat imgX=(KSCREEN_WIDTH-imgW)/2.0;
    CGFloat imgY=(self.bounds.size.height-imgH)/2.0;
    imageLayer.frame = CGRectMake(imgX, imgY, imgW, imgH);
    
    percentLayer = [KDGoalBarPercentLayer layer];
    percentLayer.color=[ColorHelper colorWithHexString:@"#E9C860"];
    percentLayer.contentsScale = [UIScreen mainScreen].scale;
    percentLayer.percent = 0;
    percentLayer.frame = self.bounds;
    percentLayer.masksToBounds = NO;
    [percentLayer setNeedsDisplay];
    
    [self.layer addSublayer:imageLayer];
    [self.layer addSublayer:percentLayer];
    [imageLayer removeAnimationForKey:@"frame"];
    
    dragging = NO;
    currentAnimating = NO;
    
//    allowTap = NO;
//    allowDragging = NO;
//    tappableRect = CGRectMake(50, 50, 200, 200);
}


#pragma mark - Drawing/Animation methods
-(void)delayedDraw:(NSNumber *)newPercentage {
    currentAnimating = YES;
    int perc = [newPercentage intValue];
    if (perc < finalPercent) {
        perc++;
    } else {
        perc--;
    }
    percentLayer.percent = perc / 100.0;
    [self setNeedsLayout];
    [percentLayer setNeedsDisplay];
    [self moveThumbToPosition:perc/100.0 * (2 * M_PI)];
    if (perc != finalPercent && !dragging) {
        [self performSelector:@selector(delayedDraw:) withObject:[NSNumber numberWithInt:perc] afterDelay:.001];
    } else {
        currentAnimating = NO;
    }
}

- (void)animateThumbToZero {
    currentAnimating = YES;
    BOOL continueAnimation = NO;
    if (totalAngle < .2 && totalAngle > -.2) {
        totalAngle = 0;
    } else if (totalAngle > 0) {
        totalAngle -= 10*M_PI/180;
        totalAngle = MAX(0, totalAngle);
        continueAnimation = (totalAngle > 0);
    } else if (totalAngle < 0) {
        totalAngle += 10*M_PI/180;
        totalAngle = MIN(0, totalAngle);
        continueAnimation = (totalAngle < 0);
    }
    [self moveThumbToPosition:totalAngle];
    [self.delegate newValue:[NSNumber numberWithFloat:(maxTotal - [self totalCalcuation])] fromControl:self];
    [self setNeedsLayout];
    
    if (continueAnimation && !thumbTouch) {
        [self performSelector:@selector(animateThumbToZero) withObject:nil afterDelay:.01];
    } else if (!thumbTouch) {
        [self moveThumbToPosition:0];
        totalAngle = 0;
        currentAnimating = NO;
        if (maxTotal != 0) {
            [self.delegate valueCommitted:[NSNumber numberWithFloat:maxTotal] fromControl:self];
        }
    } else {
        currentAnimating = NO;
        if (maxTotal != 0) {
            [self.delegate valueCommitted:[NSNumber numberWithFloat:maxTotal] fromControl:self];
        }
    }
}

- (void)moveThumbToPosition:(CGFloat)angle {
    CGRect rect = thumbLayer.frame;
    CGPoint center = CGPointMake(self.bounds.size.width/2.0f, self.bounds.size.height/2.0f);
    angle -= (M_PI/2);
    
    rect.origin.x = center.x + 75 * cosf(angle) - (rect.size.width/2);
    rect.origin.y = center.y + 75 * sinf(angle) - (rect.size.height/2);
    
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    
    thumbLayer.frame = rect;
    
    [CATransaction commit];
}

-(float)bailOutAnimation {
    if (currentAnimating && !thumbLayer.hidden) {
        return maxTotal;
    }
    return 0;
}

#pragma mark - Math Helper methods
-(CGFloat)angleBetweenCenterAndPoint:(CGPoint)point {
    CGPoint center = CGPointMake(self.bounds.size.width/2.0f, self.bounds.size.height/2.0f);
    CGFloat origAngle = atan2f(center.y - point.y, point.x - center.x);
    //Translate to Unit circle
    if (origAngle > 0) {
        origAngle = (M_PI - origAngle) + M_PI;
    } else {
        origAngle = fabsf(origAngle);
    }
    //Rotating so "origin" is at "due north/Noon", I need to stop mixing metaphors
    origAngle = fmodf(origAngle+(M_PI/2), 2*M_PI);
    return origAngle;
}

-(float)totalCalcuation {
    float total;
    if (totalAngle >= -(2*M_PI/180) && totalAngle <= (2*M_PI/180)) {
        total = 0;
    } else if (totalAngle < 0) {
        total = floorf(toDegrees(totalAngle)/divideNum);
    } else {
        total = ceilf(toDegrees(totalAngle)/divideNum);
    }
    
    if (allowDecimal) {
        total = total / 4.0;
    } else {
        if (abs(total) > 100) {
            int remainder = abs(total) - 100;
            if (total < 0) {
                remainder *= -1;
            }
            total -= remainder;
            total += 25 * remainder;
        }
    }
    if (total != lastValue && !currentAnimating) {
        //[SoundPlayer soundEffect:SEClick];
    }
    
    lastValue = total;
    return  total;
}

#pragma mark - Custom Getters/Setters
- (void)setPercent:(int)percent animated:(BOOL)animated {
    if (animated) {
        finalPercent = MIN(100, MAX(0, percent));
        int oldPercent = percentLayer.percent * 100;
        
        [self performSelector:@selector(delayedDraw:) withObject:[NSNumber numberWithInt:oldPercent] afterDelay:.001];
    } else {
        CGFloat floatPercent = percent / 100.0;
        floatPercent = MIN(1, MAX(0, floatPercent));
        
        percentLayer.percent = floatPercent;
        [self setNeedsLayout];
        [percentLayer setNeedsDisplay];
        
        [self moveThumbToPosition:floatPercent * (2 * M_PI) - (M_PI/2)];
    }
}

- (void)setBarColor:(UIColor *)color {
    percentLayer.color = color;
    [percentLayer setNeedsDisplay];
}

- (void)setThumbEnabled:(BOOL)enabled {
    [self moveThumbToPosition:0];
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    thumbLayer.hidden = !enabled;
    percentLayer.hidden = enabled;
    [CATransaction commit];
    [self setNeedsLayout];
}

- (void)setCustomText:(NSString *)string{
    customText = string;
    if ([customText length] == 0) {
        [percentLabel setFont:[UIFont fontWithName:@"Futura-CondensedMedium" size:60]];
        percentLabel.numberOfLines = 1;
    } else {
        [percentLabel setFont:[UIFont fontWithName:@"Futura-CondensedMedium" size:30]];
        percentLabel.numberOfLines = 0;
    }
    [self setNeedsLayout];
}

- (BOOL)thumbEnabled {
    return !thumbLayer.hidden;
}

- (void)displayChartMode {
    imageLayer.contents = (id)backgroundImg.CGImage;
    if (!thumbLayer.hidden && allowSwitching) {
        [self setThumbEnabled:NO];
        [self setCustomText:@""];
    }
}

@end
