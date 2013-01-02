$(document).ready ->
  $("[id^='approve_']").click ->
    votable_id = parseInt((this.id).split("_")[1])
    votable_type = $('#votable_type_'+votable_id).val()
    $.ajax
      type: 'POST'
      dataType: 'json'
      url: '/votes?vote[votable_id]='+votable_id+'&vote[votable_type]='+votable_type
      success: (data) ->
        if data.message
          alert(data.message)
        else
          $("#approve_count_" + data.voted_letter_id).text(data.vote_count);
          $('#approve_'+data.voted_letter_id).css('background-position', 'left bottom')

# $(document).ready ->
#   $('.vote').click ->
#     story_id = this.dataset.story_id
#     user_id = this.dataset.user_id
#     $.ajax ->
#       type: "POST"
#       dataType: "json"
#       url: "/votes/create?user_id="+user_id+"&story_id="+story_id
#       success: (data) ->
#         $('.link').display('none')