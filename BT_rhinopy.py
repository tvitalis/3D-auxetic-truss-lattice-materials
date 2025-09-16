#Vitalis, BT Tetragonal Unit Cell Design
import rhinoscriptsyntax as rs
import Rhino
import math
import System
import scriptcontext as sc
import Rhino, System

a = 11.0731  #75deg 10.7175, 80deg 11.0731, 85deg 11.4927  size of unit cell
n = 4  # honeycomb number - default=4 (4x4x4 cells)
m = 5 #6 for 75deg, 5 for 80deg & 85deg
theta = 1.39626  # 75deg=1.309, 80deg=1.39626, 85deg=1.48353 re-entrant angle
beam_radius = 0.5075  #0.49 for 75deg, 0.51 for 80deg, 0.505 for85deg
stubL = 0.0#+(0.5075-beam_radius) 

##-------------------------------------------------------------------------------------------##
## BEGGINING OF SCRIPT
##-------------------------------------------------------------------------------------------##

# Calculate r and L
r = math.tan(theta) / ((4 * math.tan(theta)) - (4 * math.sin(theta)))
L = 2 * r * a

# Define the Line statements and their connectivity with X, Y, Z format vectors
lines = [
#Front Plane
    ((0.0, 0.0, 0.0), (0.0, 0.0, r * a)),
    ((0.0, 0.0, r * a), (2 * math.sin(theta) * r * a, 0.0, r * a - (math.cos(theta) * r * a * 2))),
    ((2 * math.sin(theta) * r * a, 0.0, r * a - (math.cos(theta) * r * a * 2)), (4 * math.sin(theta) * r * a, 0.0, r * a)),
    ((4 * math.sin(theta) * r * a, 0.0, a), (4 * math.sin(theta) * r * a, 0.0, a - r * a)),
    ((4 * math.sin(theta) * r * a, 0.0, a - r * a), (2 * math.sin(theta) * r * a, 0.0, a - r * a + (math.cos(theta) * r * a * 2))),
    ((2 * math.sin(theta) * r * a, 0.0, a - r * a + (math.cos(theta) * r * a * 2)), (0.0, 0.0, a - r * a)),
    ((0.0, 0.0, a - r * a), (0.0, 0.0, a)),
    ((4 * math.sin(theta) * r * a, 0.0, 0.0), (4 * math.sin(theta) * r * a, 0.0, r*a)),
    ((2 * math.sin(theta) * r * a, 0.0, r * a - (math.cos(theta) * r * a * 2)), (2 * math.sin(theta) * r * a, 0.0, a -r*a + (math.cos(theta)) * r * a * 2)),
##Back Plane
    ((0.0, 4 * math.sin(theta) * r * a, 0.0), (0.0, 4 * math.sin(theta) * r * a, r * a)),
    ((0.0, 4 * math.sin(theta) * r * a, r * a), (2 * math.sin(theta) * r * a, 4 * math.sin(theta) * r * a, r * a - (math.cos(theta) * r * a * 2))),
    ((2 * math.sin(theta) * r * a, 4 * math.sin(theta) * r * a, r * a - (math.cos(theta) * r * a * 2)), (4 * math.sin(theta) * r * a, 4 * math.sin(theta) * r * a, r * a)),
    ((4 * math.sin(theta) * r * a, 4 * math.sin(theta) * r * a, a), (4 * math.sin(theta) * r * a, 4 * math.sin(theta) * r * a, a - r * a)),
    ((4 * math.sin(theta) * r * a, 4 * math.sin(theta) * r * a, a - r * a), (2 * math.sin(theta) * r * a, 4 * math.sin(theta) * r * a, a - r * a + (math.cos(theta) * r * a * 2))),
    ((2 * math.sin(theta) * r * a, 4 * math.sin(theta) * r * a, a - r * a + (math.cos(theta) * r * a * 2)), (0.0, 4 * math.sin(theta) * r * a, a - r * a)),
    ((0.0, 4 * math.sin(theta) * r * a, a - r * a), (0.0, 4 * math.sin(theta) * r * a, a)),
    ((4 * math.sin(theta) * r * a, 4 * math.sin(theta) * r * a, 0.0), (4 * math.sin(theta) * r * a, 4 * math.sin(theta) * r * a, r*a)),
    ((2 * math.sin(theta) * r * a, 4 * math.sin(theta) * r * a, r * a - (math.cos(theta) * r * a * 2)), (2 * math.sin(theta) * r * a, 4 * math.sin(theta) * r * a, a -r*a+ (math.cos(theta)) * r * a * 2)),
##Mid Plane
    ((0.0, 2 * math.sin(theta) * r * a, r * a - (math.cos(theta) * r * a * 2)), (2 * math.sin(theta) * r * a, 2 * math.sin(theta) * r * a, r * a)),
    ((2 * math.sin(theta) * r * a, 2 * math.sin(theta) * r * a, r * a), (4 * math.sin(theta) * r * a, 2 * math.sin(theta) * r * a, r * a - (math.cos(theta) * r * a * 2))),
    ((2 * math.sin(theta) * r * a, 2 * math.sin(theta) * r * a, a-r*a), (2 * math.sin(theta) * r * a, 2 * math.sin(theta) * r * a, a)),
    ((2 * math.sin(theta) * r * a, 2 * math.sin(theta) * r * a, 0.0), (2 * math.sin(theta) * r * a, 2 * math.sin(theta) * r * a, r*a)),
    ((2 * math.sin(theta) * r * a, 2 * math.sin(theta) * r * a, a-r*a), (4 * math.sin(theta) * r * a, 2 * math.sin(theta) * r * a, a-r*a+(math.cos(theta) * r * a * 2))),
    ((0.0, 2 * math.sin(theta) * r * a, a-r*a+(math.cos(theta) * r * a * 2)), (2 * math.sin(theta) * r * a,2 * math.sin(theta) * r * a,a-r*a))
]

# Create solid cylinders based on the Line statements
cylinders = []
for line in lines:
    point1, point2 = line
    cylinder = rs.AddCylinder(point1, point2, beam_radius)
    rs.RotateObjects(cylinder, [0, 0, 0], 90.0)
    rs.MoveObjects(cylinder, [4 * math.sin(theta) * r * a, 0, 0])
    cylinders.append(cylinder)
    cylinder = rs.AddCylinder(point1, point2, beam_radius)
    cylinders.append(cylinder)
    rs.BooleanUnion(rs.AllObjects())
rs.BooleanUnion(rs.AllObjects())

# Group all created cylinders
rs.AddObjectsToGroup(cylinders, 'Model-1')

# Function to create a solid sphere at a given point with a given radius
def create_solid_sphere(point, radius):
    sphere = rs.AddSphere(point, radius)
    return sphere

# Create a set to store unique coordinates
unique_coordinates = set()

# Iterate through the lines and collect unique coordinates
for line in lines:
    start_point, end_point = line
    unique_coordinates.add(start_point)
    unique_coordinates.add(end_point)

## Create solid spheres at unique coordinates
for coordinate in unique_coordinates:
    x, y, z = coordinate
    if z != 0.0 and z != a:
        create_solid_sphere(coordinate, beam_radius)
    rs.BooleanUnion(rs.AllObjects())

all_objects = rs.ObjectsByType(16)
obj=rs.BooleanUnion(all_objects)

# Calculate distances
x_distance = 4 * math.sin(theta) * r * a
y_distance = 4 * math.sin(theta) * r * a
z_distance = a
print('Tessellation Size', x_distance*n, y_distance*n, z_distance*m)

# Select objects to create a linear pattern
objects_to_copy = rs.AllObjects()  # You can select specific objects if needed

# Create a three-dimensional pattern
if objects_to_copy:
    copies = []
    for i in range(n):
        for j in range(n):
            for k in range(m):
                for obj in objects_to_copy:
                    copy = rs.CopyObject(obj, [i * x_distance, j * y_distance, k * z_distance])
                    copies.append(copy)

# Define the corner points of the box in counter-clockwise order
obj=rs.AllObjects()
corner1 = (-2*a, -2*a, 0)
corner2 = (n*x_distance+2*a, -2*a, 0)
corner3 = (n*x_distance+2*a, n*y_distance+2*a, 0)
corner4 = (-2*a,  n*y_distance+2*a, 0)
corner5 = (-2*a, -2*a, stubL)
corner6 = (n*x_distance+2*a, -2*a, stubL)
corner7 = (n*x_distance+2*a, n*y_distance+2*a, stubL)
corner8 = (-2*a, n*y_distance+2*a, stubL)

if stubL != 0:
    box = rs.AddBox([corner1, corner2, corner3, corner4, corner5, corner6, corner7, corner8])
    rs.BooleanDifference(obj,box)
    
    obj=rs.AllObjects()
    corner1 = (-2*a, -2*a, m*a-stubL)
    corner2 = (n*x_distance+2*a, -2*a, m*a-stubL)
    corner3 = (n*x_distance+2*a, n*y_distance+2*a, m*a-stubL)
    corner4 = (-2*a,  n*y_distance+2*a, m*a-stubL)
    corner5 = (-2*a, -2*a, m*a)
    corner6 = (n*x_distance+2*a, -2*a, m*a)
    corner7 = (n*x_distance+2*a, n*y_distance+2*a, m*a)
    corner8 = (-2*a, n*y_distance+2*a, m*a)
    
    box = rs.AddBox([corner1, corner2, corner3, corner4, corner5, corner6, corner7, corner8])
    rs.BooleanDifference(obj,box)

### Cleanup && SOLID UNION ALL
rs.Command('_SelDup')
rs.Command('_Delete')
obj =rs.ObjectsByType(16)
rs.BooleanUnion(obj)

##SOLID UNION ALL
rs.Command('_SelDup')
rs.Command('_Delete')
rs.BooleanUnion(rs.AllObjects())
obj =rs.ObjectsByType(1,True)
rs.DeleteObjects(obj)
obj =rs.ObjectsByType(16)
obj=rs.BooleanUnion(obj)
all_objects = rs.AllObjects()
obj=rs.BooleanUnion(all_objects)

# Specify the object to save
object_id = rs.AllObjects()
object_count = len(object_id)
print('Object count',object_count)
print("Truss Volume in mm3", rs.coercebrep(rs.ObjectsByType(16)).GetVolume())

##-------------------------------------------------------------------------------------------##
##END OF SCRIPT
##-------------------------------------------------------------------------------------------##