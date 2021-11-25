(function() {
	//TODO: 새로 짤 예정
	var hasTouchEvent = ('ontouchstart' in document.documentElement),
		RESIZE_EV = 'onorientationchange' in window ? 'orientationchange' : 'resize',
		CLICK_EV = hasTouchEvent ? 'touchend' : 'click',
		START_EV = hasTouchEvent ? 'touchstart' : 'mousedown',
		MOVE_EV = hasTouchEvent ? 'touchmove' : 'mousemove',
		END_EV = hasTouchEvent ? 'touchend' : 'mouseup',
		CANCEL_EV = hasTouchEvent ? 'touchcancel' : 'mouseup',
		WHEEL_EV = 'mousewheel';

	var FORM_STYLE = function() {
		this.select.list = null;
		this.select.thisIndex = null;
		this.select.selects = [];
		this.select.option = this.option;
	};

	FORM_STYLE.prototype.option = {
		_keyevent:function(e, element) {
			var that = this;
			switch(e.keyCode) {
				case 38:
				case 40:
					element.parent().find('.selected').text(element.find('option:selected').text());
					break;
			}
		}
	};

	FORM_STYLE.prototype.select = {
		init:function() {
			var that = this;

			$('select.design-select')
				.on('blur', $.proxy(that._blur, that))
				.on('focus', $.proxy(that._focus, that))
				.on('change', function() {
					that._change.apply(that, [$(this)]);
				})
				.each(function(i) {
					that.selects[i] = $(this);
					that.create(that.selects[i], i);
				});
		},
		create:function(element, i) {
			var that = this;

			if(element.is('[select-design=true]') === false) {
				element.wrap('<span class="select-box" />')
					.attr('select-design', 'true')
					.parent()
					.append('<span class="selected">'+ element.find('option:selected').text() +'</span><i class="arrow"></i>')
					.on('click', function(e) {
						that._click.apply(that, [e, i]);

						return false;
					});

				var classNames = element.attr('class').split(/[\s]+/);

				$.each(classNames, function(j) {
					if(classNames[j] != 'select')
						element.parent().addClass(classNames[j]);
				});

				$.each(element.data(), function(i, v) {
					element.parent().find('.selected').attr('data-' + i, v);
				});
			}
		},
		createList:function(element) {
			var that = this;

			that.list = $('<div><ul /></div>').appendTo('body').addClass('select-list');

			element.find('option').each(function() {
				$('<li><span>'+ $(this).text() +'</span></li>').appendTo(that.list.find('ul')).click(function() {
					var index = that.list.find('li').index(this);

					element.find('select').change(function() {
						$(this).val(element.find('option').eq(index).val());
					}).change();

					element.find('.selected').text(element.find('option').eq(index).text());
					that._close(element);
					$(document).unbind(START_EV, $.proxy(that._document, that));
				}).hover(function() {
					$(this).addClass('hover');
				}, function() {
					$(this).removeClass('hover');
				});
			});

			var classNames = element.find('select').attr('class').split(/[\s]+/);

			$.each(classNames, function(j) {
				if(classNames[j] != 'select')
					that.list.addClass(classNames[j] + '-list');
			});

			that.list.css({
				position:'absolute',
				left:element.find('.selected').offset().left,
				top:element.find('.selected').offset().top + element.find('.selected').outerHeight(),
				zIndex:100,
				width:function() {
					var w = element.outerWidth()
						- parseInt($(this).css('borderLeftWidth'))
						- parseInt($(this).css('borderRightWidth'))
						- parseInt($(this).css('paddingLeft'))
						- parseInt($(this).css('paddingRight'));

					return (that.list.find('ul').width() < w) ? w : 'auto';
				}
			}).on('mouseenter', function() {
				$(window).unbind('scroll', $.proxy(that._close, that, that.selects[that.thisIndex].parent()));
				$(document).unbind(WHEEL_EV, $.proxy(that._close, that, that.selects[that.thisIndex].parent()));
			}).on('mouseleave', function() {
				$(window).on('scroll', $.proxy(that._close, that, that.selects[that.thisIndex].parent()));
				$(document).on(WHEEL_EV, $.proxy(that._close, that, that.selects[that.thisIndex].parent()));
			});
		},
		_click:function(e, i) {
			var that = this;

			if(that.thisIndex === i) {
				that._close(that.selects[i].parent());
				return;
			}

			that.thisIndex = i;

			that._open(that.selects[i].parent());
			that.createList(that.selects[i].parent());

			$(document).on(START_EV, $.proxy(that._document, that));

			$(window).on('resize scroll', $.proxy(that._close, that, that.selects[that.thisIndex].parent()));
			$(document).on(WHEEL_EV, $.proxy(that._close, that, that.selects[that.thisIndex].parent()));
		},
		_focus:function(e) {
			var that = this,
				t = $(e.target);

			if(that.list) {
				that._close(that.selects[that.thisIndex].parent());
			}

			that._open(t.parent());

			t.on('keyup', function(e) {
				that.option._keyevent.apply(that, [e, t]);
			});
		},
		_blur:function(e) {
			var that = this,
				t = e.target;

			that._close($(t).parent());
			$(t).unbind('keyup');
		},
		_open:function(element) {
			var that = this;
			element.addClass('select-focus');
		},
		_close:function(element) {
			var that = this;

			element.removeClass('select-focus');

			if(that.list != null) {
				that.list.remove();
				that.list = null;
				$(window).unbind('resize scroll', $.proxy(that._close, that, that.selects[that.thisIndex].parent()));
				$(document).unbind(WHEEL_EV, $.proxy(that._close, that, that.selects[that.thisIndex].parent()));
			}

			that.thisIndex = null;
			$(document).unbind(START_EV, $.proxy(that._document, that));
		},
		_change:function(element) {
			element.parent().find('.selected').text(element.find('option:selected').text());
		},
		_document:function(e) {
			var that = this,
				t = e.target,
				currentTarget = t;

			while(currentTarget != undefined) {
				if(currentTarget == that.selects[that.thisIndex].parent()[0] || currentTarget == that.list[0]) {
					return;
				} else currentTarget = currentTarget.parentNode;
			}

			if(currentTarget === null) {
				that._close(that.selects[that.thisIndex].parent());
			}
		},
		add:function() {
			this.init();
		},
		_reset:function() {}
	};
	return {
		load:function() {
			var designForm = new FORM_STYLE();
			var initialize = function() {
				designForm.select.init();
			};

			$(initialize);
		}
	};
})().load();