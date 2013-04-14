seconds = 180
window.app =
  pusher: null
  channel: null
  selected_channel: null
  document_ready: ->
    app.token = $('#auth_token').data('auth-token')
    app.pusher = new Pusher('4265009735b51af74a68')
    $('#form').on('click', 'a[data-clear-form]', app.clear_form)
    $('.word_enter').on('keypress', 'text', app.word_enter)

  word_enter: (e) ->
    e.preventDefault
    if e.keyCode == 13
      word = $('.word_enter').text()
      settings =
      dataType: 'script'
      type: "post"
      url: "/games/add_word"
      data: {authenticity_token: app.token, word: word}
    $.ajax(settings)

  clear_form: (e) ->
    e.preventDefault()
    $('#form').slideUp()
    $('#homebuttons').show()

  bind_events: ->
    channel.bind('select_channel', app.select_channel)

  select_channel: (name) ->
    console.log(name)
    app.pusher.unsubscribe(app.selected_channel) if app.selected_channel
    app.pusher.subscribe(name)
    app.selected_channel = name
    bind_events()

  start_timer: ->
    $('#start').hide()
    $('#pause').show()
    setInterval ( -> app.show_time()), 1000

  end_game: ->
    console.log('end')

  show_time: ->
    minutes = Math.floor(seconds/60)
    secs = seconds - (minutes * 60)
    $('#time').text("0#{minutes} : #{secs}")
    seconds -= 1

  new_game_form: ->
    settings =
      dataType: 'script'
      type: "get"
      url: "/games/new_game_form"
    $.ajax(settings)

$(document).ready(app.document_ready)
