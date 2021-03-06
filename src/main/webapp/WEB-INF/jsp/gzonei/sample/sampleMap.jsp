<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/jsp/gzonei/layout/header.jsp" %>
<%@ include file="/WEB-INF/jsp/gzonei/layout/headerMap.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>샘플 페이지</title><!-- 행정안전부 공통서비스 테스트 사이트 -->
<!-- OpenLayers 3 & Proj4js -->
</head>
<style>
/* 거리재기 스타일_openlayers3 */
.tooltip {
  position: relative;
  background: rgba(0, 0, 0, 0.5);
  border-radius: 4px;
  color: white;
  padding: 4px 8px;
  opacity: 0.7;
  white-space: nowrap;
}
.tooltip-measure {
  opacity: 1;
  font-weight: bold;
}
.tooltip-static {
  background-color: #ffcc33;
  color: black;
  border: 1px solid white;
}
.tooltip-measure:before,
.tooltip-static:before {
  border-top: 6px solid rgba(0, 0, 0, 0.5);
  border-right: 6px solid transparent;
  border-left: 6px solid transparent;
  content: "";
  position: absolute;
  bottom: -6px;
  margin-left: -7px;
  left: 50%;
}
.tooltip-static:before {
  border-top-color: #ffcc33;
}
.ol-dragbox {
  background-color: rgba(255,255,255,0.4);
  border-color: rgba(255, 255, 238,1);
}
.ol-popup-closer {
  text-decoration: none;
  position: absolute;
  top: 2px;
  right: 8px;
}
.ol-popup-closer:after {
  content: "✖";
}

.ol-popup {
  position: absolute;
  background-color: white;
  -webkit-filter: drop-shadow(0 1px 4px rgba(0,0,0,0.2));
  filter: drop-shadow(0 1px 4px rgba(0,0,0,0.2));
  padding: 15px;
  border-radius: 10px;
  border: 1px solid #cccccc;
  bottom: 12px;
  left: -50px;
   max-width:500px;
}
.ol-popup:after, .ol-popup:before {
  top: 100%;
  border: solid transparent;
  content: " ";
  height: 0;
  width: 0;
  position: absolute;
  pointer-events: none;
}
.ol-popup:after {
  border-top-color: white;
  border-width: 10px;
  left: 48px;
  margin-left: -10px;
}
.ol-popup:before {
  border-top-color: #cccccc;
  border-width: 11px;
  left: 48px;
  margin-left: -11px;
}
.gzone__overlay{
	max-width:500px;
	padding: 10px;
}
</style>
<body topmargin="0" leftmargin="0">

<!-- header -->
<script>
var map; //초기설정
var draw; //거리측정 변수
var lonlat;
//벡터정의
var vectorSource = new ol.source.Vector();

$(document).ready(function(){
	
	if('geolocation' in navigator) {
	  /* 위치정보 사용 가능 */
		navigator.geolocation.getCurrentPosition(function(position) {
		var latitude = position.coords.latitude;
        var longitude = position.coords.longitude;
        lonlat = ol.proj.fromLonLat([position.coords.longitude, position.coords.latitude]);
        map.getView().setCenter(lonlat);
        map.getView().setZoom(13);
		});
	} else {
	  /* 위치정보 사용 불가능 */
		map.getView().setCenter(ol.proj.fromLonLat([126.90297485081749,37.53624148971899]));
       	map.getView().setZoom(13);
	}	
    // 지도뿌리기
    map = new ol.Map({
           target: 'map1',
            layers: [
               new ol.layer.Tile({
                   title: 'Naver Street Map',
                   name: 'Naver Street Map',
                   layerType: 'backgroundMap',
                   source: new ol.source.XYZ({
                       projection: new ol.proj.Projection({
                           code: 'EPSG:5179', //네이버 좌표가 5179라 지정
                           units: 'm'
                       }),
                       tileGrid: new ol.tilegrid.TileGrid({
                           extent: [90112, 1192896, 1990673, 2761664],
                           origin: [90112, 1192896],
                           resolutions: [2048, 1024, 512, 256, 128, 64, 32, 16, 8, 4, 2, 1, 0.5, 0.25]
                       }),
                       tileUrlFunction: function (tileCoord, pixelRatio, projection) {
                           if (tileCoord == null) return undefined;

                           var z = tileCoord[0] + 1;
                           var x = tileCoord[1];
                           var y = tileCoord[2];

                           return 'https://simg.pstatic.net/onetile/get/197/0/0/'+z+'/'+x+'/'+y+'/bl_vc_bg/ol_vc_an';
                       },
                       crossOrigin: 'Anonymous'
                   })
                   , visible: false
               }),
               new ol.layer.Tile({
                   title: 'Kakao Street Map',
                   name: 'Kakao Street Map',
                   layerType: 'backgroundMap',
                   source: new ol.source.XYZ({
                       projection: new ol.proj.Projection({
                           code: 'EPSG:5181',
                           extent: [-30000, -60000, 494288, 988576],
                           units: 'm'
                       }),
                       tileGrid: new ol.tilegrid.TileGrid({
                           extent: [-30000, -60000, 494288, 988576],
                           origin: [-30000, -60000],
                           resolutions: [2048, 1024, 512, 256, 128, 64, 32, 16, 8, 4, 2, 1, 0.5, 0.25]
                       }),
                       tileUrlFunction: function (tileCoord, pixelRatio, projection) {
                           if (tileCoord == null) return undefined;

                           var z = 14-tileCoord[0];
                           var x = tileCoord[1];
                           var y = tileCoord[2];

                           return "http://map3.daumcdn.net/map_2d/1810uis/L"+z+"/"+y+"/"+x+".png";
                       }
                   })
                   , visible: true
               }),
               new ol.layer.Tile({
                   title: 'Google Map',
                   name: 'Google Map',
                   layerType: 'backgroundMap',
                   source: new ol.source.OSM({
                       url : "https://mt0.googleapis.com/maps/vt?pb=!1m5!1m4!1i{z}!2i{x}!3i{y}!4i256!2m3!1e0!2sm!3i329238860!3m9!2sko-KR!3sUS!5e18!12m1!1e47!12m3!1e37!2m1!1ssmartmaps!4e0"
                      	, crossOrigin: 'Anonymous'
                   })
                   , visible: false
               })
           ],
           view : new ol.View({
               zoom: 10,                                        // 초기화면 zoom level
               maxZoom: 26,
               minZoom: 10,
               projection: 'EPSG:3857',
               extent:[13142962.634410318, 3687247.639029924, 15491108.143330932, 4872327.325563297],
               units: 'm'                                       
           }),
       	interactions:null,
    	controls: ol.control.defaults({
            zoom: false,
            attribution: false,
            rotate: false
        })
    });
 	// 줌인
    $('#btn_zoonin').on('click', function() {
    	removeInteraction()
        var view = map.getView();
        var zoom = view.getZoom();
        view.setZoom(zoom + 1);

    });

    // 줌아웃
    $('#btn_zoonout').on('click', function() {
    	removeInteraction()
        var view = map.getView();
        var zoom = view.getZoom();
        view.setZoom(zoom - 1);
    });
    map.on("moveend", moveEnd);
    
    function moveEnd(event){
    	$("#zoomlvl").text("줌레벨 : Lv"+event.map.getView().getZoom().toFixed(0));
    };
    
    //팝업
    var container = document.getElementById('popup');
	var content =  document.getElementById('popup-content');
	var closer =  document.getElementById('popup-closer');
	
	//팝업닫기
	closer.onclick = function() {
		  overlay.setPosition(undefined);
		  closer.blur();
		  return false;
		};
		
	var overlay = new ol.Overlay({
		  element: container,
		  autoPan: true,
		  autoPanAnimation: {
		    duration: 250
		  }
	});
    map.addOverlay(overlay);
    
    map.on('click', function(evt) {
    	var coordinate = evt.coordinate;
    	var feature = map.forEachFeatureAtPixel(evt.pixel,function(feature) {
            return feature;
        });
        if (feature.values_.devlopInfoSn) {
        	var iwContent = '<div class="gzone__overlay">' +
    	    '  <a href="#"  class="link">' +
    	    '<strong><em>도시개발사업</em>서초 염곡지구 도시개발사업</strong>' +
    	    '<span>71,808㎡(21,722평)</span>' +
    	    '<span>SH공사</span>' +
    	    '<i>자세히보기</i>' +
    	    '<div class="thumbnail">' +
    		'<img src="/img/example/hi-seoul.jpg" width="55" height="55" alt="서울시청" class="thumb" />' +
    		'</div>' +
    	    '  </a>' +
    	    '</div>';
        	content.innerHTML = iwContent ;
        	overlay.setPosition(coordinate);

        } 
    });
});

//배경지도 변경
function mapChange(val){
	map.getLayers().forEach(function (layer, i) {
			if(layer.values_.layerType == "backgroundMap"){
				layer.setVisible(false);
				layer.setOpacity(0);
			}
			if (layer.values_.name.toLowerCase().indexOf(val.toLowerCase()) > -1) {
				layer.setVisible(true);
				layer.setOpacity(1);
			}
	});
	
}
//지도저장
function mapSaveImg(){
	var format = 'a4';
	var dim = [297, 210];
	var resolution = 150;
	var width = Math.round(dim[0] * resolution / 25.4); 
    var height = Math.round(dim[1] * resolution / 25.4);
    var size =  (map.getSize());
    var extent = map.getView().calculateExtent(size);
        map.once('postcompose', function(event) {
            var interval;
            interval = setInterval(function() {
                clearInterval(interval);
                var canvas = event.context.canvas;
                canvas.setAttribute('crossOrigin', 'Anonymous');
                var data = canvas.toDataURL('image/jpeg');
                var pdf = new jsPDF('landscape', undefined, format);
                pdf.addImage(data, 'JPEG', 0, 0, dim[0], dim[1]);
                pdf.save('map.pdf');
                map.renderSync();
            }, 1000);
          });
    var printSize = [width, height];
    map.setSize(printSize);
    map.getView().fit(extent, {size: printSize});
}

//거리, 면적, 반경
function mapMeasure(val){
	//거리재기
    var sketch;
    var helpTooltipElement;
    var helpTooltip;
    var measureTooltipElement;
    var measureTooltip;
    var continuePolygonMsg = '계속해서 다각형을 그리려면 클릭하세요';
    var continueLineMsg = '계속해서 선을 그리려면 클릭하세요.';
    var listener;
    
    //지도 초기화
    removeInteraction();
    //지도에 레이어 인서트
    var vector = new ol.layer.Vector({
	    source: vectorSource,
	    layerType: 'measureMap',
	    style: new ol.style.Style({
	        fill: new ol.style.Fill({
	            color: 'rgba(255, 255, 255, 0.2)'
	        }),
	        stroke: new ol.style.Stroke({
	            color: 'rgba(0, 0, 255, 1.0)',
	            width: 2
	        }),
	        image: new ol.style.Circle({
	            radius: 7,
	            fill: new ol.style.Fill({
	                color: '#ffcc33'
	            })
	        })
	    })
	});
    map.addLayer(vector);
    map.removeOverlay(measureTooltip);
    
    addInteraction();
    
    var pointerMoveHandler = function(evt) {
      if (evt.dragging) {
        return;
      }
      
      var helpMsg = '그리기 시작하려면 클릭하세요';
    
      if (sketch) {
        var geom = (sketch.getGeometry());
        if (geom instanceof ol.geom.Polygon) {
          helpMsg = continuePolygonMsg;
        } else if (geom instanceof ol.geom.LineString) {
          helpMsg = continueLineMsg;
        }
      }
    
      helpTooltipElement.innerHTML = helpMsg;
      helpTooltip.setPosition(evt.coordinate);
    
      helpTooltipElement.classList.remove('hidden');
    };
      
    map.on('pointermove', pointerMoveHandler);
 
    map.getViewport().addEventListener('mouseout', function() {
      helpTooltipElement.classList.add('hidden');
    });
 
    var formatLength = function(line) {
        var length;
        length = Math.round(line.getLength() * 100) / 100;
        var output;
        if (length > 100) {
          output = (Math.round(length / 1000 * 100) / 100) +' ' + 'km';
        } else {
          output = (Math.round(length * 100) / 100) + ' ' + 'm';
        }
        return output;
    };
    
    var formatArea = function(polygon) {
        var area;
        area = polygon.getArea();
        var output;
        if (area > 10000) {
          output = (Math.round(area / 1000000 * 100) / 100) +
              ' ' + 'km<sup>2</sup>';
        } else {
          output = (Math.round(area * 100) / 100) +
              ' ' + 'm<sup>2</sup>';
        }
        return output;
    };
    
    var formatRadius = function (circle) {
   	  	var radius = Math.round(circle.getRadius() * 100) / 100; 
   	  	var output; 
        if (radius > 100) { 
            output = (Math.round(radius / 1000 * 100) / 100) + ' ' + 'km'; 
        } else { 
                output = (Math.round(radius * 100) / 100) + ' ' + 'm'; 
        } 
  			return output; 
    	}
      
    function addInteraction() {
        var type; 
       	if(val == 'area'){
       		type ='Polygon'
        } else if(val == 'length'){
        	type ='LineString'	
        }else{
        	type ='Circle'	
        };
        draw = new ol.interaction.Draw({
            source: vectorSource,
            type: type,
            style: new ol.style.Style({
                fill: new ol.style.Fill({
                color: 'rgba(255, 255, 255, 0.2)'
                }),
                stroke: new ol.style.Stroke({
                    color: 'rgba(0, 0, 0, 0.5)',
                    lineDash: [10, 10],
                    width: 2
                }),
                image: new ol.style.Circle({
                    radius: 5,
                    stroke: new ol.style.Stroke({
                        color: 'rgba(0, 0, 0, 0.7)'
                    }),
                    fill: new ol.style.Fill({
                    color: 'rgba(255, 255, 255, 0.2)'
                    })
                })
            })
        });
        map.addInteraction(draw);
        createMeasureTooltip();
        createHelpTooltip();
        
        draw.on('drawstart', function(evt) {
            sketch = evt.feature;
            var tooltipCoord = evt.coordinate;
            listener = sketch.getGeometry().on('change', function(evt) {
                var geom = evt.target;
                var output;
                if (geom instanceof ol.geom.Polygon) {
                    output = formatArea(geom);
                    tooltipCoord = geom.getInteriorPoint().getCoordinates();
                } else if (geom instanceof ol.geom.LineString) {
                    output = formatLength(geom);
                    tooltipCoord = geom.getLastCoordinate();
                } else if (geom instanceof ol.geom.Circle) {
                    output = formatRadius(geom);
                    tooltipCoord = geom.getLastCoordinate();
                }
                measureTooltipElement.innerHTML = output;
                measureTooltip.setPosition(tooltipCoord);
            });
        });
        
        draw.on('drawend', function() {
            measureTooltipElement.className = 'tooltip tooltip-static';
            measureTooltip.setOffset([0, -7]);
 
            sketch = null;
 
            measureTooltipElement = null;
 
            createMeasureTooltip();
            ol.Observable.unByKey(listener);
        });
    }
    
    function createHelpTooltip() {
        if (helpTooltipElement) {
          helpTooltipElement.parentNode.removeChild(helpTooltipElement);
        }
        helpTooltipElement = document.createElement('div');
        helpTooltipElement.className = 'tooltip hidden';
        helpTooltip = new ol.Overlay({
          element: helpTooltipElement,
          offset: [15, 0],
          positioning: 'center-left'
        });
        map.addOverlay(helpTooltip);
    }
    
    function createMeasureTooltip() {
        if (measureTooltipElement) {
          measureTooltipElement.parentNode.removeChild(measureTooltipElement);
        }
        measureTooltipElement = document.createElement('div');
        measureTooltipElement.className = 'tooltip tooltip-measure';
        measureTooltip = new ol.Overlay({
          element: measureTooltipElement,
          offset: [0, -15],
          positioning: 'bottom-center'
        });
        map.addOverlay(measureTooltip);
    }
}

function removeInteraction(name, mode){
	var removeInteraction = [];
	if(mode != null){
		 $.each(map.interactions.array_, function (key, val) {
	         if (typeof val.values_.mode != "undefined") {
	             if (val.values_.mode == mode) {
	                 if (val instanceof ol.interaction.Select) {
	                     var features = val.getFeatures().array_;
	                 }
	                 removeInteraction.push(val);
	             }
	         }
	     });
	}else{
		$('.tooltip').remove();
		vectorSource.clear();
	    map.getLayers().forEach(function (layer, i) {
	    	if(layer.values_.layerType == "measureMap"){
	    		map.removeLayer(layer);
	    	}
	    });
	    removeInteraction.push(draw);
	}
	
	 $.each(removeInteraction, function (key, val) {
		 map.removeInteraction(val);
     });
}

//레이어 checkbox 체크시 레이어 ON/OFF
function layer_box_chk(checked,id)
{	
	if(checked){
		if(id =="gz_devlop_info"){
			viewLayer(id);
		}else if(id.includes("gzonei")){
			viewWmsLayer(id);
		}else{
			vworld_wmslayer(id);
		}
	}else{
		map.removeLayer(map.getLayerByName(id));
	}
}
//브이월드 호출(api key 변경 필요)
function vworld_wmslayer(id)
{
	var vworld_wmslayer = new ol.layer.Tile({
        title: id,
        id: id,
        name: id,                              
        projection: "EPSG:3857",               
        extent: map.getView().getProjection().getExtent(), 
        source: new ol.source.TileWMS({
            url: "http://api.vworld.kr/req/wms?",
            params: {
                LAYERS: id,
                STYLES: id,
                CRS: "EPSG:3857",
                apikey: "C89A02AC-17DD-31D7-BEE1-C519BE2887D2",
                DOMAIN:"https://localhost:8080",
                title: id,
                FORMAT: "image/png",
                EXCEPTIONS: "text/xml",
            }
        })
    });
	map.addLayer(vworld_wmslayer);
}
//geoserver에서 호출
function viewWmsLayer(id)
{
	var viewWmsLayer = new ol.layer.Tile({
        title: id,
        id: id,
        name: id,                              
        projection: "EPSG:4326",               
        extent: map.getView().getProjection().getExtent(), 
        source: new ol.source.TileWMS({
            url: "http://211.172.247.32:58080/geoserver/gzonei/wms?",
            params: {
                LAYERS: id,
                STYLES: '',
                VERSION: '1.1.1',
                TILED: true,
                FORMAT: "image/png",
                EXCEPTIONS: "text/xml",
            }
        })
    });
	map.addLayer(viewWmsLayer);
}

//db에서 데이터 추출(권한별 레이어 point&polygon 형태로 표출)
function viewLayer(id)
{
	var resData; 
	$.ajax({
        type : 'POST',
        url : "/sample/viewLayer.do",
        async: false,
        datatype : 'json',
        contentType: 'application/x-www-form-urlencoded;charset=utf-8',
        data: {"layer":id},
        success : function(data){ 
        	resData = JSON.parse(data);
        	var features = [];
        	var text = "";
            for(var i=0; i<resData.length; i++){
				var wkt = resData[i].wkt;
				var format = new ol.format.WKT();
				features[i] = format.readFeature(wkt, {
				  dataProjection: 'EPSG:3857',
				  featureProjection: 'EPSG:3857'
				 });
				for(key in resData[i]) {
				    features[i].set(key,resData[i][key]);
	           	}
				features[i].setId(resData[i].devlopInfoSn);
			}
			//리스트 임시
			text = "<li><a onclick='zoomLayer(\""+resData[4].devlopInfoSn+"\")'>"+resData[4].devlopInfoSn+"</a></li>";
            ////리스트 임시
			$('#listSelect').html(text);
            var layerSource = new ol.source.Vector();
            layerSource.addFeatures(features);
            var vector = new ol.layer.Vector ({
            	  source: layerSource, 
            	  id: id,
            	  name: id,
            	  layerType : 'viewLayer',
            	  style: new ol.style.Style({
          	        fill: new ol.style.Fill({
        	            color: 'rgba(69,97,246,0.7)'
        	        }),
        	        stroke: new ol.style.Stroke({
        	            color: 'rgba(244,243,235,1)',
        	            width: 2
        	        }),
        	        image: new ol.style.Icon({
        	        	anchor: [0.5, 46], //src로 지정된 url의 png 이미지로 포인트를 표시하며, 표시될때의 (X, Y)에 대한 기준점으로 (0.5, 46) 
        	            anchorXUnits: 'fraction',//X 축에 대한 값인 0.5의 단위를 anchorXUnits 속성을 통해 백분률(여기서는 0.5이므로 50%)로 지정 
        	            anchorYUnits: 'pixels', //Y 축에 대한 값인 46의 단위는 anchorYUnits 속성을 통해 픽셀 단위로 지정한다는 의미
        	            src: '../css/gzonei/SRC/images/program/marker2.png'
        	          })
        	    })
            	});
            map.addLayer(vector);
        },
        error:function(e){
        	console.log(e);
        	alert('devlopinfo_list_조회 실패' + e);
    	}
    });
}
function zoomLayer(val){
	 var layerName = $('input[name="layer"]:checked').val();
	 map.getLayers().array_.some(function (layer) {
	        if (layer.get("name").includes(layerName)) {
	            var source = layer.getSource();
	            getFeatures(source);
	            return true;
	        }
	    });
	 function getFeatures(source){
		 source.getFeatures().some(function (features) {
			 if(features.id_ == val){
				 var extent = features.getGeometry().getExtent();
				 map.getView().fit(extent);
				    if (map.getView().getZoom() > 14) {
				    	map.getView().setZoom(14);
					}
				    return true;
			 }
		 });
	 }
}


function mapEdit(){
	if($("#editMenu").css('display')=='block'){
		$("#editMenu").css('display','none')
		var id = $('input[name="layer"]:checked').val();
		removeInteraction(null, "edit");
	}else{
		$("#editMenu").css('display','block');
	}
}

modifiedFeatures = {};
addedFeatures = {};
removedFeatures = {};
function insertLayer(){
	removeInteraction(null, "edit");
    var vector, source, featureType, selectStyle;
    //선택레이어 변경예정
    var layerName = $('input[name="layer"]:checked').val();
    
    if(layerName=="gz_devlop_info"){
    	featureType = "MultiPolygon";
    }else{
    	featureType = "Point";
    }
    
   	var intersectionFeatures = [];
    map.getLayers().forEach(function (layer) {
        if (layer.get("name").includes(layerName)) {
            vector = layer;
            source = layer.getSource();
        }
    });
    var draw = new ol.interaction.Draw({
        source: source,
        type: featureType
    });
    draw.setProperties({mode: "edit"});

    draw.on("drawstart", function(e){

    });
    
    draw.on("drawend", function(e){
    	var autoInputBox;
        e.feature.layerNm = layerName;
        var rotation = 0;
        e.feature.values_["wrter_opinion"] = "test";
        e.feature.values_["upper_map_code"] = "4100000000";
        if (typeof addedFeatures[layerName] == "undefined") {
        	addedFeatures[layerName] = [];
		}
        addedFeatures[layerName].push(e.feature);
    });
    
    map.addInteraction(draw);
}

function selectLayer(){
	 var select, drawBox, dragBox;
     var oldFeatures = {};
     /*함수가 시작될 때 edit 관련 interaction을 모두 지워버리므로 기존에 select되어 있던 feature들을 꺼내온다.*/
     $.each(map.interactions.array_, function (key, value) {
         if (value.values_.mode == "edit" && value instanceof ol.interaction.Select) {
             oldFeatures = value.getFeatures().array_;
         }
     });
	removeInteraction(null, "edit");
	select = new ol.interaction.Select();
	select.setProperties({name: "boxSelection"});
    select.setProperties({mode: "edit"});
    select.setProperties({type: "select"});
    map.addInteraction(select);
    select.on('select', function (e) {
    	
    });
    map.addInteraction(select);
    var selectedFeatures = select.getFeatures();
    if (dragBox == null) {
        dragBox = new ol.interaction.DragBox({
            condition: function (e) {
                return ol.events.condition.always(e);
            }
        });
        dragBox.setProperties({name: "boxSelection"});
        dragBox.setProperties({mode: "edit"});
    }

    dragBox.on('boxstart', function (e) {
        var shiftKeyPressed = false;
        if (typeof window.event.shiftKey != "undefined") {
            shiftKeyPressed = window.event.shiftKey;
        }
        if (!shiftKeyPressed) {
            var features = select.getFeatures().array_;
            select.getFeatures().clear();
        }
    });

    dragBox.on('boxend', function (e) {
        var extent = dragBox.getGeometry().getExtent();
        map.getLayers().forEach(function (layer, idx) {
        	if (layer.get('layerType') == 'viewLayer') {
        		layer.getSource().forEachFeatureIntersectingExtent(extent, function (feature) {
        			select.getFeatures().push(feature);
        		});
        	}
        	
        })
    });
    map.addInteraction(dragBox);
}

function modifyLayer(){
	var select, modify, selectFeatures;
    var selectFeatures = [], boxFeatures = {}, modifyFeatures = {};
    
    /*기존의 피쳐들과 새로운 피쳐들을 interaction에서 가져옴*/
    $.each(map.interactions.array_, function (key, value) {
    	 if (value.values_.name == "boxSelection" && value instanceof ol.interaction.Select) {
             boxFeatures = value.getFeatures().array_;
         }
         if (value.values_.name == "modifySelection" && value instanceof ol.interaction.Select) {
             modifyFeatures = value.getFeatures().array_;
         }
    });
    
    $.each(boxFeatures, function (key, val) {
        selectFeatures.push(val);
    });
    $.each(modifyFeatures, function (key, val) {
        selectFeatures.push(val);
    });
    
    /*기존 피쳐들과 새로운 피쳐의 중복되는 피쳐가 있을 경우 제거*/
    selectFeatures = selectFeatures.filter(function (value, index, self) {
        return self.indexOf(value) === index;
    });
    /*중복 이벤트를 방지하기 위해 mode가 edit인 interaction을 일괄 제거 시켜줌*/
    removeInteraction(null, "edit");
    
    /*select를 위한 interaction 준비*/
    select = new ol.interaction.Select({
        condition: ol.events.condition.never

    });

    /*새로 만들어진 select interaction에 selectFeatures를 넣어 줌*/
    $.each(selectFeatures, function (key, val) {
        val.beforeGeometry = val.getGeometry().clone();
        select.getFeatures().push(val);
    });
    /*mode와 name에 관한 properties 입력*/
    select.setProperties({mode: "edit"});
    select.setProperties({name: "modifySelection"});
    select.setProperties({type: "select"});

    /*ol의 map객체에 select interaction 추가*/
    map.addInteraction(select);

    
    /*select되어 있는 feature를 modify interaction에 지정을 해줌*/
    modify = new ol.interaction.Modify({
        features: select.getFeatures()
    });

    modify.setProperties({mode: "edit"});
    map.addInteraction(modify);

    modify.on('modifystart', function (e) {
        var features = e.features.array_;
        $.each(features, function(key, val){
            val.revision_ = 0;
        });
    });
    var layerName = $('input[name="layer"]:checked').val();
    modify.on('modifyend', function (e) {
        var features = e.features.array_;
        $.each(features, function (key, val) {
	        if (typeof modifiedFeatures[layerName] == "undefined") {
	        	modifiedFeatures[layerName] = [];
			}
	        if (modifiedFeatures[layerName].indexOf(val) == -1) {
		        modifiedFeatures[layerName].push(val);
	        }
        	
        });
    });
}

function deleteLayer(){
	
	var select, modify, selectFeatures;
    var selectFeatures = [], boxFeatures = {}, modifyFeatures = {};
    /*기존의 피쳐들과 새로운 피쳐들을 interaction에서 가져옴*/
    $.each(map.interactions.array_, function (key, value) {
        if (value.values_.name == "boxSelection" && value instanceof ol.interaction.Select) {
            boxFeatures = value.getFeatures().array_;
        }
        if (value.values_.name == "modifySelection" && value instanceof ol.interaction.Select) {
            modifyFeatures = value.getFeatures().array_;
        }
    });

    /*selectFeatures에 기존 피쳐들과 새로운 피쳐들을 넣어줌*/
    $.each(boxFeatures, function (key, val) {
        selectFeatures.push(val);
    });
    $.each(modifyFeatures, function (key, val) {
        selectFeatures.push(val);
    });
    /*기존 피쳐들과 새로운 피쳐의 중복되는 피쳐가 있을 경우 제거*/
    selectFeatures = selectFeatures.filter(function (value, index, self) {
        return self.indexOf(value) === index;
    });


    map.getLayers().forEach(function (layer) {
   		 var layerName = $('input[name="layer"]:checked').val();
    	 if (layer.get('layerType') == 'viewLayer') {
	         $.each(selectFeatures, function (key, val) {
	             if (typeof val.id_ == "undefined") {
	                 if (typeof addedFeatures[layerName] != "undefined") {
	                     delete addedFeatures[layerName][addedFeatures[layerName].indexOf(val)];
	                     if (!addedFeatures[layerName].hasOwnProperty()) {
	                         delete addedFeatures[layerName];
	                     }
	                 }
	             } else {
	                 if (typeof modifiedFeatures[layerName] != "undefined") {
	                     delete modifiedFeatures[layerName][box.modifiedFeatures[layerName].indexOf(val)];
	                     if (!modifiedFeatures[layerName].hasOwnProperty()) {
	                         delete modifiedFeatures[layerName];
	                     }
	                 }
	                 if (typeof removedFeatures[layerName] == "undefined") {
	                     removedFeatures[layerName] = [];
	                 }
	                 removedFeatures[layerName].push(val);
	                 if (typeof modifyFeatures[layerName] != "undefined") {
	                     if (modifyFeatures[layerName].indexOf(val) > -1) {
	                         var idx = modifyFeatures[layerName].indexOf(val);
	                         delete modifiedFeatures[layerName][idx];
	                     }
	                 }
	             }
	             
	             layer.getSource().removeFeature(val);
	         });
         }
    });
    removeInteraction(null, "edit");
}

function saveLayer(){
	var layerName = $('input[name="layer"]:checked').val();
	var cnt = {
            ins: {
                tryFeatureCnt: 0,
                savedFeatures: 0
            },
            udt: {
                tryFeatureCnt: 0,
                savedFeatures: 0
            },
            del: {
                tryFeatureCnt: 0,
                savedFeatures: 0
            }
        }
	
	$.each(addedFeatures[layerName], function (key, value) {
		var reqData = value.values_;
		var format = new ol.format.WKT();
      	wkt = format.writeGeometry(value.getGeometry());
       	reqData.wkt = wkt;
      	delete reqData.geometry;
     	$.ajax({
           url: '/sample/insertLayer.do',
           type: 'POST',
           async: false,
           datatype : 'json',
           contentType: 'application/x-www-form-urlencoded;charset=utf-8',
           data: reqData
       });
	});
	
	$.each(modifiedFeatures[layerName], function (key, value) {
		var reqData = value.values_;
		var format = new ol.format.WKT();
      	wkt = format.writeGeometry(value.getGeometry());
       	reqData.wkt = wkt;
      	delete reqData.geometry;
     	$.ajax({
           url: '/sample/updateLayer.do',
           type: 'POST',
           async: false,
           datatype : 'json',
           contentType: 'application/x-www-form-urlencoded;charset=utf-8',
           data: reqData
       });
	});
	
	$.each(removedFeatures[layerName], function (key, value) {
		var devlopInfoSn = value.values_.devlopInfoSn;
		$.ajax({
	           url: '/sample/deleteLayer.do',
	           type: 'POST',
	           async: false,
	           datatype : 'json',
	           contentType: 'application/x-www-form-urlencoded;charset=utf-8',
	           data: {devlopInfoSn : devlopInfoSn}
	       });
	});
	
	addedFeatures = {};
	modifiedFeatures = {};
	removedFeatures = {};
	removeInteraction(null, "edit");
	map.removeLayer(map.getLayerByName(layerName));
	viewLayer(layerName);
}

</script>
<!-- contents -->
<div>
	
	<!-- 상단 -->
	<div class="mp_top">
		<div class="l"><!-- left layout -->
			<h3 class="m_tit01 mt15">샘플맵</h3>
		</div>
		<h3 id="zoomlvl"></h3>
		<div class="r"><!-- right layout -->
			<!--지도변경-->
			<div>배경지도 :
				<button onclick="mapChange('Naver');">Naver</button>
				<button onclick="mapChange('Kakao');">Kakao</button>
				<button onclick="mapChange('Google');">Google</button>
			</div>
			<!--컨트롤-->
			<div>지도컨트롤 :
				<button onclick="mapMeasure('length');">거리</button>
				<button onclick="mapMeasure('area');">면적</button>
				<button onclick="mapMeasure('circle');">반경</button>
				<button onclick="removeInteraction()">초기화</button>
				<button id="btn_zoonin">줌인</button>
				<button id="btn_zoonout">줌아웃</button>
				<button onclick="mapSaveImg();">지도저장</button>
				<button onclick="mapEdit();">지도편집</button>
			</div>
			<div>vWorld 레이어목록 :
				<input type='checkbox' onclick='layer_box_chk(this.checked,"lt_c_upisuq153");'/>도시계획(공간시설)
				<input type='checkbox' onclick='layer_box_chk(this.checked,"lt_c_upisuq155");'/>도시계획(공공문화체육시설)
				<input type='checkbox' onclick='layer_box_chk(this.checked,"lt_c_upisuq156");'/>도시계획(방재시설)
				<input type='checkbox' onclick='layer_box_chk(this.checked,"lt_c_upisuq157");'/>도시계획(보건위생시설)
				<input type='checkbox' onclick='layer_box_chk(this.checked,"lt_c_upisuq161");'/>지구단위계획
				<input type='checkbox' onclick='layer_box_chk(this.checked,"lt_c_damdan");'/>단지경계
				<input type='checkbox' onclick='layer_box_chk(this.checked,"lt_c_damyoj");'/>단지시설용지
				<input type='checkbox' onclick='layer_box_chk(this.checked,"lt_c_wkmstrm");'/>하천망
				<input type='checkbox' onclick='layer_box_chk(this.checked,"lt_c_uq129");'/>개발진흥지구
				<input type='checkbox' onclick='layer_box_chk(this.checked,"lt_c_uma100");'/>국립공원용도지구
				<input type='checkbox' onclick='layer_box_chk(this.checked,"lt_c_uq162");'/>도시자연공원구역
				<input type='checkbox' onclick='layer_box_chk(this.checked,"lt_c_ud610");'/>국민임대주택
				<input type='checkbox' onclick='layer_box_chk(this.checked,"lt_c_uo601");'/>관광지
				<input type='checkbox' onclick='layer_box_chk(this.checked,"lt_c_ud620");'/>보금자리주택
				<input type='checkbox' onclick='layer_box_chk(this.checked,"lt_c_lhzone");'/>사업지구경계도
				<input type='checkbox' onclick='layer_box_chk(this.checked,"lp_pa_cbnd_bonbun,lp_pa_cbnd_bubun");'/>지적도
				<input type='checkbox' onclick='layer_box_chk(this.checked,"lt_c_wgisnpgug");'/>국립자연공원
				<input type='checkbox' onclick='layer_box_chk(this.checked,"lt_c_wgisnpgun");'/>군립자연공원
				<input type='checkbox' onclick='layer_box_chk(this.checked,"lt_c_wgisnpdo");'/>도립자연공원
			</div>	
			<div id ="layerList">레이어목록 :
				<input type='checkbox' name='layer' value='gzonei:gz_devlop_info' onclick= 'layer_box_chk(checked,"gzonei:gz_devlop_info");'/>개발정보wms
				<input type='checkbox' name='layer' value='gz_devlop_info' onclick= 'layer_box_chk(checked,"gz_devlop_info");'/>개발정보레이어
			</div>
			<div id="editMenu" style="display: none;">편집모드 :
				<button onclick="insertLayer()">등록</button>
				<button onclick="selectLayer()">선택</button>
				<button onclick="modifyLayer()">수정</button>
				<button onclick="deleteLayer()">삭제</button>
				<button onclick="saveLayer()">저장</button>
			</div>			
			<div id="totalWrap">
				<ul id='listSelect'></ul>
				<div id="map1">
				</div>
				<div id="mapTabs">
				<button type="button" class="on mapir naver" data-map="naver"><span>네이버맵</span></button>
				<button type="button" class="mapir kakao" data-map="kakao"><span>카카오맵</span></button>
				<button type="button" class="mapir google"  data-map="google"><span>구글맵</span></button>
			</div>
			<div id="iconSort">
				<button type="button" class="on all" data-sort="all"><span>전체</span></button>
				<button type="button" class="sort1" data-sort="1"><span>보상전례</span></button>
				<button type="button" class="sort2" data-sort="2"><span>투자정보</span></button>
				<button type="button" class="sort3"  data-sort="3"><span>개발정보</span></button>
			</div>
			<div id="quickGuide">
				<button type="button" class="mapir icon1 on">01</button>
				<button type="button" class="mapir icon2">02</button>
				<button type="button" class="mapir icon3">03</button>
				<button type="button" class="mapir icon4">04</button>
				<button type="button" class="mapir icon5">05</button>
				<button type="button" class="mapir icon6">06</button>
				<button type="button" class="mapir icon7">07</button>
				<button type="button" class="mapir icon8">08</button>
				<button type="button" class="mapir icon9">09</button>
				<button type="button" class="mapir icon10">10</button>
				<button type="button" class="mapir icon11">11</button>
				<button type="button" class="mapir icon12">12</button>
				<button type="button" class="mapir icon13">13</button>
				<button type="button" class="mapir icon14">14</button>
				<div class="dropbox">
					<button type="button" class="text-button">등록</button>
					<button type="button" class="text-button">선택</button>
					<button type="button" class="text-button">수정</button>
					<button type="button" class="text-button">삭제</button>
					<button type="button" class="text-button">저장</button>
				</div>
			</div>
				<div id="popup" class="ol-popup">
			      <a href="#" id="popup-closer" class="ol-popup-closer"></a>
			      <div id="popup-content"></div>
			    </div>
			</div>
		</div>
	</div>
	
	<!-- 배너 -->
	<h3 class="m_tit01 mt15">배너 위치</h3><!-- 배너 -->
	<div class="mp_bn">
		
	</div>

<!-- bottom -->

</div><!-- contents -->

</body>
</html>
