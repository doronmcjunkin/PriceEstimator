PricingModel = require '../models/PricingMapModel.coffee'

PricingMapsCollection = Backbone.Collection.extend
  model: PricingModel

  initialize: (models, options) ->
    window.currentDatacenter = options.datacenter
    @url = "json/pricing/" + options.datacenter + ".json"
    @fetch()

  forKey: (type) ->
    _.first @where("type": type)

module.exports = PricingMapsCollection