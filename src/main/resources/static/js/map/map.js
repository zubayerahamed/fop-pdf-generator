"use strict";
$(document).ready(function(){
	if(document.getElementById("map")){
		let markerLatLng = new google.maps.LatLng(-33.91727341958453, 151.23348314155578);

		let mapOptions = {
			zoom : 16,
			center: markerLatLng,
			mapTypeId: google.maps.MapTypeId.ROADMAP
		}

		let map = new google.maps.Map(document.getElementById("map"), mapOptions);

		let markerIcon = {
			url: 'http://image.flaticon.com/icons/svg/252/252025.svg',
			scaledSize: new google.maps.Size(40, 40),
			origin: new google.maps.Point(0, 0),
			anchor: new google.maps.Point(15,40)
		};

		let markerLabel = 'GO!';

		let marker = new MarkerWithLabel({
			map: map,
			animation: google.maps.Animation.BOUNCE,
			position: markerLatLng,
			icon: markerIcon,
			labelContent: markerLabel,
			labelAnchor: new google.maps.Point(18, 12),
			labelClass: "my-custom-class-for-label", // the CSS class for the label
			labelInBackground: true
		}); 
	}
});