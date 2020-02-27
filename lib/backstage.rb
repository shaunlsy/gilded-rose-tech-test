# class BackStage < ItemProperty
#   def calculate_quality
#     measure = 1
#     measure -= (quality + 3) if sell_in < 0
#     measure += 1 if sell_in < 11    
#     measure += 1 if sell_in < 6
#     measure
#   end
# end