(function($) {
    $.fn.menuModel2 = function(a) {
        function m(b, d, f) {
            $.each(b, function(l) {
                this._type = d;
                this._id = l + 1;
                this._parent = f;
                $(">ul>li>a", this.parentNode).size() > 0 && n($(">ul>li>a", this.parentNode).get(), 3, this._id)
            })
        }

        function n(b, d, f) {
            $.each(b, function(l) {
                this._type = d;
                this._id = l + 1;
                this._parent = f
            })
        }

        function o(b, d, f) {
            d = RegExp(eval("/" + d + "/g"));
            if (d.exec(b) != null) b = b.replace(d, f);
            return b
        }

        function h(b, d, f) {
            $(">img", b).length > 0 && $(">img", b).attr("src", o($(">img", b).attr("src"), d, f))
        }

        function i(b) {
            a.visibled && a.visibled._id != b._parent && e(a.visibled);
            a.subVisibled && a.subVisibled._parent != b._id && e(a.subVisibled);
            $(b).addClass(a.activeClass);
            a.model == 1 && a.parentYN && h(b, a.imgOff, a.imgOn);
            $("+ul", b).css(a.showOps);
            a.visibled = b
        }

        function j(b) {
            a.subVisibled && e(a.subVisibled);
            $(b).addClass(a.activeClass);
            a.model == 1 && a.childYN && h(b, a.imgOff, a.imgOn);
            $("+ul", b).css(a.showOps);
            a.subVisibled = b
        }

        function k(b) {
            a.ssubVisibled && e(a.ssubVisibled);
            $(b).addClass(a.activeClass);
            a.model == 1 && a.childYN && h(b, a.imgOff, a.imgOn);
            a.ssubVisibled = b
        }

        function e(b) {
            $(b).removeClass(a.activeClass);
            $("+ul", b).css(a.hideOps);
            a.model == 1 && h(b, a.imgOn, a.imgOff)
        }
        var g = $(this);
        a = $.extend({
            model: 1,
            parentYN: true,
            childYN: true,
            defaultLightMoveYN: true,
            target_obj: this,
            visibled: "",
            subVisibled: "",
            ssubVisibled: "",
            activeClass: "hover",
            showspeed: 1E3,
            hidespeed: 0,
            imgOn: "_on.gif",
            imgOff: ".gif",
            showOps: {
                "visibility": "visible"
            },
            hideOps: {
                visibility: "hidden"
            },
            hightLight: {
                level_1: 0,
                level_1_obj: "",
                level_2: 0,
                level_2_obj: "",
                level_3: 0,
                level_3_obj: ""
            }
        }, a || {});
        (function(b) {
            $.each(b, function(d) {
                this._type = 1;
                this._id = d + 1;
                this._parent = -1;
                $(">ul>li>a", this.parentNode).size() > 0 && m($(">ul>li>a", this.parentNode).get(), 2, this._id)
            })
        })($(">li>a", g).get());
        (function() {
            g[0].getElementsByTagName("a");
            $.each(g[0].getElementsByTagName("a"), function() {
                switch (this._type) {
                    case 1:
                        /*this.onclick=function(){i(this)};this.onfocus=function(){i(this)};break;case 2:this.onclick=function(){j(this)};this.onfocus=function(){j(this)};break;case 3:this.onclick=function(){k(this)};this.onfocus= function(){k(this)};break;*/
                    default:
                        break
                }
                if (this._type == 1 && this._id == a.hightLight.level_1) a.hightLight.level_1_obj = this;
                else if (this._type == 2 && this._parent == a.hightLight.level_1 && this._id == a.hightLight.level_2) a.hightLight.level_2_obj = this;
                else if (this._type == 3 && this._parent == a.hightLight.level_2 && this._id == a.hightLight.level_3) a.hightLight.level_3_obj = this
            })
        })();
        (function() {
            if (a.hightLight.level_1) {
                $.each(g[0].getElementsByTagName("a"), function() {
                    e(this)
                });
                if (a.hightLight.level_1_obj) {
                    i(a.hightLight.level_1_obj);
                    if (a.hightLight.level_2_obj) {
                        j(a.hightLight.level_2_obj);
                        a.hightLight.level_3_obj && k(a.hightLight.level_3_obj)
                    }
                }
            } else $.each(g[0].getElementsByTagName("a"), function() {
                e(this)
            })
        })();
        (function() {
            $(a.target_obj).hover(function() {}, function() {
                if (a.visibled) {
                    e(a.visibled);
                    if (a.hightLight.level_1_obj) {
                        i(a.hightLight.level_1_obj);
                        if (a.subVisibled) {
                            e(a.subVisibled);
                            if (a.hightLight.level_2_obj) {
                                j(a.hightLight.level_2_obj);
                                if (a.ssubVisibled) {
                                    e(a.ssubVisibled);
                                    k(a.hightLight.level_3_obj)
                                }
                            }
                        }
                    }
                }
            })
        })()
    }
})(jQuery);