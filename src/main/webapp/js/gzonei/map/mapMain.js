var map; //초기설정
var draw, select, lonlat, container, content, closer, overlay; //거리측정 변수
var maxLevel, interactions;
//사업지구 코드리스트
var dsTrcList = [];
//벡터정의
var vectorSource = new ol.source.Vector();
jQuery.loadScript = function(url, callback) {
    jQuery.ajax({
        url: url,
        dataType: 'script',
        success: callback,
        error: function(err) {
            console.log('스크립트 로드  실패');
        },
        async: true
    });
};
$(document).ready(function() {

    //투자 정보리스트 닫기(버튼) - 사용자
    $('#invtAdmSideOff').on('click', function(e) {
        map.removeLayer(map.getLayerByName('gz_invt_info'));
        if (select != null) {
            select.getFeatures().clear();
        }
        $("#sideAdmin").removeClass("moveTo");
        $('#sideAdminTg').css('display', 'none');
    });
    //투자 정보리스트 닫기(버튼) - 사용자
    $('#devAdmSideOff').on('click', function(e) {
        map.removeLayer(map.getLayerByName('gz_devlop_info'));
        if (select != null) {
            select.getFeatures().clear();
        }
        $("#sideAdmin").removeClass("moveTo");
        $('#sideAdminTg').css('display', 'none');
    });
    //투자 정보리스트 닫기(버튼) - 사용자
    $('#rewardAdmSideOff').on('click', function(e) {
        map.removeLayer(map.getLayerByName('gz_reward_precednt_info'));
        if (select != null) {
            select.getFeatures().clear();
        }
        $("#sideAdmin").removeClass("moveTo");
        $('#sideAdminTg').css('display', 'none');
    });
    var zoomLevel1 = checkAuthValue('map001001', 'menuAccesAt');
    var zoomLevel2 = checkAuthValue('map001002', 'menuAccesAt');
    var zoomLevel3 = checkAuthValue('map001003', 'menuAccesAt');
    var moveCt = checkAuthValue('map002001', 'menuAccesAt');
    if (zoomLevel3 == 'Y') {
        maxLevel = 8;
    } else if (zoomLevel2 == 'Y') {
        maxLevel = 10;
    } else {
        maxLevel = 13;
    }
    if (moveCt == 'N') {
        interactions = ol.interaction.defaults({
            doubleClickZoom: false,
            dragAndDrop: false,
            dragPan: false,
            keyboardPan: false,
            keyboardZoom: false,
            pointer: false,
            select: false
        })
    } else {
        interactions = null;
    }
});

$(document).keydown(function(event) {
    if (event.keyCode == 27 || event.which == 27) {
        removeInteraction();
    }
});

$(function() {
    var init,
        frontData,
        dataInfo = new Object(),
        dataItem = new Array(),
        dataSetup,
        mapSetup,
        iconSort,
        navControl,
        manuscript;

    var mapType,
        mapContainer,
        mapOptions,
        locPosition,
        imageSrc,
        imageSize,
        markerImage,
        bounds;

    var tempDownControl,
        tempMoreControl,
        tempSideControl,

        init = function() {
            dataSetup();
            navControl();
            submitControl();
            tempSideControl();
            adminSideControl();
            modalPop();
            searchDetail();
            toolTip();
            fn_scroll_plugin();
            accordionControl();
            sideSearchControl();
            infoSideControl();
            mapSetup();
            iconSort();
            sideMenu__mode();
        };
    dataSetup = function() {
        // 지도뿌리기
        map = new ol.Map({
            target: 'realMap',
            layers: [
                new ol.layer.Tile({
                    title: 'Naver Satellite Map',
                    name: 'Naver Satellite Map',
                    layerType: 'backgroundMap',
                    source: new ol.source.XYZ({
                        projection: new ol.proj.Projection({
                            code: 'EPSG:5179',
                            extent: [90112, 1192896, 1990673, 2761664],
                            units: 'm'
                        }),
                        tileGrid: new ol.tilegrid.TileGrid({
                            extent: [90112, 1192896, 1990673, 2761664],
                            origin: [90112, 1192896],
                            resolutions: [2048, 1024, 512, 256, 128, 64, 32, 16, 8, 4, 2, 1, 0.5, 0.25]
                        }),
                        tileUrlFunction: function(tileCoord, pixelRatio, projection) {
                            if (tileCoord == null) return undefined;

                            var z = tileCoord[0] + 1;
                            var x = tileCoord[1];
                            var y = tileCoord[2];

                            return 'https://simg.pstatic.net/onetile/get/197/0/1/' + z + '/' + x + '/' + y + '/bl_st_bg';
                        }
                    }),
                    visible: true
                }),
                new ol.layer.Tile({
                    title: 'Kakao Satellite Map',
                    name: 'Kakao Satellite Map',
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
                        tileUrlFunction: function(tileCoord, pixelRatio, projection) {
                            if (tileCoord == null) return undefined;

                            var z = 14 - tileCoord[0];
                            var x = tileCoord[1];
                            var y = tileCoord[2];
                            return "http://map0.daumcdn.net/map_skyview/L" + z + "/" + y + "/" + x + ".jpg?v=160114";
                        }
                    }),
                    visible: false
                }),
                new ol.layer.Tile({
                    title: 'Google Satellite Map',
                    name: 'Google Satellite Map',
                    layerType: 'backgroundMap',
                    source: new ol.source.OSM({
                        url: "http://mt1.google.com/vt/lyrs=s&hl=pl&&x={x}&y={y}&z={z}"
                    }),
                    visible: false
                }),
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
                        tileUrlFunction: function(tileCoord, pixelRatio, projection) {
                            if (tileCoord == null) return undefined;

                            var z = tileCoord[0] + 1;
                            var x = tileCoord[1];
                            var y = tileCoord[2];

                            return 'https://simg.pstatic.net/onetile/get/197/0/0/' + z + '/' + x + '/' + y + '/bl_vc_bg/ol_vc_an';
                        },
                        crossOrigin: 'Anonymous'
                    }),
                    visible: false
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
                        tileUrlFunction: function(tileCoord, pixelRatio, projection) {
                            if (tileCoord == null) return undefined;

                            var z = 14 - tileCoord[0];
                            var x = tileCoord[1];
                            var y = tileCoord[2];

                            return "http://map1.daumcdn.net/map_2d/2103dor/L" + z + "/" + y + "/" + x + ".png";
                        }
                    }),
                    visible: false
                }),
                new ol.layer.Tile({
                    title: 'Google Street Map',
                    name: 'Google Street Map',
                    layerType: 'backgroundMap',
                    source: new ol.source.OSM({
                        url: "https://mt0.googleapis.com/maps/vt?pb=!1m5!1m4!1i{z}!2i{x}!3i{y}!4i256!2m3!1e0!2sm!3i329238860!3m9!2sko-KR!3sUS!5e18!12m1!1e47!12m3!1e37!2m1!1ssmartmaps!4e0",
                        crossOrigin: 'Anonymous'
                    }),
                    visible: false
                })
            ],
            view: new ol.View({
                zoom: 10, // 초기화면 zoom level
                maxZoom: 19,
                minZoom: maxLevel,
                projection: 'EPSG:3857',
                units: 'm'
            }),
            controls: ol.control.defaults({
                zoom: false,
                attribution: false,
                rotate: false
            }),
            interactions: interactions
        });
        map.getView().setCenter(ol.proj.fromLonLat([126.90297485081749, 37.53624148971899]));
        map.getView().setZoom(13);
        map.on("moveend", moveEnd);
        map.on('click', function(evt) {
            var feature = map.forEachFeatureAtPixel(evt.pixel, function(feature) {
                return feature;
            });
            if (!feature) {
                var layers = [];
                map.getLayers().forEach(function(layer) {
                    if (layer.get("name").includes('gz_')) {
                        layers.push(layer);
                    }
                });
                for (var i = 0; i < layers.length; i++) {
                    var source = layers[i].getSource();
                    source.getFeatures().forEach(function(features) {
                        overlay.setPosition(undefined);
                        closer.blur();
                        setFeatureStyle(features, "deselect");
                    });
                }
            }
        });

        container = document.getElementById('popup');
        content = document.getElementById('popup-content');
        closer = document.getElementById('popup-closer');

        //팝업닫기
        closer.onclick = function() {
            overlay.setPosition(undefined);
            closer.blur();
            setFeatureStyle(select.getFeatures().array_[0], 'deselect');
            if (select != null) {
                select.getFeatures().clear();
            }
            return true;
        };

        overlay = new ol.Overlay({
            element: container,
            autoPan: true,
            autoPanAnimation: {
                duration: 250
            }
        });
        map.addOverlay(overlay);

        function moveEnd(event) {
            $("#zoomlvl").text("줌레벨 : Lv" + event.map.getView().getZoom().toFixed(0));
        };

    };

    accordionControl = function() {
        var accordion = $(".mapAll");
        var list = accordion.find(".list");
        var accordion_button = accordion.find(".minus2");

        accordion_button.on('click', function() {
            if (!$(this).parent().parent().hasClass('open')) {

                list.removeClass('open');
                $('.mapsCont').removeClass('open');
                $(this).parent().parent().addClass('open');
                $(this).next('.list').addClass('open');

            }
        });

    };

    submitControl = function() {
        var submit = $(".submit");
        var closeResult = $("#searchResult .close");
        submit.on('click', function() {
            var submitType = $(this).data('id');
            var moreBtnTxt = $('#devInfoMore button').html();
            var area1 = $('#area1 option:selected').val();
            var area2 = $('#area2 option:selected').val();
            var invArea1 = $('#invArea1 option:selected').val();
            var invArea2 = $('#invArea2 option:selected').val();
            switch (submitType) {
                case 'topArea':
                    if ($('#searchKeyword').val() != '' && $('#searchKeyword').val() != null) {
                        areaSetup();
                        break;
                    } else {
                        break;
                    }
                    case 'area':
                        if (area1 == null || area1 == "" || area2 == null || area2 == "") {
                            /*if(moreBtnTxt != '상세검색'){
                            	areaSetup();
                            }*/
                            if (checkAuthValue('dev001003', 'infoInqireAt') == "Y") {
                                areaSetup();
                                //startDevInfoSearch();
                            }
                            break;
                        } else {
                            areaSetup();
                            //startDevInfoSearch();
                            break;
                        }
                        case 'biz':
                            if ((invArea1 == null || invArea1 == '' || invArea2 == null || invArea2 == '') && $('#incdntManageNoThing').val() == "" && $('#incdntManageNoDtl').val() == "" && $('#invDs1').val() == "") {
                                break;
                            } else {
                                bizSetup();
                                break;
                            }
                            break;
                        default:
                            break;
            }
        });
        closeResult.on('click', function() {
            if (checkAuthValue('ivt001001', 'infoInqireAt') == 'N') {
                map.removeLayer(map.getLayerByName('gz_invt_info'));
                $("#sideAdmin").hide();
                $('#sideAdminTg').css('display', 'none');
            }

            $("#searchResult").hide();
            $("#info").hide();
            overlay.setPosition(undefined);
            closer.blur();
            if (select != null) {
                select.getFeatures().clear();
            }
            map.removeLayer(map.getLayerByName('gz_devlop_info'));
            map.removeLayer(map.getLayerByName('gz_reward_precednt_info'));
            //		  	removeInteraction('viewLayer', "edit");
        });
    };
    areaSetup = function() {
        //if($('#tab2')[0].title == '열림' /*|| $('#tab2')[0].title == ''*/){}
        if ($('li.link-tab.on a').text() == '투자정보' /*|| $('#tab2')[0].title == ''*/ ) {} else {
            $("#searchResult").show();
            $(".searchResult__obj").mCustomScrollbar({
                theme: "dark-1",
                autoHideScrollbar: "true",
                mouseWheelPixels: 300, // 마우스휠 속도
                scrollInertia: 400 // 부드러운 스크롤 효과 적용
            });
        }
    };
    bizSetup = function() {

    };
    navControl = function() {
        var tab = $(".link-tab a");
        tab.on("click", function(event) {
            if (event.preventDefault) {
                event.preventDefault()
            } else {
                event.returnValue = false
            }
            var $this = $(this),
                $scope = $this.parents('.ui-tablist'),
                $tabButtons = $scope.find('.link-tab'),
                $ovTab = $tabButtons.filter('.on')
            if ($ovTab[0] !== $this[0]) {
                var $tabPanels = $scope.find('.obj'),
                    $ovPanel = $tabPanels.filter('.on')
                $ovTab.removeClass('on');
                $ovTab.children('a').attr('aria-selected', 'false');
                $ovTab.children('a').attr("title", "숨김");

                $this.parent('li').addClass('on');
                $this.attr('aria-selected', 'true');
                $this.attr("title", "열림");
                var href = $this.attr("aria-controls");
                $ovPanel.removeClass('on');
                $("[id=" + href + "]").addClass('on');
                fn_scroll_plugin();
                $("#info").hide();
                overlay.setPosition(undefined);
                closer.blur();
                //			  	var id = $this[0].dataset.id;
                //			  	map.removeLayer(map.getLayerByName(id));
            }
            event.preventDefault();
        });
    };

    fn_scroll_plugin = function() {

        $(".scrollbar").mCustomScrollbar({
            theme: "dark-1",
            autoHideScrollbar: "true",
            mouseWheelPixels: 300, // 마우스휠 속도
            scrollInertia: 400 // 부드러운 스크롤 효과 적용
        });

    };
    //관리자
    $('#btn_admin').on('click', function() {
        $('[data-ly-target="modal-map-adminList"]').modal('show');
        //개발정보 목록 호출

        devInfoAdminList();
    });

    // 줌인
    $('#btn_zoonin').on('click', function() {
        removeInteraction();
        var view = map.getView();
        var zoom = view.getZoom();
        view.setZoom(zoom + 1);
    });

    // 줌아웃
    $('#btn_zoonout').on('click', function() {
        removeInteraction();
        var view = map.getView();
        var zoom = view.getZoom();
        view.setZoom(zoom - 1);
    });

    mapSetup = function(mapType) {
        var mapTabs = $('#mapTabs');
        var mapType, mapMode;
        var iconSort = $('#iconSort');
        mapTabs.on('click', 'button', function(mapType) {
            mapType = $(this).data('map');
            mapMode = $(iconSort.find('.on')).data('mode');
            if (mapMode == null || mapMode == '') {
                mapMode = 'Satellite';
            }
            mapTabs.find('button').removeClass('on');
            $(this).addClass('on');
            mapType = mapType + ' ' + mapMode;
            map.getLayers().forEach(function(layer, i) {
                if (layer.values_.layerType == "backgroundMap") {
                    layer.setVisible(false);
                    layer.setOpacity(0);
                }
                if (layer.values_.name.toLowerCase().indexOf(mapType.toLowerCase()) > -1) {
                    layer.setVisible(true);
                    layer.setOpacity(1);
                }
            });
        });
        $('#mapTabs > button').eq(0).click();
    }

    iconSort = function() {
        var mapType, mapMode;
        var mapTabs = $('#mapTabs');
        var iconSort = $('#iconSort');
        iconSort.on('click', 'button', function(mapMode) {
            mapMode = $(this).data('mode');
            iconSort.find('button').removeClass('on');
            $(this).addClass('on');
            mapType = $(mapTabs.find('.on')).data('map');
            mapType = mapType + ' ' + mapMode;
            map.getLayers().forEach(function(layer, i) {
                if (layer.values_.layerType == "backgroundMap") {
                    layer.setVisible(false);
                    layer.setOpacity(0);
                }
                if (layer.values_.name.toLowerCase().indexOf(mapType.toLowerCase()) > -1) {
                    layer.setVisible(true);
                    layer.setOpacity(1);
                }
            });
        });
        $('#iconSort > button').eq(0).click();
    }

    tempSideControl = function() {
        var info = $(".searchResult__obj");
        var infoSubmit = info.find(".link");
        infoSubmit.on('click', function() {
            $("#info").show();
            $(".searchResult__obj .scroll").mCustomScrollbar({
                theme: "dark-1",
                autoHideScrollbar: "true",
                mouseWheelPixels: 300, // 마우스휠 속도
                scrollInertia: 400 // 부드러운 스크롤 효과 적용
            });
            $("#sideAdmin").hide();
        });
        var infoClose = $("#info_close");
        infoClose.on('click', function() {
            if (checkAuthValue('ivt001001', 'infoInqireAt') == 'N') {
                map.removeLayer(map.getLayerByName('gz_invt_info'));
                $("#sideAdmin").hide();
                $('#sideAdminTg').css('display', 'none');
                if (select != null) {
                    select.getFeatures().clear();
                }
            }
            map.removeLayer(map.getLayerByName('gz_reward_precednt_info'));
            if (select) {
                if (select.getFeatures().array_[0]) {
                    if (map.getLayerByName('gz_devlop_info').getSource().getFeatures().length == 1 && select.getFeatures().array_[0].values_.mapId != 'gz_devlop_info') {
                        map.removeLayer(map.getLayerByName('gz_devlop_info'));
                    }
                }
            }
            $("#info").hide();
            $('#devInfoDtlForm')[0].reset();
        });
        var infoObject = $("#infoObject");
        infoObject.on('click', function() {

            var $href = $(this).attr('href');
            layer_popup($href);
        });

        function layer_popup(el) {
            var $el = $(el); //레이어의 id를 $el 변수에 저장
            var isDim = $el.prev().hasClass('dimBg'); //dimmed 레이어를 감지하기 위한 boolean 변수

            $el.fadeIn();
            $('html,body').addClass("modal__open");

            var $elWidth = ~~($el.outerWidth()),
                $elHeight = ~~($el.outerHeight()),
                docWidth = $(document).width(),
                docHeight = $(document).height();

            // 화면의 중앙에 레이어를 띄운다.
            if ($elHeight < docHeight || $elWidth < docWidth) {
                $el.css({
                    marginTop: -$elHeight / 2,
                    marginLeft: -$elWidth / 2
                })
            } else {
                $el.css({
                    top: 0,
                    left: 0
                });
            }

            $el.find('.btn-layerClose').click(function() {
                $el.fadeOut(); // 닫기 버튼을 클릭하면 레이어가 닫힌다.
                $('html,body').removeClass("modal__open");
                return false;
            });

        }

    };
    sideSearchControl = function() {
        var sideSearch = $("#side");
        var searchToggle = sideSearch.find(".side_toggle");
        searchToggle.on('click', function() {
            $("#side").toggleClass('moveTo');
            $("#totalWrap").toggleClass('moveTo');
            $(window).resize(function() {
                if ($(window).width() < 1023) return false;
                if ($(window).width() > 1023) {
                    if ($(this).parents("#side").hasClass('moveTo')) {
                        $('html, body').animate({
                            scrollTop: $("#side").offset().top
                        }, 2000);
                    } else {
                        $('html, body').animate({
                            scrollTop: 0
                        }, 2000);
                    };
                }
            });
        });
    };
    infoSideControl = function() {

        var info = $("#info");
        var sideToggle = info.find(".side_toggle");
        sideToggle.on('click', function() {
            $("#info").toggleClass('moveTo');
        });

        $(window).resize(function() {
            if ($(window).width() < 1023) return false;
            if ($(window).width() > 1023) {
                if ($(this).parents("#info").hasClass('moveTo')) {
                    $('html, body').animate({
                        scrollTop: $("#info").offset().top
                    }, 2000);
                } else {
                    $('html, body').animate({
                        scrollTop: 0
                    }, 2000);
                };
            }
        });

    };
    adminSideControl = function() {

        var sideAdmin = $("#sideAdmin");
        var sideToggle = sideAdmin.find(".side_toggle");
        sideToggle.on('click', function() {
            $("#sideAdmin").toggleClass('moveTo');
        });

        $(window).resize(function() {
            if ($(window).width() < 1023) {
                //$('#quickGuide .item').css('display','none');
                return false;
            }
            if ($(window).width() > 1023) {
                //$('#quickGuide .item').css('display','block');
                if ($(this).parents("#side").hasClass('moveTo')) {
                    $('html, body').animate({
                        scrollTop: $("#side").offset().top
                    }, 2000);
                } else {
                    $('html, body').animate({
                        scrollTop: 0
                    }, 2000);
                };
            }
        });

    };

    searchDetail = function() {

        var detail = $(".obj");
        var detailBtn = detail.find(".btn--more button");

        detailBtn.on('click', function() {

            var $this = $(this),
                $scope = $this.parents().parent('.mapSearch__area').find('.mapSearch__biz')

            if ($scope.css("display") == "none") {
                $scope.show();
                $this.addClass('remore').text('간편검색')
                if (this.form) {
                    if (this.form.id == "invtListForm") {
                        $("#startDate3").val(getFormatDate(new Date()));
                        $("#endDate3").val(getFormatDate2(new Date()));
                    }
                }
            } else {
                $this.removeClass('remore').text('상세검색')
                if (this.form) {
                    if (this.form.id == "invtListForm") {
                        $("#startDate3").val('');
                        $("#endDate3").val('');
                    }
                }
            }

        });

        function getFormatDate(date) {
            var year = date.getFullYear();
            var month = (1 + date.getMonth());
            month = month >= 10 ? month : '0' + month;
            var day = date.getDate();
            day = day >= 10 ? day : '0' + day;
            return year + '-' + month + '-' + day;
        }

        function getFormatDate2(date) {
            var year = date.getFullYear();
            var month = (2 + date.getMonth());
            month = month >= 10 ? month : '0' + month;
            var day = date.getDate();
            day = day >= 10 ? day : '0' + day;
            return year + '-' + month + '-' + day;
        }
    }
    toolTip = function() {

        $('.td__knowhow').on({
            "mouseenter": function() {
                var titleText = $(this).attr("title");
                $(this).data("tooltip", titleText).removeAttr("title");
                $('body').after('<div class="tooltipBox"><div class="tooltip-inner">' + titleText + '</div></div>').fadeIn("slow");
            },
            "mouseleave": function() {
                $(this).attr("title", $(this).data("tooltip"));
                $(".tooltipBox").remove();
            },
            "mousemove": function(e) {
                var mouseX = e.pageX - 10;
                var mouseY = e.pageY + 20;
                $(".tooltipBox").css({
                    "left": mouseX,
                    "top": mouseY
                });
            }
        });

        $('.module .tooltip').on({
            "mouseenter": function() {
                var titleText = $(this).attr("title");
                $(this).data("tooltip", titleText).removeAttr("title");
                $('body').after('<div class="tooltipBox"><div class="tooltip-inner">' + titleText + '</div></div>').fadeIn("slow");
            },
            "mouseleave": function() {
                $(this).attr("title", $(this).data("tooltip"));
                $(".tooltipBox").remove();
            },
            "mousemove": function(e) {
                var mouseX = e.pageX - 10;
                var mouseY = e.pageY + 20;
                $(".tooltipBox").css({
                    "left": mouseX,
                    "top": mouseY
                });
            }
        });

    }
    sideMenu__mode = function() {

        $('#quickGuide .item').on({
            "mouseenter": function() {
                $(this).find('button').addClass('on');
                $(this).find('.dropbox').fadeIn(300);
            },
            "mouseleave": function() {
                $(this).find('button').removeClass('on');
                $(this).find('.dropbox').fadeOut(300);


            }
        });

    };
    modalPop = function() {
        /*$('#infoObject, #infoAdd').on('click', function(){
	        var lyTarget = $(this).data('lyDevbtn');
	        var modalId = $(this).data('modalId');
	        
	        
	        $('#'+modalId).modal({backdrop: false});
	        if($(this)[0].dataset.id == "dtlInvtInfo"){
	        	$('#'+modalId).modal({backdrop: false, keyboard: false});
	        }else{
	        	$('#'+modalId).modal({backdrop: false, keyboard: false});
	        }
	        //$('#'+modalId).modal({backdrop: false, keyboard: false});
	        
	        $("html,body").addClass("ly__open");
	        
	        var $deviceHeight = $(window).outerHeight();
	        setTimeout(function(){
	            var $popHeight = $('#'+modalId).find('.modal__content').outerHeight();
	           
	            if($deviceHeight<=$popHeight){
	                $('#'+modalId).closest('.modal').addClass('over');
	            }
	
	        },300)
	        
	    });
	    
		$('.devInfoCloseBtn').on('click', function(){
	        if($(document).find('div.mask').length >= 1) {
	            $('div.mask').remove();
	        }
	        $(document).find('[data-ly-devtarget]').modal('hide');
	    });*/
    };
    init();
});

//지도저장
function mapSaveImg() {
    var format = 'a4';
    var dim = [297, 210];
    var resolution = 150;
    var width = Math.round(dim[0] * resolution / 25.4);
    var height = Math.round(dim[1] * resolution / 25.4);
    var size = (map.getSize());
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
    map.getView().fit(extent, {
        size: printSize
    });
}

//거리, 면적, 반경
function mapMeasure(val) {
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
                color: 'rgba(103, 3, 142, 0.2)'
            }),
            stroke: new ol.style.Stroke({
                color: 'rgba(103, 3, 142, 0.8)',
                width: 2
            }),
            image: new ol.style.Circle({
                radius: 7,
                stroke: new ol.style.Stroke({
                    color: 'rgba(0, 0, 0, 0.7)'
                }),
                fill: new ol.style.Fill({
                    color: 'rgba(255, 255, 255, 0.2)'
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
        // 모바일을 위한 문구 삭제
        var window_w = $(window).width();
        if (window_w < 768) {
            var helpMsg = '그리기 시작하려면 클릭하세요.';
        } else {
            var helpMsg = '그리기 시작하려면 클릭하세요<br>ESC : 그리기 종료'
        }

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
            output = (Math.round(length / 1000 * 100) / 100) + ' ' + 'km';
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

    var formatRadius = function(circle) {
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
        if (val == 'area') {
            type = 'Polygon'
        } else if (val == 'length') {
            type = 'LineString'
        } else {
            type = 'Circle'
        };
        draw = new ol.interaction.Draw({
            source: vectorSource,
            type: type
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

        draw.on('drawend', function(e) {
            measureTooltipElement.className = 'tooltip tooltip-static';
            measureTooltip.setOffset([0, -7]);

            sketch = null;

            measureTooltipElement = null;
            if (select != null) {
                select.getFeatures().clear();
            }
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

function removeInteraction(name, mode) {
    var removeInteraction = [];
    var layersToRemove = [];
    if (mode != null) {
        $.each(map.interactions.array_, function(key, val) {
            if (typeof val.values_.mode != "undefined") {
                if (val.values_.mode == mode) {
                    if (val instanceof ol.interaction.Select) {
                        var features = val.getFeatures().array_;
                    }
                    removeInteraction.push(val);
                }
            }
        });
        if (name != null) {
            map.getLayers().forEach(function(layer) {
                if (layer.values_.layerType != undefined && layer.values_.layerType == name) {
                    layersToRemove.push(layer);
                }
            });
            for (var i = 0; i < layersToRemove.length; i++) {
                map.removeLayer(layersToRemove[i]);
            }
        }
    } else {
        $('.tooltip').remove();
        vectorSource.clear();
        map.getLayers().forEach(function(layer, i) {
            if (layer.values_.layerType == "measureMap") {
                map.removeLayer(layer);
            }
        });
        removeInteraction.push(draw);
    }

    $.each(removeInteraction, function(key, val) {
        map.removeInteraction(val);
    });
}

//레이어 checkbox 체크시 레이어 ON/OFF
function layer_box_chk(checked, id) {
    if (checked) {
        vworld_wmslayer(id);
    } else {
        map.removeLayer(map.getLayerByName(id));
    }
}
//브이월드 호출(api key 변경 필요)
function vworld_wmslayer(id) {
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
                DOMAIN: "https://localhost:8080",
                title: id,
                FORMAT: "image/png",
                EXCEPTIONS: "text/xml",
            }
        })
    });
    vworld_wmslayer.setZIndex('98');
    map.addLayer(vworld_wmslayer);
}

//db에서 데이터 추출(권한별 레이어 point&polygon 형태로 표출)
function viewLayer(feature, id, dsCodeList) {
    if (feature != null) {
        map.removeLayer(map.getLayerByName(id));
        $("#info").addClass('moveTo');
        //			$("#info").hide();
        overlay.setPosition(undefined);
        closer.blur();
        removeInteraction(null, "edit");
        var features = [];
        var text = "";
        var j = 0;
        for (var i = 0; i < feature.length; i++) {
            var wkt = feature[i].wkt;
            if (wkt != null) {
                var format = new ol.format.WKT();
                features[j] = format.readFeature(wkt, {
                    dataProjection: 'EPSG:3857',
                    featureProjection: 'EPSG:3857'
                });
                for (key in feature[i]) {
                    features[j].set(key, feature[i][key]);
                }
                features[j].set("mapId", id);
                if (id == 'gz_devlop_info') {
                    features[j].setId(feature[i].devlopInfoSn);
                } else {
                    features[j].setId(feature[i].invtInfoSn);
                }
                j++;
            }
        }
        //사업지구 리스트 전역변수 추가
        if (dsCodeList) {
            dsTrcList = dsCodeList;
        }
        //리스트 임시
        var layerSource = new ol.source.Vector();
        layerSource.addFeatures(features);
        var vector = new ol.layer.Vector({
            source: layerSource,
            id: id,
            name: id,
            layerType: 'viewLayer'
        });
        if (id == "gz_devlop_info") {
            vector.setZIndex('100');
        } else if (id == 'gz_invt_info') {
            vector.setZIndex('101');
        }
        features.forEach(function(feature) {
            setFeatureStyle(feature, "deselect")
        });
        map.addLayer(vector);
        vector.set('selectable', true);
        // 현재 줌 고정
        var view = map.getView();
        var zoom = view.getZoom();
        //		    view.setZoom(zoom);
        map.getView().setCenter(layerSource.getFeatures()[0].getGeometry().getExtent());
        select = new ol.interaction.Select({
            layers: function(layer) {
                return layer.get('selectable') == true;
            }
        });
        select.setProperties({
            mode: "edit"
        });
        map.addInteraction(select);

        if (id == 'gz_devlop_info' || id == 'gz_invt_info' || id == 'gz_reward_precednt_info') {
            select.on('select', function(e) {
                //팝업
                var features = e.selected;
                var deselected = e.deselected;
                if (typeof features[0] != "undefined" && typeof features[0].id_ != "undefined") {
                    if (features.length > 0) {
                        var feature = select.getFeatures().array_[0];
                        var extent = feature.getGeometry().getExtent();
                        //	         		    var coordinate = ol.extent.getCenter(extent);
                        var coordinate = e.mapBrowserEvent.coordinate;
                        //투자정보&개발정보 선택
                        var str = feature.values_.mapId;
                        //	         		    var chkType = feature.getGeometry().getType();
                        //		  				 if(chkType != 'Point'){
                        //		  					 $(".ol-popup").css("bottom","15px");
                        //		  				 }else{
                        //		  					$(".ol-popup").css("bottom","50px");
                        //		  				 }
                        $(".ol-popup").css("bottom", "0px");
                        if (str == "gz_devlop_info") {
                            popup(feature, coordinate);
                        } else if (str == "gz_invt_info") {
                            zoomInv(feature.values_.invtInfoSn);

                        } else {
                            popup(feature, coordinate);
                        }
                        //select style
                        setFeatureStyle(feature, "select");
                        if (deselected != null) {
                            deselected.forEach(function(feature) {
                                setFeatureStyle(feature, "deselect");
                            });
                        }
                    } else {
                        deselected.forEach(function(feature) {
                            setFeatureStyle(feature, "deselect");
                        });
                    }
                } else {
                    return false;
                }
            });
        }

    }
}

function popup(feature, coordinate) {

    var chk = feature.values_.mapId;
    var iwContent;
    var resData;
    if (chk == 'gz_devlop_info') {
        //개발정보
        var devlopInfoSn = feature.values_.devlopInfoSn;
        //이미지 추가
        resData = getAjaxResult(devlopInfoSn, getContextPath() + "/devlopInfo/selectOldImgFileList.do");
        //면적
        var bsnsAr = "";
        if (feature.values_.bsnsArMeter) {
            bsnsAr += '		<tr class="mainMapTxt">                             ';
            bsnsAr += '			<td class="txtJust">                              ';
            switch (feature.values_.unitTy) {
                case "길이":
                    bsnsAr += '				길 이&nbsp:&nbsp                                ';
                    bsnsAr += '			</td>                                             ';
                    bsnsAr += '			<td>                                              ';
                    bsnsAr += addComma(feature.values_.bsnsArMeter) + 'km(' + addComma(feature.values_.bsnsArPyeong) + 'm)';
                    break;
                default:
                    bsnsAr += '				면 적&nbsp:&nbsp								  ';
                    bsnsAr += '			</td>                                             ';
                    bsnsAr += '			<td>                                              ';
                    bsnsAr += addComma(feature.values_.bsnsArMeter) + 'm<sup>2</sup> (' + addComma(feature.values_.bsnsArPyeong) + '평)';
                    break;
            }
            bsnsAr += '			</td>                                             ';
            bsnsAr += '		</tr>                                                 ';
        }
        //사업기간
        var bsnsDe = "";
        if (null != feature.values_.bsnsBgnde && "" != feature.values_.bsnsBgnde && "undefined" != feature.values_.bsnsBgnde) {
            bsnsDe += '		<tr class="mainMapTxt">                             ';
            bsnsDe += '			<td class="txtJust">                              ';
            bsnsDe += '				사업기간&nbsp:&nbsp                              ';
            bsnsDe += '			</td>                                             ';
            bsnsDe += '			<td>                                              ';
            if (feature.values_.bsnsEndde != "undefined" && feature.values_.bsnsEndde != "" && feature.values_.bsnsEndde != null) {
                bsnsDe += strToDate(feature.values_.bsnsBgnde) + " ~ " + strToDate(feature.values_.bsnsEndde);
            } else {
                bsnsDe += strToDate(feature.values_.bsnsBgnde);
            }
            bsnsDe += '			</td>                                             ';
            bsnsDe += '		</tr>                                                 ';
        }
        //사업비
        var wct = "";
        if (null != feature.values_.wct && "" != feature.values_.wct && "undefined" != feature.values_.wct) {
            wct += '		<tr class="mainMapTxt">                             ';
            wct += '			<td class="txtJust">                              ';
            wct += '				사업비&nbsp:&nbsp                               ';
            wct += '			</td>                                             ';
            wct += '			<td>                                              ';
            wct += numberToKorean(feature.values_.wct)						;
            wct += '			</td>                                             ';
            wct += '		</tr>                                                 ';
        }
        iwContent = '<div class="gzone__overlay">' +
            '<a href="javascript:void(0);"onclick="devInfoDtl(\'' + feature.values_.devlopInfoSn + '\',\'in\');" class="link">' +
            '<table>                                                      ' +
            '	<tbody>                                                   ' +
            '		<tr>                                                  ' +
            '			<td colspan="2">                                  ' +
            '				<div class="thumbnail">' +
            '					<img id="iwThumbnailImgMap" class="thumbnailImgMap" src="' + getContextPath() + '/images/develop/noImage.png">' +
            '				</div>' +
            '			</td>                                             ' +
            '		</tr>                                                 ' +
            '		<tr>                                                  ' +
            '			<td colspan="2">                                  ' +
            '				<strong>' +
            '<em>									  ' +
            devInfoCodeSet(dsTrcList, feature.values_.bsnsDstrcCode) +
            '</em>									  ' +
            feature.values_.dwkNm +
            '</strong>' +
            '			</td>                                             ' +
            '		</tr>                                                 ' +
            bsnsAr +
            bsnsDe +
            wct +
            //		opertnCmpny +
            '		<tr><td colspan="2">                              	  ' +
            '				<i>상세정보 보기</i>                                ' +
            '			</td>                                             ' +
            '		</tr>                                                 ' +
            '	</tbody>	                                              ' +
            '</table>                                                     ' +
            /*'<div class="thumbnail">' +
            //imgHtml +
            
            '</div>' +*/
            '  </a>' +
            '</div>';

    } else {
        var prpos = codeInvSet(getCodeAjax('CMMN', feature.values_.prposTwoCode).codeList, feature.values_.prposThreeCode);
        var bsnsAr = '<span><b>면적</b> : ' + addComma(feature.values_.ar) + '㎡</span>';
        var addr = '<span><b>지역</b> : ' + codeSet(getCodeAjax('AREA', '0000000000').codeList, feature.values_.upperMapCode) + ' ' + codeSet(getCodeAjax('AREA', feature.values_.upperMapCode).codeList, feature.values_.mapCode) + ' ' + feature.values_.addr + ' </span>';
        var arithAvrgAt = feature.values_.arithAvrgAt;
        if (arithAvrgAt == 'Y') {
            arithAvrgAt = '산술평균 적용';
        } else {
            arithAvrgAt = '산술평균 미적용';
        }

        iwContent = '<div class="gzone__overlay"><a style="padding: 0;">' +
            '<strong><em>' + prpos + '</em>' + feature.values_.dwkNm + '</strong><div style="border: solid #fbcb00;padding: 20px;">' +
            bsnsAr +
            addr +
            '<span><b>이용현황</b> : ' + feature.values_.useSttus + '</span>' +
            '<span><b>가격시점</b> : ' + tsToDt(feature.values_.pcpnttm) + '</span>' +
            '<span><b>㎡ 당 보상단가</b> : ' + addComma(feature.values_.rewardCo) + '원(' + arithAvrgAt + ')</span>' +
            '<span><b>가격시점 개별지가(㎡)</b> : ' + addComma(feature.values_.pcpnttmIndvdlzPclnd) + '원</span>' +
            '</div></a></div>';
    }
    content.innerHTML = iwContent;
    overlay.setPosition(coordinate);
    if (resData.oldFileMap) {
        createImgFileMap(resData);
    } else {
        //대표이미지 썸네일 첨부파일 -- 05.25
        if (feature.values_.thumbFileId) {
            var thumbFileResult = getThumbFilesAjax("gz_devlop_info", feature.values_.thumbFileId);
            if (thumbFileResult.atchFiles != null && thumbFileResult.atchFiles.length != 0) {
                $('#iwThumbnailImgMap').attr('src', '/file/displayFile.do?filePath=/upload/gzone/' + thumbFileResult.atchFiles[0].fileStreCours + '&fileName=' + thumbFileResult.atchFiles[0].streFileNm);
            }
        }
    }
}


function setFeatureStyle(feature, mode) {
    var id = feature.values_.mapId;
    var style = {
        gz_devlop_info: {
            highWayStyles: {
                default: [new ol.style.Style({
                    fill: new ol.style.Fill({
                        color: 'red'
                    }),
                    stroke: new ol.style.Stroke({
                        color: 'red'
                    }),
                    image: new ol.style.Icon({
                        anchor: [
                            0.5, 46
                        ], // src로 지정된 url의 png 이미지로 포인트를 표시하며, 표시될때의 (X, Y)에 대한 기준점으로 (0.5, 46)
                        anchorXUnits: 'fraction', // X 축에 대한 값인 0.5의 단위를 anchorXUnits 속성을 통해 백분률(여기서는 0.5이므로 50%)로 지정
                        anchorYUnits: 'pixels', // Y 축에 대한 값인 46의 단위는 anchorYUnits 속성을 통해 픽셀 단위로 지정한다는 의미
                        src: '..' + getContextPath() + '/css/gzonei/SRC/images/program/marker3.png'
                    })
                })],
                select: [new ol.style.Style({
                    fill: new ol.style.Fill({
                        color: 'red'
                    }),
                    stroke: new ol.style.Stroke({
                        color: 'rgba(0, 255, 255, 1)',
                        width: 2
                    }),
                    image: new ol.style.Icon({
                        anchor: [
                            0.5, 46
                        ], // src로 지정된 url의 png 이미지로 포인트를 표시하며, 표시될때의 (X, Y)에 대한 기준점으로 (0.5, 46)
                        anchorXUnits: 'fraction', // X 축에 대한 값인 0.5의 단위를 anchorXUnits 속성을 통해 백분률(여기서는 0.5이므로 50%)로 지정
                        anchorYUnits: 'pixels', // Y 축에 대한 값인 46의 단위는 anchorYUnits 속성을 통해 픽셀 단위로 지정한다는 의미
                        src: '..' + getContextPath() + '/css/gzonei/SRC/images/program/marker3.png',
                        color: '#ffff00'
                    })
                })]
            },
            trainStyles: {
                default: [new ol.style.Style({
                    fill: new ol.style.Fill({
                        color: 'yellow'
                    }),
                    stroke: new ol.style.Stroke({
                        color: 'yellow'
                    }),
                    image: new ol.style.Icon({
                        anchor: [
                            0.5, 46
                        ], // src로 지정된 url의 png 이미지로 포인트를 표시하며, 표시될때의 (X, Y)에 대한 기준점으로 (0.5, 46)
                        anchorXUnits: 'fraction', // X 축에 대한 값인 0.5의 단위를 anchorXUnits 속성을 통해 백분률(여기서는 0.5이므로 50%)로 지정
                        anchorYUnits: 'pixels', // Y 축에 대한 값인 46의 단위는 anchorYUnits 속성을 통해 픽셀 단위로 지정한다는 의미
                        src: '..' + getContextPath() + '/css/gzonei/SRC/images/program/marker3.png'
                    })
                })],
                select: [new ol.style.Style({
                    fill: new ol.style.Fill({
                        color: 'yellow'
                    }),
                    stroke: new ol.style.Stroke({
                        color: 'rgba(0, 255, 255, 1)',
                        width: 2
                    }),
                    image: new ol.style.Icon({
                        anchor: [
                            0.5, 46
                        ], // src로 지정된 url의 png 이미지로 포인트를 표시하며, 표시될때의 (X, Y)에 대한 기준점으로 (0.5, 46)
                        anchorXUnits: 'fraction', // X 축에 대한 값인 0.5의 단위를 anchorXUnits 속성을 통해 백분률(여기서는 0.5이므로 50%)로 지정
                        anchorYUnits: 'pixels', // Y 축에 대한 값인 46의 단위는 anchorYUnits 속성을 통해 픽셀 단위로 지정한다는 의미
                        src: '..' + getContextPath() + '/css/gzonei/SRC/images/program/marker3.png',
                        color: '#ffff00'
                    })
                })]
            },
            riverStyles: {
                default: [new ol.style.Style({
                    fill: new ol.style.Fill({
                        color: 'Skyblue'
                    }),
                    stroke: new ol.style.Stroke({
                        color: 'Skyblue'
                    }),
                    image: new ol.style.Icon({
                        anchor: [
                            0.5, 46
                        ], // src로 지정된 url의 png 이미지로 포인트를 표시하며, 표시될때의 (X, Y)에 대한 기준점으로 (0.5, 46)
                        anchorXUnits: 'fraction', // X 축에 대한 값인 0.5의 단위를 anchorXUnits 속성을 통해 백분률(여기서는 0.5이므로 50%)로 지정
                        anchorYUnits: 'pixels', // Y 축에 대한 값인 46의 단위는 anchorYUnits 속성을 통해 픽셀 단위로 지정한다는 의미
                        src: '..' + getContextPath() + '/css/gzonei/SRC/images/program/marker3.png'
                    })
                })],
                select: [new ol.style.Style({
                    fill: new ol.style.Fill({
                        color: 'Skyblue'
                    }),
                    stroke: new ol.style.Stroke({
                        color: 'rgba(0, 255, 255, 1)',
                        width: 2
                    }),
                    image: new ol.style.Icon({
                        anchor: [
                            0.5, 46
                        ], // src로 지정된 url의 png 이미지로 포인트를 표시하며, 표시될때의 (X, Y)에 대한 기준점으로 (0.5, 46)
                        anchorXUnits: 'fraction', // X 축에 대한 값인 0.5의 단위를 anchorXUnits 속성을 통해 백분률(여기서는 0.5이므로 50%)로 지정
                        anchorYUnits: 'pixels', // Y 축에 대한 값인 46의 단위는 anchorYUnits 속성을 통해 픽셀 단위로 지정한다는 의미
                        src: '..' + getContextPath() + '/css/gzonei/SRC/images/program/marker3.png',
                        color: '#ffff00'
                    })
                })]
            },
            roadStyles: {
                default: [new ol.style.Style({
                    fill: new ol.style.Fill({
                        color: 'orange'
                    }),
                    stroke: new ol.style.Stroke({
                        color: 'orange'
                    }),
                    image: new ol.style.Icon({
                        anchor: [
                            0.5, 46
                        ], // src로 지정된 url의 png 이미지로 포인트를 표시하며, 표시될때의 (X, Y)에 대한 기준점으로 (0.5, 46)
                        anchorXUnits: 'fraction', // X 축에 대한 값인 0.5의 단위를 anchorXUnits 속성을 통해 백분률(여기서는 0.5이므로 50%)로 지정
                        anchorYUnits: 'pixels', // Y 축에 대한 값인 46의 단위는 anchorYUnits 속성을 통해 픽셀 단위로 지정한다는 의미
                        src: '..' + getContextPath() + '/css/gzonei/SRC/images/program/marker3.png'
                    })
                })],
                select: [new ol.style.Style({
                    fill: new ol.style.Fill({
                        color: 'orange'
                    }),
                    stroke: new ol.style.Stroke({
                        color: 'rgba(0, 255, 255, 1)',
                        width: 2
                    }),
                    image: new ol.style.Icon({
                        anchor: [
                            0.5, 46
                        ], // src로 지정된 url의 png 이미지로 포인트를 표시하며, 표시될때의 (X, Y)에 대한 기준점으로 (0.5, 46)
                        anchorXUnits: 'fraction', // X 축에 대한 값인 0.5의 단위를 anchorXUnits 속성을 통해 백분률(여기서는 0.5이므로 50%)로 지정
                        anchorYUnits: 'pixels', // Y 축에 대한 값인 46의 단위는 anchorYUnits 속성을 통해 픽셀 단위로 지정한다는 의미
                        src: '..' + getContextPath() + '/css/gzonei/SRC/images/program/marker3.png',
                        color: '#ffff00'
                    })
                })]
            },
            default: {
                default: [new ol.style.Style({
                    fill: new ol.style.Fill({
                        color: 'rgba(255, 255, 77,0.7)'
                    }),
                    stroke: new ol.style.Stroke({
                        color: 'rgba(244,243,235,1)'
                    }),
                    image: new ol.style.Icon({
                        anchor: [
                            0.5, 46
                        ], // src로 지정된 url의 png 이미지로 포인트를 표시하며, 표시될때의 (X, Y)에 대한 기준점으로 (0.5, 46)
                        anchorXUnits: 'fraction', // X 축에 대한 값인 0.5의 단위를 anchorXUnits 속성을 통해 백분률(여기서는 0.5이므로 50%)로 지정
                        anchorYUnits: 'pixels', // Y 축에 대한 값인 46의 단위는 anchorYUnits 속성을 통해 픽셀 단위로 지정한다는 의미
                        src: '..' + getContextPath() + '/css/gzonei/SRC/images/program/marker3.png'
                    })
                })],
                select: [new ol.style.Style({
                    fill: new ol.style.Fill({
                        color: 'rgba(255, 255, 77,0.7)'
                    }),
                    stroke: new ol.style.Stroke({
                        color: 'rgba(0, 255, 255, 1)',
                        width: 2
                    }),
                    image: new ol.style.Icon({
                        anchor: [
                            0.5, 46
                        ], // src로 지정된 url의 png 이미지로 포인트를 표시하며, 표시될때의 (X, Y)에 대한 기준점으로 (0.5, 46)
                        anchorXUnits: 'fraction', // X 축에 대한 값인 0.5의 단위를 anchorXUnits 속성을 통해 백분률(여기서는 0.5이므로 50%)로 지정
                        anchorYUnits: 'pixels', // Y 축에 대한 값인 46의 단위는 anchorYUnits 속성을 통해 픽셀 단위로 지정한다는 의미
                        src: '..' + getContextPath() + '/css/gzonei/SRC/images/program/marker3.png',
                        color: '#ffff00'
                    })
                })]
            }
        },
        gz_invt_info: {
            default: {
                default: [new ol.style.Style({
                    fill: new ol.style.Fill({
                        color: 'rgba(255, 255, 77,0.7)'
                    }),
                    stroke: new ol.style.Stroke({
                        color: 'rgba(244,243,235,1)'
                    }),
                    image: new ol.style.Icon({
                        anchor: [
                            0.5, 46
                        ], // src로 지정된 url의 png 이미지로 포인트를 표시하며, 표시될때의 (X, Y)에 대한 기준점으로 (0.5, 46)
                        anchorXUnits: 'fraction', // X 축에 대한 값인 0.5의 단위를 anchorXUnits 속성을 통해 백분률(여기서는 0.5이므로 50%)로 지정
                        anchorYUnits: 'pixels', // Y 축에 대한 값인 46의 단위는 anchorYUnits 속성을 통해 픽셀 단위로 지정한다는 의미
                        src: '..' + getContextPath() + '/css/gzonei/SRC/images/program/marker2.png'
                    })
                })],
                select: [new ol.style.Style({
                    fill: new ol.style.Fill({
                        color: 'rgba(255, 255, 77,0.7)'
                    }),
                    stroke: new ol.style.Stroke({
                        color: 'rgba(0, 255, 255, 1)',
                        width: 2
                    }),
                    image: new ol.style.Icon({
                        anchor: [
                            0.5, 46
                        ], // src로 지정된 url의 png 이미지로 포인트를 표시하며, 표시될때의 (X, Y)에 대한 기준점으로 (0.5, 46)
                        anchorXUnits: 'fraction', // X 축에 대한 값인 0.5의 단위를 anchorXUnits 속성을 통해 백분률(여기서는 0.5이므로 50%)로 지정
                        anchorYUnits: 'pixels', // Y 축에 대한 값인 46의 단위는 anchorYUnits 속성을 통해 픽셀 단위로 지정한다는 의미
                        src: '..' + getContextPath() + '/css/gzonei/SRC/images/program/marker2.png',
                        color: '#ffff00'
                    })
                })]
            },
            maegak: {
                default: [new ol.style.Style({
                    fill: new ol.style.Fill({
                        color: 'rgba(255, 255, 77,0.7)'
                    }),
                    stroke: new ol.style.Stroke({
                        color: 'rgba(244,243,235,1)'
                    }),
                    image: new ol.style.Icon({
                        anchor: [
                            0.5, 46
                        ], // src로 지정된 url의 png 이미지로 포인트를 표시하며, 표시될때의 (X, Y)에 대한 기준점으로 (0.5, 46)
                        anchorXUnits: 'fraction', // X 축에 대한 값인 0.5의 단위를 anchorXUnits 속성을 통해 백분률(여기서는 0.5이므로 50%)로 지정
                        anchorYUnits: 'pixels', // Y 축에 대한 값인 46의 단위는 anchorYUnits 속성을 통해 픽셀 단위로 지정한다는 의미
                        src: '..' + getContextPath() + '/css/gzonei/SRC/images/program/marker4.png'
                    })
                })],
                select: [new ol.style.Style({
                    fill: new ol.style.Fill({
                        color: 'rgba(255, 255, 77,0.7)'
                    }),
                    stroke: new ol.style.Stroke({
                        color: 'rgba(0, 255, 255, 1)',
                        width: 2
                    }),
                    image: new ol.style.Icon({
                        anchor: [
                            0.5, 46
                        ], // src로 지정된 url의 png 이미지로 포인트를 표시하며, 표시될때의 (X, Y)에 대한 기준점으로 (0.5, 46)
                        anchorXUnits: 'fraction', // X 축에 대한 값인 0.5의 단위를 anchorXUnits 속성을 통해 백분률(여기서는 0.5이므로 50%)로 지정
                        anchorYUnits: 'pixels', // Y 축에 대한 값인 46의 단위는 anchorYUnits 속성을 통해 픽셀 단위로 지정한다는 의미
                        src: '..' + getContextPath() + '/css/gzonei/SRC/images/program/marker4.png',
                        color: '#ffff00'
                    })
                })]
            }
        },
        gz_reward_precednt_info: {
            default: {
                default: [new ol.style.Style({
                    fill: new ol.style.Fill({
                        color: 'rgba(255, 255, 77,0.7)'
                    }),
                    stroke: new ol.style.Stroke({
                        color: 'rgba(244,243,235,1)'
                    }),
                    image: new ol.style.Icon({
                        anchor: [
                            0.5, 46
                        ], // src로 지정된 url의 png 이미지로 포인트를 표시하며, 표시될때의 (X, Y)에 대한 기준점으로 (0.5, 46)
                        anchorXUnits: 'fraction', // X 축에 대한 값인 0.5의 단위를 anchorXUnits 속성을 통해 백분률(여기서는 0.5이므로 50%)로 지정
                        anchorYUnits: 'pixels', // Y 축에 대한 값인 46의 단위는 anchorYUnits 속성을 통해 픽셀 단위로 지정한다는 의미
                        src: '..' + getContextPath() + '/css/gzonei/SRC/images/program/marker1.png'
                    })
                })],
                select: [new ol.style.Style({
                    fill: new ol.style.Fill({
                        color: 'rgba(255, 255, 77,0.7)'
                    }),
                    stroke: new ol.style.Stroke({
                        color: 'rgba(0, 255, 255, 1)',
                        width: 2
                    }),
                    image: new ol.style.Icon({
                        anchor: [
                            0.5, 46
                        ], // src로 지정된 url의 png 이미지로 포인트를 표시하며, 표시될때의 (X, Y)에 대한 기준점으로 (0.5, 46)
                        anchorXUnits: 'fraction', // X 축에 대한 값인 0.5의 단위를 anchorXUnits 속성을 통해 백분률(여기서는 0.5이므로 50%)로 지정
                        anchorYUnits: 'pixels', // Y 축에 대한 값인 46의 단위는 anchorYUnits 속성을 통해 픽셀 단위로 지정한다는 의미
                        src: '..' + getContextPath() + '/css/gzonei/SRC/images/program/marker1.png',
                        color: '#ffff00'
                    })
                })]
            }
        }
    }
    var styleName = mode;
    if (id == "gz_devlop_info") {
        if ((typeof feature.get("bsnsDstrcCode") != "undefined" && feature.get("bsnsDstrcCode") != null)) {
            var bsnsDstrcCode;
            var roadStyle = feature.values_.bsnsDstrcCode;
            if (roadStyle.includes("DS02110000")) {
                bsnsDstrcCode = 'highWayStyles';
            } else if (roadStyle.includes("DS02100000") || roadStyle.includes("DS02100100")) {
                bsnsDstrcCode = 'trainStyles';
            } else if (roadStyle.includes("DS03030000") || roadStyle.includes("DS03030100") || roadStyle.includes("DS03030200") || roadStyle.includes("DS03030300")) {
                bsnsDstrcCode = 'riverStyles';
            } else if (roadStyle.includes("DS02120000") || roadStyle.includes("DS02130000")) {
                bsnsDstrcCode = 'roadStyles';
            } else {
                bsnsDstrcCode = 'default';
            }
            if (mode == "deselect") {
                feature.setStyle(style[id][bsnsDstrcCode]['default']);
            } else {
                feature.setStyle(style[id][bsnsDstrcCode][styleName]);
            }
        } else {
            if (mode == "deselect") {
                feature.setStyle(style[id]['default']['default']);
            } else {
                feature.setStyle(style[id]['default'][styleName]);
            }
        }
    } else if (id == "gz_invt_info") {
        if ((typeof feature.get("progrsResultCode") != "undefined" && feature.get("progrsResultCode") != null)) {
            var progrsResultCode;
            var maegakStyle = feature.values_.progrsResultCode;
            if (maegakStyle.includes("CM00130003")) {
                progrsResultCode = 'maegak'
            } else {
                progrsResultCode = 'default';
            }
            if (mode == "deselect") {
                feature.setStyle(style[id][progrsResultCode]['default']);
            } else {
                feature.setStyle(style[id][progrsResultCode][styleName]);
            }
        } else {
            if (mode == "deselect") {
                feature.setStyle(style[id]['default']['default']);
            } else {
                feature.setStyle(style[id]['default'][styleName]);
            }
        }

    } else {
        if (mode == "deselect") {
            feature.setStyle(style[id]['default']['default']);
        } else {
            feature.setStyle(style[id]['default'][styleName]);
        }
    }

}



function zoomLayer(val, id) {

    var layerName = id;
    map.getLayers().array_.some(function(layer) {
        if (layer.get("name").includes(layerName)) {
            var source = layer.getSource();
            getFeatures(source);
            return true;
        }
    });

    function getFeatures(source) {
        select.getFeatures().clear();
        source.getFeatures().forEach(function(features) {
            if (features.id_ == val) {

                var extent = features.getGeometry().getExtent();
                var view = map.getView();
                var coordinate = ol.extent.getCenter(extent);
                var chkType = features.getGeometry().getType();
                if (chkType != 'Point') {
                    $(".ol-popup").css("bottom", "15px");
                } else {
                    $(".ol-popup").css("bottom", "50px");
                }

                setFeatureStyle(features, "select");
                select.getFeatures().push(features);
                if (layerName == "gz_devlop_info") {
                    popup(features, coordinate);
                }
                view.setCenter(coordinate);
                var view = map.getView();
                var zoom = view.getZoom();
                view.setZoom(zoom);
            } else {
                setFeatureStyle(features, "deselect");
            }

        });
    }
}

modifiedFeatures = {};
addedFeatures = {};
removedFeatures = {};

function insrtLayer(layerName) {
    removeInteraction('viewLayer', "edit");
    var vector, source, featureType, selectStyle;
    //선택레이어 변경예정

    if (layerName == "gz_devlop_info") {
        featureType = "Polygon";
    } else {
        featureType = "Point";
    }

    var intersectionFeatures = [];
    map.getLayers().forEach(function(layer) {
        if (layer.get("name").includes(layerName)) {
            vector = layer;
            source = layer.getSource();
        }
    });
    if (vector == null || vector == "") {
        source = new ol.source.Vector();
        vector = new ol.layer.Vector({
            source: source,
            id: layerName,
            name: layerName,
            layerType: 'viewLayer'
        });
        map.addLayer(vector);
    }
    var draw = new ol.interaction.Draw({
        source: source,
        type: featureType
    });
    draw.setProperties({
        mode: "edit"
    });
    draw.on("drawstart", function(e) {

    });
    var features;
    var multiPolygon = new ol.geom.MultiPolygon([]);
    draw.on("drawend", function(e) {
        multiPolygon.layerNm = layerName;
        var feature = e.feature,
            poly = feature.getGeometry();
        feature.set("mapId", multiPolygon.layerNm);
        setFeatureStyle(feature, "select");
        multiPolygon.appendPolygon(poly);
        chkInsert(multiPolygon, source);

    });

    map.addInteraction(draw);


}

function chkInsert(multiPolygon, source) {
    swal("그리기 작업을 선택해 주세요.", {
            buttons: {
                default: "종료",
                catch: {
                    text: "추가",
                    value: "add",
                },
            },
        })
        .then(function(value) {
            switch (value) {
                case "add":
                    break;
                default:
                    removeInteraction(null, "edit");
                    var format = new ol.format.WKT();
                    var setWkt = format.writeGeometry(multiPolygon);
                    source.getFeatures().forEach(function(feature) {
                        setFeatureStyle(feature, "deselect");
                        source.removeFeature(feature);
                    });
                    var features = format.readFeature(setWkt, {
                        dataProjection: 'EPSG:3857',
                        featureProjection: 'EPSG:3857'
                    });
                    source.addFeatures(features);
                    showDevInfoInsrt();
                    sideShow('devInfoAdminInsrt');
                    //hidden에 값 넣기
                    document.devInfoAdminInsrtForm.wkt.value = setWkt;
                    source.addFeatures(features);
                    features.set("mapId", multiPolygon.layerNm);
                    setFeatureStyle(features, "select");
                    var select = new ol.interaction.Select({
                        condition: ol.events.condition.never

                    });
                    select.getFeatures().push(features);
                    /*mode와 name에 관한 properties 입력*/
                    select.setProperties({
                        mode: "edit"
                    });

                    map.addInteraction(select);

                    var modify = new ol.interaction.Modify({
                        features: select.getFeatures()
                    });

                    modify.setProperties({
                        mode: "edit"
                    });

                    map.addInteraction(modify);

                    modify.on('modifystart', function(e) {
                        var features = e.features.array_;
                        $.each(features, function(key, val) {
                            val.revision_ = 0;
                        });
                    });

                    modify.on('modifyend', function(e) {
                        var features = e.features.array_;
                        var setWkt = format.writeGeometry(e.features.array_[0].getGeometry());
                        document.devInfoAdminInsrtForm.wkt.value = setWkt;
                    });
            }
        });
}

function selectLayer() {
    var select, drawBox, dragBox;
    var oldFeatures = {};
    /*함수가 시작될 때 edit 관련 interaction을 모두 지워버리므로 기존에 select되어 있던 feature들을 꺼내온다.*/
    $.each(map.interactions.array_, function(key, value) {
        if (value.values_.mode == "edit" && value instanceof ol.interaction.Select) {
            oldFeatures = value.getFeatures().array_;
        }
    });
    removeInteraction(null, "edit");
    select = new ol.interaction.Select();
    select.setProperties({
        mode: "edit"
    });
    map.addInteraction(select);
    select.on('select', function(e) {

    });

    map.addInteraction(select);
    var selectedFeatures = select.getFeatures();
    if (dragBox == null) {
        dragBox = new ol.interaction.DragBox({
            condition: function(e) {
                return ol.events.condition.always(e);
            }
        });
        dragBox.setProperties({
            mode: "edit"
        });
    }

    dragBox.on('boxstart', function(e) {
        var shiftKeyPressed = false;
        if (typeof window.event.shiftKey != "undefined") {
            shiftKeyPressed = window.event.shiftKey;
        }
        if (!shiftKeyPressed) {
            var features = select.getFeatures().array_;
            $.each(features, function(key, val) {
                setFeatureStyle(val, "deselect");
            });
            if (select != null) {
                select.getFeatures().clear();
            }
        }
    });

    dragBox.on('boxend', function(e) {
        var extent = dragBox.getGeometry().getExtent();
        map.getLayers().forEach(function(layer, idx) {
            if (layer.get('layerType') == 'viewLayer') {
                layer.getSource().forEachFeatureIntersectingExtent(extent, function(feature) {
                    select.getFeatures().push(feature);
                    setFeatureStyle(feature, "select")
                });
            }

        })
    });
    map.addInteraction(dragBox);
}

function modifyLayer() {
    var select, modify, selectFeatures;
    var selectFeatures = [],
        boxFeatures = {},
        modifyFeatures = {};

    /*기존의 피쳐들과 새로운 피쳐들을 interaction에서 가져옴*/
    $.each(map.interactions.array_, function(key, value) {
        if (value.values_.name == "boxSelection" && value instanceof ol.interaction.Select) {
            boxFeatures = value.getFeatures().array_;
        }
        if (value.values_.name == "modifySelection" && value instanceof ol.interaction.Select) {
            modifyFeatures = value.getFeatures().array_;
        }
    });

    $.each(boxFeatures, function(key, val) {
        selectFeatures.push(val);
    });
    $.each(modifyFeatures, function(key, val) {
        selectFeatures.push(val);
    });

    /*기존 피쳐들과 새로운 피쳐의 중복되는 피쳐가 있을 경우 제거*/
    selectFeatures = selectFeatures.filter(function(value, index, self) {
        return self.indexOf(value) === index;
    });
    /*중복 이벤트를 방지하기 위해 mode가 edit인 interaction을 일괄 제거 시켜줌*/
    removeInteraction(null, "edit");

    /*select를 위한 interaction 준비*/
    select = new ol.interaction.Select({
        condition: ol.events.condition.never

    });

    /*새로 만들어진 select interaction에 selectFeatures를 넣어 줌*/
    $.each(selectFeatures, function(key, val) {
        val.beforeGeometry = val.getGeometry().clone();
        select.getFeatures().push(val);
    });
    /*mode와 name에 관한 properties 입력*/
    select.setProperties({
        mode: "edit"
    });

    /*ol의 map객체에 select interaction 추가*/
    map.addInteraction(select);


    /*select되어 있는 feature를 modify interaction에 지정을 해줌*/
    modify = new ol.interaction.Modify({
        features: select.getFeatures()
    });

    modify.setProperties({
        mode: "edit"
    });
    map.addInteraction(modify);

    modify.on('modifystart', function(e) {
        var features = e.features.array_;
        $.each(features, function(key, val) {
            val.revision_ = 0;
        });
    });
    modify.on('modifyend', function(e) {
        var features = e.features.array_;
        $.each(features, function(key, val) {
            var layerName = val.layerNm;
            if (typeof modifiedFeatures[layerName] == "undefined") {
                modifiedFeatures[layerName] = [];
            }
            if (modifiedFeatures[layerName].indexOf(val) == -1) {
                modifiedFeatures[layerName].push(val);
            }

        });
    });
}

function moveLayer() {
    var select, translate, selectFeatures;
    var selectFeatures = [],
        boxFeatures = {},
        modifyFeatures = {};

    /*기존의 피쳐들과 새로운 피쳐들을 interaction에서 가져옴*/
    $.each(map.interactions.array_, function(key, value) {
        if (value.values_.name == "boxSelection" && value instanceof ol.interaction.Select) {
            boxFeatures = value.getFeatures().array_;
        }
        if (value.values_.name == "modifySelection" && value instanceof ol.interaction.Select) {
            modifyFeatures = value.getFeatures().array_;
        }
    });

    $.each(boxFeatures, function(key, val) {
        selectFeatures.push(val);
    });
    $.each(modifyFeatures, function(key, val) {
        selectFeatures.push(val);
    });

    /*기존 피쳐들과 새로운 피쳐의 중복되는 피쳐가 있을 경우 제거*/
    selectFeatures = selectFeatures.filter(function(value, index, self) {
        return self.indexOf(value) === index;
    });
    /*중복 이벤트를 방지하기 위해 mode가 edit인 interaction을 일괄 제거 시켜줌*/
    removeInteraction(null, "edit");

    /*select를 위한 interaction 준비*/
    select = new ol.interaction.Select({
        condition: ol.events.condition.never

    });

    /*새로 만들어진 select interaction에 selectFeatures를 넣어 줌*/
    $.each(selectFeatures, function(key, val) {
        val.beforeGeometry = val.getGeometry().clone();
        select.getFeatures().push(val);
    });
    /*mode와 name에 관한 properties 입력*/
    select.setProperties({
        mode: "edit"
    });

    /*ol의 map객체에 select interaction 추가*/
    map.addInteraction(select);


    /*select되어 있는 feature를 modify interaction에 지정을 해줌*/
    translate = new ol.interaction.Translate({
        features: select.getFeatures()
    });

    translate.setProperties({
        mode: "edit"
    });
    map.addInteraction(translate);
    translate.on('translateend', function(e) {
        var features = e.features.array_;
        $.each(features, function(key, val) {

        });
    });
}

function formAdd() {

    $("#form-map").show();
}

function getAjaxResult(param, url) {
    var resData
    $.ajax({
        type: 'POST',
        url: url,
        async: false,
        datatype: 'json',
        contentType: 'application/x-www-form-urlencoded;charset=utf-8',
        data: {
            devlopInfoSn: param
        },
        success: function(data) {
            resData = JSON.parse(data);
        },
        error: function(e) {
            console.log(e);
            alert(param + '조회 실패' + e);
        }
    });
    return resData;
}

function createImgFileMap(resData) {
    var tumbnailHtml = '';
    var fileMap = resData.oldFileMap;
    if (fileMap) {
        if (!fileMap.fileDisNm) {
            fileMap.fileDisNm = 'titleImg';
        }
        if(fileMap.fileNm){
        	if (fileMap.fileNm.substring(0, 3) == "BBS") {
        		$('#iwThumbnailImgMap').attr('src', '/file/displayFile.do?filePath=/upload/gzone/' + fileMap.filePath + '&fileName=' + fileMap.fileNm);
        	} else {
        		$('#iwThumbnailImgMap').attr('src', '/file/displayFile.do?filePath=/upload/gzone/images/develop/' + fileMap.filePath + '/' + fileMap.fileNm + '&fileName=' + fileMap.fileNm);
        	}
        }
        //$('#iwThumbnailImgMap').attr('src','/sts_docs/images/develop/'+fileMap.filePath+'/'+fileMap.fileNm);
    }

    /*$('#devInfoDtl_thumbnail').html();
    var ImgTag = $('#devInfoTbImg');
    ImgTag.attr('src','/sts_docs/images/develop/'+fileMap.filePath+'/'+fileMap.fileNm);*/

    /*if(fileMap){
    	var fileMapList = [];
    	var newMap = {fileNm:'',filePath:'',fileDisNm:''};
    	for(let key in fileMap){
    		if(key.includes('fileNm')){
    			newMap.fileNm=fileMap[key];
    		}else if(key.includes('filePath')){
    			newMap.filePath=fileMap[key];
    		}else if(key.includes('fileDisNm')){
    			newMap.fileDisNm=fileMap[key];
    			fileMapList.push(newMap);
    			newMap = {fileNm:'',filePath:'',fileDisNm:''};
    		}
    	}
    	fileMapList.forEach(function(data,index){
    		if(data.fileDisNm == 'titleImg'){
    			//tumbnailHtml += "<img src='"+pathMap.devlopImagePath+"/"+data.filePath+"/"+data.fileNm+"'>";
    			//tumbnailHtml += "<img src='/upload/gzone/images/develop"+data.filePath+"/"+data.fileNm+"'>";
    			tumbnailHtml += "<img id='devInfoTbImg' src="+getContextPath()+"/images/develop/noImage.png'/>' alt="">';
    			$('.thumbnail').html(tumbnailHtml);
    			var tumbnailImg = '.thumbnail img';
    			var ImgTag = $(tumbnailImg);
    			if(ImgTag.attr('src') != '/upload/gzone/images/develop'+data.filePath+'/'+data.fileNm){
    				ImgTag.attr('src',getContextPath()+"/images/develop/noImage.png");
    			}
    			//src='/upload/gzone/images/develop"+data.filePath+"/"+data.fileNm+"
    		}
    		
    		if(data.fileDisNm == 'titleImg'){
    			tumbnailHtml += "<img src='"+getContextPath()+"/images/develop/"+data.filePath+"/"+data.fileNm+"' alt='"+data.fileNm+"' class='thumb'>"
    		}
    	});
    }*/
    //return tumbnailHtml;
}

function search() {
    /*var geocoder = new kakao.maps.services.Geocoder();
    var searchKeyword = $('#searchKeyword').val();
    if(searchKeyword != null){
    	geocoder.addressSearch(searchKeyword, function(result, status) {
    		if(status == "OK"){
    			
    			devInfoListSearch('search',result[0].x,result[0].y)
    			areaSetup();
    			
    		}else{
    			swal("정보가 없습니다.", "주소를 확인해 주세요!", "error");
    		}
    	});
    }*/
    //권한 -- 검색
    //if($('#tab2')[0].title == '열림' /*|| $('#tab2')[0].title == ''*/){
    if ($('li.link-tab.on a').text() == '투자정보' /*|| $('#tab2')[0].title == ''*/ ) {
        if (authVO.ivt001001.infoInqireAt == "Y") {
            //검색시 무조건 1페이지 부터
            var keyword = $('#searchKeyword').val();

            if (keyword != '' && keyword != null) {
                invListSearch(null, keyword);
            } else {
                swal("검색어를 입력해 주세요", "사업명을 검색합니다", "warning");
            }
        } else {
            swal("검색 권한이 없습니다", "권한이 부족합니다", "warning");
        }
    } else {
        if (authVO.dev001001.infoInqireAt == "Y") {
            //검색시 무조건 1페이지 부터
            $('#keyPageIndex').val('1');
            var keyword = $('#searchKeyword').val();

            //	if($('#searchKeyword').val() != '' && $('#searchKeyword').val() != null){
            if (keyword != '' && keyword != null) {
                devInfoListTopSearch('search', null, null);
            } else {
                swal("검색어를 입력해 주세요", "사업명을 검색합니다", "warning");
            }
        } else {
            swal("검색 권한이 없습니다", "권한이 부족합니다", "warning");
        }
    }
}

function deleteLayer() {

    swal("레이어를 삭제 하시겠습니까?", {
            buttons: {
                default: "아니요",
                catch: {
                    text: "네",
                    value: "add",
                },
            },
        })
        .then(function(value) {
            switch (value) {
                case "add":
                    removeInteraction("viewLayer", "edit");
                    document.devInfoAdminDtlForm.wkt.value = '';
                    var vector, source, featureType, selectStyle;
                    var layerName = "gz_devlop_info";
                    featureType = "Polygon";

                    var intersectionFeatures = [];
                    map.getLayers().forEach(function(layer) {
                        if (layer.get("name").includes(layerName)) {
                            vector = layer;
                            source = layer.getSource();
                        }
                    });
                    if (vector == null || vector == "") {
                        source = new ol.source.Vector();
                        vector = new ol.layer.Vector({
                            source: source,
                            id: layerName,
                            name: layerName,
                            layerType: 'viewLayer'
                        });
                        map.addLayer(vector);
                    }
                    var draw = new ol.interaction.Draw({
                        source: source,
                        type: featureType
                    });
                    draw.setProperties({
                        mode: "edit"
                    });
                    draw.on("drawstart", function(e) {

                    });
                    var features;
                    var multiPolygon = new ol.geom.MultiPolygon([]);
                    draw.on("drawend", function(e) {
                        multiPolygon.layerNm = layerName;
                        var feature = e.feature,
                            poly = feature.getGeometry();
                        feature.set("mapId", multiPolygon.layerNm);
                        setFeatureStyle(feature, "select");
                        multiPolygon.appendPolygon(poly);
                        chkUpInsert(multiPolygon, source);

                    });

                    map.addInteraction(draw);
                default:
                    break;
            }
        });

}

function chkUpInsert(multiPolygon, source) {
    swal("그리기 작업을 선택해 주세요.", {
            buttons: {
                default: "종료",
                catch: {
                    text: "추가",
                    value: "add",
                },
            },
        })
        .then(function(value) {
            switch (value) {
                case "add":
                    break;
                default:
                    removeInteraction(null, "edit");
                    var format = new ol.format.WKT();
                    var setWkt = format.writeGeometry(multiPolygon);
                    source.getFeatures().forEach(function(feature) {
                        setFeatureStyle(feature, "deselect");
                        source.removeFeature(feature);
                    });
                    var features = format.readFeature(setWkt, {
                        dataProjection: 'EPSG:3857',
                        featureProjection: 'EPSG:3857'
                    });
                    source.addFeatures(features);
                    $("#sideAdmin").toggleClass('moveTo');
                    //hidden에 값 넣기
                    document.devInfoAdminDtlForm.wkt.value = setWkt;
                    source.addFeatures(features);
                    features.set("mapId", multiPolygon.layerNm);
                    setFeatureStyle(features, "select");
                    var select = new ol.interaction.Select({
                        condition: ol.events.condition.never

                    });
                    select.getFeatures().push(features);
                    /*mode와 name에 관한 properties 입력*/
                    select.setProperties({
                        mode: "edit"
                    });

                    map.addInteraction(select);

                    var modify = new ol.interaction.Modify({
                        features: select.getFeatures()
                    });

                    modify.setProperties({
                        mode: "edit"
                    });

                    map.addInteraction(modify);

                    modify.on('modifystart', function(e) {
                        var features = e.features.array_;
                        $.each(features, function(key, val) {
                            val.revision_ = 0;
                        });
                    });

                    modify.on('modifyend', function(e) {
                        var features = e.features.array_;
                        var setWkt = format.writeGeometry(e.features.array_[0].getGeometry());
                        document.devInfoAdminDtlForm.wkt.value = setWkt;
                    });
            }
        });
}


function localSearch() {
    if (navigator.geolocation) {

        // GeoLocation을 이용해서 접속 위치를 얻어옵니다
        navigator.geolocation.watchPosition(function(position) {

            var lat = position.coords.latitude, // 위도
                lon = position.coords.longitude; // 경도

            devInfoListSearch('search', lon, lat);

            var geocoder = new kakao.maps.services.Geocoder();

            var callback = function(result, status) {
                if (status === kakao.maps.services.Status.OK) {
                    $('#searchKeyword').val(result[0].address.address_name);
                }
            };

            geocoder.coord2Address(lon, lat, callback);

            areaSetup();

        });

    } else { // HTML5의 GeoLocation을 사용할 수 없을때
        swal("현재위치를 찾을수 없습니다.", "현재위치 허용을 확인해 주세요!", "error");
    }

}

//콤마 추가 (addcomma)
function addComma(num) {
    var result = '';
    if (num != null) {
        var regexp = /\B(?=(\d{3})+(?!\d))/g;
        result = num.toString().replace(regexp, ',')
    }
    return result;
}