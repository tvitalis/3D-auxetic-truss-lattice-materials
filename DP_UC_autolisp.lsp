;Vitalis, DP Arrowhead Tetragonal Unit Cell Design
;First change Autocad Units to radians

;import geometric data
(arxload "geom3d")
(setq a 9.483); 15-45deg=9.483, 15-60deg=8.95  ,30-48deg=10.571 unit cell width for 1.0mm struts
(setq theta1 0.261799); in radians, 0.261799=15deg, 0.523599=30deg
(setq theta2 0.785398); in radians, 0.785398=45deg, 1.0472=60deg, 0.837758=48deg
(setq cylRadius 0.55)

;define tan
(defun tan (num)
 (/ (sin
num)(cos num))
)

(vl-load-com) 

;diagonal elements
;calculate cylinder height
(setq cylHeightTall (/ (/ a 2.0) (cos (- 1.5708 theta1))))
(setq cylHeightShort (/ (/ a 2.0) (cos (- (- 1.5708 theta1) theta2))))
(setq x (* (/ cylHeightTall 2.0) (sin theta1)))
(setq i (* (* (/ cylHeightTall 2.0) (/ (sin theta1) 2.0)) (sin (- 1.5708 (/ (- 3.14159 theta1) 2.0))))); linear arc length from rotation
(setq h (- (+ i (* (cos theta1) cylHeightTall)) (* (cos (+ theta2 theta1)) cylHeightShort)))

;Define cut_edge for bottom plane
(defun cut_edge1 (ent_name num)
(SETQ object1 ent_name)
(SETQ plane1_1 (list 0.0 0.0 i))
(SETQ plane1_2 (list 0.0 0.0 num))
(COMMAND "_OSNAP" "")
(COMMAND "_SLICE" "_SI" object1 "_XY" plane1_1 plane1_2)
(COMMAND "_OSNAP" "_END,_INT,_MID,_CEN,_INS,_PER")
(COMMAND "_REDRAW")
(SETQ object1 NIL)
)

;Define cut_edge for top plane
(defun cut_edge2 (ent_name num)
(SETQ object2 ent_name)
(SETQ plane2_1 (list 0.0 0.0 h))
(SETQ plane2_2 (list 0.0 0.0 num))
(COMMAND "_OSNAP" "")
(COMMAND "_SLICE" "_SI" object2 "_XY" plane2_1 plane2_2)
(COMMAND "_OSNAP" "_END,_INT,_MID,_CEN,_INS,_PER")
(COMMAND "_REDRAW")
(SETQ object2 NIL)
)

;ZX Face Front
;Bot Tall element id=1
(setq center (vlax-3d-point (/ x 2.0) 0 (/ cylHeightTall 4.0)))
(setq modelSpace (vla-get-ModelSpace (vla-get-ActiveDocument (vlax-get-acad-object))))
(vla-AddCylinder modelSpace center cylRadius (/ cylHeightTall 2.0))
(setq ss1 (ssget "L"))
(setq stp (list (/ x 2.0) 1.0 (/ cylHeightTall 4.0)))
(setq endp (list (/ x 2.0) -1.0 (/ cylHeightTall 4.0)))
(ROTATE3D  ss1 stp endp theta1)
(setq ss1 (ssget "L"))
(cut_edge1 ss1 a)

;Bot Tall element id=2
(setq center (vlax-3d-point (- a (/ x 2.0)) 0 (/ cylHeightTall 4.0)))
(setq modelSpace (vla-get-ModelSpace (vla-get-ActiveDocument (vlax-get-acad-object))))
(vla-AddCylinder modelSpace center cylRadius (/ cylHeightTall 2.0))
(setq ss1 (ssget "L"))
(setq stp (list (- a (/ x 2.0)) -1.0 (/ cylHeightTall 4.0)))
(setq endp (list (- a (/ x 2.0)) 1.0 (/ cylHeightTall 4.0)))
(ROTATE3D  ss1 stp endp theta1)
(setq ss1 (ssget "L"))
(cut_edge1 ss1 a)

;Top Tall element id=3
(setq center (vlax-3d-point (- (/ a 2.0) (/ x 2.0)) 0 (+ (+ (- (* (cos theta1) (/ cylHeightTall 2.0)) (* (cos (+ theta2 theta1)) cylHeightShort )) (* (cos theta1) (/ cylHeightTall 4.0))) i)))
(vla-AddCylinder modelSpace center cylRadius (/ cylHeightTall 2.0))
(setq ss1 (ssget "L"))
(setq stp (list (- (/ a 2.0) (/ x 2.0)) 1.0 (+ (+ (- (* (cos theta1) (/ cylHeightTall 2.0)) (* (cos (+ theta2 theta1)) cylHeightShort )) (* (cos theta1) (/ cylHeightTall 4.0))) i)))
(setq endp (list (- (/ a 2.0) (/ x 2.0)) -1.0 (+ (+ (- (* (cos theta1) (/ cylHeightTall 2.0)) (* (cos (+ theta2 theta1)) cylHeightShort )) (* (cos theta1) (/ cylHeightTall 4.0))) i)))
(ROTATE3D  ss1 stp endp theta1)
(setq ss1 (ssget "L"))
(cut_edge2 ss1 a)

;Top Tall element id=4
(setq center (vlax-3d-point (+ (/ a 2.0) (/ x 2.0)) 0 (+ (+ (- (* (cos theta1) (/ cylHeightTall 2.0)) (* (cos (+ theta2 theta1)) cylHeightShort )) (* (cos theta1) (/ cylHeightTall 4.0))) i)))
(vla-AddCylinder modelSpace center cylRadius (/ cylHeightTall 2.0))
(setq ss1 (ssget "L"))
(setq stp (list (+ (/ a 2.0) (/ x 2.0)) -1.0 (+ (+ (- (* (cos theta1) (/ cylHeightTall 2.0)) (* (cos (+ theta2 theta1)) cylHeightShort )) (* (cos theta1) (/ cylHeightTall 4.0))) i)))
(setq endp (list (+ (/ a 2.0) (/ x 2.0)) +1.0 (+ (+ (- (* (cos theta1) (/ cylHeightTall 2.0)) (* (cos (+ theta2 theta1)) cylHeightShort )) (* (cos theta1) (/ cylHeightTall 4.0))) i)))
(ROTATE3D  ss1 stp endp theta1)
(setq ss1 (ssget "L"))
(cut_edge2 ss1 a)

;Diag Short element id=5
(setq center (vlax-3d-point (* a 0.25) 0 (+ (- (* (cos theta1) (/ cylHeightTall 2.0)) (* (cos (+ theta2 theta1)) (/ cylHeightShort 2.0))) i)))
(setq modelSpace (vla-get-ModelSpace (vla-get-ActiveDocument (vlax-get-acad-object))))
(vla-AddCylinder modelSpace center cylRadius cylHeightShort)
(setq ss1 (ssget "L"))
(setq stp (list (* a 0.25) +1.0 (+ (- (* (cos theta1) (/ cylHeightTall 2.0)) (* (cos (+ theta2 theta1)) (/ cylHeightShort 2.0))) i)))
(setq endp (list (* a 0.25) -1.0 (+ (- (* (cos theta1) (/ cylHeightTall 2.0)) (* (cos (+ theta2 theta1)) (/ cylHeightShort 2.0))) i)))
(ROTATE3D  ss1 stp endp (+ theta1 theta2))

;Diag Short element id=6
(setq center (vlax-3d-point (* a 0.75) 0 (+ (- (* (cos theta1) (/ cylHeightTall 2.0)) (* (cos (+ theta2 theta1)) (/ cylHeightShort 2.0))) i)))
(setq modelSpace (vla-get-ModelSpace (vla-get-ActiveDocument (vlax-get-acad-object))))
(vla-AddCylinder modelSpace center cylRadius cylHeightShort)
(setq ss1 (ssget "L"))
(setq stp (list (* a 0.75) -1.0 (+ (- (* (cos theta1) (/ cylHeightTall 2.0)) (* (cos (+ theta2 theta1)) (/ cylHeightShort 2.0))) i)))
(setq endp (list (* a 0.75) +1.0 (+ (- (* (cos theta1) (/ cylHeightTall 2.0)) (* (cos (+ theta2 theta1)) (/ cylHeightShort 2.0))) i)))
(ROTATE3D  ss1 stp endp (+ theta1 theta2))

;Sphere id=7
(setq center (vlax-3d-point 0 0 (+ (* (cos theta1) (/ cylHeightTall 2.0)) i)))
(vla-AddSphere modelSpace center cylRadius)
(setq ss1 (ssget "L"))

;Sphere id=8
(setq center (vlax-3d-point a 0 (+ (* (cos theta1) (/ cylHeightTall 2.0)) i)))
(vla-AddSphere modelSpace center cylRadius)
(setq ss1 (ssget "L"))

;Sphere id=9
(setq center (vlax-3d-point (/ a 2.0) 0 (+ (- (* (cos theta1) (/ cylHeightTall 2.0)) (* (cos (+ theta2 theta1)) cylHeightShort)) i)))
(vla-AddSphere modelSpace center cylRadius)
(setq ss1 (ssget "L"))

;YZ Face Front
;Bot Tall element id=10
(setq center (vlax-3d-point 0 (/ x 2.0) (/ cylHeightTall 4.0)))
(vla-AddCylinder modelSpace center cylRadius (/ cylHeightTall 2.0))

(setq ss1 (ssget "L"))
(setq stp (list -1.0 (/ x 2.0) (/ cylHeightTall 4.0)))
(setq endp (list 1.0 (/ x 2.0) (/ cylHeightTall 4.0)))
(ROTATE3D  ss1 stp endp theta1)
(setq ss1 (ssget "L"))
(cut_edge1 ss1 a)

;Bot Tall element id=11
(setq center (vlax-3d-point 0 (- a (/ x 2.0)) (/ cylHeightTall 4.0)))
(vla-AddCylinder modelSpace center cylRadius (/ cylHeightTall 2.0))
(setq ss1 (ssget "L"))
(setq stp (list 1.0 (- a (/ x 2.0)) (/ cylHeightTall 4.0)))
(setq endp (list -1.0 (- a (/ x 2.0)) (/ cylHeightTall 4.0)))
(ROTATE3D  ss1 stp endp theta1)
(setq ss1 (ssget "L"))
(cut_edge1 ss1 a)

;Top Tall element id=12
(setq center (vlax-3d-point 0 (- (/ a 2.0) (/ x 2.0)) (+ (+ (- (* (cos theta1) (/ cylHeightTall 2.0)) (* (cos (+ theta2 theta1)) cylHeightShort )) (* (cos theta1) (/ cylHeightTall 4.0))) i)))
(vla-AddCylinder modelSpace center cylRadius (/ cylHeightTall 2.0))
(setq ss1 (ssget "L"))
(setq stp (list  -1.0 (- (/ a 2.0) (/ x 2.0)) (+ (+ (- (* (cos theta1) (/ cylHeightTall 2.0)) (* (cos (+ theta2 theta1)) cylHeightShort )) (* (cos theta1) (/ cylHeightTall 4.0))) i)))
(setq endp (list 1.0 (- (/ a 2.0) (/ x 2.0)) (+ (+ (- (* (cos theta1) (/ cylHeightTall 2.0)) (* (cos (+ theta2 theta1)) cylHeightShort )) (* (cos theta1) (/ cylHeightTall 4.0))) i)))
(ROTATE3D  ss1 stp endp theta1)
(setq ss1 (ssget "L"))
(cut_edge2 ss1 a)

;Top Tall element id=13
(setq center (vlax-3d-point 0 (+ (/ a 2.0) (/ x 2.0)) (+ (+ (- (* (cos theta1) (/ cylHeightTall 2.0)) (* (cos (+ theta2 theta1)) cylHeightShort )) (* (cos theta1) (/ cylHeightTall 4.0))) i)))
(vla-AddCylinder modelSpace center cylRadius (/ cylHeightTall 2.0))
(setq ss1 (ssget "L"))
(setq stp (list  1.0 (+ (/ a 2.0) (/ x 2.0)) (+ (+ (- (* (cos theta1) (/ cylHeightTall 2.0)) (* (cos (+ theta2 theta1)) cylHeightShort )) (* (cos theta1) (/ cylHeightTall 4.0))) i)))
(setq endp (list -1.0 (+ (/ a 2.0) (/ x 2.0)) (+ (+ (- (* (cos theta1) (/ cylHeightTall 2.0)) (* (cos (+ theta2 theta1)) cylHeightShort )) (* (cos theta1) (/ cylHeightTall 4.0))) i)))
(ROTATE3D  ss1 stp endp theta1)
(setq ss1 (ssget "L"))
(cut_edge2 ss1 a)

;Diag Short element id=14
(setq center (vlax-3d-point 0 (* a 0.25) (+ (- (* (cos theta1) (/ cylHeightTall 2.0)) (* (cos (+ theta2 theta1)) (/ cylHeightShort 2.0))) i)))
(vla-AddCylinder modelSpace center cylRadius cylHeightShort)
(setq ss1 (ssget "L"))
(setq stp (list -1.0 (* a 0.25) (+ (- (* (cos theta1) (/ cylHeightTall 2.0)) (* (cos (+ theta2 theta1)) (/ cylHeightShort 2.0))) i)))
(setq endp (list 1.0 (* a 0.25) (+ (- (* (cos theta1) (/ cylHeightTall 2.0)) (* (cos (+ theta2 theta1)) (/ cylHeightShort 2.0))) i)))
(ROTATE3D  ss1 stp endp (+ theta1 theta2))

;Diag Short element id=15
(setq center (vlax-3d-point 0 (* a 0.75) (+ (- (* (cos theta1) (/ cylHeightTall 2.0)) (* (cos (+ theta2 theta1)) (/ cylHeightShort 2.0))) i)))
(vla-AddCylinder modelSpace center cylRadius cylHeightShort)
(setq ss1 (ssget "L"))
(setq stp (list +1.0 (* a 0.75) (+ (- (* (cos theta1) (/ cylHeightTall 2.0)) (* (cos (+ theta2 theta1)) (/ cylHeightShort 2.0))) i)))
(setq endp (list -1.0 (* a 0.75) (+ (- (* (cos theta1) (/ cylHeightTall 2.0)) (* (cos (+ theta2 theta1)) (/ cylHeightShort 2.0))) i)))
(ROTATE3D  ss1 stp endp (+ theta1 theta2))

;Sphere id=16
(setq center (vlax-3d-point 0 a (+ (* (cos theta1) (/ cylHeightTall 2.0)) i)))
(vla-AddSphere modelSpace center cylRadius)
(setq ss1 (ssget "L"))

;Sphere id=17
(setq center (vlax-3d-point 0 (/ a 2.0) (+ (- (* (cos theta1) (/ cylHeightTall 2.0)) (* (cos (+ theta2 theta1)) cylHeightShort)) i)))
(vla-AddSphere modelSpace center cylRadius)
(setq ss1 (ssget "L"))

;XZ Face Back
;Bot Tall element id=18
(setq center (vlax-3d-point (/ x 2.0) a (/ cylHeightTall 4.0)))
(setq modelSpace (vla-get-ModelSpace (vla-get-ActiveDocument (vlax-get-acad-object))))
(vla-AddCylinder modelSpace center cylRadius (/ cylHeightTall 2.0))
(setq ss1 (ssget "L"))
(setq stp (list (/ x 2.0) 1.0 (/ cylHeightTall 4.0)))
(setq endp (list (/ x 2.0) -1.0 (/ cylHeightTall 4.0)))
(ROTATE3D  ss1 stp endp theta1)
(setq ss1 (ssget "L"))
(cut_edge1 ss1 a)

;Bot Tall element id=19
(setq center (vlax-3d-point (- a (/ x 2.0)) a (/ cylHeightTall 4.0)))
(setq modelSpace (vla-get-ModelSpace (vla-get-ActiveDocument (vlax-get-acad-object))))
(vla-AddCylinder modelSpace center cylRadius (/ cylHeightTall 2.0))
(setq ss1 (ssget "L"))
(setq stp (list (- a (/ x 2.0)) -1.0 (/ cylHeightTall 4.0)))
(setq endp (list (- a (/ x 2.0)) 1.0 (/ cylHeightTall 4.0)))
(ROTATE3D  ss1 stp endp theta1)
(setq ss1 (ssget "L"))
(cut_edge1 ss1 a)

;Top Tall element id=20
(setq center (vlax-3d-point (- (/ a 2.0) (/ x 2.0)) a (+ (+ (- (* (cos theta1) (/ cylHeightTall 2.0)) (* (cos (+ theta2 theta1)) cylHeightShort )) (* (cos theta1) (/ cylHeightTall 4.0))) i)))
(vla-AddCylinder modelSpace center cylRadius (/ cylHeightTall 2.0))
(setq ss1 (ssget "L"))
(setq stp (list (- (/ a 2.0) (/ x 2.0)) 1.0 (+ (+ (- (* (cos theta1) (/ cylHeightTall 2.0)) (* (cos (+ theta2 theta1)) cylHeightShort )) (* (cos theta1) (/ cylHeightTall 4.0))) i)))
(setq endp (list (- (/ a 2.0) (/ x 2.0)) -1.0 (+ (+ (- (* (cos theta1) (/ cylHeightTall 2.0)) (* (cos (+ theta2 theta1)) cylHeightShort )) (* (cos theta1) (/ cylHeightTall 4.0))) i)))
(ROTATE3D  ss1 stp endp theta1)
(setq ss1 (ssget "L"))
(cut_edge2 ss1 a)

;Top Tall element id=21
(setq center (vlax-3d-point (+ (/ a 2.0) (/ x 2.0)) a (+ (+ (- (* (cos theta1) (/ cylHeightTall 2.0)) (* (cos (+ theta2 theta1)) cylHeightShort )) (* (cos theta1) (/ cylHeightTall 4.0))) i)))
(vla-AddCylinder modelSpace center cylRadius (/ cylHeightTall 2.0))
(setq ss1 (ssget "L"))
(setq stp (list (+ (/ a 2.0) (/ x 2.0)) -1.0 (+ (+ (- (* (cos theta1) (/ cylHeightTall 2.0)) (* (cos (+ theta2 theta1)) cylHeightShort )) (* (cos theta1) (/ cylHeightTall 4.0))) i)))
(setq endp (list (+ (/ a 2.0) (/ x 2.0)) +1.0 (+ (+ (- (* (cos theta1) (/ cylHeightTall 2.0)) (* (cos (+ theta2 theta1)) cylHeightShort )) (* (cos theta1) (/ cylHeightTall 4.0))) i)))
(ROTATE3D  ss1 stp endp theta1)
(setq ss1 (ssget "L"))
(cut_edge2 ss1 a)

;Diag Short element id=22
(setq center (vlax-3d-point (* a 0.25) a (+ (- (* (cos theta1) (/ cylHeightTall 2.0)) (* (cos (+ theta2 theta1)) (/ cylHeightShort 2.0))) i)))
(setq modelSpace (vla-get-ModelSpace (vla-get-ActiveDocument (vlax-get-acad-object))))
(vla-AddCylinder modelSpace center cylRadius cylHeightShort)
(setq ss1 (ssget "L"))
(setq stp (list (* a 0.25) +1.0 (+ (- (* (cos theta1) (/ cylHeightTall 2.0)) (* (cos (+ theta2 theta1)) (/ cylHeightShort 2.0))) i)))
(setq endp (list (* a 0.25) -1.0 (+ (- (* (cos theta1) (/ cylHeightTall 2.0)) (* (cos (+ theta2 theta1)) (/ cylHeightShort 2.0))) i)))
(ROTATE3D  ss1 stp endp (+ theta1 theta2))

;Diag Short element id=23
(setq center (vlax-3d-point (* a 0.75) a (+ (- (* (cos theta1) (/ cylHeightTall 2.0)) (* (cos (+ theta2 theta1)) (/ cylHeightShort 2.0))) i)))
(setq modelSpace (vla-get-ModelSpace (vla-get-ActiveDocument (vlax-get-acad-object))))
(vla-AddCylinder modelSpace center cylRadius cylHeightShort)
(setq ss1 (ssget "L"))
(setq stp (list (* a 0.75) -1.0 (+ (- (* (cos theta1) (/ cylHeightTall 2.0)) (* (cos (+ theta2 theta1)) (/ cylHeightShort 2.0))) i)))
(setq endp (list (* a 0.75) +1.0 (+ (- (* (cos theta1) (/ cylHeightTall 2.0)) (* (cos (+ theta2 theta1)) (/ cylHeightShort 2.0))) i)))
(ROTATE3D  ss1 stp endp (+ theta1 theta2))

;Sphere id=24
(setq center (vlax-3d-point a a (+ (* (cos theta1) (/ cylHeightTall 2.0)) i)))
(vla-AddSphere modelSpace center cylRadius)
(setq ss1 (ssget "L"))

;Sphere id=25
(setq center (vlax-3d-point (/ a 2.0) a (+ (- (* (cos theta1) (/ cylHeightTall 2.0)) (* (cos (+ theta2 theta1)) cylHeightShort)) i)))
(vla-AddSphere modelSpace center cylRadius)
(setq ss1 (ssget "L"))

;YZ Face Back
;Bot Tall element id=26
(setq center (vlax-3d-point a (/ x 2.0) (/ cylHeightTall 4.0)))
(vla-AddCylinder modelSpace center cylRadius (/ cylHeightTall 2.0))
(setq ss1 (ssget "L"))
(setq stp (list -1.0 (/ x 2.0) (/ cylHeightTall 4.0)))
(setq endp (list 1.0 (/ x 2.0) (/ cylHeightTall 4.0)))
(ROTATE3D  ss1 stp endp theta1)
(setq ss1 (ssget "L"))
(cut_edge1 ss1 a)

;Bot Tall element id=27
(setq center (vlax-3d-point a (- a (/ x 2.0)) (/ cylHeightTall 4.0)))
(vla-AddCylinder modelSpace center cylRadius (/ cylHeightTall 2.0))
(setq ss1 (ssget "L"))
(setq stp (list 1.0 (- a (/ x 2.0)) (/ cylHeightTall 4.0)))
(setq endp (list -1.0 (- a (/ x 2.0)) (/ cylHeightTall 4.0)))
(ROTATE3D  ss1 stp endp theta1)
(setq ss1 (ssget "L"))
(cut_edge1 ss1 a)

;Top Tall element id=28
(setq center (vlax-3d-point a (- (/ a 2.0) (/ x 2.0)) (+ (+ (- (* (cos theta1) (/ cylHeightTall 2.0)) (* (cos (+ theta2 theta1)) cylHeightShort )) (* (cos theta1) (/ cylHeightTall 4.0))) i)))
(vla-AddCylinder modelSpace center cylRadius (/ cylHeightTall 2.0))
(setq ss1 (ssget "L"))
(setq stp (list  -1.0 (- (/ a 2.0) (/ x 2.0)) (+ (+ (- (* (cos theta1) (/ cylHeightTall 2.0)) (* (cos (+ theta2 theta1)) cylHeightShort )) (* (cos theta1) (/ cylHeightTall 4.0))) i)))
(setq endp (list 1.0 (- (/ a 2.0) (/ x 2.0)) (+ (+ (- (* (cos theta1) (/ cylHeightTall 2.0)) (* (cos (+ theta2 theta1)) cylHeightShort )) (* (cos theta1) (/ cylHeightTall 4.0))) i)))
(ROTATE3D  ss1 stp endp theta1)
(setq ss1 (ssget "L"))
(cut_edge2 ss1 a)

;Top Tall element id=29
(setq center (vlax-3d-point a (+ (/ a 2.0) (/ x 2.0)) (+ (+ (- (* (cos theta1) (/ cylHeightTall 2.0)) (* (cos (+ theta2 theta1)) cylHeightShort )) (* (cos theta1) (/ cylHeightTall 4.0))) i)))
(vla-AddCylinder modelSpace center cylRadius (/ cylHeightTall 2.0))
(setq ss1 (ssget "L"))
(setq stp (list  1.0 (+ (/ a 2.0) (/ x 2.0)) (+ (+ (- (* (cos theta1) (/ cylHeightTall 2.0)) (* (cos (+ theta2 theta1)) cylHeightShort )) (* (cos theta1) (/ cylHeightTall 4.0))) i)))
(setq endp (list -1.0 (+ (/ a 2.0) (/ x 2.0)) (+ (+ (- (* (cos theta1) (/ cylHeightTall 2.0)) (* (cos (+ theta2 theta1)) cylHeightShort )) (* (cos theta1) (/ cylHeightTall 4.0))) i)))
(ROTATE3D  ss1 stp endp theta1)
(setq ss1 (ssget "L"))
(cut_edge2 ss1 a)


;Diag Short element id=30
(setq center (vlax-3d-point a (* a 0.25) (+ (- (* (cos theta1) (/ cylHeightTall 2.0)) (* (cos (+ theta2 theta1)) (/ cylHeightShort 2.0))) i)))
(vla-AddCylinder modelSpace center cylRadius cylHeightShort)
(setq ss1 (ssget "L"))
(setq stp (list -1.0 (* a 0.25) (+ (- (* (cos theta1) (/ cylHeightTall 2.0)) (* (cos (+ theta2 theta1)) (/ cylHeightShort 2.0))) i)))
(setq endp (list 1.0 (* a 0.25) (+ (- (* (cos theta1) (/ cylHeightTall 2.0)) (* (cos (+ theta2 theta1)) (/ cylHeightShort 2.0))) i)))
(ROTATE3D  ss1 stp endp (+ theta1 theta2))

;Diag Short element id=31
(setq center (vlax-3d-point a (* a 0.75) (+ (- (* (cos theta1) (/ cylHeightTall 2.0)) (* (cos (+ theta2 theta1)) (/ cylHeightShort 2.0))) i)))
(vla-AddCylinder modelSpace center cylRadius cylHeightShort)
(setq ss1 (ssget "L"))
(setq stp (list +1.0 (* a 0.75) (+ (- (* (cos theta1) (/ cylHeightTall 2.0)) (* (cos (+ theta2 theta1)) (/ cylHeightShort 2.0))) i)))
(setq endp (list -1.0 (* a 0.75) (+ (- (* (cos theta1) (/ cylHeightTall 2.0)) (* (cos (+ theta2 theta1)) (/ cylHeightShort 2.0))) i)))
(ROTATE3D  ss1 stp endp (+ theta1 theta2))

;Sphere id=32
(setq center (vlax-3d-point a a (+ (* (cos theta1) (/ cylHeightTall 2.0)) i)))
(vla-AddSphere modelSpace center cylRadius)
(setq ss1 (ssget "L"))

;Sphere id=33
(setq center (vlax-3d-point a (/ a 2.0) (+ (- (* (cos theta1) (/ cylHeightTall 2.0)) (* (cos (+ theta2 theta1)) cylHeightShort)) i)))
(vla-AddSphere modelSpace center cylRadius)
(setq ss1 (ssget "L"))

;Flat Fillets & Cuts
;Bottom Fillet id=34
(setq center (vlax-3d-point  (/ x 2.0) 0 (- 0 (/ cylHeightTall 4.0))))
(setq modelSpace (vla-get-ModelSpace (vla-get-ActiveDocument (vlax-get-acad-object))))
(vla-AddCylinder modelSpace center cylRadius (/ cylHeightTall 2.0))
(setq ss1 (ssget "L"))
(setq stp (list (/ x 2.0) 1.0 (/ cylHeightTall 4.0)))
(setq endp (list (/ x 2.0) -1.0 (/ cylHeightTall 4.0)))
(ROTATE3D  ss1 stp endp theta1)
(setq ss1 (ssget "L"))
(cut_edge1 ss1 a)

;Bottom Fillet id=34
(setq center (vlax-3d-point (- a (/ x 2.0)) 0 (- 0 (/ cylHeightTall 4.0))))
(setq modelSpace (vla-get-ModelSpace (vla-get-ActiveDocument (vlax-get-acad-object))))
(vla-AddCylinder modelSpace center cylRadius (/ cylHeightTall 2.0))
(setq ss1 (ssget "L"))
(setq stp (list (- a (/ x 2.0)) -1.0 (/ cylHeightTall 4.0)))
(setq endp (list (- a (/ x 2.0)) 1.0 (/ cylHeightTall 4.0)))
(ROTATE3D  ss1 stp endp theta1)
(setq ss1 (ssget "L"))
(cut_edge1 ss1 a)

;Bottom Fillet id=35
(setq center (vlax-3d-point 0 (/ x 2.0) (- 0 (/ cylHeightTall 4.0))))
(vla-AddCylinder modelSpace center cylRadius (/ cylHeightTall 2.0))
(setq ss1 (ssget "L"))
(setq stp (list -1.0 (/ x 2.0) (/ cylHeightTall 4.0)))
(setq endp (list 1.0 (/ x 2.0) (/ cylHeightTall 4.0)))
(ROTATE3D  ss1 stp endp theta1)
(setq ss1 (ssget "L"))
(cut_edge1 ss1 a)

;Bottom Fillet id=36
(setq center (vlax-3d-point 0 (- a (/ x 2.0)) (- 0 (/ cylHeightTall 4.0))))
(vla-AddCylinder modelSpace center cylRadius (/ cylHeightTall 2.0))
(setq ss1 (ssget "L"))
(setq stp (list 1.0 (- a (/ x 2.0)) (/ cylHeightTall 4.0)))
(setq endp (list -1.0 (- a (/ x 2.0)) (/ cylHeightTall 4.0)))
(ROTATE3D  ss1 stp endp theta1)
(setq ss1 (ssget "L"))
(cut_edge1 ss1 a)

;Bottom Fillet id=37
(setq center (vlax-3d-point (/ x 2.0) a (- 0 (/ cylHeightTall 4.0))))
(vla-AddCylinder modelSpace center cylRadius (/ cylHeightTall 2.0))
(setq ss1 (ssget "L"))
(setq stp (list (/ x 2.0) 1.0 (/ cylHeightTall 4.0)))
(setq endp (list (/ x 2.0) -1.0 (/ cylHeightTall 4.0)))
(ROTATE3D  ss1 stp endp theta1)
(setq ss1 (ssget "L"))
(cut_edge1 ss1 a)

;Bottom Fillet id=38
(setq center (vlax-3d-point (- a (/ x 2.0)) a (- 0 (/ cylHeightTall 4.0))))
(setq modelSpace (vla-get-ModelSpace (vla-get-ActiveDocument (vlax-get-acad-object))))
(vla-AddCylinder modelSpace center cylRadius (/ cylHeightTall 2.0))
(setq ss1 (ssget "L"))
(setq stp (list (- a (/ x 2.0)) -1.0 (/ cylHeightTall 4.0)))
(setq endp (list (- a (/ x 2.0)) 1.0 (/ cylHeightTall 4.0)))
(ROTATE3D  ss1 stp endp theta1)
(setq ss1 (ssget "L"))
(cut_edge1 ss1 a)

;Bottom Fillet id=39
(setq center (vlax-3d-point a (/ x 2.0) (- 0 (/ cylHeightTall 4.0))))
(vla-AddCylinder modelSpace center cylRadius (/ cylHeightTall 2.0))
(setq ss1 (ssget "L"))
(setq stp (list -1.0 (/ x 2.0) (/ cylHeightTall 4.0)))
(setq endp (list 1.0 (/ x 2.0) (/ cylHeightTall 4.0)))
(ROTATE3D  ss1 stp endp theta1)
(setq ss1 (ssget "L"))
(cut_edge1 ss1 a)

;Bottom Fillet id=40
(setq center (vlax-3d-point a (- a (/ x 2.0)) (- 0 (/ cylHeightTall 4.0))))
(vla-AddCylinder modelSpace center cylRadius (/ cylHeightTall 2.0))
(setq ss1 (ssget "L"))
(setq stp (list 1.0 (- a (/ x 2.0)) (/ cylHeightTall 4.0)))
(setq endp (list -1.0 (- a (/ x 2.0)) (/ cylHeightTall 4.0)))
(ROTATE3D  ss1 stp endp theta1)
(setq ss1 (ssget "L"))
(cut_edge1 ss1 a)

;Top Fillet id=41
(setq center (vlax-3d-point (- (/ a 2.0) (/ x 2.0)) 0 (+ (+ (+ (- (* (cos theta1) (/ cylHeightTall 2.0)) (* (cos (+ theta2 theta1)) cylHeightShort )) (* (cos theta1) (/ cylHeightTall 4.0))) i) (/ cylHeightTall 4.0))))
(vla-AddCylinder modelSpace center cylRadius (/ cylHeightTall 2.0))
(setq ss1 (ssget "L"))
(setq stp (list (- (/ a 2.0) (/ x 2.0)) 1.0 (+ (+ (- (* (cos theta1) (/ cylHeightTall 2.0)) (* (cos (+ theta2 theta1)) cylHeightShort )) (* (cos theta1) (/ cylHeightTall 4.0))) i)))
(setq endp (list (- (/ a 2.0) (/ x 2.0)) -1.0 (+ (+ (- (* (cos theta1) (/ cylHeightTall 2.0)) (* (cos (+ theta2 theta1)) cylHeightShort )) (* (cos theta1) (/ cylHeightTall 4.0))) i)))
(ROTATE3D  ss1 stp endp theta1)
(setq ss1 (ssget "L"))
(cut_edge2 ss1 a)

;Top Fillet id=42
(setq center (vlax-3d-point (+ (/ a 2.0) (/ x 2.0)) 0 (+ (+ (+ (- (* (cos theta1) (/ cylHeightTall 2.0)) (* (cos (+ theta2 theta1)) cylHeightShort )) (* (cos theta1) (/ cylHeightTall 4.0))) i) (/ cylHeightTall 4.0))))
(vla-AddCylinder modelSpace center cylRadius (/ cylHeightTall 2.0))
(setq ss1 (ssget "L"))
(setq stp (list (+ (/ a 2.0) (/ x 2.0)) -1.0 (+ (+ (- (* (cos theta1) (/ cylHeightTall 2.0)) (* (cos (+ theta2 theta1)) cylHeightShort )) (* (cos theta1) (/ cylHeightTall 4.0))) i)))
(setq endp (list (+ (/ a 2.0) (/ x 2.0)) +1.0 (+ (+ (- (* (cos theta1) (/ cylHeightTall 2.0)) (* (cos (+ theta2 theta1)) cylHeightShort )) (* (cos theta1) (/ cylHeightTall 4.0))) i)))
(ROTATE3D  ss1 stp endp theta1)
(setq ss1 (ssget "L"))
(cut_edge2 ss1 a)

;Top Fillet id=43
(setq center (vlax-3d-point 0 (- (/ a 2.0) (/ x 2.0)) (+ (+ (+ (- (* (cos theta1) (/ cylHeightTall 2.0)) (* (cos (+ theta2 theta1)) cylHeightShort )) (* (cos theta1) (/ cylHeightTall 4.0))) i) (/ cylHeightTall 4.0))))
(vla-AddCylinder modelSpace center cylRadius (/ cylHeightTall 2.0))
(setq ss1 (ssget "L"))
(setq stp (list  -1.0 (- (/ a 2.0) (/ x 2.0)) (+ (+ (- (* (cos theta1) (/ cylHeightTall 2.0)) (* (cos (+ theta2 theta1)) cylHeightShort )) (* (cos theta1) (/ cylHeightTall 4.0))) i)))
(setq endp (list 1.0 (- (/ a 2.0) (/ x 2.0)) (+ (+ (- (* (cos theta1) (/ cylHeightTall 2.0)) (* (cos (+ theta2 theta1)) cylHeightShort )) (* (cos theta1) (/ cylHeightTall 4.0))) i)))
(ROTATE3D  ss1 stp endp theta1)
(setq ss1 (ssget "L"))
(cut_edge2 ss1 a)

;Top Fillet id=44
(setq center (vlax-3d-point 0 (+ (/ a 2.0) (/ x 2.0)) (+ (+ (+ (- (* (cos theta1) (/ cylHeightTall 2.0)) (* (cos (+ theta2 theta1)) cylHeightShort )) (* (cos theta1) (/ cylHeightTall 4.0))) i) (/ cylHeightTall 4.0))))
(vla-AddCylinder modelSpace center cylRadius (/ cylHeightTall 2.0))
(setq ss1 (ssget "L"))
(setq stp (list  1.0 (+ (/ a 2.0) (/ x 2.0)) (+ (+ (- (* (cos theta1) (/ cylHeightTall 2.0)) (* (cos (+ theta2 theta1)) cylHeightShort )) (* (cos theta1) (/ cylHeightTall 4.0))) i)))
(setq endp (list -1.0 (+ (/ a 2.0) (/ x 2.0)) (+ (+ (- (* (cos theta1) (/ cylHeightTall 2.0)) (* (cos (+ theta2 theta1)) cylHeightShort )) (* (cos theta1) (/ cylHeightTall 4.0))) i)))
(ROTATE3D  ss1 stp endp theta1)
(setq ss1 (ssget "L"))
(cut_edge2 ss1 a)

;Top Fillet id=45
(setq center (vlax-3d-point (- (/ a 2.0) (/ x 2.0)) a (+ (+ (+ (- (* (cos theta1) (/ cylHeightTall 2.0)) (* (cos (+ theta2 theta1)) cylHeightShort )) (* (cos theta1) (/ cylHeightTall 4.0))) i) (/ cylHeightTall 4.0))))
(vla-AddCylinder modelSpace center cylRadius (/ cylHeightTall 2.0))
(setq ss1 (ssget "L"))
(setq stp (list (- (/ a 2.0) (/ x 2.0)) 1.0 (+ (+ (- (* (cos theta1) (/ cylHeightTall 2.0)) (* (cos (+ theta2 theta1)) cylHeightShort )) (* (cos theta1) (/ cylHeightTall 4.0))) i)))
(setq endp (list (- (/ a 2.0) (/ x 2.0)) -1.0 (+ (+ (- (* (cos theta1) (/ cylHeightTall 2.0)) (* (cos (+ theta2 theta1)) cylHeightShort )) (* (cos theta1) (/ cylHeightTall 4.0))) i)))
(ROTATE3D  ss1 stp endp theta1)
(setq ss1 (ssget "L"))
(cut_edge2 ss1 a)

;Top Fillet id=46
(setq center (vlax-3d-point (+ (/ a 2.0) (/ x 2.0)) a (+ (+ (+ (- (* (cos theta1) (/ cylHeightTall 2.0)) (* (cos (+ theta2 theta1)) cylHeightShort )) (* (cos theta1) (/ cylHeightTall 4.0))) i) (/ cylHeightTall 4.0))))
(vla-AddCylinder modelSpace center cylRadius (/ cylHeightTall 2.0))
(setq ss1 (ssget "L"))
(setq stp (list (+ (/ a 2.0) (/ x 2.0)) -1.0 (+ (+ (- (* (cos theta1) (/ cylHeightTall 2.0)) (* (cos (+ theta2 theta1)) cylHeightShort )) (* (cos theta1) (/ cylHeightTall 4.0))) i)))
(setq endp (list (+ (/ a 2.0) (/ x 2.0)) +1.0 (+ (+ (- (* (cos theta1) (/ cylHeightTall 2.0)) (* (cos (+ theta2 theta1)) cylHeightShort )) (* (cos theta1) (/ cylHeightTall 4.0))) i)))
(ROTATE3D  ss1 stp endp theta1)
(setq ss1 (ssget "L"))
(cut_edge2 ss1 a)

;Top Fillet id=47
(setq center (vlax-3d-point a (- (/ a 2.0) (/ x 2.0)) (+ (+ (+ (- (* (cos theta1) (/ cylHeightTall 2.0)) (* (cos (+ theta2 theta1)) cylHeightShort )) (* (cos theta1) (/ cylHeightTall 4.0))) i) (/ cylHeightTall 4.0))))
(vla-AddCylinder modelSpace center cylRadius (/ cylHeightTall 2.0))
(setq ss1 (ssget "L"))
(setq stp (list  -1.0 (- (/ a 2.0) (/ x 2.0)) (+ (+ (- (* (cos theta1) (/ cylHeightTall 2.0)) (* (cos (+ theta2 theta1)) cylHeightShort )) (* (cos theta1) (/ cylHeightTall 4.0))) i)))
(setq endp (list 1.0 (- (/ a 2.0) (/ x 2.0)) (+ (+ (- (* (cos theta1) (/ cylHeightTall 2.0)) (* (cos (+ theta2 theta1)) cylHeightShort )) (* (cos theta1) (/ cylHeightTall 4.0))) i)))
(ROTATE3D  ss1 stp endp theta1)
(setq ss1 (ssget "L"))
(cut_edge2 ss1 a)

;Top Fillet id=48
(setq center (vlax-3d-point a (+ (/ a 2.0) (/ x 2.0)) (+ (+ (+ (- (* (cos theta1) (/ cylHeightTall 2.0)) (* (cos (+ theta2 theta1)) cylHeightShort )) (* (cos theta1) (/ cylHeightTall 4.0))) i) (/ cylHeightTall 4.0))))
(vla-AddCylinder modelSpace center cylRadius (/ cylHeightTall 2.0))
(setq ss1 (ssget "L"))
(setq stp (list  1.0 (+ (/ a 2.0) (/ x 2.0)) (+ (+ (- (* (cos theta1) (/ cylHeightTall 2.0)) (* (cos (+ theta2 theta1)) cylHeightShort )) (* (cos theta1) (/ cylHeightTall 4.0))) i)))
(setq endp (list -1.0 (+ (/ a 2.0) (/ x 2.0)) (+ (+ (- (* (cos theta1) (/ cylHeightTall 2.0)) (* (cos (+ theta2 theta1)) cylHeightShort )) (* (cos theta1) (/ cylHeightTall 4.0))) i)))
(ROTATE3D  ss1 stp endp theta1)
(setq ss1 (ssget "L"))
(cut_edge2 ss1 a)