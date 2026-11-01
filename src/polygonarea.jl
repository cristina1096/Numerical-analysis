"""
Computes the area of the polygon.

ploygonarea(x, y)

Let x and y be vectors whose entries give the coordinates of 
the n vertices of a polygon, given in counterclockwise order.

Based on Green's Theorem:

A = 1/2 |sum x_k * y_k+1 - x_k+1 * y_k|

Total number of vertics is n, x_n+1 = x_1. 
"""
