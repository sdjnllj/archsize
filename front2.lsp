(defun c:drawfront2 ()
  ; Draw main outline
  (command "_line" "0,0" "9000,0" "")
  (command "_line" "9000,0" "9000,3000" "")
  (command "_line" "9000,3000" "0,3000" "")
  (command "_line" "0,3000" "0,0" "")
  
  ; Draw eave
  (command "_line" "-600,3000" "9600,3000" "")
  
  ; Draw first door
  (command "_line" "600,0" "600,2100" "")
  (command "_line" "600,2100" "1500,2100" "")
  (command "_line" "1500,2100" "1500,0" "")
  (command "_line" "1500,0" "600,0" "")
  
  ; Draw second door
  (command "_line" "6500,0" "6500,2100" "")
  (command "_line" "6500,2100" "7400,2100" "")
  (command "_line" "7400,2100" "7400,0" "")
  (command "_line" "7400,0" "6500,0" "")
  
  ; Draw first window
  (command "_line" "2500,900" "2500,2100" "")
  (command "_line" "2500,2100" "3700,2100" "")
  (command "_line" "3700,2100" "3700,900" "")
  (command "_line" "3700,900" "2500,900" "")
  
  ; Draw second window
  (command "_line" "4500,900" "4500,2100" "")
  (command "_line" "4500,2100" "5700,2100" "")
  (command "_line" "5700,2100" "5700,900" "")
  (command "_line" "5700,900" "4500,900" "")
  
  (princ)
)
