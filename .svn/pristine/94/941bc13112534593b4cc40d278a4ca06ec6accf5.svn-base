function _defineProperty(obj, key, value) {if (key in obj) {Object.defineProperty(obj, key, { value: value, enumerable: true, configurable: true, writable: true });} else {obj[key] = value;}return obj;}jQuery(document).ready(function () {
    $('[data-banner]').each(function (key, item) {
        var _$$slick;
        var bannerIdName = 'banner' + key;
        this.id = bannerIdName;
        var bannerId = '#' + bannerIdName;
        var autoplay = Boolean($(bannerId).data("autoplay"));
        var autoplayInterval = parseInt($(bannerId).data("autoplay-interval"));
        var show = parseInt($(bannerId).data("show"));
        var slides = parseInt($(bannerId).data("slides"));
        var fade =  Boolean($(bannerId).data("fade"));
        var dot = Boolean($(bannerId).data("dot"));
        var variableWidth = Boolean($(bannerId).data("variableWidth"));
        var total =  Boolean($(bannerId).data("total"));
        var arrows = Boolean($(bannerId).data("arrows"));
      if (total == true) {
           $(bannerId).parent().find('[data-paging]').append('<div class="total"></div>');
           $(bannerId).on("init", function(event, _$$slick){
               $(bannerId).parent().find('.total').html('<span class="current">'+ parseInt(_$$slick.currentSlide + 1) + '</span> <span class="line">/</span><span class="count">' + _$$slick.slideCount +'</span>');
            });
        }
        $(bannerId).slick((_$$slick = {
            slidesToShow: show,
            slidesToScroll: slides,
            autoplay:autoplay,
            autoplaySpeed: autoplayInterval,
            arrows: arrows,
            draggable: true,
            infinite: true,
            variableWidth: variableWidth,
            fade: fade,
            dots: dot
        }, 
        _defineProperty(_$$slick, 'arrows',true), 
        _defineProperty(_$$slick, 'appendDots',$(bannerId).parent().find('[data-dot]')), 
        _defineProperty(_$$slick, 'nextArrow',$(bannerId).parent().find('[data-control=next]')), 
        _defineProperty(_$$slick, 'prevArrow',$(bannerId).parent().find('[data-control=prev]')),
        _$$slick)); 
        $(bannerId).on("breakpoint", function(event, _$$slick, breakpoint){
             $(bannerId)
            .slick('slickPlay')
            .slick('slickSetOption', true);
        });
        if (total == true) {
            $(bannerId).on("afterChange", function(event, _$$slick, currentSlide){
               $(bannerId).parent().find('.total').html('<span class="current">'+ parseInt(_$$slick.currentSlide + 1) + '</span> <span class="line">/</span><span class="count">' + _$$slick.slideCount +'</span>');
            });
        }
        var $pause = $(bannerId).parent().find("[data-control=stop]");
        var $play = $(bannerId).parent().find("[data-control=play]");
        $play.hide();
        $pause.on('click', function() {
            $pause.hide();
            $play.show().focus();
            $(bannerId)
            .slick('slickPause')
            .slick('slickSetOption', true);
        });
        $play.on('click', function() {
            $pause.show().focus();
            $play.hide();
            $(bannerId)
            .slick('slickPlay')
            .slick('slickSetOption', true);
        });
        
        
       
        
    });
});