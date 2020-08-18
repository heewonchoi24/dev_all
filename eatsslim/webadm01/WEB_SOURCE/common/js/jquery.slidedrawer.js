/*
 * jQuery Slide Drawer
 */
;
(function (d) {
    var c = {
        init: function (a, b) {
            !0 == a.showDrawer && !0 == a.slideTimeout ? setTimeout(function () {
                c.slide(b, a.drawerHiddenHeight, a.slideSpeed)
            }, a.slideTimeoutCount) : !1 == a.showDrawer && c.slide(b, a.drawerHiddenHeight, a.slideSpeed);
            d(".clickme").on("click", function () {
                c.toggle(a, b)
            })
        },
        toggle: function (a, b) {
            d(b).height() + a.borderHeight === a.drawerHeight ? c.slide(b, a.drawerHiddenHeight, a.slideSpeed) : c.slide(b, a.drawerHeight - a.borderHeight, a.slideSpeed)
        },
        slide: function (a, b, c) {
            d(a).animate({
                height: b
            }, c)
        }
    };
    d.fn.slideDrawer =
        function (a) {
            var b = this.children(".drawer-content"),
                e = parseInt(b.css("border-top-width"));
            drawerHeight = this.height() + e;
            drawerContentHeight = b.height() - e;
            drawerHiddenHeight = drawerHeight - drawerContentHeight;
            a = d.extend({
                showDrawer: !1,
                slideSpeed: 700,
                slideTimeout: !0,
                slideTimeoutCount: 5E3,
                drawerContentHeight: drawerContentHeight,
                drawerHeight: drawerHeight,
                drawerHiddenHeight: drawerHiddenHeight,
                borderHeight: e
            }, a);
            return this.each(function () {
                c.init(a, this)
            })
    }
})(jQuery);