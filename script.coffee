Raphael ->
  wheel_bg_src      = document.getElementById('wheel_bg').src
  wheel_src      = document.getElementById('wheel').src
  highlight_src  = document.getElementById('highlights').src
  pin_src        = document.getElementById('pin').src
  needle_src     = document.getElementById('needle').src
  btn_spin_src     = document.getElementById('btn_spin_me').src
  
  paper = Raphael("the_wheel", 800, 400)
  wheel_bg = paper.image(wheel_bg_src, 0, 0, 400, 400)
  wheel = paper.image(wheel_src, 0, 0, 400, 400)
  pin = paper.image(pin_src, 150, 150, 97, 98)
  highlight = paper.image(highlight_src, 0, 0, 400, 400)
  needle = paper.image(needle_src, 185, -10, 29, 64)
  btn_spin = paper.image(btn_spin_src, 500, 220, 309, 87)
  
  deg_inc = 360/12
  money_map =
    '500': 0
    '10': deg_inc
    '200': deg_inc*2
    '5': deg_inc*3 
    '2000': deg_inc*4
    '1': deg_inc*5
    '5000': deg_inc*6
    '100': deg_inc*7
    '1000': deg_inc*8
    '50': deg_inc*9
    '10000': deg_inc*10
    '25': deg_inc*11
  
  # returns the a random value b/w `from` and `to`
  randomFromInterval = (from, to) ->
    Math.floor( Math.random()*(to-from+1) + from)

  # fake server response factory for win money
  get_win_value = (money_map) ->
    val = for money, degree of money_map
      'money': money, 'degree': degree
    val[randomFromInterval(0, val.length)]

  # display result
  show_result = (win_value) ->
    btn_spin.hide()
    action_text = document.getElementById('action_text')
    action_text.parentNode.removeChild(action_text)
    document.getElementById("result_text").className = ""
    document.getElementById("prize_money").innerHTML = win_value.money + '!'
    
  # wheel spinner
  spin_the_wheel = (win_value) ->
    angle = 5*360+win_value.degree+randomFromInterval(-10, 10)
    needle.animate({transform: "0r" + -5}, 500, "<>")
    wheel.stop().animate({transform: "r" + angle}, 5000, "cubic-bezier(0.100, 0.300, 0.700, 1.050)", (e) ->
      needle.animate({transform: "0r" + 0}, 300, "<>", show_result(win_value))                       
    )
  
  btn_spin.click (e) ->
    win_value = get_win_value(money_map)
    spin_the_wheel(win_value)
    btn_spin.unclick() 
    