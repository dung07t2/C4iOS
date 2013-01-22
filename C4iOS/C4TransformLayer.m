//
//  C4TransformLayer.m
//  Clock
//
//  Created by moi on 12-08-15.
//  Copyright (c) 2012 moi. All rights reserved.
//

#import "C4TransformLayer.h"

@interface C4TransformLayer ()
@property (readwrite, nonatomic) CGFloat rotationAngle, rotationAngleX, rotationAngleY;
@end

@implementation C4TransformLayer
@synthesize animationOptions = _animationOptions, currentAnimationEasing, repeatCount, animationDuration = _animationDuration;
@synthesize allowsInteraction, repeats;
@synthesize rotationAngle, rotationAngleX, rotationAngleY;
@synthesize perspectiveDistance = _perspectiveDistance;

- (id)init {
    self = [super init];
    if (self != nil) {
        self.name = @"backingLayer";
        self.repeatCount = 0;
        self.autoreverses = NO;
        self.rotationAngle = 0;
        currentAnimationEasing = (NSString *)kCAMediaTimingFunctionEaseInEaseOut;
        allowsInteraction = NO;
        repeats = NO;
        
        /* makes sure there are no extraneous animation keys lingering about after init */
        [self removeAllAnimations];
#ifdef VERBOSE
        C4Log(@"%@ init",[self class]);
#endif
    }
    return self;
}

-(void)awakeFromNib {
#ifdef VERBOSE
    C4Log(@"%@ awakeFromNib",[self class]);
#endif
}

#pragma mark Safe Initialization Methods
-(void)setup {
    
}

#pragma mark C4Layer Animation Methods
-(CABasicAnimation *)setupBasicAnimationWithKeyPath:(NSString *)keyPath {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:keyPath];
    animation.duration = self.animationDuration;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:self.currentAnimationEasing];
    animation.autoreverses = self.autoreverses;
    animation.repeatCount = self.repeats ? FOREVER : 0;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeBoth;
    return animation;
}

-(void)setAnimationOptions:(NSUInteger)animationOptions {
    if((animationOptions & LINEAR) == LINEAR) {
        currentAnimationEasing = kCAMediaTimingFunctionLinear;
    } else if((animationOptions & EASEOUT) == EASEOUT) {
        currentAnimationEasing = kCAMediaTimingFunctionEaseOut;
    } else if((animationOptions & EASEIN) == EASEIN) {
        currentAnimationEasing = kCAMediaTimingFunctionEaseIn;
    } else if((animationOptions & EASEINOUT) == EASEINOUT) {
        currentAnimationEasing = kCAMediaTimingFunctionEaseInEaseOut;
    } else {
        currentAnimationEasing = kCAMediaTimingFunctionDefault;
    }
    
    if((animationOptions & AUTOREVERSE) == AUTOREVERSE) self.autoreverses = YES;
    else self.autoreverses = NO;
    
    if((animationOptions & REPEAT) == REPEAT) repeats = YES;
    else repeats = NO;
    
    if((animationOptions & ALLOWSINTERACTION) == ALLOWSINTERACTION) allowsInteraction = YES;
    else allowsInteraction = NO;
}

#pragma mark C4Layer methods
-(void)animateShadowColor:(CGColorRef)_shadowColor {
    [CATransaction begin];
    CABasicAnimation *animation = [self setupBasicAnimationWithKeyPath:@"shadowColor"];
    animation.fromValue = (id)self.shadowColor;
    animation.toValue = (__bridge id)_shadowColor;
    if (animation.repeatCount != FOREVER && !self.autoreverses) {
        [CATransaction setCompletionBlock:^ {
            self.shadowColor = _shadowColor;
            [self removeAnimationForKey:@"animateShadowColor"];
        }];
    }
    [self addAnimation:animation forKey:@"animateShadowColor"];
    [CATransaction commit];
}

-(void)animateShadowOpacity:(CGFloat)_shadowOpacity {
    [CATransaction begin];
    CABasicAnimation *animation = [self setupBasicAnimationWithKeyPath:@"shadowOpacity"];
    animation.fromValue = @(self.shadowOpacity);
    animation.toValue = @(_shadowOpacity);
    if (animation.repeatCount != FOREVER && !self.autoreverses) {
        [CATransaction setCompletionBlock:^ {
            self.shadowOpacity = _shadowOpacity;
            [self removeAnimationForKey:@"animateShadowOpacity"];
        }];
    }
    [self addAnimation:animation forKey:@"animateShadowOpacity"];
    [CATransaction commit];
}

-(void)animateShadowRadius:(CGFloat)_shadowRadius {
    [CATransaction begin];
    CABasicAnimation *animation = [self setupBasicAnimationWithKeyPath:@"shadowRadius"];
    animation.fromValue = @(self.shadowRadius);
    animation.toValue = @(_shadowRadius);
    if (animation.repeatCount != FOREVER && !self.autoreverses) {
        [CATransaction setCompletionBlock:^ {
            self.shadowRadius = _shadowRadius;
            [self removeAnimationForKey:@"animateShadowRadius"];
        }];
    }
    [self addAnimation:animation forKey:@"animateShadowRadius"];
    [CATransaction commit];
}

-(void)animateShadowOffset:(CGSize)_shadowOffset {
    [CATransaction begin];
    CABasicAnimation *animation = [self setupBasicAnimationWithKeyPath:@"shadowOffset"];
    animation.fromValue = [NSValue valueWithCGSize:self.shadowOffset];
    animation.toValue = [NSValue valueWithCGSize:_shadowOffset];
    if (animation.repeatCount != FOREVER && !self.autoreverses) {
        [CATransaction setCompletionBlock:^ {
            self.shadowOffset = _shadowOffset;
            [self removeAnimationForKey:@"animateShadowOffset"];
        }];
    }
    [self addAnimation:animation forKey:@"animateShadowOffset"];
    [CATransaction commit];
}

-(void)animateShadowPath:(CGPathRef)_shadowPath {
    [CATransaction begin];
    CABasicAnimation *animation = [self setupBasicAnimationWithKeyPath:@"shadowPath"];
    animation.fromValue = (id)self.shadowPath;
    animation.toValue = (__bridge id)_shadowPath;
    if (animation.repeatCount != FOREVER && !self.autoreverses) {
        [CATransaction setCompletionBlock:^ {
            self.shadowPath = _shadowPath;
            [self removeAnimationForKey:@"animateShadowPath"];
        }];
    }
    [self addAnimation:animation forKey:@"animateShadowPath"];
    [CATransaction commit];
}

-(void)animateBackgroundFilters:(NSArray *)_backgroundFilters {
    [CATransaction begin];
    CABasicAnimation *animation = [self setupBasicAnimationWithKeyPath:@"backgroundFilters"];
    animation.fromValue = self.backgroundFilters;
    animation.toValue = _backgroundFilters;
    if (animation.repeatCount != FOREVER && !self.autoreverses) {
        [CATransaction setCompletionBlock:^ {
            self.backgroundFilters = _backgroundFilters;
            [self removeAnimationForKey:@"animateBackgroundFilters"];
        }];
    }
    [self addAnimation:animation forKey:@"animateBackgroundFilters"];
    [CATransaction commit];
}

-(void)animateCompositingFilter:(id)_compositingFilter {
    [CATransaction begin];
    CABasicAnimation *animation = [self setupBasicAnimationWithKeyPath:@"compositingFilter"];
    animation.fromValue = self.compositingFilter;
    animation.toValue = _compositingFilter;
    if (animation.repeatCount != FOREVER && !self.autoreverses) {
        [CATransaction setCompletionBlock:^ {
            self.compositingFilter = _compositingFilter;
            [self removeAnimationForKey:@"animateCompositingFilter"];
        }];
    }
    [self addAnimation:animation forKey:@"animateCompositingFilter"];
    [CATransaction commit];
}

-(void)animateContents:(CGImageRef)_image {
    [CATransaction begin];
    CABasicAnimation *animation = [self setupBasicAnimationWithKeyPath:@"contents"];
    animation.fromValue = self.contents;
    animation.toValue = (__bridge id)_image;
    if (animation.repeatCount != FOREVER && !self.autoreverses) {
        [CATransaction setCompletionBlock:^ {
            self.contents = (__bridge id)_image;
            [self removeAnimationForKey:@"animateContents"];
        }];
    }
    [self addAnimation:animation forKey:@"animateContents"];
    [CATransaction commit];
}
/* in the following method
 if we implement other kinds of options, we'll have to get rid of the returns...
 reversing how i check the values, if linear is at the bottom, then all the other values get called
 */

-(void)test {
}

//-(BOOL)isOpaque {
//    /*
//     Apple docs say that the frameworks flip this to NO automatically
//     ...if you do things like set the background color to anything transparent (i.e. alpha other than 1.0f)
//     */
//    return YES;
//}

#pragma mark New Stuff
-(void)animateBackgroundColor:(CGColorRef)_backgroundColor {
    [CATransaction begin];
    CABasicAnimation *animation = [self setupBasicAnimationWithKeyPath:@"backgroundColor"];
    animation.fromValue = (id)self.backgroundColor;
    animation.toValue = (__bridge id)_backgroundColor;
    if (animation.repeatCount != FOREVER && !self.autoreverses) {
        [CATransaction setCompletionBlock:^ {
            self.backgroundColor = _backgroundColor;
            [self removeAnimationForKey:@"animateBackgroundColor"];
        }];
    }
    [self addAnimation:animation forKey:@"animateBackgroundColor"];
    [CATransaction commit];
}

-(void)animateBorderWidth:(CGFloat)_borderWidth {
    [CATransaction begin];
    CABasicAnimation *animation = [self setupBasicAnimationWithKeyPath:@"borderWidth"];
    animation.fromValue = @(self.borderWidth);
    animation.toValue = @(_borderWidth);
    if (animation.repeatCount != FOREVER && !self.autoreverses) {
        [CATransaction setCompletionBlock:^ {
            self.borderWidth = _borderWidth;
            [self removeAnimationForKey:@"animateBorderWidth"];
        }];
    }
    [self addAnimation:animation forKey:@"animateBorderWidth"];
    [CATransaction commit];
}

-(void)animateBorderColor:(CGColorRef)_borderColor {
    [CATransaction begin];
    CABasicAnimation *animation = [self setupBasicAnimationWithKeyPath:@"borderColor"];
    animation.fromValue = (id)self.borderColor;
    animation.toValue = (__bridge id)_borderColor;
    if (animation.repeatCount != FOREVER && !self.autoreverses) {
        [CATransaction setCompletionBlock:^ {
            self.borderColor = _borderColor;
            [self removeAnimationForKey:@"animateBorderColor"];
        }];
    }
    [self addAnimation:animation forKey:@"animateBorderColor"];
    [CATransaction commit];
}

-(void)animateCornerRadius:(CGFloat)_cornerRadius {
    [CATransaction begin];
    CABasicAnimation *animation = [self setupBasicAnimationWithKeyPath:@"cornerRadius"];
    animation.fromValue = @(self.cornerRadius);
    animation.toValue = @(_cornerRadius);
    if (animation.repeatCount != FOREVER && !self.autoreverses) {
        [CATransaction setCompletionBlock:^ {
            self.cornerRadius = _cornerRadius;
            [self removeAnimationForKey:@"animateCornerRadius"];
        }];
    }
    [self addAnimation:animation forKey:@"animateCornerRadius"];
    [CATransaction commit];
}

-(void)animateZPosition:(CGFloat)_zPosition {
    [CATransaction begin];
    CABasicAnimation *animation = [self setupBasicAnimationWithKeyPath:@"zPosition"];
    animation.fromValue = @(self.zPosition);
    animation.toValue = @(_zPosition);
    if (animation.repeatCount != FOREVER && !self.autoreverses) {
        [CATransaction setCompletionBlock:^ {
            self.zPosition = _zPosition;
            [self removeAnimationForKey:@"animateZPosition"];
        }];
    }
    [self addAnimation:animation forKey:@"animateZPosition"];
    [CATransaction commit];
}

-(void)setPerspectiveDistance:(CGFloat)perspectiveDistance {
    _perspectiveDistance = perspectiveDistance;
    CATransform3D t = self.transform;
    if(perspectiveDistance != 0.0f) t.m34 = 1/self.perspectiveDistance;
    else t.m34 = 0.0f;
    self.transform = t;
}

-(void)animateRotation:(CGFloat)_rotationAngle {
    [CATransaction begin];
    CABasicAnimation *animation = [self setupBasicAnimationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = @(self.rotationAngle);
    animation.toValue = @(_rotationAngle);
    if (animation.repeatCount != FOREVER && !self.autoreverses) {
        [CATransaction setCompletionBlock:^ {
            self.rotationAngle = _rotationAngle;
            [self.delegate rotationDidFinish:_rotationAngle];
            [self removeAnimationForKey:@"animateRotationZ"];
        }];
    }
    [self addAnimation:animation forKey:@"animateRotationZ"];
    [CATransaction commit];
}

-(void)animateRotationX:(CGFloat)_rotationAngle {
    [CATransaction begin];
    CABasicAnimation *animation = [self setupBasicAnimationWithKeyPath:@"transform.rotation.x"];
    animation.fromValue = @(self.rotationAngleX);
    animation.toValue = @(_rotationAngle);
    if (animation.repeatCount != FOREVER && !self.autoreverses) {
        [CATransaction setCompletionBlock:^ {
            self.transform = CATransform3DRotate(self.transform, _rotationAngle - self.rotationAngleX, 1, 0, 0);
            self.rotationAngleX = _rotationAngle;
            [self removeAnimationForKey:@"animateRotationX"];
        }];
    }
    [self addAnimation:animation forKey:@"animateRotationX"];
    [CATransaction commit];
}

-(void)animateRotationY:(CGFloat)_rotationAngle {
    [CATransaction begin];
    CABasicAnimation *animation = [self setupBasicAnimationWithKeyPath:@"transform.rotation.y"];
    animation.fromValue = @(self.rotationAngleY);
    animation.toValue = @(_rotationAngle);
    if (animation.repeatCount != FOREVER && !self.autoreverses) {
        [CATransaction setCompletionBlock:^ {
            self.transform =    CATransform3DRotate(self.transform, _rotationAngle - self.rotationAngleY, 0, 1, 0);
            self.rotationAngleY = 0;
            [self removeAnimationForKey:@"animateRotationY"];
        }];
    }
    [self addAnimation:animation forKey:@"animateRotationY"];
    [CATransaction commit];
}

-(void)animateLayerTransform:(CATransform3D)_transform {
    [CATransaction begin];
    CABasicAnimation *animation = [self setupBasicAnimationWithKeyPath:@"sublayerTransform"];
    animation.fromValue = [NSValue valueWithCATransform3D:self.sublayerTransform];
    animation.toValue = [NSValue valueWithCATransform3D:_transform];
    if (animation.repeatCount != FOREVER && !self.autoreverses) {
        [CATransaction setCompletionBlock:^ {
            self.sublayerTransform = _transform;
            [self removeAnimationForKey:@"sublayerTransform"];
        }];
    }
    [self addAnimation:animation forKey:@"sublayerTransform"];
    [CATransaction commit];
}

-(void)setOpaque:(BOOL)opaque {
    
}
@end