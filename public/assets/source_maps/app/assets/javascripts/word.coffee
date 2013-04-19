window.app =
  seconds: 60
  pusher: null
  channel: null
  letters: []
  rows: []
  cols: []
  document_ready: ->
    app.token = $('#auth_token').data('auth-token')
    $('#form').on('click', 'a[data-clear-form]', app.clear_form)
    $('#tiles').on('click', '.square', app.select_letter)
    $('#submit_word').on('click', 'a[data-game-name]', app.submit_word)

  select_letter: ->
    if app.rows.length == 0
      row = $(this).data('row')
      col = $(this).data('col')
      app.rows.push(row)
      app.cols.push(col)
      $(this).addClass('selected_letter')
      letter = $(this).text()
      app.letters.push(letter)
      row = $(this).data('row')
      col = $(this).data('col')
    else
      row = $(this).data('row')
      col = $(this).data('col')
      if (row + 1) == app.rows[(app.rows.length)-1] && (col + 1) == app.cols[(app.cols.length)-1] || (row + 1) == app.rows[(app.rows.length)-1] && col == app.cols[(app.cols.length)-1] || (row + 1) == app.rows[(app.rows.length)-1] && (col - 1) == app.cols[(app.cols.length)-1] || row == app.rows[(app.rows.length)-1] && (col + 1) == app.cols[(app.cols.length)-1] || row == app.rows[(app.rows.length)-1] && col == app.cols[(app.cols.length)-1] || row == app.rows[(app.rows.length)-1] && (col - 1) == app.cols[(app.cols.length)-1] || (row - 1) == app.rows[(app.rows.length)-1] && (col + 1) == app.cols[(app.cols.length)-1] || (row - 1) == app.rows[(app.rows.length)-1] && col == app.cols[(app.cols.length)-1] || (row - 1) == app.rows[(app.rows.length)-1] && (col - 1) == app.cols[(app.cols.length)-1]
        unless $(this).hasClass('selected_letter')
          app.rows.push(row)
          app.cols.push(col)
          $(this).addClass('selected_letter')
          letter = $(this).text()
          app.letters.push(letter)

  reset_selection: ->
    $('.square.selected_letter').removeClass('selected_letter')
    app.letters = []


  submit_word: (e) ->
    $('.square.selected_letter').removeClass('selected_letter')
    game = $(this).data('game-name')
    e.preventDefault
    word = app.letters
    settings =
      dataType: 'script'
      type: "post"
      url: "/games/add_word"
      data: {authenticity_token: app.token, word: word, game: game}
    $.ajax(settings)
    app.letters = []
    app.rows = []
    app.cols = []

  clear_form: (e) ->
    e.preventDefault()
    $('#form').slideUp()
    $('#homebuttons').show()
    $('.rulelink').show()

  enter_channel: (name) ->
    name = $('#enterchannel').val()
    app.pusher.subscribe(name)
    app.selected_channel = name

  bind_events: ->
    channel.bind('refresh_words', app.refresh_words)
    channel.bind('start_game', app.start_game)

  start_game: (name) ->
    settings =
      dataType: 'script'
      type: "get"
      url: "/games/start_game/#{name}"
    $.ajax(settings)

  refresh_words: (name) ->
    settings =
      dataType: 'script'
      type: "get"
      url: "/games/refresh_words/#{name}"
    $.ajax(settings)

  start_timer: ->
    app.timer = setInterval ( -> app.show_time()), 1000

  show_time: ->
    minutes = Math.floor(app.seconds/60)
    secs = app.seconds - (minutes * 60)
    $('#time').text("0#{minutes} : #{secs}")
    app.seconds -= 1
    if app.seconds < 0
      clearInterval(app.timer)
      app.end_game()

  quit_game: ->
    clearInterval(app.timer)

  end_game: ->
    settings =
      dataType: 'script'
      type: 'get'
      url: "/end_game"
    $.ajax(settings)

  new_game_form: ->
    settings =
      dataType: 'script'
      type: "get"
      url: "/games/new_game_form"
    $.ajax(settings)

$(document).ready(app.document_ready)

