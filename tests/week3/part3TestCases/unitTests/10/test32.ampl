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
var x14 >=0 ;
maximize obj: 0.0  -3.0 * x1   + 1.0 * x2   -5.0 * x3   + 3.0 * x4   + 0.0 * x5   -4.0 * x6   -4.0 * x7   -1.0 * x8   -3.0 * x9 ;
c1: x10 = 19.0  -4.0 * x1  + 8.0 * x2  + 5.0 * x3  -5.0 * x4  -7.0 * x5  -9.0 * x6  -5.0 * x7  + 3.0 * x8  -6.0 * x9 ;
c2: x11 = 34.0  + 6.0 * x1  -10.0 * x2  -5.0 * x3  -10.0 * x4  -2.0 * x5  + 7.0 * x6  -10.0 * x7  -3.0 * x8  + 2.0 * x9 ;
c3: x12 = 25.0  -10.0 * x1  -3.0 * x2  + 0.0 * x3  -5.0 * x4  + 7.0 * x5  + 2.0 * x6  + 8.0 * x7  + 6.0 * x8  -1.0 * x9 ;
c4: x13 = 51.0  -10.0 * x1  + 5.0 * x2  + 1.0 * x3  -8.0 * x4  + 3.0 * x5  + 8.0 * x6  + 9.0 * x7  -1.0 * x8  -9.0 * x9 ;
c5: x14 = 9.0  + 6.0 * x1  + 2.0 * x2  + 6.0 * x3  -8.0 * x4  + 2.0 * x5  + 4.0 * x6  + 8.0 * x7  -8.0 * x8  -8.0 * x9 ;
solve; 
display 0.0  -3.0 * x1   + 1.0 * x2   -5.0 * x3   + 3.0 * x4   + 0.0 * x5   -4.0 * x6   -4.0 * x7   -1.0 * x8   -3.0 * x9 ;
 
 end; 
