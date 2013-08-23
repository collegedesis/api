App.Adapter = DS.RESTAdapter.extend({
  serializer: App.Serializer,

  didError: function(store, type, record, xhr) {
    if (type === App.User) {
      switch (xhr.status) {
        case 422:
          if (confirm("confirmMsg")) {
            return window.location.reload();
          } else {
            alert("So you're not going to play nice eh? Sorry, we have to reload anyway.");
            return window.location.reload();
          }
          break;
        case 401:
          /*
            If we hit this code it means that someone tried
            to create a user with an email address that already
            exists but they entered the wrong password.
            It is a funky state, and we should be handling it better.
          */

          if (record.constructor === App.User) {
            return console.log('Something bad happened');
          }
          break;
        default:
          return this._super.apply(this, arguments);
      }
    } else {
      return this._super.apply(this, arguments);
    }
  }
});

App.Adapter.configure("plurals", {
  university: "universities"
});

App.Adapter.reopen({
  namespace: 'api/v1'
})