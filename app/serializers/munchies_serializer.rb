class MunchiesSerializer
  include FastJsonapi::ObjectSerializer
  attributes  :start_location,
              :end_location,
              :restaurant,
              :destination_forecast
end
#
# {
#   "data": {
#     "id": "null",
#     "type": "munchie",
#     "attributes": {
#       "start_location": "Denver, CO",
#       "end_location": "Pueblo, CO",
#       "destination_forecast": {
#         "current": "Cloudy with a chance of meatballs"
#       },
#       "restaurant": {
#         "name": "Chinese Restaurant",
#         "address": "4602 N. Elizabeth St, Ste 120, Pueblo, CO 81008"
#       }
#     }
#   }
# }
