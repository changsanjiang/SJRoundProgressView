
//
//  SJRoundProgressView.m
//  SJRoundProgressView
//
//  Created by BlueDancer on 2017/11/2.
//  Copyright © 2017年 lanwuzhe. All rights reserved.
//

#import "SJRoundProgressView.h"


#define SJLineW     (2)

#define SJStartAngle (0)

#define SJAngle360  (M_PI * 2)

@interface SJRoundProgressView()

@property (nonatomic, assign, readwrite) CGFloat r_t_preAngle; // 触摸开始的时候的角度
@property (nonatomic, assign, readwrite) CGFloat r_endAngle; // 目前的位置所在角度

@end

@implementation SJRoundProgressView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGFloat angle = [self calculateAngleWithTouch:touches.anyObject];
    _r_t_preAngle = angle;
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGFloat angle = [self calculateAngleWithTouch:touches.anyObject];
    [self touchControlWithAngle:angle];
}

- (CGFloat)calculateAngleWithTouch:(UITouch *)touch {
    CGPoint A = CGPointMake(self.frame.size.width * 0.95, self.frame.size.height * 0.5); // 起点
    CGPoint B = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5); // center
    CGPoint C = [touch locationInView:self];
    return [self getAnglesWithPointA:A pointB:B pointC:C];
}

- (CGFloat)getAnglesWithPointA:(CGPoint)pointA pointB:(CGPoint)pointB pointC:(CGPoint)pointC {
    
    CGFloat x1 = pointA.x - pointB.x;
    CGFloat y1 = pointA.y - pointB.y;
    CGFloat x2 = pointC.x - pointB.x;
    CGFloat y2 = pointC.y - pointB.y;
    
    CGFloat x = x1 * x2 + y1 * y2;
    CGFloat y = x1 * y2 - x2 * y1;
    CGFloat angle = acos( x / sqrt( x * x + y * y));
    
    if ( pointC.y < pointB.y ) angle = M_PI * 2 - angle;
    
    return angle;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    UIBezierPath *backgroundBezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(rect.size.width * 0.5, rect.size.height * 0.5) radius:rect.size.width * 0.4 startAngle:SJStartAngle endAngle:SJAngle360  clockwise:YES];
    backgroundBezierPath.lineWidth = SJLineW;
    [[UIColor lightGrayColor] set];
    [backgroundBezierPath stroke];
    
    
    UIBezierPath *bezierPath =
    [UIBezierPath bezierPathWithArcCenter:CGPointMake(rect.size.width * 0.5, rect.size.height * 0.5) radius:rect.size.width * 0.45 startAngle:SJStartAngle endAngle:_r_endAngle clockwise:YES];
    bezierPath.lineWidth = SJLineW;
    [[UIColor greenColor] set];
    [bezierPath stroke];
    
    
    CGPoint point = CGPathGetCurrentPoint(bezierPath.CGPath);
    UIBezierPath *dotBezierPath = [UIBezierPath bezierPathWithArcCenter:point radius:8 startAngle:0 endAngle:SJAngle360 clockwise:YES];
    [[UIColor yellowColor] set];
    [dotBezierPath fill];
}

- (void)setProgress:(CGFloat)progress {
    if ( progress > 1 ) progress = 1;
    else if ( progress < 0 ) progress = 0;
    _progress = progress;
    
    [self progressControlWithProgress:progress];
}

// 进度
- (void)progressControlWithProgress:(CGFloat)progress {
    _r_endAngle = SJAngle360 * progress;
    [self setNeedsDisplay];
}

// 触控
- (void)touchControlWithAngle:(CGFloat)touchMoveAngle {
    CGFloat moveAngel = touchMoveAngle - _r_t_preAngle;
    _r_t_preAngle = touchMoveAngle;
    if ( ABS(moveAngel) > 6 ) return;
    _r_endAngle += moveAngel;
    if ( _r_endAngle > SJAngle360 ) _r_endAngle = SJAngle360;
    else if ( _r_endAngle < SJStartAngle ) _r_endAngle = SJStartAngle;
    [self setNeedsDisplay];
    
}

@end
