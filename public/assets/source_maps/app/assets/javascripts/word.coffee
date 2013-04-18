window.app =
  seconds: 180
  pusher: null
  channel: null
  letters: []
  rows: []
  cols: []
  document_ready: ->
    console.log('doc ready')
    app.token = $('#auth_token').data('auth-token')
    $('#form').on('click', 'a[data-clear-form]', app.clear_form)
    $('#tiles').on('click', '.square', app.select_letter)
    $('#submit_word').on('click', 'a[data-game-name]', app.submit_word)
    $('#start').hover('.shake').trigger('startRumble')

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
          console.log(letter, row, col)
          app.letters.push(letter)

  submit_word: (e) ->
    game = $(this).data('game-name')
    console.log(game)
    console.log('hello')
    e.preventDefault
    word = app.letters
    console.log(word)
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
    console.log(name)
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

  end_game: ->
    console.log('end')
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

