library(leaflet)
library(mapboxapi)



mapbox_map <- leaflet() %>%
  addMapboxTiles(style_id = "streets-v11",
                 username = "mapbox") 
## Mapbox maps in R
mapbox_map

home <- mb_geocode("175 Humphrey St, Marblehead, MA 01945")
home
mapbox_map %>%
  setView(lng = home[1],
          lat = home[2],
          zoom = 20)

#### Using Mapbox Navigation APIs in R
## Isochrones
home_isochrones <- mb_isochrone(home, profile = "cycling", time=c(5,10,15,20,25,30))
home_isochrones
colors <- viridisLite::viridis(6)
mapbox_map %>%
  addPolygons(data = home_isochrones,
              color = rev(colors),
              fillColor = rev(colors),
              fillOpacity = 0.5, 
              opacity = 1, 
              weight = 0.2) %>%
  addLegend(labels = c(5, 10, 15,20,25,30),
            colors = colors,
            title = "Bike-time<br/>around home")

## Routing
route <- mb_directions(origin = home,
                       destination = "Museum of Fine Arts, Boston MA",
                       profile = "walking")
route
mapbox_map %>%
  addPolylines(data = route, 
               popup = paste0(
                 "Distance (km): ",
                 round(route$distance, 1), 
                 "<br/>Time (minutes): ",
                 round(route$duration, 1)
               ))
## Directions
route_dir <- mb_directions(origin = home,
                           destination = "Museum of Fine Arts, Boston MA",
                           profile = "driving",
                           steps = TRUE)

route_dir

#### Custom Styles
mapbox_map <- leaflet() %>%
  addMapboxTiles(style_id = "ckg2fc6lv0o3419mpzpz0jc6i",
                 username = "dncarpenter")
#(chaco <- mb_geocode("Chaco Canyon, NM"))
mapbox_map %>%
  setView(lng = -107.967,
          lat = 36.035,
          zoom = 12)

