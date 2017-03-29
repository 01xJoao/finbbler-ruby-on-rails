var loadFile = function(event) {
  var output = document.getElementById('image-preview');
  output.src = URL.createObjectURL(event.target.files[0]);
};

/*
var users = new Vue({
  el: '#app',
  data: {
    users: []
  },
  ready: function() {
    var that;
    that = this;
    $.ajax({
      url: '/users.json',
      success: function(res) {
        console.log(res);
        that.users = res;
      }
    });
  }
});*/