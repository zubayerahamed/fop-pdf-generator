var driverQuery;
var driverdata;
var consignmentdata;
var map;
var unassignedJobs;
var assignedJobs;
var markers = [];
var driverMarkers = [];
var markerCluster;
var resourcePath;
var driverIMG;
var collectionjob;
var deliveredMarker;
var deliveryjob;
var assignableDrivers;
var cbcolours = ['ff00ff', '00a0a0', '535154', '6B4C9A', '922228', '94A93D', 'FF0000', '8C7546', 'B6F2B6', '234D8C', '8C0083', 'F20000', 'FFEABF', '79F279', '0061F2', 'F279DA', 'FF8080', '7F5500', '269954', '0D1C33', 'FF00AA', '7F0000', 'FFCC00', '1A664D', '0022FF', '59003C', '8C4F46', 'E5CF73', '00FFCC', '696E8C', '33262F', 'B23E2D', '332900', 'B6F2E6', '161F59', '994D75', 'FFA280', '8C8300', '4D9994', 'B6B6F2', 'FF0066', '402820', 'E2F200', '00EEFF', '000066', '330014', 'FF6600', '474D00', '005359', '452699', '8C233F', 'F2CEB6', 'C3D96C', '00CCFF', '0E0033', 'FF80A2', '8C4D23', '61664D', '4D8099', 'BA79F2', 'F2B6BE', '66574D', '758C46', 'BFEAFF', '804D99', '664D50', 'FF8800', '88FF00', '004466', 'AA00FF', '4C000A', 'FFC480', '4B8C00', '1A2B33', '614D66', '4C2900', '20331A', '0081F2', 'EEB6F2', 'FFAA00', '1F5916', '79BAF2', 'FF00EE', '1DACD6', 'BC5D58', 'CD9575', 'FDD9B5', '78DBE2', '87A96B', '37A474', 'FCE9BD', '9F8170', 'FD7C6E', '232323', '1F75FE', 'A2A2D0', '199EBD', '7366BD', 'DE5D83', 'CB4154', 'B4674D', 'FF7F49', 'EA7E5D', 'B0B7C6', 'FFFDAD', '1CD3A2', 'FFAACC', 'DD4492', 'DD9475', '9ACEEB', 'FFBCD9', 'FDDB6D', '2B6CC4', 'EFCDB8', '6E5160', 'CEFF1D', '71BC78', '6DAE81', 'C364C5', 'CC6666', 'E7C697', 'FCD975', 'A8E4A0', '95918C', '1CAC78', 'F0E891', 'FF1DCE', 'B2EC5D', '5D76CB', 'C63061', '3BB08F', 'EFDBC5', 'FDFC74', 'FCB4D5', 'FFBD88', 'F664AF', 'CD4A4C', '979AAA', 'FF8243', 'C8385A', 'EF98AA', 'FDBCB4', '1A4876', '30BA8F', '1974D2', 'FFA343', 'BAB86C', 'FF7538', 'E6A8D7', '414A4C', 'FF6E4A', '1CA9C9', 'FFCFAB', 'C5D0E6', 'FDDDE6', '158078', 'FC74FD', 'F78FA7', '8E4585', '7442C8', '9D81BA', 'FF1DCE', 'FF496C', 'D68A59', 'FF48D0', 'E3256B', 'EE204D', 'FF5349', 'C0448F', '1FCECB', '7851A9', 'FF9BAA', 'FC2847', '76FF7A', '9FE2BF', 'A5694F', '8A795D', '45CEA2', 'FB7EFD', 'CDC5C2', '80DAEB', 'ECEABE', 'FFCF48', 'FD5E53', 'FAA76C', '396AB1', 'FC89AC', 'DBD7D2', '17806D', 'DEAA88', '77DDE7', 'FDFC74', '926EAE', 'F75394', 'FFA089', '8F509D', 'EDEDED', 'DA7C30', 'A2ADD0', 'FF43A4', 'FC6C85', 'CDA4DE', 'FCE883', 'C5E384', 'FFB653'];
var driverarray = [];
var colourarray = [];
var jobsOnMap = [];
var LatLngList = [];
var LatLng;
var alreadyCentered = false;

document.addEventListener('keydown', function(e) {


    if (e.ctrlKey && e.which === 68) {
        if ($('.dropdown').has("#driverbtn").hasClass('open')) {
            $('.dropdown').has("#driverbtn").toggleClass('open');
        }
        $('.dropdown').has("#jobbtn").toggleClass('open');

    }
    if (e.ctrlKey && e.which === 74) {
        if ($('.dropdown').has("#jobbtn").hasClass('open')) {
            $('.dropdown').has("#jobbtn").toggleClass('open');
        }
        $('.dropdown').has("#driverbtn").toggleClass('open');

    }

    if (e.which === 27) {
        if ($('.dropdown').has("#jobbtn").hasClass('open')) {
            $('.dropdown').has("#jobbtn").toggleClass('open');
        }
        if ($('.dropdown').has("#driverbtn").hasClass('open')) {
            $('.dropdown').has("#driverbtn").toggleClass('open');
        }

    }
}, false);



function queryFunction() {
    resourcePath = $('#resourceVersion').val();
    deliveredMarker = resourcePath + "img/newdelivered_34c534.png";
    driverQuery = 'query{drivers{Name UserId Latitude Longitude} consignments{HawbNumber DriverId Driver{Name} DriverName DriverAssigned Collected Delivered Received collectionAddress{Longitude Latitude Contact Company AddressLine1 Postcode} deliveryAddress{Longitude Latitude Contact Company AddressLine1 Postcode}}}';
    $.ajax({
        contentType: "application/json",
        method: "POST",
        url: '/netcourier-rs/map',
        data: JSON.stringify({"query": driverQuery}),
        success: function(data) {
            driverdata = data.data.drivers;
            consignmentdata = data.data.consignments;
            deleteMarkers();
            driverFunction();
            markerFunction();
            tableFunction();
            if (alreadyCentered == false) {
                centerMap();
                alreadyCentered = true;
            }
        }
    });
}

function initMap() {

    var style = [
        {
            featureType: "poi",
            elementType: "labels",
            stylers: [
                {visibility: "off"}
            ]
        },
        {
            featureType: "transit",
            elementType: "labels",
            stylers: [
                {visibility: "off"}
            ]
        }
    ];

    map = new google.maps.Map(document.getElementById('map'), {
        center: new google.maps.LatLng(34.30714386, -9.31640625),
        scrollwheel: true,
        zoom: 3,
        styles: style,
        fullscreenControl: false,
        streetViewControl: false,
        mapTypeControl: true,
        mapTypeControlOptions: {
            position: google.maps.ControlPosition.BOTTOM_CENTER
        }
    });

    var centerControlDiv = document.createElement('div');
    var centerControl = new CenterControl(centerControlDiv, map);

    centerControlDiv.index = 1;
    map.controls[google.maps.ControlPosition.TOP_RIGHT].push(centerControlDiv);

    $('body').on('click', '#map:not(".dropdown, .dropdown *")', function() {
        if ($('#mapcontrols .dropdown-content:visible').length > 0) {
            $('#mapcontrols .dropdown-content:visible').hide();
        }
    });
}

function driverFunction() {
    var drivercoords = [];
    assignableDrivers = driverdata.filter(function(ele) {
        return ele.Latitude && ele.Longitude;
    });

    assignableDrivers.forEach(function(eachDriver, i) {
        drivercoords[0] = eachDriver.Latitude;
        drivercoords[1] = eachDriver.Longitude;


        driverIMG = resourcePath + 'img/newdriver_' + cbcolours[i] + '.png';
        driverarray.push(eachDriver.UserId);
        colourarray.push(cbcolours[i]);
        var image1 = {
            url: driverIMG,
            origin: new google.maps.Point(0, 0)
        };


        var driverString = '<img height="84" width="34" src = "' + driverIMG + '"><h1 id="firstHeading" class="firstHeading">' + eachDriver.Name + '</h1>' +
                '<div id="bodyContent"> ';

        var infowindowdriver = new google.maps.InfoWindow({
            content: driverString
        });

        var marker = new google.maps.Marker({
            position: new google.maps.LatLng(drivercoords[0], drivercoords[1]),
            map: map,
            icon: image1,
            zIndex: 100,
            title: eachDriver.Name
        });
        driverMarkers.push(marker);
        LatLng = new google.maps.LatLng(drivercoords[0], drivercoords[1]);
        LatLngList.push(LatLng)
        marker.addListener('click', function() {
    			infowindowdriver.open(map, marker);
         });
	});
}

function markerFunction() {
    unassignedJobs = document.getElementById("unass").checked;
    assignedJobs = document.getElementById("ass").checked;
    clustered = document.getElementById("cluster").checked;
    deliveredcheck = document.getElementById("delivery").checked;
    var consignmentcoords = [];
    var marker;


    consignmentdata.forEach(function(eachJob) {

        if (eachJob.collectionAddress == null)
            return;
        if (eachJob.deliveryAddress == null)
            return;

        if (assignedJobs !== false) {
            driverId = eachJob.DriverId;
            var j = driverarray.indexOf(driverId);
            var colour = cbcolours[j];
            if (colour === undefined) {
                colour = "000000";
            }
            collectionjob = resourcePath + 'img/newcollection_' + colour + '.png';
            deliveryjob = resourcePath + 'img/newdelivery_' + colour + '.png';

            if (eachJob.DriverAssigned !== false && eachJob.DriverId !== null) {
                if (eachJob.Received !== false && eachJob.Delivered !== true) {
                    if (eachJob.deliveryAddress.Latitude !== null) {
                        consignmentcoords[0] = eachJob.deliveryAddress.Latitude;
                        consignmentcoords[1] = eachJob.deliveryAddress.Longitude;
                    }
                    var image2 = {
                        url: deliveryjob,
                        origin: new google.maps.Point(0, 0),
                        collection: false
                    };
                    var jobsString = '<img height="37" width="35" src = "' + deliveryjob + '"><h1 id="firstHeading" class="firstHeading">' + eachJob.HawbNumber + '</h1>' + '<div id="bodyContent">' + '<p><b>Ready to be Delivered</b> <p> Driver Assigned: ' + eachJob.Driver.Name + '<p><b>' + eachJob.deliveryAddress.AddressLine1 + '</b> <p><b>' + eachJob.deliveryAddress.Postcode + '</b>';
                }


                if (eachJob.Delivered !== true && eachJob.Collected !== true) {
                    if (eachJob.collectionAddress.Latitude !== null) {
                        consignmentcoords[0] = eachJob.collectionAddress.Latitude;
                        consignmentcoords[1] = eachJob.collectionAddress.Longitude;
                    }
                    var image2 = {
                        url: collectionjob,
                        origin: new google.maps.Point(0, 0),
                        collection: true
                    }
                    var jobsString = '<img height="37" width="35" src = "' + collectionjob + '"><h1 id="firstHeading" class="firstHeading">' + eachJob.HawbNumber + '</h1>' + '<div id="bodyContent">' + '<p><b>Ready to be Collected</b> <p> Driver Assigned: ' + eachJob.Driver.Name + '<p><b>' + eachJob.deliveryAddress.Company + '</b><p><b> ' + eachJob.collectionAddress.AddressLine1 + '</b> <p><b>' + eachJob.collectionAddress.Postcode + '</b>';
                }
                if (eachJob.Delivered !== false && deliveredcheck !== false) {
                    if (eachJob.deliveryAddress.Latitude !== null) {
                        consignmentcoords[0] = eachJob.deliveryAddress.Latitude;
                        consignmentcoords[1] = eachJob.deliveryAddress.Longitude;
                    }
                    var image3 = {
                        url: deliveredMarker,
                        origin: new google.maps.Point(0, 0)
                    };
                    var jobsString = '<img height="36" width="34" src = "' + deliveredMarker + '"><h1 id="firstHeading" class="firstHeading">' + eachJob.HawbNumber + '</h1>' + '<div id="bodyContent">' + '<p><b>Delivered</b><p> <b>' + eachJob.deliveryAddress.Company + '</b><p><b>' + eachJob.deliveryAddress.AddressLine1 + ' </b> <p><b>' + eachJob.deliveryAddress.Postcode + '</b>';
                }
            }
        }

        if (unassignedJobs !== false && eachJob.HawbNumber !== null) {

            collectionjob = resourcePath + "img/newcollection_8b0000.png";
            deliveryjob = resourcePath + "img/newdelivery_8b0000.png";


            if (eachJob.DriverAssigned !== true) {
                if (eachJob.Received !== false) {
                    if (eachJob.deliveryAddress.Latitude !== null) {
                        consignmentcoords[0] = eachJob.deliveryAddress.Latitude;
                        consignmentcoords[1] = eachJob.deliveryAddress.Longitude;
                    }
                    var image2 = {
                        url: deliveryjob,
                        origin: new google.maps.Point(0, 0),
                        collection: false,
                        zIndex: 80
                    };
                    var jobsString = '<img height="37" width="35" src = "' + deliveryjob + '"><h1 id="firstHeading" class="firstHeading">' + eachJob.HawbNumber + '</h1>' + '<div id="bodyContent">' + '<p><b>Unassigned Delivery</b> <p><b>' + eachJob.deliveryAddress.Company + '</b><p><b>' + eachJob.deliveryAddress.AddressLine1 + '</b> <p><b>' + eachJob.deliveryAddress.Postcode + '</b>';
                }
                else {
                    if (eachJob.collectionAddress !== null) {
                        if (eachJob.collectionAddress.Latitude !== null) {
                            consignmentcoords[0] = eachJob.collectionAddress.Latitude;
                            consignmentcoords[1] = eachJob.collectionAddress.Longitude;
                        }
                    }
                    var image2 = {
                        url: collectionjob,
                        origin: new google.maps.Point(0, 0),
                        collection: true,
                        zIndex: 80
                    };
                    var jobsString = '<img height="37" width="35" src = "' + collectionjob + '"><h1 id="firstHeading" class="firstHeading">' + eachJob.HawbNumber + '</h1>' + '<div id="bodyContent">' + '<p><b>Unassigned Collection</b><p><b>' + eachJob.collectionAddress.Company + '</b> <p><b>' + eachJob.collectionAddress.AddressLine1 + '</b> <p><b>' + eachJob.collectionAddress.Postcode + '</b>';
                }

            }
        }

        var infowindowjobs = new google.maps.InfoWindow({
            content: jobsString,
        });

        if (image2 !== undefined && consignmentcoords[0] !== 0) {
            var contact;
            var ad1;
            var pc;

            if (image2.collection == true) {
                if (eachJob.collectionAddress.Contact !== null) {
                    contact = eachJob.collectionAddress.Contact;
                } else {
                    contact = ""
                }
                ad1 = eachJob.collectionAddress.AddressLine1;
                pc = eachJob.collectionAddress.Postcode;
            } else {
                if (eachJob.deliveryAddress.Contact !== null) {
                    contact = eachJob.deliveryAddress.Contact;
                } else {
                    contact = ""
                }
                ad1 = eachJob.deliveryAddress.AddressLine1;
                pc = eachJob.deliveryAddress.Postcode;
            }
            marker = new google.maps.Marker({
                _hawb: eachJob.HawbNumber,
                _contact: contact,
                _adr1: ad1,
                _pstcode: pc,
                position: new google.maps.LatLng(consignmentcoords[0], consignmentcoords[1]),
                map: map,
                icon: image2,
            });
            markers.push(marker);
            LatLng = new google.maps.LatLng(consignmentcoords[0], consignmentcoords[1]);
            LatLngList.push(LatLng)

            marker.addListener('click', function() {
                infowindowjobs.open(map, this);
            });
        }

        if (image3 !== undefined && consignmentcoords[0] !== 0) {
            marker = new google.maps.Marker({
                _hawb: eachJob.HawbNumber,
                _adr1: eachJob.deliveryAddress.AddressLine1,
                _pstcode: eachJob.deliveryAddress.Postcode,
                _contact: eachJob.deliveryAddress.Contact,
                position: new google.maps.LatLng(consignmentcoords[0], consignmentcoords[1]),
                map: map,
                icon: image3
            });
            markers.push(marker);
            LatLng = new google.maps.LatLng(consignmentcoords[0], consignmentcoords[1]);
            LatLngList.push(LatLng)


            marker.addListener('click', function() {
                infowindowjobs.open(map, this);
            });
        }
    });

    if (clustered !== false) {
        markerCluster = new MarkerClusterer(map, markers,
                {
                    imagePath: resourcePath + "img/m"})

        markerCluster.onClickZoom = function() {
            return multiChoice(markerCluster);
        }
    }
    ;
}

function multiChoice(mc) {
    var cluster = mc.clusters_;
    if (cluster.length == 1 && cluster[0].markers_.length > 1) {
        console.log("Success?")
        var markers1 = cluster[0].markers_;
        var addressString = markers1[0]._adr1;
        var postcodeString = markers1[0]._pstcode;
        var numberOfJobs = markers1.length;

        var str = '<h1 id="firstHeading" class="firstHeading">Jobs</h1> <p><b>Address: ' + addressString + ', ' + postcodeString + ' </b> <p>';

        markers1.forEach(function(markerInCluster, i) {
            var image = markerInCluster.getIcon().url;
            var hawbNum = markerInCluster._hawb;
            i = i + 1;
            str += '<img height="45" width="33" src = "' + image + '"> <b>Job ' + i + ' of ' + numberOfJobs + ' jobs</b> <p>      HAWB: ' + hawbNum + ' <p>      Contact: ' + markerInCluster._contact + ' <p> ';
        })

        var infoWindow = new google.maps.InfoWindow();
        infoWindow.setContent('<div class="scrollFix">' + str + '</div>');
        infoWindow.setPosition(markers1[0].getPosition());
        infoWindow.open(map);

        return false;
    }

    return true;
}

function setMapOnAll(map) {
	for (var i = 0; i < markers.length; i++) {
        markers[i].setMap(map);
    }
    for (var i = 0; i < driverMarkers.length; i++) {
        driverMarkers[i].setMap(map);
    }
}

function centerMap() {

    var latlngbounds = new google.maps.LatLngBounds();
    LatLngList.forEach(function(latLng) {
        latlngbounds.extend(latLng);
    });
    map.setCenter(latlngbounds.getCenter());
    map.fitBounds(latlngbounds);
}

function clearMarkers() {
    setMapOnAll(null);
}

function deleteMarkers() {
	console.log("Clearing Markers!!!");
    clearMarkers();
    markers = [];
    driverMarkers = [];
    if (markerCluster !== undefined) {
        markerCluster.clearMarkers();
    }
}

function tableFunction() {

    $("#Table").removeClass("nodisplay");
    $("#driverTable").removeClass("nodisplay");

    var table = document.getElementById("JobsTable");
    var Body = document.getElementById("body");
    var Header = document.getElementById("header");
    var drivertable = document.getElementById("driverTable");
    var driverBody = document.getElementById("driverbody");
    var driverHeader = document.getElementById("driverheader");

    while (Body.rows.length > 0) {
        Body.deleteRow(0);
    }
    while (driverBody.rows.length > 0) {
        driverBody.deleteRow(0);
    }
    while (Header.rows.length > 0) {
        Header.deleteRow(0);
    }
    while (driverHeader.rows.length > 0) {
        driverHeader.deleteRow(0);
    }


    var mainHead = Header.insertRow(0);
    mainHead.insertCell(0).outerHTML = "<th>HAWB</th>";
    mainHead.insertCell(1).outerHTML = "<th>Delivery/Collection</th>"
    mainHead.insertCell(2).outerHTML = "<th>Collection Company Name</th>";
    mainHead.insertCell(3).outerHTML = "<th>Collection Address</th>";
    mainHead.insertCell(4).outerHTML = "<th>Collection Postcode</th>";
    mainHead.insertCell(5).outerHTML = "<th>Collection Contact</th>";
    mainHead.insertCell(6).outerHTML = "<th>Delivery Company Name</th>";
    mainHead.insertCell(7).outerHTML = "<th>Delivery Address</th>";
    mainHead.insertCell(8).outerHTML = "<th>Delivery Postcode</th>";
    mainHead.insertCell(9).outerHTML = "<th>Delivery Contact</th>";


    if (unassignedJobs !== false) {

        if (assignedJobs !== false) {

            if (deliveredcheck !== false) {
                jobsOnMap = consignmentdata;
            }
            else {
                jobsOnMap = consignmentdata.filter(function(ele) {
                    return ele.Delivered !== true;
                });
            }
        }

        if (assignedJobs !== true && deliveredcheck !== false) {
            jobsOnMap = consignmentdata.filter(function(ele) {
                return ele.Delivered !== false && ele.DriverAssigned !== true;
            });
        }

        if (assignedJobs !== true && deliveredcheck !== true) {
            jobsOnMap = consignmentdata.filter(function(ele) {
                return ele.Delivered !== true && ele.DriverAssigned !== true;
            });
        }
    }
    else {
        if (assignedJobs !== false) {
            if (deliveredcheck !== false) {
                jobsOnMap = consignmentdata.filter(function(ele) {
                    return ele.Delivered !== false && ele.DriverAssigned !== false;
                });
            }
            else {
                jobsOnMap = consignmentdata.filter(function(ele) {
                    return ele.Delivered !== true && ele.DriverAssigned !== false;
                });
            }
        }


        if (assignedJobs !== true && deliveredcheck !== true || assignedJobs !== true && deliveredcheck !== false) {
            jobsOnMap = null;
        }

    }

    var k = 0;
    if (jobsOnMap.length !== 0) {
        jobsOnMap.forEach(function(eachJob) {
            if (eachJob.collectionAddress == null)
                return;
            if (eachJob.deliveryAddress == null)
                return;
            if (eachJob.HawbNumber !== undefined) {
                if (eachJob.collectionAddress.Longitude !== null && eachJob.collectionAddress.Longitude !== 0 || eachJob.deliveryAddress.Longitude !== null && eachJob.deliveryAddress.Longitude !== 0) {
                    var newRow = Body.insertRow(k);
                    newRow.insertCell(0).innerHTML = eachJob.HawbNumber;
                    if (eachJob.Received !== false) {
                        newRow.insertCell(1).innerHTML = "Delivery";
                    }
                    else {
                        newRow.insertCell(1).innerHTML = "Collection";
                    }
                    newRow.insertCell(2).innerHTML = eachJob.collectionAddress.Company;
                    newRow.insertCell(3).innerHTML = eachJob.collectionAddress.AddressLine1;
                    newRow.insertCell(4).innerHTML = eachJob.collectionAddress.Postcode;
                    newRow.insertCell(5).innerHTML = eachJob.collectionAddress.Contact;
                    newRow.insertCell(6).innerHTML = eachJob.deliveryAddress.Company;
                    newRow.insertCell(7).innerHTML = eachJob.deliveryAddress.AddressLine1;
                    newRow.insertCell(8).innerHTML = eachJob.deliveryAddress.Postcode;
                    newRow.insertCell(9).innerHTML = eachJob.deliveryAddress.Contact;
                    k = k + 1;
                }
            }
        });
    }
    else {
        $("#Table").addClass("nodisplay");
        $("#nojob").removeClass("nodisplay");

    }

    var drivemainHead = driverHeader.insertRow(0);


    if (assignableDrivers.length !== 0) {
        assignableDrivers.forEach(function(eachJob, k) {
            var newRow = driverBody.insertRow(k);
            driverIMG = resourcePath + 'img/newdriver_' + cbcolours[k] + '.png';
            newRow.insertCell(0).innerHTML = "<img src='" + driverIMG + "'/>";
            newRow.insertCell(1).innerHTML = eachJob.Name;
        });
    }
    else {
        $("#driverTable").addClass("nodisplay");
        $("#nodriver").removeClass("nodisplay");


    }

    if (!$('body').data('init')) {
        $('#mapcontrols div.dropdown').on('click', function(e) {
            if ($(this).find('.dropdown-content:visible').length > 0) {
                $(this).find('.dropdown-content').hide();
            }
            else {
                $('#mapcontrols .dropdown-content:visible').hide();
                $(this).find('.dropdown-content').show();
            }
            e.stopPropagation();
        });

        $('#mapcontrols .dropdown-content *').on('click', function(e) {
            e.stopPropagation();
        });
        $('body').data('init', 'Y');
    }
}

function clearTable() {
    jobsOnMap = [];

    var thing = document.getElementById("Table");
    while (thing.rows.length > 0) {
        thing.deleteRow(0);
    }
    querybits.deleteContents;
    document.getElementById("list").innerHTML = "";
    var thing = document.getElementById("sortsel");
    var thing2 = document.getElementById("searchsel");
    while (thing.hasChildNodes()) {
        thing.removeChild(thing.lastChild);
    }
    while (thing2.hasChildNodes()) {
        thing2.removeChild(thing2.lastChild);
    }
}

function CenterControl(controlDiv, map) {
    collectionjob = resourcePath + "img/newcollection_8b0000.png";
    deliveryjob = resourcePath + "img/newdelivery_8b0000.png";
    driverIMG = resourcePath + 'img/newdriver_0D1C33.png';
    deliveredMarker = resourcePath + "img/newdelivered_34c534.png";

    //Set CSS for the control border.
    var controlUI = document.createElement('div');
    controlDiv.appendChild(controlUI);
    controlUI.innerHTML = '<div id="mapcontrols" style="background-color:white;height:145px;width:190px;padding: 10px; border-left: 6px solid white; border-bottom: 6px solid white; border-bottom-left-radius: 25px;"><label for="delivery"><input type="checkbox" id="delivery" onchange="queryFunction()" checked> View Delivered Jobs</label><label for="ass"><input type="checkbox" id="ass" onchange="queryFunction()" checked> View Assigned Jobs</label><label for="unass"><input type="checkbox" id="unass" onchange="queryFunction()" checked> View Unassigned Jobs</label><label for="cluster"><input type="checkbox" id="cluster" onchange="queryFunction()" checked> Cluster Jobs</label><div class="dropdown" style="float:right; padding-top:10px;"><button id="driverbtn" class="dropbtn btn btn-info"><i style="color: white;" class="fa fa-gift" aria-hidden="true"></i>  Jobs   <i class="fa fa-chevron-circle-down" aria-hidden="true"></i></button><div class="dropdown-content"><i id="nojob" class="nodisplay">No jobs available</i><table id="Table" class="nodisplay"><thead id ="header"></thead><tbody id ="body"></tbody></table></div></div><div class="dropdown" style="float:right;padding-top:10px;"><button id="jobbtn" class="dropbtn btn btn-info"><i style="color: white;" class="fa fa-truck" aria-hidden="true"></i>  Drivers  <i class="fa fa-chevron-circle-down" aria-hidden="true"></i></button><div class="dropdown-content"><i id="nodriver" class="nodisplay">No Drivers to display</i><table id="driverTable" class="driverTable nodisplay" ><thead id ="driverheader"></thead><tbody id ="driverbody"><tr></tr></tbody></table></div></div><div class="dropdown" style="float:right; padding-top:10px;"><button id="driverbtn" class="dropbtn btn btn-info"><i class="fa fa-key" aria-hidden="true" style="font-size: 16px;"></i></button><div class="dropdown-content" style="text-align:center;"><ul style="list-style:none;"><li><img height="84" width="34" src = "' + driverIMG + '">Driver</li><li><img height="84" width="34" src = "' + collectionjob + '">Unassigned Collection</li><li><img height="84" width="34" src = "' + deliveryjob + '">Unassigned Delivery</li><li><img height="74" width="28" src = "' + deliveredMarker + '">Delivered Job</li></ul></div></div></div>';
}

setInterval(queryFunction, 120000);