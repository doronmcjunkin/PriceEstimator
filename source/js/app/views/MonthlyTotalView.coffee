MonthlyTotalView = Backbone.View.extend

  el: "#monthly-total"

  events:
    "change .datacenter": "changeDatacenter"

  initialize: (options) ->
    @options = options || {};

    @options.app.on "totalPriceUpdated", =>
      @updateTotal()

    $.getJSON "json/pricing/index.json", (data) =>
      $.each data, (index, location) =>
        label = location[1].replace("_", " ")
        selected = if options.datacenter is location[0] then "selected" else ""
        $(".datacenter", @$el).append("<option value='#{location[0]}' #{selected}>#{label}</option>")

    $(window).scroll => @positionHeader()

  updateTotal: ->
    $(".price", @$el).html accounting.formatMoney(@options.app.totalPriceWithSupport)

  positionHeader: ->
    if $(window).scrollTop() > 289
      @$el.css("position", "fixed")
    else
      @$el.css("position", "absolute")

  changeDatacenter: (e) ->
    # @options.app.setPricingMap $(e.target).val()
    href = window.top.location.href
    href = href.replace(/\?datacenter=.*/, "")
    href = "#{href}?datacenter=#{$(e.target).val()}"
    window.top.location.href = href

module.exports = MonthlyTotalView
