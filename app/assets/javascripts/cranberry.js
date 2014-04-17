// $(document).ready(function() {
//     init(window.location.href);
// });
var map;
var wiMnBounds;

function init(baseURL) {
  var googleProj = new OpenLayers.Projection("EPSG:900913");
  var latLongProj = new OpenLayers.Projection("EPSG:4326");
  
  ll = new OpenLayers.LonLat(-98.0, 42.0);
  ll.transform(latLongProj,googleProj);
  ur = new OpenLayers.LonLat(-86.0, 50.0);
  ur.transform(latLongProj,googleProj);
  
  wiMnBounds = new OpenLayers.Bounds(ll.lon,ll.lat,ur.lon,ur.lat);

  map = new OpenLayers.Map('map', {
    projection: 'EPSG:900913',
    layers: [
      new OpenLayers.Layer.Google(
          "Google Hybrid",
          {type: google.maps.MapTypeId.HYBRID, numZoomLevels: 20}
      )
    ],
    center: new OpenLayers.LonLat(-91.5, 44.8)
        // Google.v3 uses web mercator as projection, so we have to
        // transform our coordinates
        .transform('EPSG:4326', 'EPSG:900913'),
    zoom: 7
  });
}

// Adapted from the OpenLayers Click Handler Example (OL 2.1)
// OpenLayers.Control.Click = OpenLayers.Class(OpenLayers.Control, {                
//   defaultHandlerOptions: {
//       'single': true,
//       'double': false,
//       'pixelTolerance': 0,
//       'stopSingle': false,
//       'stopDouble': false
//   },
// 
//   initialize: function(options) {
//       this.handlerOptions = OpenLayers.Util.extend(
//           {}, this.defaultHandlerOptions
//       );
//       OpenLayers.Control.prototype.initialize.apply(
//           this, arguments
//       ); 
//       this.handler = new OpenLayers.Handler.Click(
//           this, {
//               'click': this.onClick,
//               'dblclick': this.onDblclick 
//           }, this.handlerOptions
//       );
//   }, 
// 
//   onClick:     function(e) {
//     xy = e.xy;
//     var lonlat = map.getLonLatFromViewPortPx(xy);
//     if (wiMnBounds.containsLonLat(lonlat)) {
//       var point = new OpenLayers.Geometry.Point(lonlat.lon, lonlat.lat);
//       point.transform(googleProj,latLongProj);
//       $.ajax(
//         {
//           type: "GET",
//           url: baseURL + "/summary",
//           async: false,
//           data: {latitude:point.y,longitude:point.x,ajax:true},
//           dataType: 'html',
//           success: function(html)
//           {
//             sr = document.getElementById('summary_results');
//             sr.innerHTML = html;
//             // $('#summary_results').innerHTML = html;
//           }
//         });
//     } else {
//       alert('Point is outside our data. Please choose a point closer to the center of the map.');
//     } 
//   },
// 
//   onDblclick: function(evt) {  
//       var output = document.getElementById(this.key + "Output");
//       var msg = "dblclick " + evt.xy;
//       output.value = output.value + msg + "\n";
//   }   
// 
// });


// 
// // make map available for easy debugging
// var map;
// var googleProj;
// var latLongProj;
// 
// function init(baseURL) {
//   var googleProj = new OpenLayers.Projection("EPSG:900913");
//   var latLongProj = new OpenLayers.Projection("EPSG:4326");
//   
//   ll = new OpenLayers.LonLat(-98.0, 42.0);
//   ll.transform(latLongProj,googleProj);
//   ur = new OpenLayers.LonLat(-86.0, 50.0);
//   ur.transform(latLongProj,googleProj);
//   
//   var wiMnBounds = new OpenLayers.Bounds(ll.lon,ll.lat,ur.lon,ur.lat);
//   /**
//    * The commercial layers (Google, Virtual Earth, and Yahoo) are
//    * in a custom projection - we're calling this Spherical Mercator.
//    * GeoServer understands that requests for EPSG:900913 should
//    * match the projection for these commercial layers.  Note that
//    * this is not a standard EPSG code - so, if you want to load
//    * layers from another WMS, it will have to be configured to work
//    * with this projection.
//    */
//   var options = {
//     // the "community" epsg code for spherical mercator
//     projection: "EPSG:900913",
//     // map horizontal units are meters
//     units: "m",
//     // this resolution displays the globe in one 256x256 pixel tile
//     // maxResolution: 156543.0339,
//     maxExtent: wiMnBounds
//   };
// 
//   map = new OpenLayers.Map('map', options);
//   // create Google Hybrid layer
//   var ghyb = new OpenLayers.Layer.Google(
//     "Google Hybrid",
//     {
//       'type': google.maps.MapTypeId.HYBRID,
//       'sphericalMercator': true,
//       'minZoomLevel': 5
//     }
//   );
//   map.addLayers([ghyb]);
//   hancock = new OpenLayers.LonLat(-89.53,44.1189);
//   hancock.transform(latLongProj,googleProj);
//   map.events.register('click', map,
//     function(e) {
//       xy = e.xy;
//       var lonlat = map.getLonLatFromViewPortPx(xy);
//       if (wiMnBounds.containsLonLat(lonlat)) {
//         var point = new OpenLayers.Geometry.Point(lonlat.lon, lonlat.lat);
//         point.transform(googleProj,latLongProj);
//         $.ajax(
//           {
//             type: "GET",
//             url: baseURL + "/summary",
//             async: false,
//             data: {latitude:point.y,longitude:point.x,ajax:true},
//             dataType: 'html',
//             success: function(html)
//             {
//               sr = document.getElementById('summary_results');
//               sr.innerHTML = html;
//               // $('#summary_results').innerHTML = html;
//             }
//           });
//       } else {
//         alert('Point is outside our data. Please choose a point closer to the center of the map.');
//       } 
//     }
//   );
//   map.setCenter(hancock,1);
// }
