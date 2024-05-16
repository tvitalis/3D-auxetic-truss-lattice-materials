#Vitalis, DP Arrowhead Tetragonal Unit Cell Design
import rhinoscriptsyntax as rs
import Rhino
import math
import System
import scriptcontext as sc
import Rhino, System

a = 10.571  # DP1545 9.483mm, DP1560 8.95mm, DP3048 10.571mm
theta1 = 0.523599  # 15 degrees in radians 0.261799, 30 degrees in radians 0.523599
theta2 = 0.837758  # 45 degrees in radians 0.785398, 60 degrees in radians 1.0472, 48 degrees in radians 0.837758
n = 5 # ALL n=5
m = 7 # DP1545 & DP1560=4, DP3048=7
beam_radius = 0.5325
stubL = beam_radius-0.5325 # 0.52 DP1545, 0.5225 DP1560, 0.53 DP3048 circular beam radius

##-------------------------------------------------------------------------------------------##
## BEGGINING OF SCRIPT
##-------------------------------------------------------------------------------------------##
### MAIN PART
#Create sketch points and cylinders
point1 = rs.AddPoint(0.0, 0.0, 0.0)
point2 = rs.AddPoint(-a / 2, 0.0, -(a / 2) * math.tan(1.5708 - theta1 - theta2))
point3 = rs.AddPoint(a / 2, 0.0, -(a / 2) * math.tan(1.5708 - theta1 - theta2))
point4 = rs.AddPoint(0.0, 0.0, (a / 2) * math.tan(1.5708 - theta1)-(a / 2) * math.tan(1.5708 - theta1 - theta2))

cylinder1 = rs.AddCylinder(point2, point4, beam_radius)
cylinder2 = rs.AddCylinder(point4, point3, beam_radius)
cylinder3 = rs.AddCylinder(point3, point1, beam_radius)
cylinder4 = rs.AddCylinder(point1, point2, beam_radius)

# Create spheres at the nodes of part1
node1 = rs.AddSphere(point1, beam_radius)
node2 = rs.AddSphere(point2, beam_radius)
node3 = rs.AddSphere(point3, beam_radius)
node4 = rs.AddSphere(point4, beam_radius)

# Duplicate the objects
copied_objects = [rs.CopyObject(cylinder1), rs.CopyObject(cylinder2),
                  rs.CopyObject(cylinder3), rs.CopyObject(cylinder4),rs.CopyObject(node2),
                  rs.CopyObject(node3), rs.CopyObject(node4)]

# Rotate the copied geometry 90 degrees around the Z-axis
rs.RotateObjects(copied_objects, [0, 0, 0], 90.0)
copied_objects = rs.BooleanUnion(copied_objects)

# Group the original and rotated geometry
all_objects = [cylinder1, cylinder2, cylinder3, cylinder4, node1, node2, node3, node4] + copied_objects
group_name = rs.AddGroup()
rs.AddObjectsToGroup(all_objects, group_name)

# Union all objects to create a solid
unioned_objects = rs.BooleanUnion(all_objects)

## Create the linear instances
x_offset = a
y_offset = a
z_offset = (a / 2) * math.tan(1.5708 - theta1)-(a / 2) * math.tan(1.5708 - theta1 - theta2)

for i in range(n-1):
    for y in range(n-1):
        for j in range(m):
            translation_vector = rs.VectorAdd((i * x_offset, y * y_offset, j * z_offset), (0, 0, 0))
            rs.CopyObjects(unioned_objects, translation_vector)
            rs.AddObjectsToGroup(unioned_objects, group_name)


##CORNERS
point1 = rs.AddPoint(-a, -a, 0.0)
point2 = rs.AddPoint(-a, -a/2, -(a / 2) * math.tan(1.5708 - theta1 - theta2))
point3 = rs.AddPoint(-a/2, -a, -(a / 2) * math.tan(1.5708 - theta1 - theta2))
point4 = rs.AddPoint(-a, -a, (a / 2) * math.tan(1.5708 - theta1)-(a / 2) * math.tan(1.5708 - theta1 - theta2))

cylinder1 = rs.AddCylinder(point2, point4, beam_radius)
cylinder2 = rs.AddCylinder(point4, point3, beam_radius)
cylinder3 = rs.AddCylinder(point3, point1, beam_radius)
cylinder4 = rs.AddCylinder(point1, point2, beam_radius)

# Create spheres at the nodes of part1
node1 = rs.AddSphere(point1, beam_radius)
node2 = rs.AddSphere(point2, beam_radius)
node3 = rs.AddSphere(point3, beam_radius)
node4 = rs.AddSphere(point4, beam_radius)

# Group the original and rotated geometry
all_objects = [cylinder1, cylinder2, cylinder3, cylinder4, node1, node2, node3, node4]
group_name = rs.AddGroup()
rs.AddObjectsToGroup(all_objects, group_name)
for j in range(m):
    translation_vector = rs.VectorAdd((0, 0, j * z_offset), (0, 0, 0))
    rs.CopyObjects(all_objects, translation_vector)
    rs.AddObjectsToGroup(all_objects, group_name)

# Duplicate the objects
copied_objects = [rs.CopyObject(cylinder1), rs.CopyObject(cylinder2),
                  rs.CopyObject(cylinder3), rs.CopyObject(cylinder4),rs.CopyObject(node1),rs.CopyObject(node2),
                  rs.CopyObject(node3), rs.CopyObject(node4)]
translation_vector = [(n-2) * a, 0, 0]
rs.RotateObjects(copied_objects, [0, 0, 1.0], 90.0)
rs.MoveObjects(copied_objects, translation_vector)
for j in range(m):
    translation_vector = rs.VectorAdd((0, 0, j * z_offset), (0, 0, 0))
    rs.CopyObjects(copied_objects, translation_vector)
    rs.AddObjectsToGroup(copied_objects, group_name)

# Duplicate the objects
translation_vector = [ (n-2)*a,0, 0]
rs.RotateObjects(copied_objects, [0, 0, 1.0], 90.0)
rs.MoveObjects(copied_objects, translation_vector)
for j in range(m):
    translation_vector = rs.VectorAdd((0, 0, j * z_offset), (0, 0, 0))
    rs.CopyObjects(copied_objects, translation_vector)
    rs.AddObjectsToGroup(copied_objects, group_name)

# Duplicate the objects
translation_vector = [ (n-2)*a,0, 0]
rs.RotateObjects(copied_objects, [0, 0, 1.0], 90.0)
rs.MoveObjects(copied_objects, translation_vector)
for j in range(m):
    translation_vector = rs.VectorAdd((0, 0, j * z_offset), (0, 0, 0))
    rs.CopyObjects(copied_objects, translation_vector)
    rs.AddObjectsToGroup(copied_objects, group_name)

# Union all objects to create a solid
unioned_objects = rs.BooleanUnion(all_objects)

##T-SECTIONS
point1 = rs.AddPoint(0.0, 0.0, 0.0)
point2 = rs.AddPoint(-a / 2, 0.0, -(a / 2) * math.tan(1.5708 - theta1 - theta2))
point3 = rs.AddPoint(a / 2, 0.0, -(a / 2) * math.tan(1.5708 - theta1 - theta2))
point4 = rs.AddPoint(0.0, 0.0, (a / 2) * math.tan(1.5708 - theta1)-(a / 2) * math.tan(1.5708 - theta1 - theta2))

cylinder1 = rs.AddCylinder(point2, point4, beam_radius)
cylinder2 = rs.AddCylinder(point4, point3, beam_radius)
cylinder3 = rs.AddCylinder(point3, point1, beam_radius)
cylinder4 = rs.AddCylinder(point1, point2, beam_radius)

# Create spheres at the nodes of part1
node1 = rs.AddSphere(point1, beam_radius)
node2 = rs.AddSphere(point2, beam_radius)
node3 = rs.AddSphere(point3, beam_radius)
node4 = rs.AddSphere(point4, beam_radius)

# Duplicate the objects
copied_objects = [rs.CopyObject(cylinder2),
                  rs.CopyObject(cylinder3),
                  rs.CopyObject(node3), rs.CopyObject(node4)]

# Rotate the copied geometry 90 degrees around the Z-axis
rs.RotateObjects(copied_objects, [0, 0, 0], 90.0)

# Group the original and rotated geometry
all_objects = [cylinder1, cylinder2, cylinder3, cylinder4, node1, node2, node3, node4] + copied_objects
group_name = rs.AddGroup()
rs.AddObjectsToGroup(all_objects, group_name)

# Union all objects to create a solid
unioned_objects = rs.BooleanUnion(all_objects)

translation_vector = [ 0,-a, 0]
rs.MoveObjects(unioned_objects, translation_vector)
for i in range(n-1):
    for j in range(m):
        translation_vector = rs.VectorAdd((i * x_offset, 0, j * z_offset), (0, 0, 0))
        rs.CopyObjects(unioned_objects, translation_vector)
        rs.AddObjectsToGroup(unioned_objects, group_name)

#Rotate and Translate
translation_vector = [ (n-2)*a,0, 0]
rs.RotateObjects(unioned_objects, [0, 0, 1.0], 90.0)
rs.MoveObjects(unioned_objects, translation_vector)
for i in range(n-1):
    for j in range(m):
        translation_vector = rs.VectorAdd((0, i * y_offset, j * z_offset), (0, 0, 0))
        rs.CopyObjects(unioned_objects, translation_vector)
        rs.AddObjectsToGroup(unioned_objects, group_name)

#Rotate and Translate
translation_vector = [ (n-2)*a,0, 0]
rs.RotateObjects(unioned_objects, [0, 0, 1.0], 90.0)
rs.MoveObjects(unioned_objects, translation_vector)
for i in range(n-1):
    for j in range(m):
        translation_vector = rs.VectorAdd((-i * x_offset, 0, j * z_offset), (0, 0, 0))
        rs.CopyObjects(unioned_objects, translation_vector)
        rs.AddObjectsToGroup(unioned_objects, group_name)

#Rotate and Translate
translation_vector = [(n-2)*a,0, 0]
rs.RotateObjects(unioned_objects, [0, 0, 1.0], 90.0)
rs.MoveObjects(unioned_objects, translation_vector)
for i in range(n-1):
    for j in range(m):
        translation_vector = rs.VectorAdd((0, -i * y_offset, j * z_offset), (0, 0, 0))
        rs.CopyObjects(unioned_objects, translation_vector)
        rs.AddObjectsToGroup(unioned_objects, group_name)

temp=unioned_objects+copied_objects

##TOP LAYER
#Individual beams around
point1 = rs.AddPoint(0, -a, (m)*z_offset)
point2 = rs.AddPoint(-a/2, -a, (m)*z_offset-(a / 2) * math.tan(1.5708 - theta1 - theta2))
point3 = rs.AddPoint(-a/2, -a, (m)*z_offset-(a / 2) * math.tan(1.5708 - theta1 - theta2))
point4 = rs.AddPoint(0, -a, (m)*z_offset+(a / 2) * math.tan(1.5708 - theta1)-(a / 2) * math.tan(1.5708 - theta1 - theta2))
cylinder3 = rs.AddCylinder(point3, point1, beam_radius)
cylinder4 = rs.AddCylinder(point1, point2, beam_radius)
node2 = rs.AddSphere(point2, beam_radius)
node3 = rs.AddSphere(point3, beam_radius)

# Duplicate the objects
copied_objects = [rs.CopyObject(cylinder3), rs.CopyObject(cylinder4),rs.CopyObject(node3)]

for i in range(n):
    for y in range(n+1):
            translation_vector = rs.VectorAdd((i * x_offset, y * y_offset, 0), (0, 0, 0))
            rs.CopyObjects(copied_objects, translation_vector)
            rs.AddObjectsToGroup(copied_objects, group_name)

# Union all objects to create a solid
unioned_objects = rs.BooleanUnion(copied_objects)

# Duplicate the objects
copied_objects = [rs.CopyObject(cylinder3), rs.CopyObject(cylinder4),rs.CopyObject(node2)]

## Rotate the copied geometry 90 degrees around the Z-axis
rs.RotateObjects(copied_objects, [0, 0, 0], 90.0)

for i in range(n+1):
    for y in range(n):
            translation_vector = rs.VectorAdd((i * x_offset-2*a, y * y_offset, 0), (0, 0, 0))
            rs.CopyObjects(copied_objects, translation_vector)
            rs.AddObjectsToGroup(copied_objects, group_name)

# Union all objects to create a solid
unioned_objects = rs.BooleanUnion(copied_objects)

# Duplicate the objects
copied_objects = [rs.CopyObject(cylinder3), rs.CopyObject(cylinder4)]

## Rotate the copied geometry 90 degrees around the Z-axis
rs.RotateObjects(copied_objects, [0, 0, 0], 180)

for i in range(n):
    for y in range(n+1):
            translation_vector = rs.VectorAdd((i * x_offset-a, y * y_offset-2*a, 0), (0, 0, 0))
            rs.CopyObjects(copied_objects, translation_vector)
            rs.AddObjectsToGroup(copied_objects, group_name)

# Union all objects to create a solid
unioned_objects = rs.BooleanUnion(copied_objects)

# Duplicate the objects
copied_objects = [rs.CopyObject(cylinder3), rs.CopyObject(cylinder4)]

## Rotate the copied geometry 90 degrees around the Z-axis
rs.RotateObjects(copied_objects, [0, 0, 0], 270)

for i in range(n+1):
    for y in range(n):
            translation_vector = rs.VectorAdd((i * x_offset, y * y_offset-a, 0), (0, 0, 0))
            rs.CopyObjects(copied_objects, translation_vector)
            rs.AddObjectsToGroup(copied_objects, group_name)

# Union all objects to create a solid
unioned_objects = rs.BooleanUnion(copied_objects)


## BOTTOM LAYER
point1 = rs.AddPoint(0.0, 0.0, 0.0)
point2 = rs.AddPoint(-(math.tan(theta1))*(1+(a/2)*math.tan(1.5708-theta1-theta2)), 0.0, -(1+(a / 2) * math.tan(1.5708 - theta1 - theta2)+stubL)-2.0)
point3 = rs.AddPoint((math.tan(theta1))*(1+(a/2)*math.tan(1.5708-theta1-theta2)), 0.0, -(1+(a / 2) * math.tan(1.5708 - theta1 - theta2)+stubL)-2.0)
point4 = rs.AddPoint(0.0, 0.0, 0.0)
cylinder1 = rs.AddCylinder(point2, point4, beam_radius)
cylinder2 = rs.AddCylinder(point4, point3, beam_radius)

# Define the dimensions of the box
w = n*a+2*a  # Length along the X-axis
r = n*a+2*a  # Width along the Y-axis
z = -(1+(a / 2) * math.tan(1.5708 - theta1 - theta2)+stubL)   # Height along the Z-axis

# Define the corner points of the box in counter-clockwise order
corner1 = (-2*a, -2*a, z)
corner2 = (w, -2*a, z)
corner3 = (w, r, z)
corner4 = (-2*a, r, z)
corner5 = (-2*a, -2*a, z-5.0)
corner6 = (w, -2*a, z-5.0)
corner7 = (w, r, z-5.0)
corner8 = (-2*a, r, z-5.0)

box = rs.AddBox([corner1, corner2, corner3, corner4, corner5, corner6, corner7, corner8])
cylinder1=rs.BooleanDifference(cylinder1,box)
box = rs.AddBox([corner1, corner2, corner3, corner4, corner5, corner6, corner7, corner8])
cylinder2=rs.BooleanDifference(cylinder2,box)

# Duplicate the objects
copied_objects = [rs.CopyObject(cylinder1), rs.CopyObject(cylinder2)]

for i in range(n-1):
    for y in range(n+1):
            translation_vector = rs.VectorAdd((i * x_offset, y * y_offset-a, 0), (0, 0, 0))
            rs.CopyObjects(copied_objects, translation_vector)
            rs.AddObjectsToGroup(copied_objects, group_name)

# Rotate the copied geometry 90 degrees around the Z-axis
rs.RotateObjects(copied_objects, [0, 0, 0], 90.0)

# Group the original and rotated geometry
all_objects = copied_objects
group_name = rs.AddGroup()
rs.AddObjectsToGroup(all_objects, group_name)

# Union all objects to create a solid
unioned_objects = rs.BooleanUnion(all_objects)

translation_vector = [ 0,0, 0]
rs.MoveObjects(unioned_objects, translation_vector)
for i in range(n+1):
    for j in range(n-1):
        translation_vector = rs.VectorAdd((i * x_offset-a, j * y_offset, 0), (0, 0, 0))
        rs.CopyObjects(unioned_objects, translation_vector)
        rs.AddObjectsToGroup(unioned_objects, group_name)

# Rotate the copied geometry 90 degrees around the Z-axis
rs.RotateObjects(cylinder1, [0, 0, 0], 180)

translation_vector = [ 0,0, 0]
rs.MoveObjects(cylinder2, translation_vector)

for j in range(n+1):
    translation_vector = rs.VectorAdd((x_offset-2*a, j * y_offset-a, 0), (0, 0, 0))
    rs.CopyObjects(cylinder1, translation_vector)
    rs.AddObjectsToGroup(cylinder1, group_name)
    
# Rotate the copied geometry 90 degrees around the Z-axis
rs.RotateObjects(cylinder1, [0, 0, 0], 180)

translation_vector = [ 0,0, 0]
rs.MoveObjects(cylinder2, translation_vector)

for j in range(n+1):
    translation_vector = rs.VectorAdd((n*a-a, j * y_offset-a, 0), (0, 0, 0))
    rs.CopyObjects(cylinder1, translation_vector)
    rs.AddObjectsToGroup(cylinder1, group_name)
    
# Rotate the copied geometry 90 degrees around the Z-axis
rs.RotateObjects(cylinder1, [0, 0, 0], 90)

translation_vector = [ 0,0, 0]
rs.MoveObjects(cylinder2, translation_vector)

for j in range(n+1):
    translation_vector = rs.VectorAdd((j * x_offset-a, (n-1)*a,0), (0, 0, 0))
    rs.CopyObjects(cylinder1, translation_vector)
    rs.AddObjectsToGroup(cylinder1, group_name)


# Rotate the copied geometry 90 degrees around the Z-axis
rs.RotateObjects(cylinder1, [0, 0, 0], 180)

translation_vector = [ 0,0, 0]
rs.MoveObjects(cylinder2, translation_vector)

for j in range(n+1):
    translation_vector = rs.VectorAdd((j * x_offset-a, -a,0), (0, 0, 0))
    rs.CopyObjects(cylinder1, translation_vector)
    rs.AddObjectsToGroup(cylinder1, group_name)

copied_objects=rs.BooleanUnion(cylinder1, cylinder2)

## TOP LAYER
point1 = rs.AddPoint(-a/2, 0.0, m*z_offset-(a / 2) * math.tan(1.5708 - theta1 - theta2))
point2 = rs.AddPoint(-a/2-(math.tan(theta1))*(1+(a/2)*math.tan(1.5708-theta1-theta2)), 0.0, m*z_offset+(1+(a / 2) * math.tan(1.5708 - theta1 - theta2)+stubL)-(a / 2) * math.tan(1.5708 - theta1 - theta2)+2.0)
point3 = rs.AddPoint(-a/2+(math.tan(theta1))*(1+(a/2)*math.tan(1.5708-theta1-theta2)), 0.0, m*z_offset+(1+(a / 2) * math.tan(1.5708 - theta1 - theta2)+stubL)-(a / 2) * math.tan(1.5708 - theta1 - theta2)+2.0)
point4 = rs.AddPoint(-a/2, 0.0, m*z_offset-(a / 2) * math.tan(1.5708 - theta1 - theta2))

cylinder1 = rs.AddCylinder(point2, point4, beam_radius)
cylinder2 = rs.AddCylinder(point4, point3, beam_radius)

# Define the dimensions of the box
w = n*a+2*a  # Length along the X-axis
r = n*a+2*a  # Width along the Y-axis
z = m*z_offset+(1+(a / 2) * math.tan(1.5708 - theta1 - theta2)+stubL)-(a / 2) * math.tan(1.5708 - theta1 - theta2)   # Height along the Z-axis

# Define the corner points of the box in counter-clockwise order
corner1 = (-2*a, -2*a, z)
corner2 = (w, -2*a, z)
corner3 = (w, r, z)
corner4 = (-2*a, r, z)
corner5 = (-2*a, -2*a, z+5.0)
corner6 = (w, -2*a, z+5.0)
corner7 = (w, r, z+5.0)
corner8 = (-2*a, r, z+5.0)
box = rs.AddBox([corner1, corner2, corner3, corner4, corner5, corner6, corner7, corner8])
copied_objects=rs.BooleanDifference([cylinder1, cylinder2],box)

# Duplicate the objects
for i in range(n):
    for y in range(n+1):
            translation_vector = rs.VectorAdd((i * x_offset, y * y_offset-a, 0), (0, 0, 0))
            rs.CopyObjects(copied_objects, translation_vector)
            rs.AddObjectsToGroup(copied_objects, group_name)

copied_objects=rs.BooleanUnion(copied_objects)

# Rotate the copied geometry 90 degrees around the Z-axis
rs.RotateObjects(copied_objects, [0, 0, 0], 90)

# Duplicate the objects
for i in range(n+1):
    for y in range(n):
            translation_vector = rs.VectorAdd((i * x_offset-a, y * y_offset, 0), (0, 0, 0))
            rs.CopyObjects(copied_objects, translation_vector)
            rs.AddObjectsToGroup(copied_objects, group_name)

##SOLID UNION ALL
rs.Command('_SelDup')
rs.Command('_Delete')
rs.BooleanUnion(copied_objects)
obj =rs.ObjectsByType(1,True)
rs.DeleteObjects(obj)
obj =rs.ObjectsByType(16)
obj=rs.BooleanUnion(obj)
all_objects = rs.AllObjects()
obj=rs.BooleanUnion(all_objects)

print("Truss Volume in mm3", rs.coercebrep(rs.ObjectsByType(16)).GetVolume())

# Specify the object to save
object_id = rs.AllObjects()
object_count = len(object_id)
print('Object count',object_count)

##-------------------------------------------------------------------------------------------##
##END OF SCRIPT
##-------------------------------------------------------------------------------------------##