var wms_layers = [];

var format_ne_10m_coastline_0 = new ol.format.GeoJSON();
var features_ne_10m_coastline_0 = format_ne_10m_coastline_0.readFeatures(json_ne_10m_coastline_0, 
            {dataProjection: 'EPSG:4326', featureProjection: 'EPSG:3857'});
var jsonSource_ne_10m_coastline_0 = new ol.source.Vector({
    attributions: ' ',
});
jsonSource_ne_10m_coastline_0.addFeatures(features_ne_10m_coastline_0);
var lyr_ne_10m_coastline_0 = new ol.layer.Vector({
                declutter: true,
                source:jsonSource_ne_10m_coastline_0, 
                style: style_ne_10m_coastline_0,
                interactive: false,
                title: '<img src="styles/legend/ne_10m_coastline_0.png" /> ne_10m_coastline'
            });
var format_Buffered_1 = new ol.format.GeoJSON();
var features_Buffered_1 = format_Buffered_1.readFeatures(json_Buffered_1, 
            {dataProjection: 'EPSG:4326', featureProjection: 'EPSG:3857'});
var jsonSource_Buffered_1 = new ol.source.Vector({
    attributions: ' ',
});
jsonSource_Buffered_1.addFeatures(features_Buffered_1);
var lyr_Buffered_1 = new ol.layer.Vector({
                declutter: true,
                source:jsonSource_Buffered_1, 
                style: style_Buffered_1,
                interactive: false,
                title: '<img src="styles/legend/Buffered_1.png" /> Buffered'
            });
var format_Intersection_2 = new ol.format.GeoJSON();
var features_Intersection_2 = format_Intersection_2.readFeatures(json_Intersection_2, 
            {dataProjection: 'EPSG:4326', featureProjection: 'EPSG:3857'});
var jsonSource_Intersection_2 = new ol.source.Vector({
    attributions: ' ',
});
jsonSource_Intersection_2.addFeatures(features_Intersection_2);
var lyr_Intersection_2 = new ol.layer.Vector({
                declutter: true,
                source:jsonSource_Intersection_2, 
                style: style_Intersection_2,
                interactive: true,
                title: '<img src="styles/legend/Intersection_2.png" /> Intersection'
            });

lyr_ne_10m_coastline_0.setVisible(true);lyr_Buffered_1.setVisible(true);lyr_Intersection_2.setVisible(true);
var layersList = [lyr_ne_10m_coastline_0,lyr_Buffered_1,lyr_Intersection_2];
lyr_ne_10m_coastline_0.set('fieldAliases', {'featurecla': 'featurecla', 'scalerank': 'scalerank', 'min_zoom': 'min_zoom', });
lyr_Buffered_1.set('fieldAliases', {'ATCOCode': 'ATCOCode', 'NaptanCode': 'NaptanCode', 'PlateCode': 'PlateCode', 'CleardownCode': 'CleardownCode', 'CommonName': 'CommonName', 'CommonNameLang': 'CommonNameLang', 'ShortCommonName': 'ShortCommonName', 'ShortCommonNameLang': 'ShortCommonNameLang', 'Landmark': 'Landmark', 'LandmarkLang': 'LandmarkLang', 'Street': 'Street', 'StreetLang': 'StreetLang', 'Crossing': 'Crossing', 'CrossingLang': 'CrossingLang', 'Indicator': 'Indicator', 'IndicatorLang': 'IndicatorLang', 'Bearing': 'Bearing', 'NptgLocalityCode': 'NptgLocalityCode', 'LocalityName': 'LocalityName', 'ParentLocalityName': 'ParentLocalityName', 'GrandParentLocalityName': 'GrandParentLocalityName', 'Town': 'Town', 'TownLang': 'TownLang', 'Suburb': 'Suburb', 'SuburbLang': 'SuburbLang', 'LocalityCentre': 'LocalityCentre', 'GridType': 'GridType', 'Easting': 'Easting', 'Northing': 'Northing', 'Longitude': 'Longitude', 'Latitude': 'Latitude', 'StopType': 'StopType', 'BusStopType': 'BusStopType', 'TimingStatus': 'TimingStatus', 'DefaultWaitTime': 'DefaultWaitTime', 'Notes': 'Notes', 'NotesLang': 'NotesLang', 'AdministrativeAreaCode': 'AdministrativeAreaCode', 'CreationDateTime': 'CreationDateTime', 'ModificationDateTime': 'ModificationDateTime', 'RevisionNumber': 'RevisionNumber', 'Modification': 'Modification', 'Status': 'Status', });
lyr_Intersection_2.set('fieldAliases', {'OBJECTID': 'OBJECTID', 'code': 'code', 'easting': 'easting', 'northing': 'northing', 'ATCOCode': 'ATCOCode', 'NaptanCode': 'NaptanCode', 'PlateCode': 'PlateCode', 'CleardownCode': 'CleardownCode', 'CommonName': 'CommonName', 'CommonNameLang': 'CommonNameLang', 'ShortCommonName': 'ShortCommonName', 'ShortCommonNameLang': 'ShortCommonNameLang', 'Landmark': 'Landmark', 'LandmarkLang': 'LandmarkLang', 'Street': 'Street', 'StreetLang': 'StreetLang', 'Crossing': 'Crossing', 'CrossingLang': 'CrossingLang', 'Indicator': 'Indicator', 'IndicatorLang': 'IndicatorLang', 'Bearing': 'Bearing', 'NptgLocalityCode': 'NptgLocalityCode', 'LocalityName': 'LocalityName', 'ParentLocalityName': 'ParentLocalityName', 'GrandParentLocalityName': 'GrandParentLocalityName', 'Town': 'Town', 'TownLang': 'TownLang', 'Suburb': 'Suburb', 'SuburbLang': 'SuburbLang', 'LocalityCentre': 'LocalityCentre', 'GridType': 'GridType', 'Easting_2': 'Easting_2', 'Northing_2': 'Northing_2', 'Longitude': 'Longitude', 'Latitude': 'Latitude', 'StopType': 'StopType', 'BusStopType': 'BusStopType', 'TimingStatus': 'TimingStatus', 'DefaultWaitTime': 'DefaultWaitTime', 'Notes': 'Notes', 'NotesLang': 'NotesLang', 'AdministrativeAreaCode': 'AdministrativeAreaCode', 'CreationDateTime': 'CreationDateTime', 'ModificationDateTime': 'ModificationDateTime', 'RevisionNumber': 'RevisionNumber', 'Modification': 'Modification', 'Status': 'Status', });
lyr_ne_10m_coastline_0.set('fieldImages', {'featurecla': '', 'scalerank': '', 'min_zoom': '', });
lyr_Buffered_1.set('fieldImages', {'ATCOCode': '', 'NaptanCode': '', 'PlateCode': '', 'CleardownCode': '', 'CommonName': '', 'CommonNameLang': '', 'ShortCommonName': '', 'ShortCommonNameLang': '', 'Landmark': '', 'LandmarkLang': '', 'Street': '', 'StreetLang': '', 'Crossing': '', 'CrossingLang': '', 'Indicator': '', 'IndicatorLang': '', 'Bearing': '', 'NptgLocalityCode': '', 'LocalityName': '', 'ParentLocalityName': '', 'GrandParentLocalityName': '', 'Town': '', 'TownLang': '', 'Suburb': '', 'SuburbLang': '', 'LocalityCentre': '', 'GridType': '', 'Easting': '', 'Northing': '', 'Longitude': '', 'Latitude': '', 'StopType': '', 'BusStopType': '', 'TimingStatus': '', 'DefaultWaitTime': '', 'Notes': '', 'NotesLang': '', 'AdministrativeAreaCode': '', 'CreationDateTime': '', 'ModificationDateTime': '', 'RevisionNumber': '', 'Modification': '', 'Status': '', });
lyr_Intersection_2.set('fieldImages', {'OBJECTID': '', 'code': '', 'easting': '', 'northing': '', 'ATCOCode': '', 'NaptanCode': '', 'PlateCode': '', 'CleardownCode': '', 'CommonName': '', 'CommonNameLang': '', 'ShortCommonName': '', 'ShortCommonNameLang': '', 'Landmark': '', 'LandmarkLang': '', 'Street': '', 'StreetLang': '', 'Crossing': '', 'CrossingLang': '', 'Indicator': '', 'IndicatorLang': '', 'Bearing': '', 'NptgLocalityCode': '', 'LocalityName': '', 'ParentLocalityName': '', 'GrandParentLocalityName': '', 'Town': '', 'TownLang': '', 'Suburb': '', 'SuburbLang': '', 'LocalityCentre': '', 'GridType': '', 'Easting_2': '', 'Northing_2': '', 'Longitude': '', 'Latitude': '', 'StopType': '', 'BusStopType': '', 'TimingStatus': '', 'DefaultWaitTime': '', 'Notes': '', 'NotesLang': '', 'AdministrativeAreaCode': '', 'CreationDateTime': '', 'ModificationDateTime': '', 'RevisionNumber': '', 'Modification': '', 'Status': '', });
lyr_ne_10m_coastline_0.set('fieldLabels', {'featurecla': 'no label', 'scalerank': 'no label', 'min_zoom': 'no label', });
lyr_Buffered_1.set('fieldLabels', {'ATCOCode': 'inline label', 'NaptanCode': 'inline label', 'PlateCode': 'inline label', 'CleardownCode': 'inline label', 'CommonName': 'inline label', 'CommonNameLang': 'no label', 'ShortCommonName': 'no label', 'ShortCommonNameLang': 'no label', 'Landmark': 'no label', 'LandmarkLang': 'no label', 'Street': 'no label', 'StreetLang': 'no label', 'Crossing': 'no label', 'CrossingLang': 'no label', 'Indicator': 'no label', 'IndicatorLang': 'no label', 'Bearing': 'no label', 'NptgLocalityCode': 'no label', 'LocalityName': 'no label', 'ParentLocalityName': 'no label', 'GrandParentLocalityName': 'no label', 'Town': 'no label', 'TownLang': 'no label', 'Suburb': 'no label', 'SuburbLang': 'no label', 'LocalityCentre': 'no label', 'GridType': 'no label', 'Easting': 'no label', 'Northing': 'no label', 'Longitude': 'no label', 'Latitude': 'no label', 'StopType': 'no label', 'BusStopType': 'no label', 'TimingStatus': 'no label', 'DefaultWaitTime': 'no label', 'Notes': 'no label', 'NotesLang': 'no label', 'AdministrativeAreaCode': 'no label', 'CreationDateTime': 'no label', 'ModificationDateTime': 'no label', 'RevisionNumber': 'no label', 'Modification': 'no label', 'Status': 'no label', });
lyr_Intersection_2.set('fieldLabels', {'OBJECTID': 'inline label', 'code': 'inline label', 'easting': 'inline label', 'northing': 'inline label', 'ATCOCode': 'inline label', 'NaptanCode': 'inline label', 'PlateCode': 'inline label', 'CleardownCode': 'inline label', 'CommonName': 'inline label', 'CommonNameLang': 'inline label', 'ShortCommonName': 'inline label', 'ShortCommonNameLang': 'inline label', 'Landmark': 'inline label', 'LandmarkLang': 'inline label', 'Street': 'header label', 'StreetLang': 'inline label', 'Crossing': 'inline label', 'CrossingLang': 'inline label', 'Indicator': 'inline label', 'IndicatorLang': 'inline label', 'Bearing': 'inline label', 'NptgLocalityCode': 'inline label', 'LocalityName': 'inline label', 'ParentLocalityName': 'inline label', 'GrandParentLocalityName': 'inline label', 'Town': 'inline label', 'TownLang': 'inline label', 'Suburb': 'inline label', 'SuburbLang': 'inline label', 'LocalityCentre': 'inline label', 'GridType': 'inline label', 'Easting_2': 'inline label', 'Northing_2': 'inline label', 'Longitude': 'inline label', 'Latitude': 'inline label', 'StopType': 'inline label', 'BusStopType': 'inline label', 'TimingStatus': 'inline label', 'DefaultWaitTime': 'inline label', 'Notes': 'inline label', 'NotesLang': 'inline label', 'AdministrativeAreaCode': 'inline label', 'CreationDateTime': 'inline label', 'ModificationDateTime': 'inline label', 'RevisionNumber': 'inline label', 'Modification': 'inline label', 'Status': 'inline label', });
lyr_Intersection_2.on('precompose', function(evt) {
    evt.context.globalCompositeOperation = 'normal';
});