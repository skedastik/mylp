var x1 >=0 ;
var x2 >=0 ;
var x3 >=0 ;
var x4 >=0 ;
var x5 >=0 ;
var x6 >=0 ;
var x7 >=0 ;
var x8 >=0 ;
var x9 >=0 ;
var x10 >=0 ;
var x11 >=0 ;
var x12 >=0 ;
var x13 >=0 ;
maximize obj: 0.0  + 4.0 * x1   + 3.0 * x2   -4.0 * x3   + 1.0 * x4   + 1.0 * x5   -4.0 * x6   -4.0 * x7   -1.0 * x8 ;
c1: x9 = 52.0  -7.0 * x1  + 8.0 * x2  -10.0 * x3  + 4.0 * x4  -9.0 * x5  -8.0 * x6  + 9.0 * x7  -7.0 * x8 ;
c2: x10 = 34.0  + 5.0 * x1  + 3.0 * x2  -5.0 * x3  -9.0 * x4  + 3.0 * x5  -8.0 * x6  -3.0 * x7  + 0.0 * x8 ;
c3: x11 = -10.0  -3.0 * x1  + 1.0 * x2  + 7.0 * x3  + 0.0 * x4  -4.0 * x5  + 3.0 * x6  + 7.0 * x7  + 3.0 * x8 ;
c4: x12 = 1.0  + 5.0 * x1  -1.0 * x2  + 2.0 * x3  -3.0 * x4  + 2.0 * x5  -3.0 * x6  -9.0 * x7  -3.0 * x8 ;
c5: x13 = 15.0  + 8.0 * x1  -3.0 * x2  + 3.0 * x3  -8.0 * x4  -10.0 * x5  -5.0 * x6  + 3.0 * x7  + 5.0 * x8 ;
solve; 
display 0.0  + 4.0 * x1   + 3.0 * x2   -4.0 * x3   + 1.0 * x4   + 1.0 * x5   -4.0 * x6   -4.0 * x7   -1.0 * x8 ;
 
 end; 
