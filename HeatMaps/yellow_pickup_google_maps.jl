using JLD,Clustering
HTML("""
<script>

      // This example requires the Visualization library. Include the libraries=visualization
      // parameter when you first load the API. For example:
      // <script src="https://maps.googleapis.com/maps/api/js?key=YOUR_API_KEY&libraries=visualization">

      var yellow_pickup_map, yellow_pickup_heatmap;

      function yellow_pickup_initMap() {
    yellow_pickup_map = new google.maps.Map(document.getElementById('yellow_pickup'), {
          zoom: 10,
          center: {lat: 40.720572, lng: -73.916548},
          mapTypeId: 'satellite'
        });

        yellow_pickup_heatmap = new google.maps.visualization.HeatmapLayer({
data: yellow_pickup_getPoints(),
          map: yellow_pickup_map
        });
      }
function yellow_pickup_getPoints() {
return  [
{location: new google.maps.LatLng(37.782, -122.447), weight: 0.5},
  new google.maps.LatLng(37.782, -122.445),
  {location: new google.maps.LatLng(37.782, -122.443), weight: 2},
  {location: new google.maps.LatLng(37.782, -122.441), weight: 3},
  {location: new google.maps.LatLng(37.782, -122.439), weight: 2},
  new google.maps.LatLng(37.782, -122.437),
  {location: new google.maps.LatLng(37.782, -122.435), weight: 0.5},
        ];
}
</script>""")
HTML("""
<script>
function yellow_pickup_setMapData(points) {
google.maps.event.trigger(yellow_pickup_heatmap,'resize');
yellow_pickup_heatmap.setData(_.map(points, function (p) { return {location: new google.maps.LatLng(p[0], p[1]), weight:p[2]}; }));
}
</script>
""")
yellow_pickup_saved_data=load("Yellow_pickup_centers.jld");
function yellow_pickup_getData(year,month)
        if(year==13 && month<8)
            d = yellow_pickup_saved_data["v"][1][1]
        else
            d = yellow_pickup_saved_data["v"][(year-13)*12+month-7][1]
        end
        x=Matrix(2,0);
        y=Matrix(1,0);
        v=d.centers;
        w=d.counts';
        x=hcat(x,v);
        y=hcat(y,w);
        c=vcat(x,y);
        return JSON.json(c)
end
HTML("""<script async defer
src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCRFxi25LNABkLGs_c1xSwLdfMcUAhCe4s&libraries=visualization&callback=yellow_dropoff_initMap">
</script>""")