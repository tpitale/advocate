formListeners = {

  init: function(){
    $(document).ready(function(){
      $('.selectize').selectize({
        create          : false,
        onItemAdd: function(value, $item) {
          window.location.href = "/users/services?interaction_id=" + "<%=params['id'] %>" + "&service_type=" + value
        }
      })
    })
  }

}
