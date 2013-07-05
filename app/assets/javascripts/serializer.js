App.Serializer = DS.RESTSerializer.extend({
    /*
      TODO: _addAttribute is private, should resort to using public apis
      Add attribute to serialized object if it's not supposed to be excluded
    */
  addAttributes: function(data, record) {
    var _this = this;
    switch (record.constructor) {
      case App.Bulletin:
        return record.eachAttribute(function(name, attribute) {
          if (name !== "author") {
            return _this._addAttribute(data, record, name, attribute.type);
          }
        });
      case App.User:
        return record.eachAttribute(function(name, attribute) {
          if (["avatar_url", "approved"].indexOf(name) === -1) {
            return _this._addAttribute(data, record, name, attribute.type);
          }
        });
      case App.Membership:
        return record.eachAttribute(function(name, attribute) {
          if (name !== "display_name") {
            return _this._addAttribute(data, record, name, attribute.type);
          }
        });
      case App.Organization:
        return record.eachAttribute(function(name, attribute) {
          var readOnlyAttributesForOrganization;
          readOnlyAttributesForOrganization = ["display_name", "location", "university_name", "reputation"];
          if (readOnlyAttributesForOrganization.indexOf(name) === -1) {
            return _this._addAttribute(data, record, name, attribute.type);
          }
        });
      default:
        return this._super(data, record);
    }
  }
});
