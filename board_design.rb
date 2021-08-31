# frozen_string_literal: true

cell_hash = { A1: 'X', A2: 'O', A3: 'X', B1: 'O', B2: 'X', B3: 'O', C1: ' ', C2: 'O', C3: 'X' }

board =
  "    _______ _______ _______
   |       |       |       |
  A|   #{cell_hash[:A1]}   |   #{cell_hash[:A2]}   |   #{cell_hash[:A3]}   |
   |_______|_______|_______|
   |       |       |       |
  B|   #{cell_hash[:B1]}   |   #{cell_hash[:B2]}   |   #{cell_hash[:B3]}   |
   |_______|_______|_______|
   |       |       |       |
  C|   #{cell_hash[:C1]}   |   #{cell_hash[:C2]}   |   #{cell_hash[:C3]}   |
   |_______|_______|_______|
       1       2       3
  "
puts board
