/*!
 * jQuery Lightbox Evolution - for jQuery 1.4+
 * http://codecanyon.net/item/jquery-lightbox-evolution/115655?ref=aeroalquimia
 *
 * Copyright (c) 2013, Eduardo Daniel Sada
 * Released under CodeCanyon Regular License.
 * http://codecanyon.net/licenses/regular
 *
 * Version: 1.8.0 (August 17 2013)
 */
;
(function ($, A, B, C) {
    var D = (function (u) {
        return function () {
            return u.search(arguments[0])
        }
    })((navigator && navigator.userAgent) ? navigator.userAgent.toLowerCase() : "");
    var E = false;
    var F = (function () {
        for (var a = 3, b = B.createElement("b"), c = b.all || []; b.innerHTML = "<!--[if gt IE " + ++a + "]><i><![endif]-->", c[0];);
        return 4 < a ? a : B.documentMode
    })();
    var G = (function () {
        var b;
        var a;
        var c = B.createElement("div");
        c.innerHTML = "  <link/><table></table><a href='/a'>a</a><input type='checkbox'/>";
        b = c.getElementsByTagName("*");
        a = c.getElementsByTagName("a")[0];
        if (!b || !a || !b.length) {
            return {}
        }
        a.style.cssText = "top:1px;float:left;opacity:.5";
        return {
            opacity: /^0.5/.test(a.style.opacity)
        }
    })();
    if (D("mobile") > -1) {
        if (D("android") > -1 || D("googletv") > -1 || D("htc_flyer") > -1) {
            E = true
        }
    };
    if (D("opera") > -1) {
        if (D("mini") > -1 && D("mobi") > -1) {
            E = true
        }
    };
    if (D("iphone") > -1) {
        E = true
    };
    if (D("windows phone os 7") > -1) {
        E = true
    };
    $.extend($.easing, {
        easeOutBackMin: function (x, t, b, c, d, s) {
            if (s === C) s = 1;
            return c * ((t = t / d - 1) * t * ((s + 1) * t + s) + 1) + b
        }
    });
    if (typeof $.fn.live === "undefined") {
        $.fn.live = function (a, b, c) {
            jQuery(this.context).on(a, this.selector, b, c);
            return this
        }
    }
    $.extend({
        LightBoxObject: {
            defaults: {
                name: 'jquery-lightbox',
                style: {
                    zIndex: 9999,
                    width: 470,
                    height: 280
                },
                modal: false,
                overlay: {
                    opacity: 0.6
                },
                animation: {
                    show: {
                        duration: 400,
                        easing: "easeOutBackMin"
                    },
                    close: {
                        duration: 200,
                        easing: "easeOutBackMin"
                    },
                    move: {
                        duration: 700,
                        easing: "easeOutBackMin"
                    },
                    shake: {
                        duration: 100,
                        easing: "easeOutBackMin",
                        distance: 10,
                        loops: 2
                    }
                },
                flash: {
                    width: 640,
                    height: 360
                },
                iframe: {
                    width: 640,
                    height: 360
                },
                maxsize: {
                    width: -1,
                    height: -1
                },
                preload: true,
                emergefrom: "top",
                ajax: {
                    type: "GET",
                    cache: false,
                    dataType: "html"
                }
            },
            options: {},
            animations: {},
            gallery: {},
            image: {},
            esqueleto: {
                lightbox: [],
                buttons: {
                    close: [],
                    prev: [],
                    max: [],
                    next: []
                },
                background: [],
                image: [],
                title: [],
                html: []
            },
            visible: false,
            maximized: false,
            mode: "image",
            videoregs: {
                swf: {
                    reg: /[^\.]\.(swf)\s*$/i
                },
                youtu: {
                    reg: /youtu\.be\//i,
                    split: '/',
                    index: 3,
                    iframe: 1,
                    url: "http://www.youtube.com/embed/%id%?autoplay=1&amp;fs=1&amp;rel=0&amp;enablejsapi=1"
                },
                youtube: {
                    reg: /youtube\.com\/watch/i,
                    split: '=',
                    index: 1,
                    iframe: 1,
                    url: "http://www.youtube.com/embed/%id%?autoplay=1&amp;fs=1&amp;rel=0&amp;enablejsapi=1"
                },
                vimeo: {
                    reg: /vimeo\.com/i,
                    split: '/',
                    index: 3,
                    iframe: 1,
                    url: "http://player.vimeo.com/video/%id%?hd=1&amp;autoplay=1&amp;show_title=1&amp;show_byline=1&amp;show_portrait=0&amp;color=&amp;fullscreen=1"
                },
                metacafe: {
                    reg: /metacafe\.com\/watch/i,
                    split: '/',
                    index: 4,
                    url: "http://www.metacafe.com/fplayer/%id%/.swf?playerVars=autoPlay=yes"
                },
                dailymotion: {
                    reg: /dailymotion\.com\/video/i,
                    split: '/',
                    index: 4,
                    iframe: true,
                    url: "http://www.dailymotion.com/embed/video/%id%?autoPlay=1&forcedQuality=hd720"
                },
                collegehumornew: {
                    reg: /collegehumor\.com\/video\//i,
                    split: 'video/',
                    index: 1,
                    iframe: true,
                    url: "http://www.collegehumor.com/e/%id%"
                },
                collegehumor: {
                    reg: /collegehumor\.com\/video:/i,
                    split: 'video:',
                    index: 1,
                    url: "http://www.collegehumor.com/moogaloop/moogaloop.swf?autoplay=true&amp;fullscreen=1&amp;clip_id=%id%"
                },
                ustream: {
                    reg: /ustream\.tv/i,
                    split: '/',
                    index: 4,
                    url: "http://www.ustream.tv/flash/video/%id%?loc=%2F&amp;autoplay=true&amp;vid=%id%&amp;disabledComment=true&amp;beginPercent=0.5331&amp;endPercent=0.6292&amp;locale=en_US"
                },
                twitvid: {
                    reg: /twitvid\.com/i,
                    split: '/',
                    index: 3,
                    url: "http://www.twitvid.com/player/%id%"
                },
                wordpress: {
                    reg: /v\.wordpress\.com/i,
                    split: '/',
                    index: 3,
                    url: "http://s0.videopress.com/player.swf?guid=%id%&amp;v=1.01"
                },
                vzaar: {
                    reg: /vzaar\.com\/videos/i,
                    split: '/',
                    index: 4,
                    url: "http://view.vzaar.com/%id%.flashplayer?autoplay=true&amp;border=none"
                },
                youku: {
                    reg: /v.youku.com\/v_show\//i,
                    split: 'id_',
                    index: 1,
                    iframe: 1,
                    url: "http://player.youku.com/embed/%id%&amp;autoplay=1"
                }
            },
            mapsreg: {
                bing: {
                    reg: /bing\.com\/maps/i,
                    split: '?',
                    index: 1,
                    url: "http://www.bing.com/maps/embed/?emid=3ede2bc8-227d-8fec-d84a-00b6ff19b1cb&amp;w=%width%&amp;h=%height%&amp;%id%"
                },
                streetview: {
                    reg: /maps\.google\.(com|co.uk|ca|es)(.*)layer=c/i,
                    split: '?',
                    index: 1,
                    url: "http://maps.google.com/?output=svembed&amp;%id%"
                },
                googlev2: {
                    reg: /maps\.google\.(com|co.uk|ca|es)\/maps\/ms/i,
                    split: '?',
                    index: 1,
                    url: "http://maps.google.com/maps/ms?output=embed&amp;%id%"
                },
                google: {
                    reg: /maps\.google\.(com|co.uk|ca|es)/i,
                    split: '?',
                    index: 1,
                    url: "http://maps.google.com/maps?%id%&amp;output=embed"
                }
            },
            imgsreg: /\.(?:jpg|png|jpeg|gif|bmp|tiff)/i,
            overlay: {
                create: function (a) {
                    this.options = a;
                    this.element = $('<div id="' + new Date().getTime() + '" class="' + this.options.name + '-overlay"></div>');
                    this.element.css($.extend({}, {
                        'position': 'fixed',
                        'top': 0,
                        'left': 0,
                        'opacity': 0,
                        'display': 'none',
                        'z-index': this.options.zIndex
                    }, this.options.style));
                    this.element.bind("click", $.proxy(function (e) {
                        if (!this.options.modal && !this.hidden) {
                            if ($.isFunction(this.options.callback)) {
                                this.options.callback()
                            } else {
                                this.hide()
                            }
                        }
                        e.preventDefault()
                    }, this));
                    this.hidden = true;
                    this.inject();
                    return this
                },
                inject: function () {
                    this.target = $(B.body);
                    this.target.append(this.element)
                },
                resize: function (x, y) {
                    this.element.css({
                        'height': 0,
                        'width': 0
                    });
                    if (this.shim) {
                        this.shim.css({
                            'height': 0,
                            'width': 0
                        })
                    };
                    var a = {
                        x: $(B).width(),
                        y: $(B).height()
                    };
                    this.element.css({
                        'width': '100%',
                        'height': y || a.y
                    });
                    if (this.shim) {
                        this.shim.css({
                            'height': 0,
                            'width': 0
                        });
                        this.shim.css({
                            'position': 'absolute',
                            'left': 0,
                            'top': 0,
                            'width': this.element.width(),
                            'height': y || a.y
                        })
                    }
                    return this
                },
                show: function (a) {
                    if (!this.hidden) {
                        return this
                    };
                    if (this.transition) {
                        this.transition.stop()
                    };
                    if (this.shim) {
                        this.shim.css('display', 'block')
                    };
                    this.element.css({
                        'display': 'block',
                        'opacity': 0
                    });
                    this.resize();
                    this.hidden = false;
                    this.transition = this.element.fadeTo(this.options.showDuration, this.options.style.opacity, $.proxy(function () {
                        if (this.options.style.opacity) {
                            this.element.css(this.options.style)
                        };
                        this.element.trigger('show');
                        if ($.isFunction(a)) {
                            a()
                        }
                    }, this));
                    $('body').css('overflow', 'hidden');
                    return this
                },
                hide: function (a) {
                    if (this.hidden) {
                        return this
                    };
                    if (this.transition) {
                        this.transition.stop()
                    };
                    if (this.shim) {
                        this.shim.css('display', 'none')
                    };
                    this.hidden = true;
                    this.transition = this.element.fadeTo(this.options.closeDuration, 0, $.proxy(function () {
                        this.element.trigger('hide');
                        if ($.isFunction(a)) {
                            a()
                        };
                        this.element.css({
                            'height': 0,
                            'width': 0,
                            'display': 'none'
                        })
                    }, this));
                    $('body').css('overflow', '');
                    return this
                }
            },
            create: function (a) {
                this.options = $.extend(true, this.defaults, a);
                var b = this.options.name;
                var c = $('<div class="' + b + ' ' + b + '-mode-image"><div class="' + b + '-border-top-left"></div><div class="' + b + '-border-top-middle"></div><div class="' + b + '-border-top-right"></div><a class="' + b + '-button-close" href="#close"><span>Close</span></a><div class="' + b + '-navigator"><a class="' + b + '-button-left" href="#"><span>Previous</span></a><a class="' + b + '-button-right" href="#"><span>Next</span></a></div><div class="' + b + '-buttons"><div class="' + b + '-buttons-init"></div><a class="' + b + '-button-left" href="#"><span>Previous</span></a><a class="' + b + '-button-max" href="#"><span>Maximize</span></a><div class="' + b + '-buttons-custom"></div><a class="' + b + '-button-right" href="#"><span>Next</span></a><div class="' + b + '-buttons-end"></div></div><div class="' + b + '-background"></div><div class="' + b + '-html"></div><div class="' + b + '-border-bottom-left"></div><div class="' + b + '-border-bottom-middle"></div><div class="' + b + '-border-bottom-right"></div></div>');
                var e = this.esqueleto;
                this.overlay.create({
                    name: b,
                    style: this.options.overlay,
                    modal: this.options.modal,
                    zIndex: this.options.style.zIndex - 1,
                    callback: this.proxy(this.close),
                    showDuration: (E ? this.options.animation.show.duration / 2 : this.options.animation.show.duration),
                    closeDuration: (E ? this.options.animation.close.duration / 2 : this.options.animation.close.duration)
                });
                e.lightbox = c;
                e.navigator = $('.' + b + '-navigator', c);
                e.buttons.div = $('.' + b + '-buttons', c);
                e.buttons.close = $('.' + b + '-button-close', c);
                e.buttons.prev = $('.' + b + '-button-left', c);
                e.buttons.max = $('.' + b + '-button-max', c);
                e.buttons.next = $('.' + b + '-button-right', c);
                e.buttons.custom = $('.' + b + '-buttons-custom', c);
                e.background = $('.' + b + '-background', c);
                e.html = $('.' + b + '-html', c);
                e.move = $('<div class="' + b + '-move"></div>').css({
                    'position': 'absolute',
                    'z-index': this.options.style.zIndex,
                    'top': -999
                }).append(c);
                $('body').append(e.move);
                this.win = $(A);
                this.addevents();
                return c
            },
            addevents: function () {
                var a = this.win;
                a[0].onorientationchange = function () {
                    if (this.visible) {
                        this.overlay.resize();
                        if (this.move && !this.maximized) {
                            this.movebox()
                        }
                    }
                };
                a.bind('resize', this.proxy(function () {
                    if (this.visible && !E) {
                        this.overlay.resize();
                        if (this.move && !this.maximized) {
                            this.movebox()
                        }
                    }
                }));
                a.bind('scroll', this.proxy(function () {
                    if (this.visible && this.move && !this.maximized && !E) {
                        this.movebox()
                    }
                }));
                $(B).bind('keydown', this.proxy(function (e) {
                    if (this.visible) {
                        if (e.keyCode === 27 && this.options.modal === false) {
                            this.close()
                        }
                        if (this.gallery.total > 1) {
                            if (e.keyCode === 37) {
                                this.esqueleto.buttons.prev.triggerHandler('click', e)
                            }
                            if (e.keyCode === 39) {
                                this.esqueleto.buttons.next.triggerHandler('click', e)
                            }
                        }
                    }
                }));
                this.esqueleto.buttons.close.bind('click touchend', {
                    "fn": "close"
                }, this.proxy(this.fn));
                this.esqueleto.buttons.max.bind('click touchend', {
                    "fn": "maximinimize"
                }, this.proxy(this.fn));
                this.overlay.element.bind('show', this.proxy(function () {
                    $(this).triggerHandler('show')
                }));
                this.overlay.element.bind('hide', this.proxy(function () {
                    $(this).triggerHandler('close')
                }))
            },
            fn: function (e) {
                this[e.data.fn].apply(this);
                e.preventDefault()
            },
            proxy: function (a) {
                return $.proxy(a, this)
            },
            ex: function (f, g, h) {
                var j = {
                    type: "",
                    width: "",
                    height: "",
                    href: ""
                };
                $.each(f, this.proxy(function (c, d) {
                    $.each(d, this.proxy(function (i, e) {
                        if ((c == "flash" && g.split('?')[0].match(e.reg)) || (c == "iframe" && g.match(e.reg))) {
                            j.href = g;
                            if (e.split) {
                                var a = c == "flash" ? g.split(e.split)[e.index].split('?')[0].split('&')[0] : g.split(e.split)[e.index];
                                j.href = e.url.replace("%id%", a).replace("%width%", h.width).replace("%height%", h.height)
                            }
                            j.type = e.iframe ? "iframe" : c;
                            if (h.width) {
                                j.width = h.width;
                                j.height = h.height
                            } else {
                                var b = this.calculate(this.options[j.type].width, this.options[j.type].height);
                                j.width = b.width;
                                j.height = b.height
                            }
                            return false
                        }
                    }));
                    if ( !! j.type) return false
                }));
                return j
            },
            create_gallery: function (a, b) {
                var c = this;
                var d = c.esqueleto.buttons.prev;
                var f = c.esqueleto.buttons.next;
                c.gallery.total = a.length;
                if (a.length > 1) {
                    d.unbind('.lightbox');
                    f.unbind('.lightbox');
                    d.bind('click.lightbox touchend.lightbox', function (e) {
                        e.preventDefault();
                        a.unshift(a.pop());
                        c.show(a)
                    });
                    f.bind('click.lightbox touchend.lightbox', function (e) {
                        e.preventDefault();
                        a.push(a.shift());
                        c.show(a)
                    });
                    if (c.esqueleto.navigator.css("display") === "none") {
                        c.esqueleto.buttons.div.show()
                    }
                    d.show();
                    f.show();
                    if (this.options.preload) {
                        if (a[1].href.match(this.imgsreg)) {
                            (new Image()).src = a[1].href
                        }
                        if (a[a.length - 1].href.match(this.imgsreg)) {
                            (new Image()).src = a[a.length - 1].href
                        }
                    }
                } else {
                    d.hide();
                    f.hide()
                }
            },
            custombuttons: function (c, d) {
                var f = this.esqueleto;
                f.buttons.custom.empty();
                $.each(c, this.proxy(function (i, a) {
                    var b = $('<a href="#" class="' + a['class'] + '">' + a['html'] + '</a>');
                    b.bind('click', this.proxy(function (e) {
                        if ($.isFunction(a.callback)) {
                            a.callback(this.esqueleto.image.src, this, d)
                        }
                        e.preventDefault()
                    }));
                    f.buttons.custom.append(b)
                }));
                f.buttons.div.show()
            },
            show: function (d, f, g) {
                if (this.utils.isEmpty(d)) {
                    return false
                }
                var h = d[0];
                var i = '';
                var j = false;
                var k = h.href;
                var l = this.esqueleto;
                var m = {
                    x: this.win.width(),
                    y: this.win.height()
                };
                var n, height;
                if (d.length === 1 && h.type === "element") {
                    i = "element"
                }
                this.loading();
                j = this.visible;
                this.open();
                if (j === false) {
                    this.movebox()
                }
                this.create_gallery(d, f);
                f = $.extend(true, {
                    'width': 0,
                    'height': 0,
                    'modal': 0,
                    'force': '',
                    'autoresize': true,
                    'move': true,
                    'maximized': false,
                    'iframe': false,
                    'flashvars': '',
                    'cufon': true,
                    'ratio': 1,
                    'onOpen': function () {},
                    'onClose': function () {}
                }, f || {}, h);
                this.options.onOpen = f.onOpen;
                this.options.onClose = f.onClose;
                this.options.cufon = f.cufon;
                var o = this.unserialize(k);
                f = $.extend({}, f, o);
                if (f.width && ("" + f.width).indexOf("p") > 0) {
                    f.width = Math.round((m.x - 20) * f.width.substring(0, f.width.indexOf("p")) / 100)
                }
                if (f.height && ("" + f.height).indexOf("p") > 0) {
                    f.height = Math.round((m.y - 20) * f.height.substring(0, f.height.indexOf("p")) / 100)
                }
                this.overlay.options.modal = f.modal;
                var p = l.buttons.max;
                p.removeClass(this.options.name + '-button-min');
                p.removeClass(this.options.name + '-button-max');
                p.addClass(this.options.name + '-hide');
                this.move = !! f.move;
                this.maximized = !! f.maximized;
                if ($.isArray(f.buttons)) {
                    this.custombuttons(f.buttons, h.element)
                }
                if (l.buttons.custom.is(":empty") === false) {
                    l.buttons.div.show()
                }
                if (this.utils.isEmpty(f.force) === false) {
                    i = f.force
                } else if (f.iframe) {
                    i = 'iframe'
                } else if (k.match(this.imgsreg)) {
                    i = 'image'
                } else {
                    var q = this.ex({
                        "flash": this.videoregs,
                        "iframe": this.mapsreg
                    }, k, f);
                    if ( !! q.type === true) {
                        k = q.href;
                        i = q.type;
                        f.width = q.width;
                        f.height = q.height
                    }
                    if ( !! i === false) {
                        if (k.match(/#/)) {
                            var r = k.substr(k.indexOf("#"));
                            if ($(r).length > 0) {
                                i = 'inline';
                                k = r
                            } else {
                                i = 'ajax'
                            }
                        } else {
                            i = 'ajax'
                        }
                    }
                } if (i === 'image') {
                    l.image = new Image();
                    $(l.image).load(this.proxy(function () {
                        var a = this.esqueleto.image;
                        $(a).unbind('load');
                        if (this.visible === false) {
                            return false
                        }
                        if (f.width) {
                            n = parseInt(f.width, 10);
                            height = parseInt(f.height, 10);
                            f.autoresize = false
                        } else {
                            a.width = parseInt(a.width * f.ratio, 10);
                            a.height = parseInt(a.height * f.ratio, 10);
                            if (f.maximized) {
                                n = a.width;
                                height = a.height
                            } else {
                                var b = this.calculate(a.width, a.height);
                                n = b.width;
                                height = b.height
                            }
                        } if (f.autoresize) {
                            if (f.maximized || (!f.maximized && a.width != n && a.height != height)) {
                                l.buttons.div.show();
                                l.buttons.max.removeClass(this.options.name + '-hide');
                                l.buttons.max.addClass(this.options.name + (f.maximized ? '-button-min' : '-button-max'))
                            }
                        }
                        l.title = (this.utils.isEmpty(f.title)) ? false : $('<div class="' + this.options.name + '-title"></div>').html(f.title);
                        this.loadimage();
                        this.resize(n, height)
                    }));
                    this.esqueleto.image.onerror = this.proxy(function () {
                        this.error("The requested image cannot be loaded. Please try again later.")
                    });
                    this.esqueleto.image.src = k
                } else if (i == 'jwplayer' && typeof jwplayer !== "undefined") {
                    if (f.width) {
                        n = f.width;
                        height = f.height
                    } else {
                        this.error("You have to specify the size. Add ?lightbox[width]=600&lightbox[height]=400 at the end of the url.");
                        return false
                    }
                    var s = 'DV_' + (new Date().getTime());
                    var t = '<div id="' + s + '"></div>';
                    this.appendhtml($(t).css({
                        width: n,
                        height: height
                    }), n, height);
                    this.esqueleto.background.bind('complete', this.proxy(function () {
                        this.esqueleto.background.unbind('complete');
                        jwplayer(s).setup($.extend(true, {
                            file: k,
                            autostart: true
                        }, f));
                        if (this.visible === false) {
                            return false
                        }
                    }))
                } else if (i == 'flash' || i == 'inline' || i == 'ajax' || i == 'element') {
                    if (i == 'inline') {
                        var u = $(k);
                        var v = f.source == "original" ? u : u.clone(true).show();
                        n = f.width > 0 ? f.width : u.outerWidth(true);
                        height = f.height > 0 ? f.height : u.outerHeight(true);
                        this.appendhtml(v, n, height)
                    } else if (i == 'ajax') {
                        if (f.width) {
                            n = f.width;
                            height = f.height
                        } else {
                            this.error("You have to specify the size. Add ?lightbox[width]=600&lightbox[height]=400 at the end of the url.");
                            return false
                        } if (this.animations.ajax) {
                            this.animations.ajax.abort()
                        }
                        this.animations.ajax = $.ajax($.extend(true, {}, this.options.ajax, f.ajax || {}, {
                            url: k,
                            error: this.proxy(function (a, b, c) {
                                this.error("AJAX Error " + a.status + " " + c + ". Url: " + k)
                            }),
                            success: this.proxy(function (a) {
                                this.appendhtml($("<div>" + a + "</div>"), n, height)
                            })
                        }))
                    } else if (i == 'flash') {
                        var w = this.swf2html(k, f.width, f.height, f.flashvars);
                        this.appendhtml($(w), f.width, f.height, 'flash')
                    } else if (i === 'element') {
                        n = f.width > 0 ? f.width : h.element.outerWidth(true);
                        height = f.height > 0 ? f.height : h.element.outerHeight(true);
                        this.appendhtml(h.element, n, height)
                    }
                } else if (i == 'iframe') {
                    if (f.width) {
                        n = f.width;
                        height = f.height
                    } else {
                        this.error("You have to specify the size. Add ?lightbox[width]=600&lightbox[height]=400&lighbox[iframe]=true at the end of the url.");
                        return false
                    }
                    var t = '<iframe id="IF_' + (new Date().getTime()) + '" frameborder="0" src="' + k + '" style="margin:0; padding:0;"></iframe>';
                    this.appendhtml($(t).css({
                        width: n,
                        height: height
                    }), n, height)
                }
                this.callback = $.isFunction(g) ? g : function (e) {}
            },
            loadimage: function () {
                var a = this.esqueleto;
                var b = a.background;
                var c = this.options.name + '-loading';
                b.bind('complete', this.proxy(function () {
                    b.unbind('complete');
                    if (this.visible === false) {
                        return false
                    }
                    this.changemode('image');
                    b.empty();
                    a.html.empty();
                    if (a.title) {
                        b.append(a.title)
                    }
                    b.append(a.image);
                    if (!G.opacity) {
                        b.removeClass(c)
                    } else {
                        $(a.image).css("background-color", "rgba(255, 255, 255, 0)");
                        $(a.image).stop().css("opacity", 0).animate({
                            "opacity": 1
                        }, (E ? this.options.animation.show.duration / 2 : this.options.animation.show.duration), function () {
                            b.removeClass(c)
                        })
                    }
                    this.options.onOpen.apply(this)
                }))
            },
            swf2html: function (c, d, e, f) {
                var g = $.extend(true, {
                    classid: "clsid:D27CDB6E-AE6D-11cf-96B8-444553540000",
                    width: d,
                    height: e,
                    movie: c,
                    src: c,
                    style: "margin:0; padding:0;",
                    allowFullScreen: "true",
                    allowscriptaccess: "always",
                    wmode: "transparent",
                    autostart: "true",
                    autoplay: "true",
                    type: "application/x-shockwave-flash",
                    flashvars: "autostart=1&autoplay=1&fullscreenbutton=1"
                }, f);
                var h = "<object ";
                var i = "<embed ";
                var j = "";
                $.each(g, function (a, b) {
                    if (b !== "") {
                        h += a + "=\"" + b + "\" ";
                        i += a + "=\"" + b + "\" ";
                        j += "<param name=\"" + a + "\" value=\"" + b + "\"></param>"
                    }
                });
                var k = h + ">" + j + i + "></embed></object>";
                return k
            },
            appendhtml: function (a, b, c, d) {
                var e = this;
                var f = e.options;
                var g = e.esqueleto;
                var h = g.background;
                e.changemode("html");
                e.resize(b + 30, c + 20);
                h.bind('complete', function () {
                    h.removeClass(f.name + '-loading');
                    g.html.append(a);
                    if (d == "flash" && D("chrome") > -1) {
                        g.html.html(a)
                    }
                    h.unbind('complete');
                    if (f.cufon && typeof Cufon !== 'undefined') {
                        Cufon.refresh()
                    }
                    f.onOpen.apply(this)
                })
            },
            movebox: function (w, h) {
                var a = $(this.win);
                var b = {
                    x: a.width(),
                    y: a.height()
                };
                var c = {
                    x: a.scrollLeft(),
                    y: a.scrollTop()
                };
                var d = this.esqueleto;
                var e = w != null ? w : d.lightbox.outerWidth(true);
                var f = h != null ? h : d.lightbox.outerHeight(true);
                var y = 0;
                var x = 0;
                x = c.x + ((b.x - e) / 2);
                if (this.visible) {
                    y = c.y + (b.y - f) / 2
                } else if (this.options.emergefrom == "bottom") {
                    y = (c.y + b.y + 14)
                } else if (this.options.emergefrom == "top") {
                    y = (c.y - f) - 14
                } else if (this.options.emergefrom == "right") {
                    x = b.x;
                    y = c.y + (b.y - f) / 2
                } else if (this.options.emergefrom == "left") {
                    x = -e;
                    y = c.y + (b.y - f) / 2
                }
                if (this.visible) {
                    if (!this.animations.move) {
                        this.morph(d.move, {
                            'left': parseInt(x, 10)
                        }, 'move')
                    }
                    this.morph(d.move, {
                        'top': parseInt(y, 10)
                    }, 'move')
                } else {
                    d.move.css({
                        'left': parseInt(x, 10),
                        'top': parseInt(y, 10)
                    })
                }
            },
            morph: function (d, f, g, h, i) {
                var j = jQuery.fn.jquery.split(".");
                if (j[0] == 1 && j[1] < 8) {
                    var k = $.speed({
                        queue: i || false,
                        duration: (E ? this.options.animation[g].duration / 2 : this.options.animation[g].duration),
                        easing: this.options.animation[g].easing,
                        complete: ($.isFunction(h) ? this.proxy(h, this) : null)
                    });
                    return d[k.queue === false ? "each" : "queue"](function () {
                        if (j[1] > 5) {
                            if (k.queue === false) {
                                $._mark(this)
                            }
                        }
                        var c = $.extend({}, k),
                            self = this;
                        c.curAnim = $.extend({}, f);
                        c.animatedProperties = {};
                        for (var p in f) {
                            name = p;
                            c.animatedProperties[name] = c.specialEasing && c.specialEasing[name] || c.easing || 'swing'
                        }
                        $.each(f, function (a, b) {
                            var e = new $.fx(self, c, a);
                            e.custom(e.cur(true) || 0, b, "px")
                        });
                        return true
                    })
                } else {
                    d.animate(f, {
                        queue: i || false,
                        duration: (E ? this.options.animation[g].duration / 2 : this.options.animation[g].duration),
                        easing: this.options.animation[g].easing,
                        complete: ($.isFunction(h) ? this.proxy(h, this) : null)
                    })
                }
            },
            resize: function (x, y) {
                var a = this.esqueleto;
                if (this.visible) {
                    var b = {
                        x: $(this.win).width(),
                        y: $(this.win).height()
                    };
                    var c = {
                        x: $(this.win).scrollLeft(),
                        y: $(this.win).scrollTop()
                    };
                    var d = Math.max((c.x + (b.x - (x + 14)) / 2), 0);
                    var e = Math.max((c.y + (b.y - (y + 14)) / 2), 0);
                    this.animations.move = true;
                    this.morph(a.move.stop(), {
                        'left': (this.maximized && d < 0) ? 0 : d,
                        'top': (this.maximized && (y + 14) > b.y) ? c.y : e
                    }, 'move', $.proxy(function () {
                        this.move = false
                    }, this.animations));
                    this.morph(a.html, {
                        'height': y - 20
                    }, 'move');
                    this.morph(a.lightbox.stop(), {
                        'width': (x + 14),
                        'height': y - 20
                    }, 'move', {}, true);
                    this.morph(a.navigator, {
                        'width': x
                    }, 'move');
                    this.morph(a.navigator, {
                        'top': (y - (a.navigator.height())) / 2
                    }, 'move');
                    this.morph(a.background.stop(), {
                        'width': x,
                        'height': y
                    }, 'move', function () {
                        $(a.background).trigger('complete')
                    })
                } else {
                    a.html.css({
                        'height': y - 20
                    });
                    a.lightbox.css({
                        'width': x + 14,
                        'height': y - 20
                    });
                    a.background.css({
                        'width': x,
                        'height': y
                    });
                    a.navigator.css({
                        'width': x
                    })
                }
            },
            close: function (a) {
                var b = this.esqueleto;
                this.visible = false;
                this.gallery = {};
                this.options.onClose();
                var c = b.html.children(".jwplayer");
                if (c.length > 0 && typeof jwplayer !== "undefined") {
                    jwplayer(c[0]).remove()
                }
                if (F || !G.opacity || E) {
                    b.background.empty();
                    b.html.find("iframe").attr("src", "");
                    if (F) {
                        setTimeout(function () {
                            b.html.hide().empty().show()
                        }, 100)
                    } else {
                        b.html.hide().empty().show()
                    }
                    b.buttons.custom.empty();
                    b.move.css("display", "none");
                    this.movebox()
                } else {
                    b.move.animate({
                        "opacity": 0,
                        "top": "-=40"
                    }, {
                        queue: false,
                        complete: (this.proxy(function () {
                            b.background.empty();
                            b.html.empty();
                            b.buttons.custom.empty();
                            this.movebox();
                            b.move.css({
                                "display": "none",
                                "opacity": 1,
                                "overflow": "visible"
                            })
                        }))
                    })
                }
                this.overlay.hide(this.proxy(function () {
                    if ($.isFunction(this.callback)) {
                        this.callback.apply(this, $.makeArray(a))
                    }
                }));
                b.background.stop(true, false).unbind("complete")
            },
            open: function () {
                this.visible = true;
                if (!G.opacity) {
                    this.esqueleto.move.get(0).style.removeAttribute("filter")
                }
                this.esqueleto.move.stop().css({
                    opacity: 1,
                    display: "block",
                    overflow: "visible"
                }).show();
                this.overlay.show()
            },
            shake: function () {
                var z = this.options.animation.shake;
                var x = z.distance;
                var d = z.duration;
                var t = z.transition;
                var o = z.loops;
                var l = this.esqueleto.move.position().left;
                var e = this.esqueleto.move;
                for (var i = 0; i < o; i++) {
                    e.animate({
                        left: l + x
                    }, d, t);
                    e.animate({
                        left: l - x
                    }, d, t)
                };
                e.animate({
                    left: l + x
                }, d, t);
                e.animate({
                    left: l
                }, d, t)
            },
            changemode: function (a) {
                if (a != this.mode) {
                    var b = this.options.name + "-mode-";
                    this.esqueleto.lightbox.removeClass(b + this.mode).addClass(b + a);
                    this.mode = a
                }
                this.esqueleto.move.css("overflow", "visible")
            },
            error: function (a) {
                alert(a);
                this.close()
            },
            unserialize: function (d) {
                var e = /lightbox\[([^\]]*)?\]$/i;
                var f = {};
                if (d.match(/#/)) {
                    d = d.slice(0, d.indexOf("#"))
                }
                d = d.slice(d.indexOf('?') + 1).split("&");
                $.each(d, function () {
                    var a = this.split("=");
                    var b = a[0];
                    var c = a[1];
                    if (b.match(e)) {
                        if (isFinite(c)) {
                            c = parseFloat(c)
                        } else if (c.toLowerCase() == "true") {
                            c = true
                        } else if (c.toLowerCase() == "false") {
                            c = false
                        }
                        f[b.match(e)[1]] = c
                    }
                });
                return f
            },
            calculate: function (x, y) {
                var a = this.options.maxsize.width > 0 ? this.options.maxsize.width : this.win.width() - 50;
                var b = this.options.maxsize.height > 0 ? this.options.maxsize.height : this.win.height() - 50;
                if (x > a) {
                    y = y * (a / x);
                    x = a;
                    if (y > b) {
                        x = x * (b / y);
                        y = b
                    }
                } else if (y > b) {
                    x = x * (b / y);
                    y = b;
                    if (x > a) {
                        y = y * (a / x);
                        x = a
                    }
                }
                return {
                    width: parseInt(x, 10),
                    height: parseInt(y, 10)
                }
            },
            loading: function () {
                var a = this.options.style;
                var b = this.esqueleto;
                var c = b.background;
                this.changemode('image');
                c.children().stop(true);
                c.empty();
                b.html.empty();
                b.buttons.div.hide();
                b.buttons.div.css("width");
                c.addClass(this.options.name + '-loading');
                if (this.visible == false) {
                    this.movebox(a["width"], a["height"]);
                    this.resize(a["width"], a["height"])
                }
            },
            maximinimize: function () {
                var a = this;
                var b = a.esqueleto.buttons;
                var c = a.esqueleto.image;
                var d = a.options.name;
                var e = {};
                b.max.removeClass(d + '-button-min ' + d + '-button-max').addClass((a.maximized) ? d + '-button-max' : d + '-button-min');
                a.loading();
                a.loadimage();
                b.div.show();
                if (a.maximized) {
                    e = a.calculate(c.width, c.height)
                } else {
                    e = c
                }
                a.resize(e.width, e.height);
                a.maximized = !a.maximized
            },
            getOptions: function (a) {
                var a = $(a);
                return $.extend({}, {
                    href: a.attr("href"),
                    rel: ($.trim(a.attr("data-rel") || a.attr("rel"))),
                    relent: a.attr("data-rel") ? "data-rel" : "rel",
                    title: $.trim(a.attr("data-title") || a.attr("title")),
                    element: a[0]
                }, ($.parseJSON((a.attr("data-options") || "{}").replace(/\'/g, '"')) || {}))
            },
            link: function (b, c) {
                var d = $(c.element);
                var e = this.getOptions(d);
                var f = e.rel;
                var g = e.relent;
                var h = c.options;
                var j = [];
                d.blur();
                if (c.gallery) {
                    j = c.gallery
                } else if (this.utils.isEmpty(f) || f === 'nofollow') {
                    j = [e]
                } else {
                    var k = [];
                    var l = [];
                    var m = false;
                    $("a[" + g + "], area[" + g + "]", this.ownerDocument).filter("[" + g + "=\"" + f + "\"]").each($.proxy(function (i, a) {
                        if (d[0] === a) {
                            k.unshift(this.getOptions(a));
                            m = true
                        } else if (m == false) {
                            l.push(this.getOptions(a))
                        } else {
                            k.push(this.getOptions(a))
                        }
                    }, this));
                    j = k.concat(l)
                }
                $.lightbox(j, h, c.callback, d);
                return false
            },
            utils: {
                isEmpty: function (a) {
                    if (a == null) return true;
                    if (Object.prototype.toString.call(a) === '[object String]' || $.type(a) === "array") return a.length === 0
                }
            }
        },
        lightbox: function (a, b, c) {
            var d = [];
            if ($.LightBoxObject.utils.isEmpty(a)) {
                return $.LightBoxObject
            }
            if ($.type(a) === "string") {
                d = [$.extend({}, {
                    href: a
                }, b)]
            } else if ($.type(a) === "array") {
                var e = a[0];
                if ($.type(e) === "string") {
                    for (var i = 0; i < a.length; i++) {
                        d[i] = $.extend({}, {
                            href: a[i]
                        }, b)
                    }
                } else if ($.type(e) === "object") {
                    for (var i = 0; i < a.length; i++) {
                        d[i] = $.extend({}, b, a[i])
                    }
                }
            } else if ($.type(a) === "object" && a[0].nodeType) {
                d = [$.extend({}, {
                    type: "element",
                    href: "#",
                    element: a
                }, b)]
            }
            return $.LightBoxObject.show(d, b, c)
        }
    });
    $.fn.lightbox = function (a, b) {
        var c = {
            "selector": this.selector,
            "options": a,
            "callback": b
        };
        return $(this).live('click', function (e) {
            e.preventDefault();
            e.stopImmediatePropagation();
            return $.proxy($.LightBoxObject.link, $.LightBoxObject)(e, $.extend({}, c, {
                "element": this
            }))
        })
    };
    $(function () {
        var a = jQuery.fn.jquery.split(".");
        if (a[0] > 1 || (a[0] == 1 && a[1] > 3)) {
            $.LightBoxObject.create()
        } else {
            throw "The jQuery version that was loaded is too old. Lightbox Evolution requires jQuery 1.4+";
        }
    })
})(jQuery, window, document);