;Vitalis, BT Tetragonal Unit Cell Design
;First change Autocad Units to radians

;import geometric data
(arxload "geom3d")
(setq L 6.7); 7.23mm for 75deg, 6.7mm for 80deg, 6.295mm for 85deg
(setq cylRadius 0.5)
(setq angle_set 1.39626);1.309 radians = 75deg, 1.39626 = 80deg, 1.48353 = 85deg radians, 1.5708 = 90deg
(setq n 4)
(setq m 5)

;define tan
(defun tan (num)
 (/ (sin
num)(cos num))
)

(vl-load-com) 

(setq factor (/ (tan angle_set) (- (* 4.0 (tan angle_set)) (* 4.0 (sin angle_set))))); factor between the size of vertical struts to the unitcell height
(setq a (/ L (* 2.0 factor))); x-axis length of the unit cell
(setq b (- a (* (* 2.0 factor) a)))
(setq x (* (* (* 4 (sin angle_set)) factor) a))
(setq y (* (* (* 4 (sin angle_set)) factor) a))
(setq z (+ (* (* 2 factor) a) (- 1 (* factor a))))

;first column id=1
(setq cylHeight_1 (* factor a))
(setq z_1 (/ cylHeight_1 2))
(setq center (vlax-3d-point 0 0 z_1))
(setq modelSpace (vla-get-ModelSpace (vla-get-ActiveDocument (vlax-get-acad-object))))
(vla-AddCylinder modelSpace center cylRadius cylHeight_1)
(setq ss1 (ssget "L"))

;second column id=2
(setq center (vlax-3d-point 0 (* (* (* 4 (sin angle_set)) factor) a) z_1))
(vla-AddCylinder modelSpace center cylRadius cylHeight_1)
(setq ss1 (ssget "L"))

;third column id=3
(setq center (vlax-3d-point (* (* (* 4 (sin angle_set)) factor) a) (* (* (* 4 (sin angle_set)) factor) a) z_1))
(vla-AddCylinder modelSpace center cylRadius cylHeight_1)
(setq ss1 (ssget "L"))

;forth column id=4
(setq center (vlax-3d-point (* (* (* 4 (sin angle_set)) factor) a) 0 z_1))
(vla-AddCylinder modelSpace center cylRadius cylHeight_1)
(setq ss1 (ssget "L"))

;fifth column id=5
(setq x_5 (* (* (* 2.0 (sin angle_set)) factor) a))
(setq center (vlax-3d-point x_5  x_5  z_1))
(vla-AddCylinder modelSpace center cylRadius cylHeight_1)

;diagonal elements
;calculate cylinder height
(setq cylHeight_diag (* 2 (* factor a)))

;calculate and place location for diagonal element id=6
(setq z_diag (- (* factor a) (/ (* (* (* 1.0 (sin angle_set)) factor) a) (tan angle_set))))
(setq center (vlax-3d-point (* (* (* 1.0 (sin angle_set)) factor) a)  0  z_diag))
(vla-AddCylinder modelSpace center cylRadius cylHeight_diag)

;rotate and cut
(setq ss1 (ssget "L"))
(setq stp (list (* (* (* 1.0 (sin angle_set)) factor) a)   1  z_diag))
(setq endp (list (* (* (* 1.0 (sin angle_set)) factor) a) -1  z_diag))
(ROTATE3D  ss1 stp endp angle_set)

;calculate and place location for diagonal element id=7
(setq center (vlax-3d-point (* (* (* 3.0 (sin angle_set)) factor) a)  0  z_diag))
(vla-AddCylinder modelSpace center cylRadius cylHeight_diag)

;rotate and cut
(setq ss1 (ssget "L"))
(setq stp (list (* (* (* 3.0 (sin angle_set)) factor) a)  -1.0  z_diag))
(setq endp (list (* (* (* 3.0 (sin angle_set)) factor) a)  1.0  z_diag))
(ROTATE3D  ss1 stp endp angle_set)

;calculate and place location for diagonal element id=8
(setq center (vlax-3d-point (* (* (* 1.0 (sin angle_set)) factor) a)  (* (* (* 4.0 (sin angle_set)) factor) a)  z_diag))
(vla-AddCylinder modelSpace center cylRadius cylHeight_diag)

;rotate abd cut
(setq ss1 (ssget "L"))
(setq stp (list (* (* (* 1.0 (sin angle_set)) factor) a)   1  z_diag))
(setq endp (list (* (* (* 1.0 (sin angle_set)) factor) a) -1  z_diag))
(ROTATE3D  ss1 stp endp angle_set)

;calculate and place location for diagonal element id=9
(setq center (vlax-3d-point (* (* (* 3.0 (sin angle_set)) factor) a)  (* (* (* 4.0 (sin angle_set)) factor) a)  z_diag))
(vla-AddCylinder modelSpace center cylRadius cylHeight_diag)

;rotate and cut
(setq ss1 (ssget "L"))
(setq stp (list (* (* (* 3.0 (sin angle_set)) factor) a)  -1  z_diag))
(setq endp (list (* (* (* 3.0 (sin angle_set)) factor) a)  1  z_diag))
(ROTATE3D  ss1 stp endp angle_set)

;calculate and place location for diagonal element id=10
(setq center (vlax-3d-point 0 (* (* (* 1.0 (sin angle_set)) factor) a)  z_diag))
(vla-AddCylinder modelSpace center cylRadius cylHeight_diag)

;rotate and cut
(setq ss1 (ssget "L"))
(setq stp (list  -1 (* (* (* 1.0 (sin angle_set)) factor) a)  z_diag))
(setq endp (list  1 (* (* (* 1.0 (sin angle_set)) factor) a) z_diag))
(ROTATE3D  ss1 stp endp angle_set)

;calculate and place location for diagonal element id=11
(setq center (vlax-3d-point 0 (* (* (* 3.0 (sin angle_set)) factor) a)  z_diag))
(vla-AddCylinder modelSpace center cylRadius cylHeight_diag)

;rotate and cut
(setq ss1 (ssget "L"))
(setq stp (list   1 (* (* (* 3.0 (sin angle_set)) factor) a)  z_diag))
(setq endp (list -1 (* (* (* 3.0 (sin angle_set)) factor) a)  z_diag))
(ROTATE3D  ss1 stp endp angle_set)

;calculate and place location for diagonal element id=12
(setq center (vlax-3d-point (* (* (* 4.0 (sin angle_set)) factor) a) (* (* (* 3.0 (sin angle_set)) factor) a)  z_diag))
(vla-AddCylinder modelSpace center cylRadius cylHeight_diag)

;rotate and cut
(setq ss1 (ssget "L"))
(setq stp (list   1 (* (* (* 3.0 (sin angle_set)) factor) a)  z_diag))
(setq endp (list -1 (* (* (* 3.0 (sin angle_set)) factor) a)  z_diag))
(ROTATE3D  ss1 stp endp angle_set)

;calculate and place location for diagonal element id=13
(setq center (vlax-3d-point (* (* (* 4.0 (sin angle_set)) factor) a) (* (* (* 1.0 (sin angle_set)) factor) a)  z_diag))
(vla-AddCylinder modelSpace center cylRadius cylHeight_diag)

;rotate nad cut
(setq ss1 (ssget "L"))
(setq stp (list  -1 (* (* (* 1.0 (sin angle_set)) factor) a)  z_diag))
(setq endp (list  1 (* (* (* 1.0 (sin angle_set)) factor) a)  z_diag))
(ROTATE3D  ss1 stp endp angle_set)

;calculate and place location for diagonal element id=14
(setq center (vlax-3d-point (* (* (* 1.0 (sin angle_set)) factor) a)  (* (* (* 2.0 (sin angle_set)) factor) a)  z_diag))
(vla-AddCylinder modelSpace center cylRadius cylHeight_diag)

;rotate
(setq ss1 (ssget "L"))
(setq stp (list (* (* (* 1.0 (sin angle_set)) factor) a)  -1  z_diag))
(setq endp (list (* (* (* 1.0 (sin angle_set)) factor) a)  1  z_diag))
(ROTATE3D  ss1 stp endp angle_set)

;calculate and place location for diagonal element id=15
(setq center (vlax-3d-point (* (* (* 3.0 (sin angle_set)) factor) a)  (* (* (* 2.0 (sin angle_set)) factor) a)  z_diag))
(vla-AddCylinder modelSpace center cylRadius cylHeight_diag)

;rotate
(setq ss1 (ssget "L"))
(setq stp  (list (* (* (* 3.0 (sin angle_set)) factor) a)  1  z_diag))
(setq endp (list (* (* (* 3.0 (sin angle_set)) factor) a) -1  z_diag))
(ROTATE3D  ss1 stp endp angle_set)

;calculate and place location for diagonal element id=16
(setq center (vlax-3d-point (* (* (* 2.0 (sin angle_set)) factor) a) (* (* (* 1.0 (sin angle_set)) factor) a)  z_diag))
(vla-AddCylinder modelSpace center cylRadius cylHeight_diag)

;rotate
(setq ss1 (ssget "L"))
(setq stp (list   1 (* (* (* 1.0 (sin angle_set)) factor) a)  z_diag))
(setq endp (list -1 (* (* (* 1.0 (sin angle_set)) factor) a)  z_diag))
(ROTATE3D  ss1 stp endp angle_set)

;calculate and place location for diagonal element id=17
(setq center (vlax-3d-point (* (* (* 2.0 (sin angle_set)) factor) a) (* (* (* 3.0 (sin angle_set)) factor) a)  z_diag))
(vla-AddCylinder modelSpace center cylRadius cylHeight_diag)

;rotate
(setq ss1 (ssget "L"))
(setq stp (list  -1 (* (* (* 3.0 (sin angle_set)) factor) a)  z_diag))
(setq endp (list  1 (* (* (* 3.0 (sin angle_set)) factor) a)  z_diag))
(ROTATE3D  ss1 stp endp angle_set)


;Upper section
;column id=18
(setq z_upper (- a (/ (* factor a) 2)))
(setq center (vlax-3d-point 0 0 z_upper))
(vla-AddCylinder modelSpace center cylRadius cylHeight_1)
(setq ss1 (ssget "L"))

;column id=19
(setq center (vlax-3d-point 0 (* (* (* 4.0 (sin angle_set)) factor) a) z_upper))
(vla-AddCylinder modelSpace center cylRadius cylHeight_1)
(setq ss1 (ssget "L"))

;column id=20
(setq center (vlax-3d-point (* (* (* 4.0 (sin angle_set)) factor) a) (* (* (* 4.0 (sin angle_set)) factor) a) z_upper))
(vla-AddCylinder modelSpace center cylRadius cylHeight_1)
(setq ss1 (ssget "L"))

;column id=21
(setq center (vlax-3d-point (* (* (* 4.0 (sin angle_set)) factor) a) 0 z_upper))
(vla-AddCylinder modelSpace center cylRadius cylHeight_1)
(setq ss1 (ssget "L"))

;column id=22
(setq center (vlax-3d-point (* (* (* 2.0 (sin angle_set)) factor) a) (* (* (* 2.0 (sin angle_set)) factor) a) z_upper))
(vla-AddCylinder modelSpace center cylRadius cylHeight_1)

;diagonal elements
;calculate and place location for diagonal element id=23
(setq z_diag_up  (+ (+ b (* factor a)) (/ (* (* (* 1.0 (sin angle_set)) factor) a) (tan angle_set))))
(setq center (vlax-3d-point (* (* (* 1.0 (sin angle_set)) factor) a)  0  z_diag_up))
(vla-AddCylinder modelSpace center cylRadius cylHeight_diag)

;rotate
(setq ss1 (ssget "L"))
(setq stp (list (* (* (* 1.0 (sin angle_set)) factor) a) -1  z_diag_up))
(setq endp (list (* (* (* 1.0 (sin angle_set)) factor) a) 1  z_diag_up))
(ROTATE3D  ss1 stp endp angle_set)

;calculate and place location for diagonal element id=24
(setq center (vlax-3d-point (* (* (* 3.0 (sin angle_set)) factor) a)  0  z_diag_up))
(vla-AddCylinder modelSpace center cylRadius cylHeight_diag)

;rotate
(setq ss1 (ssget "L"))
(setq stp (list (* (* (* 3.0 (sin angle_set)) factor) a)   1  z_diag_up))
(setq endp (list (* (* (* 3.0 (sin angle_set)) factor) a) -1  z_diag_up))
(ROTATE3D  ss1 stp endp angle_set)

;calculate and place location for diagonal element id=25
(setq center (vlax-3d-point (* (* (* 1.0 (sin angle_set)) factor) a)  (* (* (* 4.0 (sin angle_set)) factor) a)  z_diag_up))
(vla-AddCylinder modelSpace center cylRadius cylHeight_diag)

;rotate
(setq ss1 (ssget "L"))
(setq stp (list (* (* (* 1.0 (sin angle_set)) factor) a)  -1  z_diag_up))
(setq endp (list (* (* (* 1.0 (sin angle_set)) factor) a)  1  z_diag_up))
(ROTATE3D  ss1 stp endp angle_set)

;calculate and place location for diagonal element id=26
(setq center (vlax-3d-point (* (* (* 3.0 (sin angle_set)) factor) a)  (* (* (* 4.0 (sin angle_set)) factor) a)  z_diag_up))
(vla-AddCylinder modelSpace center cylRadius cylHeight_diag)

;rotate
(setq ss1 (ssget "L"))
(setq stp (list (* (* (* 3.0 (sin angle_set)) factor) a)   1  z_diag_up))
(setq endp (list (* (* (* 3.0 (sin angle_set)) factor) a) -1  z_diag_up))
(ROTATE3D  ss1 stp endp angle_set)

;calculate and place location for diagonal element id=27
(setq center (vlax-3d-point 0 (* (* (* 1.0 (sin angle_set)) factor) a)  z_diag_up))
(vla-AddCylinder modelSpace center cylRadius cylHeight_diag)

;rotate
(setq ss1 (ssget "L"))
(setq stp  (list 1 (* (* (* 1.0 (sin angle_set)) factor) a) z_diag_up))
(setq endp (list -1  (* (* (* 1.0 (sin angle_set)) factor) a) z_diag_up))
(ROTATE3D  ss1 stp endp angle_set)

;calculate and place location for diagonal element id=28
(setq center (vlax-3d-point 0 (* (* (* 3.0 (sin angle_set)) factor) a)  z_diag_up))
(vla-AddCylinder modelSpace center cylRadius cylHeight_diag)

;rotate
(setq ss1 (ssget "L"))
(setq stp  (list -1 (* (* (* 3.0 (sin angle_set)) factor) a) z_diag_up))
(setq endp (list  1  (* (* (* 3.0 (sin angle_set)) factor) a) z_diag_up))
(ROTATE3D  ss1 stp endp angle_set)

;calculate and place location for diagonal element id=29
(setq center (vlax-3d-point (* (* (* 4.0 (sin angle_set)) factor) a) (* (* (* 3.0 (sin angle_set)) factor) a)  z_diag_up))
(vla-AddCylinder modelSpace center cylRadius cylHeight_diag)

;rotate
(setq ss1 (ssget "L"))
(setq stp  (list -1 (* (* (* 3.0 (sin angle_set)) factor) a) z_diag_up))
(setq endp (list  1  (* (* (* 3.0 (sin angle_set)) factor) a) z_diag_up))
(ROTATE3D  ss1 stp endp angle_set)

;calculate and place location for diagonal element id=30
(setq center (vlax-3d-point (* (* (* 4.0 (sin angle_set)) factor) a) (* (* (* 1.0 (sin angle_set)) factor) a)  z_diag_up))
(vla-AddCylinder modelSpace center cylRadius cylHeight_diag)

;rotate
(setq ss1 (ssget "L"))
(setq stp  (list 1 (* (* (* 1.0 (sin angle_set)) factor) a) z_diag_up))
(setq endp (list -1  (* (* (* 1.0 (sin angle_set)) factor) a) z_diag_up))
(ROTATE3D  ss1 stp endp angle_set)

;calculate and place location for diagonal element id=31
(setq center (vlax-3d-point (* (* (* 1.0 (sin angle_set)) factor) a) (* (* (* 2.0 (sin angle_set)) factor) a)  z_diag_up))
(vla-AddCylinder modelSpace center cylRadius cylHeight_diag)

;rotate
(setq ss1 (ssget "L"))
(setq stp  (list  (* (* (* 1.0 (sin angle_set)) factor) a)  1 z_diag_up))
(setq endp (list  (* (* (* 1.0 (sin angle_set)) factor) a) -1  z_diag_up))
(ROTATE3D  ss1 stp endp angle_set)

;calculate and place location for diagonal element id=32
(setq center (vlax-3d-point (* (* (* 3.0 (sin angle_set)) factor) a) (* (* (* 2.0 (sin angle_set)) factor) a)  z_diag_up))
(vla-AddCylinder modelSpace center cylRadius cylHeight_diag)

;rotate
(setq ss1 (ssget "L"))
(setq stp  (list  (* (* (* 3.0 (sin angle_set)) factor) a) -1 z_diag_up))
(setq endp (list  (* (* (* 3.0 (sin angle_set)) factor) a)  1  z_diag_up))
(ROTATE3D  ss1 stp endp angle_set)

;calculate and place location for diagonal element id=33
(setq center (vlax-3d-point (* (* (* 2.0 (sin angle_set)) factor) a) (* (* (* 3.0 (sin angle_set)) factor) a)  z_diag_up))
(vla-AddCylinder modelSpace center cylRadius cylHeight_diag)

;rotate
(setq ss1 (ssget "L"))
(setq stp  (list  1 (* (* (* 3.0 (sin angle_set)) factor) a)  z_diag_up))
(setq endp (list -1 (* (* (* 3.0 (sin angle_set)) factor) a)   z_diag_up))
(ROTATE3D  ss1 stp endp angle_set)

;calculate and place location for diagonal element id=34
(setq center (vlax-3d-point (* (* (* 2.0 (sin angle_set)) factor) a) (* (* (* 1.0 (sin angle_set)) factor) a)  z_diag_up))
(vla-AddCylinder modelSpace center cylRadius cylHeight_diag)

;rotate
(setq ss1 (ssget "L"))
(setq stp  (list -1 (* (* (* 1.0 (sin angle_set)) factor) a)  z_diag_up))
(setq endp (list  1 (* (* (* 1.0 (sin angle_set)) factor) a)   z_diag_up))
(ROTATE3D  ss1 stp endp angle_set)

;long section
;column id=35
(setq cylHeight_long (* 2 (* a factor))) 
(setq z_long (+ (* factor a) (/ b 2)))
(setq center (vlax-3d-point (* (* (* 2.0 (sin angle_set)) factor) a) 0  z_long))
(vla-AddCylinder modelSpace center cylRadius cylHeight_long)
(setq ss1 (ssget "L"))

;column id=36
(setq center (vlax-3d-point 0 (* (* (* 2.0 (sin angle_set)) factor) a)   z_long))
(vla-AddCylinder modelSpace center cylRadius cylHeight_long)
(setq ss1 (ssget "L"))

;column id=37
(setq center (vlax-3d-point (* (* (* 2.0 (sin angle_set)) factor) a) (* (* (* 4.0 (sin angle_set)) factor) a)   z_long))
(vla-AddCylinder modelSpace center cylRadius cylHeight_long)
(setq ss1 (ssget "L"))

;column id=38
(setq center (vlax-3d-point (* (* (* 4.0 (sin angle_set)) factor) a) (* (* (* 2.0 (sin angle_set)) factor) a)   z_long))
(vla-AddCylinder modelSpace center cylRadius cylHeight_long)
(setq ss1 (ssget "L"))

;Spheres
;Corner Spheres Down
(setq center (vlax-3d-point 0 0 (* factor a)))
(vla-AddSphere modelSpace center cylRadius)
(setq ss1 (ssget "L"))

(setq center (vlax-3d-point (* (* (* 4.0 (sin angle_set)) factor) a)  0 (* factor a)))
(vla-AddSphere modelSpace center cylRadius)
(setq ss1 (ssget "L"))

(setq center (vlax-3d-point (* (* (* 4.0 (sin angle_set)) factor) a)  (* (* (* 4.0 (sin angle_set)) factor) a) (* factor a)))
(vla-AddSphere modelSpace center cylRadius)
(setq ss1 (ssget "L"))

(setq center (vlax-3d-point 0  (* (* (* 4.0 (sin angle_set)) factor) a) (* factor a)))
(vla-AddSphere modelSpace center cylRadius)
(setq ss1 (ssget "L"))

;Corner Spheres Up
(setq center (vlax-3d-point 0 0 (- a (* factor a))))
(vla-AddSphere modelSpace center cylRadius)
(setq ss1 (ssget "L"))

(setq center (vlax-3d-point (* (* (* 4.0 (sin angle_set)) factor) a)  0 (- a (* factor a))))
(vla-AddSphere modelSpace center cylRadius)
(setq ss1 (ssget "L"))

(setq center (vlax-3d-point (* (* (* 4.0 (sin angle_set)) factor) a)  (* (* (* 4.0 (sin angle_set)) factor) a) (- a (* factor a))))
(vla-AddSphere modelSpace center cylRadius)
(setq ss1 (ssget "L"))

(setq center (vlax-3d-point 0  (* (* (* 4.0 (sin angle_set)) factor) a) (- a (* factor a))))
(vla-AddSphere modelSpace center cylRadius)
(setq ss1 (ssget "L"))

;Cross Spheres Down
(setq center (vlax-3d-point (* (* (* 2.0 (sin angle_set)) factor) a) (* (* (* 2.0 (sin angle_set)) factor) a) (* factor a)))
(vla-AddSphere modelSpace center cylRadius)
(setq ss1 (ssget "L"))

(setq center (vlax-3d-point (* (* (* 2.0 (sin angle_set)) factor) a) (* (* (* 2.0 (sin angle_set)) factor) a) (- a (* factor a))))
(vla-AddSphere modelSpace center cylRadius)
(setq ss1 (ssget "L"))

;Middle of Struts Down
(setq center (vlax-3d-point 0 (* (* (* 2.0 (sin angle_set)) factor) a) (- (* factor a) (* (* 2 (* factor a) (cos angle_set))))))
(vla-AddSphere modelSpace center cylRadius)
(setq ss1 (ssget "L"))

(setq center (vlax-3d-point (* (* (* 2.0 (sin angle_set)) factor) a) 0 (- (* factor a) (* (* 2 (* factor a) (cos angle_set))))))
(vla-AddSphere modelSpace center cylRadius)
(setq ss1 (ssget "L"))

(setq center (vlax-3d-point (* (* (* 4.0 (sin angle_set)) factor) a) (* (* (* 2.0 (sin angle_set)) factor) a) (- (* factor a) (* (* 2 (* factor a) (cos angle_set))))))
(vla-AddSphere modelSpace center cylRadius)
(setq ss1 (ssget "L"))

(setq center (vlax-3d-point (* (* (* 2.0 (sin angle_set)) factor) a) (* (* (* 4.0 (sin angle_set)) factor) a) (- (* factor a) (* (* 2 (* factor a) (cos angle_set))))))
(vla-AddSphere modelSpace center cylRadius)
(setq ss1 (ssget "L"))

;Middle of Struts Up
(setq center (vlax-3d-point (* (* (* 4.0 (sin angle_set)) factor) a) (* (* (* 2.0 (sin angle_set)) factor) a) (+ (- a (* factor a)) (* (* (* factor a) 2) (cos angle_set)))))
(vla-AddSphere modelSpace center cylRadius)
(setq ss1 (ssget "L"))

(setq center (vlax-3d-point (* (* (* 2.0 (sin angle_set)) factor) a) (* (* (* 4.0 (sin angle_set)) factor) a) (+ (- a (* factor a)) (* (* (* factor a) 2) (cos angle_set)))))
(vla-AddSphere modelSpace center cylRadius)
(setq ss1 (ssget "L"))

(setq center (vlax-3d-point 0 (* (* (* 2.0 (sin angle_set)) factor) a) (+ (- a (* factor a)) (* (* (* factor a) 2) (cos angle_set)))))
(vla-AddSphere modelSpace center cylRadius)
(setq ss1 (ssget "L"))

(setq center (vlax-3d-point (* (* (* 2.0 (sin angle_set)) factor) a) 0 (+ (- a (* factor a)) (* (* (* factor a) 2) (cos angle_set)))))
(vla-AddSphere modelSpace center cylRadius)
(setq ss1 (ssget "L"))


;Union all objects
(setq ss (ssget "X"))
(COMMAND "UNION" ss "")

;Array all objects
; (command "_ARRAY" ss "" "R" n n x y)
; (setq ss (ssget "X"))
; (COMMAND "UNION" ss "")
